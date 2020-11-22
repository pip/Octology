if (Form                  == undefined) var Form              = { };
if (Form.Validator        == undefined) Form.Validator        = { };
if (Form.Validator.Report == undefined) Form.Validator.Report = { };

Form.Validator.Report.AlertFirst = function(fv) {
  this.fv = fv;
};

Form.Validator.Report.AlertFirst.prototype = {

  // form validator object
  fv: null,
  // first field to fail a constraint check
  field: null,
  // error message for first field
  message: null,

  header: '',
  footer: '',

  start: function() {
    this.field   = null;
    this.message = null;
  },

  run: function(ok, c) {
    if (ok) {
      return;
    }
    this.field   = c.field;
    this.message = c.onFailure;
    throw('last');
  },

  finish: function() {
    if (this.message) {
      alert(
        this.header +
        this.message +
        this.footer
      );
      this.fv.form[this.field].focus();
    }
  }

};

/*

=head1 NAME

Form.Validator.Report.AlertFirst - alert on first error and focus

=head1 SYNOPSIS

Usage:

  var jsan = new JSAN('lib');
  jsan.use('Form.Validator');
  jsan.use('Form.Validator.Report.AlertFirst');

  fv = new Form.Validator(document.f);
  fv.reporter('AlertFirst');

=head1 DESCRIPTION

I affectionately refer to this as Indian-style validation,
because the Indian programmers at my current job
liked to implement validation this way.

=head1 PROPERTIES

=head2 fv

This is the L<Form.Validator> object that's using this report.

=head2 field

This is the name of the field where the first constraint failure happened.

=head2 message

This is the onFailure message for the constraint that failed during validation.

=head2 header

Text to be placed at the top of the alert message.

=head2 footer

Text to be placed at the bottom of the alert message.

=head1 METHODS

=head2 start

This method clears C<this.field> and C<this.message> in preparation for
the validation phase.

=head2 run

If the constraint passed, nothing happens.  However, if a constraint fails,
C<this.field> and C<this.message> are updated.  Then, an exception is thrown
so that no more constraint checks will be performed.

=head2 finish

If there were any constraint failures, an alert pop-up with the error message.
Then, when the alert is closed, focus on the field that had a constraint
failure.

=cut

*/
