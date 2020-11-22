if (Form                  == undefined) var Form              = { };
if (Form.Validator        == undefined) Form.Validator        = { };
if (Form.Validator.Report == undefined) Form.Validator.Report = { };

Form.Validator.Report.Data = function(fv) {
  this.fv       = fv;
  this.messages = [ ];
};

Form.Validator.Report.Data.prototype = {
  fv       : null,
  messages : null,

  start: function() {
    this.messages.length = 0;
  },

  run: function(ok, c) {
    if (ok) {
      return;
    }
    this.messages.push(c.onFailure);
  },

  finish: function() { }
};

/*

=head1 NAME

Form.Validator.Report.Data - no action taken, only data filled

=head1 SYNOPSIS

Usage:

  var fv = new Form.Validator(document.f);
  var r  = fv.reporter('Data');
  fv.set('name', 'notBlank', 'Name is required');
  fv.validate();
  var messages = r.messages;

=head1 DESCRIPTION

This report object doesn't do anything visibly observable upon validation.
All it does is fill in some internal data structures so that test scripts
can inspect them later.

Think of this as L<Form.Validator.Report.AlertAll> without the C<alert()>.
It's reason for existing is to facilitate testing of this framework.

=head1 PROPERTIES

=head2 messages

This is an L<Array> that contains a list of onFailure messages for
constraints that failed during the call to C<fv.validate()>.

=head1 METHODS

=head2 start

This method clears the contents of this.messages just before validation
starts.

=head2 run

This method populates this.messages whenever a constraint fails
during validation.

=head2 finish

This method does nothing.

=head1 AUTHOR

John Beppu E<lt>beppu@cpan.orgE<gt>

=cut

*/
