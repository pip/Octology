if (Form                  == undefined) var Form              = { };
if (Form.Validator        == undefined) Form.Validator        = { };
if (Form.Validator.Report == undefined) Form.Validator.Report = { };

Form.Validator.Report.InnerHTML = function(fv) {
  this.fv       = fv;
  this.messages = { };
};

Form.Validator.Report.InnerHTML.prototype = {

  fv        : null,
  messages  : null,
  prefix    : "",
  suffix    : "_errors",
  separator : ", ",
  onSuccess : "OK",

  start: function(constraints) {
    var i;
    for (i = 0; i < constraints.length; i++) {
      var c = constraints[i];
      var id = this.prefix + c.field + this.suffix;
      this.messages[id] = { 
        list      : [ ],
        onSuccess : c.onSuccess || this.onSuccess
      };
    }
  },

  run: function(ok, c) {
    if (!ok) {
      var id = this.prefix + c.field + this.suffix;
      this.messages[id].list.push(c.onFailure);
    }
  },

  finish: function() {
    var key;
    for (id in this.messages) {
      var list = this.messages[id].list;
      var element = document.getElementById(id);
      if (list.length > 0) {
        element.innerHTML = list.join(this.separator);
      } else {
        element.innerHTML = 
          this.messages[id].onSuccess ||
          this.onSuccess;
      }
    }
    this.messages = { };
  }

};

/*

=head1 NAME

Form.Validator.Report.InnerHTML - messages inside an element's innerHTML

=head1 SYNOPSIS

InnerHTML requires extra elements for the error messages:

  <form name="f" action="/process" method="post" 
    onsubmit="return fv.validate()">
    <table>
      <tr>
        <td class="label">
          Name:
        </td>
        <td class="field"> 
          <input type="text" name="name" onkeyup="fv.validate('name')" />
        </td>
        <td class="status" id="name_errors">&nbsp;</td>
      </tr>
      <tr>
        <td class="label">
          Email:
        </td>
        <td class="field"> 
          <input type="text" name="email" onkeyup="fv.validate('email')" />
        </td>
        <td class="status" id="email_errors">&nbsp;</td>
      </tr>
    </table>
  </form>

Now for the javascript:

  var jsan = new JSAN('/js');
  jsan.use('Form.Validator');
  jsan.use('Form.Validator.Report.InnerHTML');

  fv = new Form.Validator('document.f');
  fv.set('name', 'notBlank', {
    onFailure: 'Name is required.',
    onSuccess: '<b>OK</b>'
  });
  fv.set('email', 'notBlank', {
    onFailure: 'Email is required.',
    onSuccess: '<b>OK</b>'
  });
  var report = fv.reporter('InnerHTML');
  report.suffix = "_errors";

=head1 DESCRIPTION

This method of reporting validation errors was inspired by the way
http://www.rememberthemilk.com/ does validation on their registration
form.  Realtime validation is really nice.

However, Unlike the reporting methods that use alert pop-ups, this 
technique requires a bit more support from the form.  

=over 2

=item * HTML elements for displaying messages must be provided.

It doesn't matter whether it's a div, span, td or whatever.
As long as it has an innerHTML property that can be modified,
we can use it.  It should also have an id that consists of:
`this.prefix + field + this.suffix`.

=item * Input elements need extra event handlers for realtime response.

The example in the L</SYNOPSIS> uses C<onkeyup>.  I have a suspicion
that C<onchange> and C<onblur> may also benefit from getting handlers
hooked up.

=back

=head1 PROPERTIES

=head2 fv

This is the L<Form.Validator> object.

=head2 messages

This is a dictionary of messages keyed by field name.

=head2 prefix

=head2 suffix

When Form.Validator.Report.InnerHTML looks for an element to put
a message into, it'll look for the id:

  this.prefix + field + this.suffix

The default prefix is "", and the default suffix is currently "_errors",
because that's what seems to make sense for L<HTML::Widget>.

=head2 separator

It's possible for a field to fail multiple constraints, so a
separator string for the list of messages was needed.  The default
is: ", ".

=head2 onSuccess

This is the default message that'll be used when a constraint passes.
It'll be used when an onSuccess message specific to a constraint
doesn't exist.  The default is "OK", but you should probably override
this one.

=head1 METHODS

=head2 start

This clears this.messages.

=head2 run

This populates this.messages.

=head2 finish

This takes the contents of this.messages and stuffs it inside the
innerHTML of the elements that have been set aside to hold these
validation messages.

=head1 AUTHOR

John Beppu E<lt>beppu@cpan.orgE<gt>

=cut

*/
