if (Form                  == undefined) var Form              = { };
if (Form.Validator        == undefined) Form.Validator        = { };
if (Form.Validator.Report == undefined) Form.Validator.Report = { };

Form.Validator.Report.AlertAll = function(fv) {
  this.fv       = fv;
  this.messages = [ ];
};

Form.Validator.Report.AlertAll.prototype = {
  fv       : null,
  messages : null,
  header   : '',
  footer   : '',

  start: function() {
    this.messages.length = 0;
  },

  run: function(ok, c) {
    if (ok) {
      return;
    }
    this.messages.push(c.onFailure);
  },

  finish: function() {
    if (this.messages.length > 0) {
      alert(
        this.header +
        this.messages.join("\n") +
        this.footer
      );
    }
  }
};

/*

=head1 NAME

Form.Validator.Report.AlertAll - show an alert w/ all validation failures

=head1 SYNOPSIS

Setting up your L<Form.Validator> to use AlertAll:

  var jsan = new JSAN('js');
  jsan.use('Form.Validator');
  jsan.use('Form.Validator.Report.AlertAll');

  fv = new Form.Validator(document.report);
  fv.reporter('AlertAll');

Another way to say the same thing:

  fv = new Form.Validator(document.report);
  fv.reporter(new Form.Validator.Report.AlertAll());

Or don't say anything at all, because AlertAll happens to be the default:

  fv = new Form.Validator(document.report);
  // AlertAll is the default reporting mechanism

=head1 DESCRIPTION

This report object is a port of the original C<fv.validateAndAlert()>
method which would run validation tests, and pop up an alert that had
the onFailure messages for each contraint that failed.

=head1 PROPERTIES

=head2 fv

This is the L<Form.Validator> object that's using this report.

=head2 messages

This is an L<Array> that contains a list of onFailure messages for
constraints that failed during the call to C<fv.validate()>.

=head2 header

Text to be placed at the top of the alert message.

=head2 footer

Text to be placed at the bottom of the alert message.

=head1 METHODS

=head2 start

This method will clear the messages array in preparation for a validation
sweep.

=head2 run

If a constraint fails, C<this.messages> will have the onFailure message for
that constraint pushed on to the end of it.

=head2 finish

If C<this.messages> has anything in it, it'll be joined into a "\n" separated
string and displayed in an alert pop-up.

=head1 AUTHOR

John Beppu E<lt>beppu@cpan.orgE<gt>

=cut

*/
