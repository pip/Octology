/* A9SJWEw: From Proggit: HTTP://Groups.Google.Com/group/comp.lang.c/msg/22e3473f80eec512?dmode=source&pli=1
 * compile & link with eg.
 * gcc -std=c99 -pedantic -Wall -Wextra -o keypress keypress.c
 * Be nice to other users, run it with
 * nice ./keypress */
#define _XOPEN_SOURCE 600 /* SUSv3 */

#include <stdio.h>        /* fprintf() */
#include <stdlib.h>       /* EXIT_FAILURE */
#include <unistd.h>       /* close() */
#include <signal.h>       /* sigaction() */
#include <sys/time.h>     /* setitimer() */
#include <fcntl.h>        /* open() */
#include <string.h>       /* strrchr() */
#include <errno.h>        /* errno */
#include <termios.h>      /* tcgetattr() */
#include <limits.h>       /* ULLONG_MAX */

/* Counter limit. Make this a long long unsigned. */
#define CTR_LIM ULLONG_MAX

/* Generate SIGARLM this often. */
#define USECS_PER_KEYCHECK ((suseconds_t)1000 * 1000 / 10)

/* Indicators set by SIGALRM, SIGINT, SIGTERM. */
static volatile sig_atomic_t ring,
     abandon_int, abandon_term;

/* Basename of executable. */
static const char *pname;

/* File descriptor to the controlling terminal. */
static int term_fd = -1;

/* Original attributes of the controlling terminal. */
static struct termios orig_attrs;


static void
satomic_handler(int sig)
{
   switch (sig) {
     case SIGALRM: ring         = 1; break;
     case SIGINT:  abandon_int  = 1; break;
     case SIGTERM: abandon_term = 1;
   }
}


static int
term_setup(void)
{
   /*
 *      Turn off canonical mode and local echo. Make read() return 0 if no byte is
 *           available immediately. Since requests can succeed partially, make sure the
 *                entire request succeeded. This function can be called from within an async
 *                     signal handler. This function is reentrant and idempotent.
 *                        */
   struct termios attrs;
   int tmp;

   attrs = orig_attrs;
   attrs.c_lflag &= ~(ECHO | ICANON);
   attrs.c_cc[VMIN] = 0;
   attrs.c_cc[VTIME] = 0;

   while (-1 == (tmp = tcsetattr(term_fd, TCSAFLUSH, &attrs))
       && EINTR == errno) {
   }

   return (0 == tmp
       && 0 == tcgetattr(term_fd, &attrs)
       && 0 == (attrs.c_lflag & (ECHO | ICANON))
       && 0 == attrs.c_cc[VMIN]
       && 0 == attrs.c_cc[VTIME]) ? 0 : -1;
}


static void
scont_handler(int sig)
{
   /* Re-setup the terminal characteristics we need. */
   if (-1 == term_setup()) {
     abort();
   }
}


static void
xsigemptyset(sigset_t *set)
{
   if (-1 == sigemptyset(set)) {
     (void)fprintf(stderr, "%s: sigemptyset() failed\n", pname);
     abort();
   }
}

static void
xsigaddset(sigset_t *set, int signo)
{
   if (-1 == sigaddset(set, signo)) {
     (void)fprintf(stderr, "%s: sigaddset() failed\n", pname);
     abort();
   }
}


static void
xsigaction(int sig, const struct sigaction *restrict act,
     struct sigaction *restrict oact)
{
   if (-1 == sigaction(sig, act, oact)) {
     (void)fprintf(stderr, "%s: sigaction(): %s\n", pname, strerror(errno));
     abort();
   }
}


static void
xsigprocmask(int how, const sigset_t *restrict set, sigset_t *restrict oset)
{
   if (-1 == sigprocmask(how, set, oset)) {
     (void)fprintf(stderr, "%s: sigprocmask(): %s\n", pname, strerror(errno));
     abort();
   }
}


static void
xsetitimer(int which, const struct itimerval *restrict value,
     struct itimerval *restrict ovalue)
{
   if (-1 == setitimer(which, value, ovalue)) {
     (void)fprintf(stderr, "%s: setitimer(): %s\n", pname, strerror(errno));
     abort();
   }
}

static void
sig_setup(struct sigaction *old_int, struct sigaction *old_term)
{
   struct sigaction sa;

   sa.sa_handler = &satomic_handler;
   xsigemptyset(&sa.sa_mask);
   sa.sa_flags = 0;

   /*
 *      Allow the parent process to turn off SIGINT/SIGTERM handling, by
 *           making us inherit SIG_IGN.
 *              */
   xsigaction(SIGINT, 0, old_int);
   if (SIG_DFL == old_int->sa_handler) {
     xsigaction(SIGINT, &sa, 0);
   }

   xsigaction(SIGTERM, 0, old_term);
   if (SIG_DFL == old_term->sa_handler) {
     xsigaction(SIGTERM, &sa, 0);
   }

   xsigaction(SIGALRM, &sa, 0);

   sa.sa_handler = &scont_handler;
   sa.sa_flags = SA_RESTART;
   xsigaction(SIGCONT, &sa, 0);
}


static void
sig_restore(const struct sigaction *old_int, const struct sigaction *old_term)
{
   {
     struct sigaction sa;

     sa.sa_handler = SIG_DFL;
     xsigemptyset(&sa.sa_mask);
     sa.sa_flags = 0;
     xsigaction(SIGCONT, &sa, 0);
   }

   xsigaction(SIGINT, old_int, 0);
   xsigaction(SIGTERM, old_term, 0);
}


static void
timer_start(void)
{
   struct itimerval it;

   it.it_value.tv_sec = 0;
   it.it_value.tv_usec = USECS_PER_KEYCHECK;
   it.it_interval = it.it_value;
   xsetitimer(ITIMER_REAL, &it, 0);
}


static void
timer_stop(void)
{
   struct itimerval it;

   it.it_value.tv_sec = 0;
   it.it_value.tv_usec = 0;
   it.it_interval = it.it_value;
   xsetitimer(ITIMER_REAL, &it, 0);
}


static int
process(FILE *term_str)
{
   sigset_t alrm_mask;
   int err;
   long long unsigned ctr;

   xsigemptyset(&alrm_mask);
   xsigaddset(&alrm_mask, SIGALRM);

   err = 0;
   for (ctr = 0LLU; ctr < CTR_LIM && !abandon_int && !abandon_term && !err;
       ++ctr) {
     /* computation comes here */

     if (ring) {
       char unsigned dummy;

       /*
 *          Block SIGALRM. We've set up SIGCONT to restart read() and write(). So
 *                   the only signals that can interrupt the primitives below are SIGINT
 *                            and SIGTERM.
 *                                   */
       xsigprocmask(SIG_BLOCK, &alrm_mask, 0);

       switch (read(term_fd, &dummy, sizeof dummy)) {
         case -1:
           if (EINTR != errno) {
             (void)fprintf(stderr, "%s: read(ctty): %s\n", pname,
                 strerror(errno));
             err = 1;
           }
           break;

         case 0:
           /* no key was pressed */
           break;

         default:
           /* Flush any other pending keypresses. */
           if (-1 == tcflush(term_fd, TCIFLUSH)) {
             /* tcflush() is uninterruptible */
             (void)fprintf(stderr,
                 "%s: failed to flush pending ctty input: %s\n", pname,
                 strerror(errno));
             err = 1;
           }
           else {
             /*
 *                Notify the user on the controlling terminal. The current active
 *                               handle here is a file descriptor, no action is needed when
 *                                              leaving it for the sake of a standard I/O stream. After the
 *                                                             fprintf(), the active handle will again become the file
 *                                                                            descriptor, thus some action may be necessary, dependent on the
 *                                                                                           buffering of term_str (which we didn't modify with setvbuf()
 *                                                                                                          after fdopen() returned). Since term_str is open for writing
 *                                                                                                                         only, fflush() is sufficient.
 *                                                                                                                                      */
             if ((0 > fprintf(term_str, "please wait... %llu / %llu\n", ctr,
                 CTR_LIM) || EOF == fflush(term_str)) && EINTR != errno) {
               (void)fprintf(stderr, "%s: failed to write to ctty: %s\n", pname,
                   strerror(errno));
               err = 1;
             }
           }
       }

       ring = 0;
       xsigprocmask(SIG_UNBLOCK, &alrm_mask, 0);
     }
   }

   return err ? -1 : 0;
}


int
main(int argc, char **argv)
{
   int ret;

   ret = EXIT_FAILURE;

   pname = strrchr(argv[0], '/');
   pname = pname ? pname + 1 : argv[0];

   term_fd = open("/dev/tty", O_RDWR);
   if (-1 == term_fd) {
     (void)fprintf(stderr, "%s: failed to open controlling terminal: %s\n",
         pname, strerror(errno));
   }
   else {
     /*
 *        Transfer ownership of file descriptor to an stdio stream. We'll use the
 *               file descriptor for input (because input from a stream can't be portably
 *                      done in an unbuffered fashion), and the stream for output. We'll obey
 *                             the handle activation rules when switching between them.
 *                                  */
     FILE *term_str;

     term_str = fdopen(term_fd, "w");
     if (0 == term_str) {
       (void)fprintf(stderr, "%s: fdopen(ctty): %s\n", pname, strerror(errno));
       (void)close(term_fd);
     }
     else {
       if (-1 == tcgetattr(term_fd, &orig_attrs)) {
         (void)fprintf(stderr, "%s: failed to get ctty attrs: %s\n", pname,
             strerror(errno));
       }
       else {
         struct sigaction old_int,
             old_term;

         sig_setup(&old_int, &old_term);

         /*
 *            From this point on, SIGINT and SIGTERM can interrupt. SIGALRM is not
 *                       yet periodically generated. A SIGCONT can be delivered. If it does,
 *                                  it will set up the terminal for us. The probable case is that no
 *                                             SIGCONT arrives in this tiny window, so we set up the terminal
 *                                                        ourselves, and are bit more lenient if it fails. If a SIGINT or
 *                                                                   SIGTERM interrupts an underlying write() which has written no bytes
 *                                                                              yet, then that's no problem, because we're bailing out anyway. A
 *                                                                                         SIGCONT will restart such a write().
 *                                                                                                  */

         if (-1 == term_setup()) {
           (void)fprintf(stderr, "%s: failed to set ctty attrs\n", pname);
         }
         else {
           timer_start();
           /* SIGALRM is generated periodically. */

           if (0 == process(term_str)) {
             ret = EXIT_SUCCESS;
           }

           timer_stop();
           /* SIGALRM isn't generated by the timer anymore. */

           if ((abandon_int || abandon_term) && (0 > fprintf(term_str,
               "SIGINT/SIGTERM received\n") || EOF == fflush(term_str))) {
             (void)fprintf(stderr, "%s: failed to write to ctty: %s\n", pname,
                 strerror(errno));
             ret = EXIT_FAILURE;
           }
         }

         sig_restore(&old_int, &old_term);

         /*
 *            SIGCONT is reset to SIG_DFL here ("nothing special"). The
 *                       disposition of SIGINT and SIGTERM are reset to the inherited
 *                                  actions.
 *                                           */

         /* Make an effort to restore original terminal modes. */
         if (-1 == tcsetattr(term_fd, TCSAFLUSH, &orig_attrs)
             && EXIT_SUCCESS == ret) {
           (void)fprintf(stderr, "%s: failed to restore ctty attrs\n", pname);
           ret = EXIT_FAILURE;
         }
       }

       /* fclose() takes care of term_fd as well */
       if (EOF == fclose(term_str) && EXIT_SUCCESS == ret) {
         (void)fprintf(stderr, "%s: fclose(ctty): %s\n", pname,
             strerror(errno));
         ret = EXIT_FAILURE;
       }
     }

     /* Here, term_fd was already dealt with. */
   }

   if (abandon_int) {
     (void)raise(SIGINT);
   }
   if (abandon_term) {
     (void)raise(SIGTERM);
   }
   return ret;
}
