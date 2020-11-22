/*ToDo:
  changes fonts_array in stats_type to linked list
  Deal efficiently with rendering, i.e. render only what will be displayed
  Deal efficiently with fonts[] and name[] area
  Remember to free fonts / font files */
#define  _GNU_SOURCE
#include           <gtk/gtk.h>
#include          <cairo-ft.h>
#include          <ft2build.h>
#include             <stdio.h>
#include            <string.h>
#include              <math.h>
#include             <ctype.h>
#include        FT_FREETYPE_H
#include           FT_GLYPH_H
#include <kpathsea/kpathsea.h>
#define  W_IN                        8.5
#define  R_IN                       11.0
#define  HORIZ_RES                1280.0
#define  VERT_RES                 1024.0
#define  INIT_WIN_WIDTH          (( 15.0 / 16.0) * HORIZ_RES          )
#define  INIT_WIN_LENGTH         (( 11.0 / 12.0) * VERT_RES           )
#define  INIT_PAGE_WIDTH_ACT     (( 14.0 / 15.0) * INIT_WIN_WIDTH     )
#define  INIT_PAGE_LENGTH_ACT    (( R_IN / W_IN) * INIT_PAGE_WIDTH_ACT)
#define  INIT_PAGE_WIDTH_DISP    INIT_PAGE_WIDTH_ACT
#define  INIT_PAGE_LENGTH_DISP   (( 10.0 / 11.0) * INIT_WIN_LENGTH    )
#define  MIN_WIN_WIDTH           ((  1.0 / 10.0) * INIT_WIN_WIDTH     )
#define  MIN_WIN_LENGTH          ((  1.0 / 10.0) * MIN_WIN_WIDTH      )
#define  PT_PER_IN                  72.27
#define  SP_PER_PT_TH            65536.0
#define  SP_PER_PT               64838.45196
#define  M_IN                        1.0
#define  L_IN                    (W_IN - 2.0 *      M_IN              )
#define  L_SP                    (L_IN       * PT_PER_IN * SP_PER_PT  )
#define  S_IN                    (R_IN - 2.0 *      M_IN              )
#define  S_SP                    (S_IN       * PT_PER_IN * SP_PER_PT  )
#define  SAMPLE_DVI              "sample.dvi"
#define  MAXLINE                 80
#define  MAX_H_SP                (SP_PER_PT  * PT_PER_IN * W_IN       )
#define  MAX_V_SP                (SP_PER_PT  * PT_PER_IN * R_IN       )
#define  MAXH                    31934563.0
#define  MAXV                    43725786.0
#define  MAX_WORD_SIZE               1024
#define  WIDTH_FAC                  70000
#define  TFM_PER_FT              ((double)( 1.027781 / 640.0))
/*define TFM_PER_FT              ((double)( 1.027781 / 991.0)) */
#define  DEFAULT_FONT_AREA       "/usr/share/texmf-texlive/fonts/type1/bluesky/cm/"
#define  DEFAULT_FONT_SUFFIX     "pfb"
#define  RES                           72.0
typedef  struct {
    unsigned char       font_num;
    unsigned long       cnsfc   ;  /* current number of same-fonted characters */
}   font_changes_type;
typedef  struct {
             long       scale    ;
             long       design   ;
             char       name[512]; /* full name of font */
    unsigned char       a, l     ; /* 8A9Jinx - Pip xchgd rows wi *name so ucharz r 2gethr (!2b confuzd wi UChr tho ;) ) */
    unsigned char       font_num ;
}   font_type;
typedef  struct {
             long       maxv            ;
             long       maxh            ;
             int        maxstackdepth   ;
    unsigned long       num_chars       ;
             long       num_pages       ;
             long       num_fonts       ;
    unsigned long       num_font_changes;
    font_changes_type  *font_changes    ;
    font_type          *fonts           ;
}   stats_type;
typedef  struct {
    cairo_glyph_t      *proto_glyphs;
            gint16        width     ;
            gint16       height     ;
    stats_type         *  stats     ;
    FT_Library         *library     ;
    cairo_font_face_t **font_faces  ;
             double     border_width;
    GdkColor            bgcolor     ;
}   datatype1;
typedef  struct {
         long                h,  v,  w,  x,y,z;
}   state_type; /* ignoring hh, vv */
unsigned char         get_byte(                FILE               *dvi             );
         char      signed_byte(                FILE               *dvi             );
unsigned int      get_two_bytes(               FILE               *dvi             );
         int       signed_pair(                FILE               *dvi             );
unsigned long   get_three_bytes(               FILE               *dvi             );
         long       signed_trio(               FILE               *dvi             );
         long       signed_quad(               FILE               *dvi             );
void            get_stats(                     stats_type         *stats           );
void            get_proto_glyphs_font_changes( cairo_glyph_t     **proto_glyphs    ,
                                               stats_type         *stats           ,
                                               FT_Face            *faces           );
static gboolean expose_event_callback(         GtkWidget          *widget          ,
                                               GdkEventExpose     *event           ,
                                               gpointer            data            );
void            copy_glyphs(                   datatype1          *data            ,
                                               cairo_glyph_t      *      glyphs    );
void            adv_thru_argumented_opcodes(   FILE               *dvi             ,
                                               unsigned char       b               );
void            adv_thru_preamble(             FILE               *dvi             );
unsigned long   get_width(                     unsigned char       index           ,
                                               FT_Face            *face            ,
                                               stats_type         *stats           ,
                                               unsigned char       font_num        );
void            adv_to_font_defs(              FILE               *dvi             );
void            adv_thru_fnt_def_params(       FILE               *dvi             ,
                                               stats_type         *stats           , 
                                               unsigned char       cur_oc          );
unsigned char   adv_thru_cur_op_call(          FILE               *dvi             ,
                                               unsigned int       *args_len        );
void            show_glyphs(                   cairo_t            *cr              ,
                                               cairo_glyph_t      *      glyphs    ,
                                               stats_type         *stats           ,
                                               cairo_font_face_t **font_faces      );
void            load_all_font_changes_into_cr( cairo_t            *cr              ,
                                               stats_type         *stats           ,
                                               font_changes_type  *font_changes_end);
void            get_num_chars_num_font_changes(stats_type         *stats           ,
                                               FILE               *dvi             );
void            handle_fnt_num(                unsigned long      *cfci            , stats_type *stats, unsigned long *pci,
                                               stats_type         *stats           ,
                                               unsigned long      *pci             ,
                                               unsigned long       cci             ,
                                               unsigned char       cur_oc          );
void            get_num_fonts (                stats_type         *stats           ,
                                               FILE               *dvi             );
unsigned char   get_font_index(                font_type          *fonts           ,
                                               unsigned char       font_num        );
/*       double h_p(                           cairo_glyph_t             glyph     ,
                                                        double     w_p             );
         double v_p(                           cairo_glyph_t             glyph     ,
                                                        double     s_p             ); */
void            scale_glyphs(                  cairo_glyph_t      *      glyphs    ,
                                               unsigned long       num_chars       ,
                                                       gint16      w_p             ,
                                                        double     thickness       );
         double x_p(                                    double     h_pu            ,
                                                        double     w_p             );
         double y_p(                                    double     v_pu            ,
                                                        double     w_p             ,
                                                        double     thickness       );
void            draw_page_dividers(            cairo_t            *cr              ,
                                                        long       num_pages       ,
                                                        double     thickness       ,
                                                        double     page_width      ,
                                               GdkColor           *color           );
         long   load_font(                              char      *full_font_path  ,
                                               unsigned char     **font_file       );
         long   get_final_pos(                 FILE               *file            );
/***************************************************************/
gint config_event_callback(GtkWidget *widget, GdkEventConfigure *event,
                           gpointer data)
{
    datatype1 *_data;
    static GdkEventExpose expose_event;

    GtkWidget *scrolled_window, *drawing_area;

    scrolled_window = GTK_WIDGET( 
        gtk_container_get_children(GTK_CONTAINER(widget))->data);

    drawing_area = GTK_WIDGET(
        gtk_container_get_children(GTK_CONTAINER(scrolled_window))->data);
    
    _data = (datatype1 *) data;
    _data->border_width = gtk_container_get_border_width(GTK_CONTAINER(widget));

    expose_event.type = GDK_EXPOSE;
    expose_event.window = drawing_area->window;
    expose_event.send_event = TRUE;
    expose_event.area.x = 0;
    expose_event.area.y = 0;
    expose_event.area.width = _data->width = 
        event->width - 2 * _data->border_width; 
    expose_event.area.height = _data->height = 
        event->height - 2 * _data->border_width;
    expose_event.region = gdk_region_rectangle(&(expose_event.area));
    expose_event.count= 0;
    expose_event_callback(drawing_area, &expose_event, data);  
    
    return FALSE; 
}

void scale_glyphs(cairo_glyph_t *glyphs, unsigned long num_chars, 
                  gint16 w_p, double thickness)
{
    unsigned long i;

    for (i = 0; i < num_chars; i++) {
        /*
        glyphs[i].x = round((h_p(glyphs[i], (double) w_p))); 
        glyphs[i].y = round((v_p(glyphs[i], (double) w_p * R_IN / W_IN))); */

        glyphs[i].x = x_p(glyphs[i].x, (double) w_p);
        glyphs[i].y = y_p(glyphs[i].y, (double) w_p, thickness);
    }    
}

void draw_page_dividers(cairo_t *cr, long num_pages, double thickness,  
                        double page_width, GdkColor *color)
{
    int i;

    cairo_set_source_rgb(cr, (double) color->red/ 65535.0, 
                             (double) color->green/65535.0, 
                              (double) color->blue/65535.0);

    for (i = 0; i < num_pages - 1; i++) {
        cairo_rectangle(cr, 0, (i + 1) * page_width * R_IN / W_IN + 
                                i * thickness, page_width, thickness); 
        cairo_fill(cr);
    }
}

/* Remember to use cairo_save to handle multiple fonts */
static gboolean expose_event_callback(GtkWidget *widget, GdkEventExpose *event,
                                     gpointer data)
{
    datatype1 *_data;
    cairo_t *cr;
    int new_length;
    double em = 10.00003, pppt;
    cairo_glyph_t *glyphs; 

    _data = (datatype1 *) data;
    
    glyphs = g_slice_alloc(_data->stats->num_chars * sizeof(cairo_glyph_t));


/*    new_length = round(((double) _data->height) * 
                       ((double) _data->stats->num_pages) * 
                        INIT_PAGE_LENGTH_ACT / INIT_PAGE_LENGTH_DISP);*/

    new_length = round(((double) _data->stats->num_pages) * 
                       ((double) _data->width) * R_IN / W_IN); 

    gtk_widget_set_size_request(widget, -1, new_length);

    pppt = _data->width / (W_IN * PT_PER_IN); 
    gdk_window_clear(widget->window);

    cr = gdk_cairo_create(widget->window);
    draw_page_dividers(cr, _data->stats->num_pages, _data->border_width,
                       _data->width, &(_data->bgcolor));
    cairo_set_source_rgb(cr, 0, 0, 0);
    cairo_set_font_size(cr, em * pppt);

    copy_glyphs(_data, glyphs);
    scale_glyphs(glyphs, _data->stats->num_chars, _data->width, 
                 _data->border_width);

    show_glyphs(cr, glyphs, _data->stats, _data->font_faces); 

    g_slice_free1(_data->stats->num_chars * sizeof(cairo_glyph_t), glyphs);
    cairo_destroy(cr);
    
    return FALSE;
}


void show_glyphs(cairo_t *cr, cairo_glyph_t *glyphs, stats_type *stats,
                 cairo_font_face_t **font_faces)
{
    int fci;    /* font change index */

    for (fci = 0; fci < stats->num_font_changes; fci++) {
        cairo_set_font_face(cr, 
              font_faces[get_font_index(stats->fonts, 
                                        stats->font_changes[fci].font_num)]);
        cairo_show_glyphs(cr, glyphs, stats->font_changes[fci].cnsfc);
        glyphs += stats->font_changes[fci].cnsfc;
    } 
}

/*
double h_p(cairo_glyph_t glyph, double w_p)
{
    return (w_p * ((L_IN/W_IN)*(glyph.x - 1.0/2.0) + 1.0/2.0));
}

double v_p(cairo_glyph_t glyph, double s_p)
{
    return (s_p * ((S_IN/R_IN)*(glyph.y - 1.0/2.0) + 1.0/2.0));
}
*/

double x_p(double h_pu, double w_p)
{
    long res;

    res = w_p / 8.5;

    return w_p * h_pu + res * (1.0 - 2.0 * h_pu);
}

long Floor(double n)
{
    if ((double) floor(n) == n)
        return (long) n - 1;
    return floor(n);
}

double y_p(double v_pu, double w_p, double thickness)
{
/*    return (v_pu - (double)floor(v_pu)) * (w_p * R_IN / W_IN - 2.1 * RES) +
           RES * (1.0 + R_IN * (double)floor(v_pu)); */
    long res;

    res = w_p / 8.5;

    return (double)Floor(v_pu) * (R_IN * res + thickness) + 
            (v_pu - (double)Floor(v_pu)) *
           (w_p * R_IN / W_IN - 2.1 * res) + res;
}

/* reads a word of n bytes from stream, with 0 <= n <= 255 */
void readword(unsigned short n, FILE *stream, unsigned char *word)
{
    fread((void *) word, sizeof(char), n, stream); 
}

/* assumes file is open and is at the beginning; ultimately leaves it 
 * in that state */
long get_final_pos(FILE *file) 
{
    fpos_t fp[1];

    fseek(file, 0, SEEK_END);
    fgetpos(file, fp); 
    rewind(file);
    return (int) fp->__pos; 
}

void clearbuf(unsigned char *buf, int len)
{
    int i;

    for (i = 0; i < len; i++) {
        buf[i] = 0;
    }
}

void get_num_pages_stack_depth(stats_type *stats, FILE *dvi)
{
    int q;             /* pointer to post location */
    long cur_pos;
    unsigned char byte;
    
    cur_pos = get_final_pos(dvi);

    do {
        fseek(dvi, cur_pos - 1, SEEK_SET);
        byte = get_byte(dvi);
        cur_pos--;
    } while (byte == 223);

    /* skip past identification byte to beginning of q */
    fseek(dvi, cur_pos - 4, SEEK_SET); 
    
    q = signed_quad(dvi);

    fseek(dvi, q, SEEK_SET);

    get_byte(dvi);         /* post op-code */ 
    signed_quad(dvi);    /* final bop */
    signed_quad(dvi);    /*numerator */
    signed_quad(dvi);    /* denominator */
    signed_quad(dvi);    /* mag */

    stats->maxv = (long) signed_quad(dvi);
    stats->maxh = (long) signed_quad(dvi);
    stats->maxstackdepth =  get_two_bytes(dvi);
    stats->num_pages = (long) get_two_bytes(dvi);
}

unsigned char get_byte(FILE *dvi)
{
    unsigned char word[1];
    
    readword(1, dvi, word);
    
    return word[0];
}

char signed_byte(FILE *dvi)
{
    unsigned char word[1];

    readword(1, dvi, word);
    
    if (word[0] < 128)
        return word[0];
    else
        return word[0] - 256;
}

unsigned int get_two_bytes(FILE *dvi)
{
    unsigned char word[2];

    readword(2, dvi, word);
    
    return 256*word[0] + word[1];
}

int signed_pair(FILE *dvi)
{
    unsigned char word[2];

    readword(2, dvi, word);

    if (word[0] < 128) 
        return word[0]*256 + word[1];
    return (word[0] - 256) * 256 + word[1];
}

unsigned long get_three_bytes(FILE *dvi)
{
    unsigned char word[3];

    readword(3, dvi, word);    
    return (word[0]*256 + word[1])*256 + word[2];
}

long signed_trio(FILE *dvi)
{
    unsigned char word[3];

    readword(3, dvi, word);
    if (word[0] < 128)
        return (word[0] * 256 + word[1]) * 256 + word[2];
    return ((word[0] - 256)*256 + word[1]) * 256 + word[2];
}

long signed_quad(FILE *dvi)
{
    unsigned char word[4];

    readword(4, dvi, word);
    if (word[0] < 128)
        return ((word[0] * 256 + word[1]) * 256 + word[2])*256 + word[3];
    return (((word[0] - 256) * 256 + word[1])*256 + word[2])*256 + word[3];
}


void adv_thru_preamble(FILE *dvi)
{
    int i;
    int k;            /* number of bytes of comment */

    rewind(dvi);

    get_byte(dvi);    /* pre-amble opcode */
    get_byte(dvi);    /* identifier byte */
    signed_quad(dvi);    /* numerator */
    signed_quad(dvi);    /* denominator */
    signed_quad(dvi);    /* magnitude */
    k = get_byte(dvi);        /* k */
    for (i = 0; i < k; i++)    /* advance through comments */
        get_byte(dvi);
}

/* assumes dvi is already open */

/* advance thru bops and fnt_def; returns last non-nop-fnt-def byte
 * Returns 1 if one of those two commands were found; 0 otherwise */

unsigned char adv_thru_nops_fnt_defs(FILE *dvi)
{
    unsigned char ret = 0;

    while ((ret = get_byte(dvi)) == 138 || (ret >= 243 && ret <= 246))
        ret = 1;

    return ret;
}


/* boolean: returns number of bytes of arguments, 0 if none 
 * leaves FILE* unchanged; add zs later, maybe leave FILE* 
 * unchanged more elegantly! */
unsigned char argus(unsigned char byte, FILE *dvi)
{
    unsigned char a,l;
    int orig_pos;
    long k;
    fpos_t fp[1];

    fgetpos(dvi, fp);
    orig_pos = fp->__pos;
    
    switch (byte) {
        case 139:
            return 44;
          case 143: case 148: case 153: case 157 : case 162: case 167 : 
            return 1;
        case 144: case 149: case 154: case 158:  case 163: case 168 :
            return 2;
        case 145: case 150: case 155:  case 159:  case 164: case 169 :
            return 3;
        case 146: case 151: case 156: case 160: case 165: case 170 :
            return 4;
        case 239:
            k = (long) get_byte(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return k + 1;
        case 240:
            k = (long) signed_pair(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return k + 2;
        case 241:
            k = (long) signed_trio(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return k + 3;
        case 242:
            k = signed_quad(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return k + 4;
        case 243:
            fseek(dvi, orig_pos + 1 + 4*3, SEEK_SET);
            a = get_byte(dvi);
            l = get_byte(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return (1 + 4*3 + 2 + a + l);
        case 244:
            fseek(dvi, orig_pos + 2 + 4*3, SEEK_SET);
            a = get_byte(dvi);
            l = get_byte(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return (2 + 4*3 + 2 + a + l);
        case 245:
            fseek(dvi, orig_pos + 3 + 4*3, SEEK_SET);
            a = get_byte(dvi);
            l = get_byte(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return (3 + 4*3 + 2 + a + l);
        case 246:
            fseek(dvi, orig_pos + 4 + 4*3, SEEK_SET);
            a = get_byte(dvi);
            l = get_byte(dvi);
            fseek(dvi, orig_pos, SEEK_SET);
            return (4 + 4*3 + 2 + a + l);
    
    }
    return 0;
}

unsigned char adv_thru_cur_op_call(FILE *dvi, unsigned int *args_len)
{
    unsigned char byte;
    fpos_t fp[1];

    byte = get_byte(dvi); 
    if ((*args_len = argus(byte, dvi))) {
        fgetpos(dvi, fp);
        fseek(dvi, fp->__pos + *args_len, SEEK_SET); 
    } 

    return byte;
}

void get_num_chars_num_font_changes(stats_type *stats, FILE *dvi)
{
    unsigned char cur_oc;    /*current opcode */ 
    unsigned int dummy;
    int i1, i2;

    stats->num_chars = 0;
    stats->num_font_changes = 0;

    adv_thru_preamble(dvi);

    for (i1 = 0; i1 < stats->num_pages; i1++) {
        get_byte(dvi);        /* bop opcode */
        for (i2 = 0; i2 < 11; i2++)
            signed_quad(dvi);
        while ((cur_oc = adv_thru_cur_op_call(dvi, &dummy))) {
            if (!(cur_oc >> 7)) {
                stats->num_chars++;
            } else if (171 <= cur_oc && cur_oc <= 235) {
                stats->num_font_changes++;
            }
        }
    }
}

void adv_thru_fnt_def_params(FILE *dvi, stats_type *stats, unsigned char cur_oc)
{
    fpos_t fp[1];
    unsigned char a, l;

    fgetpos(dvi, fp);
    fseek(dvi, (int) (fp->__pos) + (cur_oc - 243 + 1) + 12, SEEK_SET);
    a = get_byte(dvi);
    l = get_byte(dvi);
    fgetpos(dvi, fp);
    fseek(dvi, (int) (fp->__pos) + a + l, SEEK_SET);
}


/* assumes dvi is currently pointing to post */
void adv_to_font_defs(FILE *dvi)
{
    fpos_t fp[1];

    fgetpos(dvi, fp);
    /* adv thru post's params */
    fseek(dvi, fp->__pos + 1 + 4*6 + 2*2, SEEK_SET);
}

/* doesn't fseek back to original file position.  Must do that explicitly 
 * Assumes dvi is at position q*/
void get_num_fonts(stats_type *stats, FILE *dvi)
{
    unsigned char byte;
    stats->num_fonts = 0;
    
    adv_to_font_defs(dvi);
    byte = get_byte(dvi);

    /* while get font_def? byte != post_post */
    do {    
        if (243 <= byte && byte <= 246) {
            if (byte > 243) { 
                printf("TeX82 didn't generate your DVI file.\n");
                printf("byte is %u\n", byte);
            }
            stats->num_fonts++;
        }
        adv_thru_fnt_def_params(dvi, stats, byte);
        byte = get_byte(dvi);
    } while (byte != 249);    
}


/* assumes at most 256 fonts */
void get_font_info(stats_type *stats, FILE *dvi)
{
    long q, cur_pos;             /* pointer to post location */
    int j, cfi;    /* cfi is current_font_index */
    unsigned char byte;
    fpos_t fp[1];
    unsigned char cur_char;

    cfi = 0;
    cur_pos = get_final_pos(dvi);

    do {
        fseek(dvi, cur_pos - 1, SEEK_SET);
        byte = get_byte(dvi);
        cur_pos--;
    } while (byte == 223);

    /* skip to beginning of q (assumes we skipped identification byte) */
    fseek(dvi, cur_pos - 4, SEEK_SET); 

    q = signed_quad(dvi);

    fseek(dvi, q, SEEK_SET);
    get_num_fonts(stats, dvi);
    fseek(dvi, q, SEEK_SET);
    
    stats->fonts = g_slice_alloc(stats->num_fonts * sizeof(font_type));
    
    adv_to_font_defs(dvi);
    byte = get_byte(dvi);

    /* while get font_def? byte != post_post */
    do {    
        if (243 <= byte && byte <= 246) {
            if (byte > 243) {
                printf("TeX82 didn't generate your DVI file.\n");
            }
            fgetpos(dvi, fp);
            stats->fonts[cfi].font_num  = get_byte(dvi);    
            fseek(dvi, (int) (fp->__pos) + (byte - 243 + 1) + 4, SEEK_SET);
            stats->fonts[cfi].scale  = signed_quad(dvi);
            stats->fonts[cfi].design = signed_quad(dvi);
            stats->fonts[cfi].a = get_byte(dvi);
            stats->fonts[cfi].l = get_byte(dvi);
            for (j = 0, stats->fonts[cfi].name[0] = '\0'; 
                 j < stats->fonts[cfi].a + 
                      stats->fonts[cfi].l; j++) {
                cur_char = get_byte(dvi);
                stats->fonts[cfi].name[j] = cur_char;
            }
            stats->fonts[cfi].name[j] = '\0';
        }
        byte = get_byte(dvi);
        cfi++;
    } while (byte != 249);    
    
}

void get_stats(stats_type *stats)
{
    FILE *dvi;
    char l[MAXLINE];     /* current line */
    char *lp[1];
/*    char *ss_pos; */


    *lp = l;

    dvi = fopen(SAMPLE_DVI, "r");
    get_num_pages_stack_depth(stats, dvi); 
    get_num_chars_num_font_changes(stats, dvi);
    get_font_info(stats, dvi);

    fclose(dvi);
}


/* remember to free glyphs when expose_event yields different DVI files! */

void copy_glyphs(datatype1 *data, cairo_glyph_t *glyphs)
{
    int i; 

    for (i = 0; i < data->stats->num_chars; i++) {
        glyphs[i].x = data->proto_glyphs[i].x;
        glyphs[i].y = data->proto_glyphs[i].y;
        glyphs[i].index = data->proto_glyphs[i].index;
    }
}

/* no overflow increment.  Assumes initial value is ULONG_MAX */
void no_of_inc(unsigned long *num)
{
  if (~*num)
    *num += 1;
  else
       *num = 0;
}

void init_state(state_type *state, int maxstackdepth)
{
    int i;

    for (i = 0; i < maxstackdepth; i++) {
        state[i].h = state[i].v = state[i].w = state[i].x = state[i].y =
        state[i].z = 0;
    }
} 

void get_proto_glyphs_font_changes(cairo_glyph_t **proto_glyphs, 
                                   stats_type *stats, FT_Face *faces)
{
    FILE *dvi;
    fpos_t fp[1];    /* file position */
    state_type *state;
    state_type cur_state;
    int p_i = 0;        /* page index.  1 less than current page num */ 
    unsigned char cur_oc, cur_fn;/* current op-code and current font_number */
    unsigned long pci;/* previous char index: for use by ...->font_changes */
    unsigned int cur_args_len;    /* length in bytes of arguments of current 
                                   op_code */

    int s = 0;     /* current stack-depth */
    unsigned long cci = ULONG_MAX;    /* current character index */
    unsigned long cfci = ULONG_MAX;    /* current font change index */

    state = g_slice_alloc(stats->maxstackdepth * sizeof(state_type));
    *proto_glyphs = g_slice_alloc(stats->num_chars * sizeof(cairo_glyph_t));
    stats->font_changes = g_slice_alloc(stats->num_font_changes * 
                                        sizeof(font_changes_type));

    dvi = fopen(SAMPLE_DVI, "r");

    adv_thru_preamble(dvi);
            /* must take care of sets and puts and putchars */ 
            /* am using this advancing thru then tracing back 
             * algorithm to handle random fnt_defs */
        while ((cur_oc = adv_thru_cur_op_call(dvi, &cur_args_len)))
            if (cur_oc == 139) {
                cur_state.h = cur_state.v = cur_state.w = cur_state.x = 
                cur_state.y = cur_state.z = 0;
                init_state(state, stats->maxstackdepth);
            } else if (cur_oc == 140) {
                p_i++;
            } else if (!(cur_oc >> 7)) {
                no_of_inc(&cci);
                (*proto_glyphs)[cci].index = FT_Get_Char_Index(
                    faces[get_font_index(stats->fonts, cur_fn)], cur_oc); 

                (*proto_glyphs)[cci].x = ((double) cur_state.h) / MAXH; 
                (*proto_glyphs)[cci].y = (double) p_i + 
                                         ((double) cur_state.v) / MAXV; 
                cur_state.h += get_width(cur_oc, 
                    &faces[get_font_index(stats->fonts, cur_fn)], 
                    stats, cur_fn); 
                /*cur_state.h += 300000;*/
            } else if (cur_oc == 141) /* push */ {
                state[s].h = cur_state.h;
                state[s].v = cur_state.v;
                state[s].w = cur_state.w;
                state[s].x = cur_state.x;
                state[s].y = cur_state.y;
                state[s].z = cur_state.z;
                s++; 
            } else if (cur_oc == 142) /* pop */ {
                s--;
                cur_state.h = state[s].h;
                cur_state.v = state[s].v;
                cur_state.w = state[s].w;
                cur_state.x = state[s].x;
                cur_state.y = state[s].y;
                cur_state.z = state[s].z; 
            } else if (143 <= cur_oc && cur_oc <= 146) {
                fgetpos(dvi, fp); 
                switch (cur_oc) { 
                    case 143 :        /* right1*/ 
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.h += signed_byte(dvi);
                        break;        
                    case 144 :         /* right2*/ 
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.h += signed_pair(dvi);
                        break;        
                    case 145 :        /* right3*/ 
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.h += signed_trio(dvi);
                        break;        
                    case 146 :        /* right4*/ 
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.h += signed_quad(dvi);
                        break;
                }
            } else if (cur_oc == 147)          /* w0 */
                cur_state.h += cur_state.w; 
              else if (148 <= cur_oc && cur_oc <= 151) {
                fgetpos(dvi, fp); 
                switch (cur_oc) {
                    case 148:                /* w1 */
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.w  = signed_byte(dvi);
                        break;
                    case 149:                /* w2 */
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.w  = signed_pair(dvi);
                        break;
                    case 150:                /* w3 */
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.w  = signed_trio(dvi);
                        break;
                    case 151:                /* w4 */
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.w  = signed_quad(dvi);
                        break;
                }
                cur_state.h += cur_state.w;
            } else if (cur_oc == 152)        /* x0 */ 
                cur_state.h += cur_state.x;
              else if (153 <= cur_oc && cur_oc <= 156) {
                fgetpos(dvi, fp); 
                switch (cur_oc) {
                    case 153:                /* x1 */
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.x = signed_byte(dvi);
                        break;
                    case 154:                /* x2 */
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.x = signed_pair(dvi);
                        break;
                    case 155:                /* x3 */
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.x = signed_trio(dvi);
                        break;
                    case 156:                /* x4 */
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.x = signed_quad(dvi);
                        break;
                cur_state.h += cur_state.x;
                }
            } else if (157 <= cur_oc && cur_oc <= 160) {
                fgetpos(dvi, fp); 
                switch (cur_oc) {
                    case 157:                /* down1 */
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.v += signed_byte(dvi); 
                        break;
                    case 158:                /* down2 */
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.v += signed_pair(dvi); 
                        break;
                    case 159:                /* down3 */
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.v += signed_trio(dvi); 
                        break;
                    case 160:                /* down4 */
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.v += signed_quad(dvi); 
                        break;
                }
            } else if (cur_oc == 161)         /* y0 */
                cur_state.v += cur_state.y;
              else if (162 <= cur_oc && cur_oc <= 165) {
                fgetpos(dvi, fp); 
                switch (cur_oc) {
                    case 162:                /* y1 */
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.y = signed_byte(dvi);
                        break;
                    case 163:                /* y2 */
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.y = signed_pair(dvi);
                        break;
                    case 164:                /* y3 */
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.y = signed_trio(dvi);
                        break;
                    case 165:                /* y4 */
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.y = signed_quad(dvi);
                        break;
                }
                cur_state.v += cur_state.y;

            } else if (cur_oc == 166) {
                cur_state.v += cur_state.z;
            } else if (167 <= cur_oc && cur_oc <= 170) {
                fgetpos(dvi, fp);
                switch (cur_oc) {
                    case 167:
                        fseek(dvi, fp->__pos - 1, SEEK_SET);
                        cur_state.z = signed_byte(dvi);
                        break;
                    case 168:
                        fseek(dvi, fp->__pos - 2, SEEK_SET);
                        cur_state.z = signed_pair(dvi);
                        break;
                    case 169:
                        fseek(dvi, fp->__pos - 3, SEEK_SET);
                        cur_state.z = signed_trio(dvi);
                        break;
                    case 170:
                        fseek(dvi, fp->__pos - 4, SEEK_SET);
                        cur_state.z = signed_quad(dvi);
                        break;
                }
                cur_state.v += cur_state.z;
            } else if (171 <= cur_oc && cur_oc <= 234) {
                cur_fn = cur_oc - 171;
                handle_fnt_num(&cfci, stats, &pci, cci, cur_oc);
                /* remember to consider case of nops appearing in-between */
            }
    g_slice_free1(stats->maxstackdepth * sizeof(state_type), state);
    fclose(dvi);
}


void handle_fnt_num(unsigned long *cfci, stats_type *stats, unsigned long *pci,
                    unsigned long cci, unsigned char cur_oc)
{
    no_of_inc(cfci);
    if (*cfci) {
        if (~(*pci)) {
            stats->font_changes[*cfci-1].cnsfc = cci - *pci + 1;
        } else {
            stats->font_changes[*cfci-1].cnsfc = cci + 1; 
        }
        *pci = cci + 1;
    } else {
        *pci = ULONG_MAX;
        stats->font_changes[*cfci].cnsfc = 0;
    }
    stats->font_changes[*cfci].font_num = cur_oc - 171;

    if (*cfci == stats->num_font_changes - 1) {
        stats->font_changes[*cfci].cnsfc = stats->num_chars - cci - 1;
    }
}

/* get font_index corresponding to given font number */

unsigned char get_font_index(font_type *fonts, unsigned char font_num)
{
    int i = 0;

    while (fonts[i].font_num != font_num)
        i++;

    return i;
}


/* Returns width of character in sp (DVI) units */
unsigned long get_width(unsigned char index, FT_Face *face, stats_type *stats,
                        unsigned char font_num)
{
    unsigned long width;

    FT_Load_Glyph(*face, FT_Get_Char_Index(*face, index), FT_LOAD_CROP_BITMAP);
    width = ((*face)->glyph->advance.x);
    return (unsigned long) 
        round((double)width * TFM_PER_FT * 
              (double) 
              (stats->fonts[get_font_index(stats->fonts, font_num)].scale));
}


long load_font(char *full_font_path, unsigned char **font_file)
{
    FILE *ff;    /* font file */
    long file_length;

    ff = fopen(full_font_path, "r");
    file_length = get_final_pos(ff) + 1;
    *font_file = g_slice_alloc(file_length * sizeof(unsigned char *)); 
    fread((void *) *font_file, sizeof(char), (size_t) file_length, ff);
    fclose(ff);

    return file_length;
}

void get_set_FT_faces(FT_Face **faces, FT_Library *library, stats_type *stats,
                      unsigned char ***font_files, long **font_files_lengths)
{
    int i, j, error = 0;
    char *full_font_path;
    int pt;

    *faces = g_slice_alloc(stats->num_fonts * sizeof(FT_Face));
    *font_files = g_slice_alloc(stats->num_fonts * sizeof(unsigned char **));
    *font_files_lengths = g_slice_alloc(stats->num_fonts * sizeof(long));

    for (i = 0; i < stats->num_fonts; i++) {
        j = 0;
        if (stats->fonts[i].name[0] == '/') {
            strcpy(full_font_path, stats->fonts[i].name);
        } else {
            full_font_path = 
                kpse_find_file(stats->fonts[i].name, kpse_type1_format, 0);
        }

        (*font_files_lengths)[i] = 
            load_font(full_font_path, &((*font_files)[i]));
    
        while (!isdigit(stats->fonts[i].name[j]))
            j++;
    
        pt = atoi(stats->fonts[i].name + j); 
        error = FT_New_Memory_Face(*library, (*font_files)[i], 
                                   (*font_files_lengths)[i], 0, &((*faces)[i])); 

/*
        printf("%d\n", (int)round(((double) pt) * RES * INIT_PAGE_WIDTH_DISP 
                            *((double) stats->fonts[i].scale)    / 
                          (PT_PER_IN * HORIZ_RES * 
                           ((double) stats->fonts[i].design))));*/
        FT_Select_Charmap((*faces)[i], 1094992451);
    
        error = FT_Set_Char_Size(
                    (*faces)[i], (int) 
                    (round(((double) pt) * RES * INIT_PAGE_WIDTH_DISP 
                            *((double) stats->fonts[i].scale)    / 
                          (PT_PER_IN * HORIZ_RES * 
                           ((double) stats->fonts[i].design)))) * 64, 
                    0, 0, 0);
    }

    if (error) {
        fprintf(stderr, "Unknown File Format\n");
    }
}

void get_cairo_font_faces(cairo_font_face_t ***font_faces, FT_Face *faces, 
                          long num_fonts)
{
    int i;

    *font_faces = g_slice_alloc(num_fonts * sizeof(cairo_font_face_t *));

    for (i = 0; i < num_fonts; i++) {
        (*font_faces)[i] = 
            cairo_ft_font_face_create_for_ft_face(faces[i], 
                                                  FT_LOAD_CROP_BITMAP);
    }
}

int main(int argc, char *argv[])
{
    GtkWidget *drawing_area, *window, *scrolled_window, *vbox;
    FT_Library     library;
    FT_Face     *faces;            /* array of faces */ 
    cairo_font_face_t **font_faces; /* array of "cairo_font_face *"s */
    datatype1 data1;
    const GdkColor white = {0, 65535, 65535, 65535};
    const GdkColor gray = {0, 0xea60, 0xea60, 0xea60};

    stats_type stats;
    int error;
    int i;
    unsigned char **font_files;
    long *font_files_lengths;

/* glyphs_t will hold x = x_sp/l_sp, y = y_sp/s_sp
 * 0 <= x,y <= 1  */
    cairo_glyph_t *proto_glyphs; 


/*    GSList *list; */

    kpse_set_program_name(argv[0], NULL);
    kpse_init_prog(argv[0], 300, NULL, "cmr10");

    get_stats(&stats); 

    error = FT_Init_FreeType(&library);
    if (error) {
        fprintf(stderr, "Initialization of library failed");
        return 1;
    }

    get_set_FT_faces(&faces, &library, &stats, &font_files, 
                     &font_files_lengths);

    get_cairo_font_faces(&font_faces, faces, stats.num_fonts);

    if (error == FT_Err_Unknown_File_Format) {
        return 1;
    } else if (error) {
        fprintf(stderr, "Font file could not be opened or read or "
                        "is broken\n");
        return 1;
    }

    get_proto_glyphs_font_changes(&proto_glyphs, &stats, faces);

/* add for loop of FT_Dones
    FT_Done_Face(face1); */

/*    g_mem_set_vtable (glib_mem_profiler_table); */

    gtk_init(&argc, &argv);


    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_widget_modify_bg(window, GTK_STATE_NORMAL, &gray);
    gtk_widget_set_size_request(window, INIT_WIN_WIDTH/10, INIT_WIN_LENGTH/10);
    gtk_window_resize(GTK_WINDOW(window), INIT_WIN_WIDTH, INIT_WIN_LENGTH);

    vbox = gtk_vbox_new(TRUE, 0);
    

    drawing_area = gtk_drawing_area_new();
/*    gtk_widget_set_size_request(drawing_area, -1, 
                                stats.num_pages * INIT_PAGE_LENGTH_ACT); */
    gtk_container_set_border_width(GTK_CONTAINER(window),
                                   (INIT_WIN_WIDTH - INIT_PAGE_WIDTH_DISP) / 2); 

    scrolled_window = gtk_scrolled_window_new(NULL, NULL);

    gtk_container_set_border_width(GTK_CONTAINER(scrolled_window), 0); 

    gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window), 
                                   GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);

    gtk_widget_modify_bg(drawing_area, GTK_STATE_NORMAL, &white);

    gtk_scrolled_window_add_with_viewport(
            GTK_SCROLLED_WINDOW(scrolled_window), drawing_area);     

    gtk_container_add(GTK_CONTAINER(window), scrolled_window);

    gtk_widget_set_events(drawing_area, GDK_ALL_EVENTS_MASK);    
    gtk_widget_realize(drawing_area); 

    data1.proto_glyphs = proto_glyphs;
    data1.library = &library;
    data1.font_faces = font_faces; 
    data1.width = INIT_PAGE_WIDTH_DISP; 
    data1.height = INIT_PAGE_LENGTH_DISP;
    data1.stats = &stats;
    data1.bgcolor.red = gray.red;
    data1.bgcolor.green = gray.green;
    data1.bgcolor.blue = gray.blue;

    gtk_widget_add_events(window, GDK_ALL_EVENTS_MASK);

    g_signal_connect(G_OBJECT(drawing_area), "expose_event", 
                     G_CALLBACK(expose_event_callback), (gpointer) &data1);

    g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(gtk_main_quit), 
                     NULL);

    g_signal_connect(G_OBJECT(window), "configure_event", 
                     G_CALLBACK(config_event_callback), (gpointer) &data1);

    gtk_widget_show_all(window);

    gtk_main();

    for (i = 0; i < stats.num_fonts; i++) {
        FT_Done_Face(faces[i]);
        cairo_font_face_destroy(font_faces[i]);
        g_slice_free1(font_files_lengths[i]*sizeof(char), font_files[i]);
    }

    g_slice_free1(stats.num_fonts * sizeof(long), font_files_lengths);
    g_slice_free1(stats.num_fonts * sizeof(unsigned char *), font_files);

    FT_Done_FreeType(library);

    g_slice_free1(stats.num_chars * sizeof(cairo_glyph_t), proto_glyphs);
    g_slice_free1(stats.num_font_changes * sizeof(font_changes_type),
                  stats.font_changes); 
    /*g_atexit(g_mem_profile);

    list = (GSList*) g_malloc(sizeof(GSList));
    list->next = (GSList*) g_malloc(sizeof(GSList));
    g_free(list->next); */

    g_slice_free1(stats.num_fonts * sizeof(cairo_font_face_t *), font_faces);
    g_slice_free1(stats.num_fonts * sizeof(FT_Face), faces);
    
    return 0;
}
