if (Form == undefined) var Form = { };

Form.Validator = function(form) {
  if (!form) {
    throw('A valid form was not passed in.');
  }
  this.form  = form;
  this.list  = [ ];
  this.stash = { };
};

Form.Validator.VERSION = '0.30';

// Form.Validator Class
Form.Validator.prototype = {

  // form that this object is validating
  form: null,

  // list of constraints
  list: null,

  // when validation fails, this is how you report your failure.
  report: null,

  // temporary storage for inter-object communication
  stash: null,

  // define a constraint for a field
  set: function(field, constraint, option) {
    if (!this.form[field]) {
      throw(field + " is not a valid form input");
    }

    var c = { };

    if (typeof(option) == 'string') {
      // onFailure message (for backwards compatibility)
      c.onFailure = option;
    } else {
      // assume it's an object w/ sane values
      c = option;
    }

    if (typeof(constraint) == 'string') {
      // predefined validator
      c.constraint = this[constraint];
    } else {
      // function reference w/ a custom validator
      c.constraint = constraint;
    }

    c.field = field;
    this.list.push(c);
  },

  // get constraint info for a field. 
  // (this can return more than 1 constraint)
  get: function(field) {
    var constraints = new Array();
    for (i in this.list) {
      var c = this.list[i];
      if (c.field == field || field == null) {
        constraints.push(c);
      }
    }
    return constraints;
  },

  // define how validation failures are handled
  reporter: function() {
    if (arguments.length == 0) {
      if (this.report == null) {
        // this is the default action
        this.report = new Form.Validator.Report.AlertAll(this);
      }
    } else {
      if (typeof(arguments[0]) == 'string') {
        // instantiate one of our built-in reports
        var proto   = 'Form.Validator.Report.' + arguments[0];
        var code    = 'new ' + proto + '(this);';
        this.report = eval(code);
      } else {
        // assume they gave as a validation action
        // object that can start(), run() and finish().
        this.report = arguments[0];
      }
    }
    return this.report;
  },

  // run validation tests
  // 0 params means run all the tests
  // 1 or more params means run the tests for the fields specified
  validate: function() {
    var i, j, c;
    var errors   = 0;
    var reporter = this.reporter();
    var constraints;

    // figure out what we have to validate and populate constraints array
    if (arguments.length == 0) {
      constraints = this.list;
    } else {
      constraints = [ ];
      for (i = 0; i < arguments.length; i++) {
        var field = arguments[i];
        var clist = this.get(field);
        for (j = 0; j < clist.length; j++) {
          constraints.push(clist[j]);
        }
      }
    }

    // actual validation begins here, iterating through constraints
    reporter.start(constraints);
    try {
      var ok;
      for (i = 0; i < constraints.length; i++) {
        c  = constraints[i];
        ok = c.constraint(this, c.field);
        if (!ok) { errors++ }
        reporter.run(ok, c);
      }
    }
    catch (e) {
      // alert(e);
    }
    reporter.finish();

    // if anything went wrong, return false
    if (errors > 0) {
      return false;
    } else {
      return true;
    }
  },

  // XXX - This is going to become Form.Validator.Report.AlertAll
  // This displays an alert box telling you what went wrong.
  /*
  validateAndAlert: function() {
    var messages = this.validate();
    if (messages.length > 0) {
      alert(messages.join("\n"));
      return false;
    }
  },
  */

  // VALIDATION FUNCTIONS

  // false is bad
  // true  is good

  // Make sure a field's value is not blank
  notBlank: function(self, field) {
    var blankness = new RegExp(/^\s*$/);
    if (self.form[field].value == '' || blankness.test(self.form[field].value)) {
      return false;
    } else {
      return true;
    }
  },
  // ...meaning, you can't be Blank; if you are, you messed up;
 
  // Make sure a field's value is not 0
  notZero: function(self, field) {
    if (self.form[field].value == "0") {
      return false;
    } else {
      return true;
    }
  },

  // METHODS THAT GENERATE VALIDATION CLOSURES
  makeOptional: function(f) {
    return function(fv, field) {
      if (fv.notBlank(fv, field)) {
        return f(fv, field);
      } else {
        return true;
      }
    }
  },

  // Make sure field is at least n characters long
  makeLengthMin: function(n) {
    return function(fv, field) {
      if (fv.form[field].value.length < n) {
        return false;
      } else {
        return true;
      }
    }
  },

  // Make sure field is not more than n characters long
  makeLengthMax: function(n) {
    return function(fv, field) {
      if (fv.form[field].value.length > n) {
        return false;
      } else {
        return true;
      }
    }
  },

  // Make sure field is at least n (or greater)
  makeValueMin: function(n) {
    return function(fv, field) {
      if (fv.form[field].value < n) {
        return false;
      } else {
        return true;
      }
    }
  },

  // Make sure field is at most n (or less).
  makeValueMax: function(n) {
    return function(fv, field) {
      if (fv.form[field].value > n) {
        return false;
      } else {
        return true;
      }
    }
  },

  // Make sure a field matches the given regex
  makeMatchRegex: function(regex) {
    return function(fv, field) {
      return regex.test(fv.form[field].value);
    }
  },

  // Make sure a field does not match the given regex
  makeNotMatchRegex: function(regex) {
    return function(fv, field) {
      return !regex.test(fv.form[field].value);
    }
  }

};

/*

=head1 NAME

Form.Validator - a framework for client-side form validation

=head1 SYNOPSIS

First, make a form with an C<onsubmit> handler:

  <form name="stuff"
    action="process_stuff.mas"
    method="post"
    onsubmit="return fv.validate()">

    name: 
      <input name="name" type="text"/><br/>

    category:
      <select name="category_id">
        <option value="0">Select a category</option>
        <option value="1"> cat 1 </option>
        <option value="2"> cat 2 </option>
        <option value="3"> cat 3 </option>
      </select>
      <br/>

    cost:
      <input name="cost" type="text"/><br/>

    <input type="submit" name="submit" value="Save" />
  </form>

Then, define the reporting method and your constraints:

  <script>
    fv = new Form.Validator(document.stuff);
    fv.reporter('AlertAll');    // show a pop-up with all errors
    fv.set('name',        'notBlank',           "Name is required.");
    fv.set('name',        fv.makeLengthMax(32), "Name is too long.");
    fv.set('category_id', 'notZero',            "Please pick a category.");
    fv.set('cost',        fv.makeValueMin(5),   "Cost must be 5 or greater.");
    fv.set('cost',        fv.makeValueMax(100), "Cost may not exceed 100.");
  </script>

At any time, you can change the way validation is reported:

  <script>
    fv.reporter('AlertAll');    // pop-up with all errors

    fv.reporter('AlertFirst');  // pop-up with first error

    fv.reporter('InnerHTML');   // errors placed in the innerHTML...
                                // ...of an element
                                // require a bit more setup.
                                // Please consult the docs for
                                // Form.Validator.Report.InnerHTML
                                // for the little details
                                // that make all the difference.
  </script>

Cliff's Notes:

  Learn to use set(), reporter(), and validate().

Demo Site: 

  http://asciicker.kicks-ass.org/x/form_validator_demo.html

=head1 DESCRIPTION


L<Form.Validator> provides a framework for form validation that allows
one to concisely define validation constraints.  The readability of the
code you have to write was of prime concern, and tangential to that was
the notion of keeping typing to a reasonable minimum.  The goal was to
provide an expressive API that would be easy to read as well as write,
requiring the programmer to only learn a few methods to do his work.

The method that you will be most concerned with will be C<set()>.  It is
through C<set()> that input fields will be associated with constraint
functions, and you'll call this method repeatedly for each constraint
you want to define.  (There is a lot of opportunity for vertical
alignment of parameters for those of you who are ASCII-artistically
inclined.)

The current collection of validation functions and function generators
is fairly small, but they should be expressive enough for almost any
need.  Learn them well, but when they're just not enough, know that
you can always write your own validation functions to test anything
else you need.

Finally, one of the most intersting features of L<Form.Validator> is
that you can choose different ways to report validation failure.  Using
the C<reporter()> method, you can tell a form validator to 'B<AlertAll>'
which means display an alert pop-up that shows all validation failures
upon unsuccessful validation.  If you want to be more modern, you can
use 'B<InnerHTML>'.  This makes it so that you can see error messages
being updated in divs or spans as you type into the form.  (For real
world examples of this technique, see L</INSPIRATION>.)

What's nice about this approach is that changing between different
reporting mechanisms is a fairly effortless task for the programmer.
This was the result of having a clean separation between the code that
does validation and the code that does error reporting.

The end result is a framework for form validation that (I hope) will
help a lot of programmers with their client-side validation needs.

=head1 METHODS

=head2 new Form.Validator(form)

This is the constructor.  It takes a form object as its only parameter.

B<Example>:

  var fv = new Form.Validator(document.stuff);
  var fv2 = new Form.Validator(document.forms[0]);

=head2 set(field, constraint, option);

This method associates a form field with a validation function
and an error message.

The first parameter is the name of a form field.

The second parameter is either a string with the name of a
built-in validation function (like C<notBlank> or C<notZero>),
or an actual function that can perform a validation test.

The third parameter is either a string that will be used when
the validation fails or an object with properties that will be
used by a report object to display validation results.
L<Form.Validator.Report.InnerHTML> is currently the only class
that will take advantage of this.  The standard properties for
the object form of the 3rd parameter are as follows:

=head3 The constraint object's standard properties

=over 2

=item onFailure

Message to use when validation fails.  (Internally, the 3rd parameter
gets assigned to onFailure when it's passed in as a string.)

=item onSuccess

Message to use when validation succeeds.  (InnerHTML will use this
if you provide it.)

=item constraint

This is the function used for testing a field.  It should be able to
take a L<Form.Validator> object and a field name as parameters.
(Internally, the 2nd parameter is assigned to constraint.)

=item field

This is the name of the field that is being checked.  (Internally, the
first paramter is assigned to field.)

=back

B<Example>:  The standard way.

  // using a built-in validator function
  fv.set('name', 'notBlank', "Name must be filled in.");

B<Example>:  Using a custom validation function.

  // using a custom validator
  fv.set('category_id',
    function(fv, field) {
      if (fv.form[field].value == 3) {
        return false;
      } else {
        return true;
      }
    },
    "Problems always come in 3s.  Bad choice, my friend."
  );

B<Example>:  Passing an object in the third parameter

  fv.reporter('InnerHTML');
  fv.set(
    'email', 
    'notBlank', 
    {
      onFailure: 'Please fill in an email address',
      onSuccess: 'OK'
    }
  );

Note that the following 2 statements are equivalent:

  fv.set('x', 'notBlank', { onFailure: 'X is required' });
  fv.set('x', fv.notBlank, 'X is required');

=head2 get()

=head2 get(field)

This method returns a list of the constraints for a given input field.
If a field is not passed in, this method will return all constraints
in the order that they were defined.

B<Example>:

  var name_constraints = fv.get('name');   // constraints for name
  var all_constraints  = fv.get();         // Array of all constraints

=head2 reporter(report);

This method allows one to specify the way validation errors will be reported
back to the user.  Your choices are as follows:

=over 2

=item AlertAll

This is the classical approach where all validation messages are joined
together and displayed in an alert pop-up.  
See L<Form.Validator.Report.AlertAll>.

=item AlertFirst

This will stop on the first validation error and display an alert
pop-up.  After the pop-up is closed, it will focus on the form element
where the validation error occured.
See L<Form.Validator.Report.AlertFirst>.

(I affectionately refer to this as Indian-style validation.)

=item InnerHTML

This was inspired by the way http://www.remeberthemilk.com/ handles
form validation during user registration.  If you try to create an
account on that site, you'll see that it validates the form as you
type, and validation messages are placed in the innerHTML of an element
right next to the form input it references.

I was so impressed by that validation technique that I rearchitected
L<Form.Validator> so that it could accomodate multiple validation styles
with this particular style in the forefront of my thoughts.

See L<Form.Validator.Report.InnerHTML>.

=back

B<Example>:

  // You can change the reporting method at any time.
  fv.reporter('AlertFirst');
  fv.validate();
  fv.reporter('AlertAll');
  fv.validate();

Note that you can also pass an object to the C<reporter()> method.  The
minimum requirement is that the object support a start(), run() and finish()
method.

B<Example>:

  fv.reporter(new Form.Validator.Report.AlertFirst(fv));

This is effectively the same as:

  fv.reporter('AlertFirst');

=head2 validate()

=head2 validate(field, ...)

This method runs through the list of constraints in the order they were
defined.  It also executes the C<start()>, C<run()>, and C<finish()> methods of
the report object at the appropriate times.  

If any of the constraints failed, this method will return false.  Otherwise, 
it'll return true.

B<Example>: Validating a form all at once

  <form action="/process" method="post" onsubmit="return fv.validate()">
    ...                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  </form>

B<Example>: Also validating one field at a time

  <form action="/process" method="post" onsubmit="return fv.validate()">
    <label>name</label>
    <input type="text" name="name" onkeyup="fv.validate('name')" />
    <!--                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -->
    <label>email</label>
    <input type="text" name="name" onkeyup="fv.validate('email')" />
    <!--                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -->
  </form>

=head2 validateAndAlert

B<*** DEPRECATED ***>

This function is intended to be used as an C<onsubmit> handler on a form.  It
runs through the validation tests in the order they were defined and displays
an alert box if any of the validation tests failed.  Then it will return
C<false> to prevent the form from being submitted.

B<Example>:

  <form name="stuff"
    action="process_stuff.mas"
    method="POST"
    onsubmit="return fv.validateAndAlert()">

=head1 BUILT-IN VALIDATION FUNCTIONS

=head2 notBlank

For inputs that shouldn't be blank, use this test function.

=head2 notZero

For inputs that shouldn't be 0, use this test function.

=head1 VALIDATION FUNCTION GENERATORS

=head2 makeLengthMin(number)

This method returns a function that will ensure that the contents
of a field are at least n characters long.

B<Example>:

  fv.set(
    'name',
    fv.makeLengthMin(3),
    "The name field must be at least 3 characters long"
  );

=head2 makeLengthMax(number)

This method returns a function that will ensure that the contents
of a field are not more than n characters long.

B<Example>:

  fv.set(
    'name',
    fv.makeLengthMax(10),
    "The name field may not be more than 10 characters long"
  );

=head2 makeValueMin(number)

This method returns a function that will ensure that the value
of a field is at least n.

=head2 makeValueMax(number)

This method returns a function that will ensure that the value
of a field is less than or equal to n.

=head2 makeMatchRegex(regex)

This method returns a function that will match the regex passed
to it.

B<Example>:

  fv.set(
    'country',
    fv.makeMatchRegex(/CA|US/),
    "Sorry, we do not ship outside of Canada or the US."
  );

=head2 makeNotMatchRegex(regex)

This method returns a function that will make sure that the
specified input does not match the given regex.

B<Example>:

  fv.set(
    'do_i_look_fat_in_this',
    fv.makeNotMatchRegex(/[Yy]es/),
    "I hate you!"
  );

=head2 makeOptional(funktion)

Sometimes, you only want to check a constraint if something was
typed in.  That's when you'd use this method.

B<Example>:

  var naive_email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/;
  fv.set(
    'email',
    fv.makeOptional(fv.makeMatchRegex(naive_email_regex)),
    'If you're going to type in an email address, type it right!'
  );

Thus, you can wrap any function with fv.makeOptional to make it
an optional constraint.  (Optional is defined as "check if the field
is not blank".)

=head1 WRITING YOUR OWN VALIDATION FUNCTIONS

If the provided validation tests cannot fulfill your needs, you may add
validation functions of your own.  They should expect to receive 2
parameters.  The first is the Form.Validator object (fv) and the second
is the name of the field that the function needs to test.  To get at the
actual form, access C<fv.form>.

B<Example>:

  function notOdd (fv, field) {
    var form = fv.form;
    if (form.field.value > 0 && form.field.value & 0x01) {
      return false;
    } else {
      return true;
    }
  };

  fv.set('number', notOdd, "Only positive, even numbers are allowed.");

Furthermore, if you feel compelled to add this method to the Form.Validator
class, you can do this:

  Form.Validator.prototype.notOdd = notOdd;

Now that we've added the C<notOdd> method, all Form.Validator objects 
can test to see whether a field has an odd value or not.

=head1 WRITING YOUR OWN VALIDATION REPORTERS

Currently, you get to pick from 

  Form.Validator.Report.AlertAll,
  Form.Validator.Report.AlertFirst, and
  Form.Validator.Report.InnerHTML

as a way to report what went wrong.  If you want to implement your own
way of reporting that works within the L<Form.Validator> framework, here
are the methods your object needs to implement.

=over 2

=item The Constructor

The constructor will be passed a L<Form.Validator> object with which
it can do whatever it wants.  It can be useful, so keeping it in a
property for later use is recommended.

=item C<start(constraints)>

Before validation starts, this method will be called with a list of
constraints that will be checked in this pass.  You can use this
opportunity to perform initializaton.

=item C<run(ok, constraint)>

Implement a method that takes a boolean value and a constraint object.
The boolean value will contain the result of the constraint function.
If it's false, that means the constraint failed, so you'll want
to update some data structures so that you'll be able to display an
error message.

=item C<finish()>

The finish method is executed after all the validations have been
performed.  If you haven't done so already, now would be a good time
to actually display any messages concerning validation failures.

=back

If this object prototype is placed within the Form.Validator.Report.*
namespace, the C<reporter()> method will be able to see it.  For
example, if you created something called Form.Validator.Report.SVG,
you could tell your L<Form.Validator> object to use it by saying:

  fv.reporter('SVG');

If, for whatever reason, you don't want to put your reporter in the
Form.Validator.Report.* namespace, that's fine.  As long as you support
the C<start()>, C<run()>, and C<finish()> methods, it will work.  The 
only difference is that you'll have to call C<reporter()> a little
differently.  For example, if you created a report object prototype
called My.Brilliant.Report, you'd make the validator use it by saying:

  fv.reporter( new My.Brilliant.Report() );

=head1 INSPIRATION

Originally, I wanted to avoid repeatedly writing the same javascript
over and over again for form validation.  I'm satisfied with how I
tackled that problem, but new developments in form validation techniques
have pushed me to improve this library further.  To that end, 
I am indebted to the following implementations of form validation for
their inspiration.

=over 2

=item http://rememberthemilk.com/signup/

This is the first implementation of the innerHTML validation technique
that I ever saw.  My friend, Jeremy Seitz, brought this to my attention
for the signup page alone, and I must agree with him that it is quite
impressive how they validate your input as you type, even making AJAX
requests for some of their constraint checking.  If I hadn't seen this,
I would not have been motivated to rearchitect L<Form.Validator>.

=item http://masuidrive.jp/validation/index_en.html

This is a more general implementation of the innerHTML validation
technique that uses the Behaviour library in a clever way.  (However, It
would have been nicer if he didn't assimilate the code of behaviour.js
into his own library.)

=back

=head1 TO DO

=over 2

=item * Add more validation functions.

Surprisingly, C<notBlank> and C<notZero> alone can take you pretty far, 
but a few more validation functions would be nice to have.

=item * Be able to handle checkboxes and radio buttons

Perhaps a validation function called C<isChecked()> could be written.

=item * Add a validation function named, 'isRequired'

This would subsume C<notBlank> and C<notZero>.

=back

=head1 AUTHOR

John Beppu (beppu@cpan.org)

=cut

*/
