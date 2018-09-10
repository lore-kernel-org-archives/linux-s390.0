From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Sep 2018 14:37:15 +0000
Subject: Re: [PATCH 1/2] s390: qeth: Fix potential array overrun in cmd/rc lookup
Message-Id: <20180910163715.24f5cddc@endymion>
In-Reply-To: <12375fbf-56b2-2b2b-9b60-f17ce60c3672@linux.ibm.com>
References: <12375fbf-56b2-2b2b-9b60-f17ce60c3672@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Ursula,

On Mon, 10 Sep 2018 16:03:23 +0200, Ursula Braun wrote:
> On 09/10/2018 11:09 AM, Jean Delvare wrote:
> > Functions qeth_get_ipa_msg and qeth_get_ipa_cmd_name are modifying
> > the last member of global arrays without any locking that I can see.
> > If two instances of either function are running at the same time,
> > it could cause a race ultimately leading to an array overrun (the
> > contents of the last entry of the array is the only guarantee that
> > the loop will ever stop).
> > 
> > Performing the lookups without modifying the arrays is admittedly
> > slower (two comparisons per iteration instead of one) but these
> > are operations which are rare (should only be needed in error
> > cases or when debugging, not during successful operation) and it
> > seems still less costly than introducing a mutex to protect the
> > arrays in question.
> > 
> > As a side bonus, it allows us to declare both arrays as const data.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Julian Wiedmann <jwi@linux.ibm.com>
> > Cc: Ursula Braun <ubraun@linux.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > ---
> > Note: build-tested only.
> > (...)
> > -static struct ipa_cmd_names qeth_ipa_cmd_names[] = {
> > +static const struct ipa_cmd_names qeth_ipa_cmd_names[] = {
> >  	{IPA_CMD_STARTLAN,	"startlan"},
> >  	{IPA_CMD_STOPLAN,	"stoplan"},
> >  	{IPA_CMD_SETVMAC,	"setvmac"},
> > @@ -263,14 +264,14 @@ static struct ipa_cmd_names qeth_ipa_cmd
> >  	{IPA_CMD_REGISTER_LOCAL_ADDR,	"register_local_addr"},
> >  	{IPA_CMD_UNREGISTER_LOCAL_ADDR,	"unregister_local_addr"},
> >  	{IPA_CMD_ADDRESS_CHANGE_NOTIF, "address_change_notification"},
> > -	{IPA_CMD_UNKNOWN,	"unknown"},  
> 
> Why is this line removed? Doesn't the last line of function qeth_get_ipa_cmd_name()
> still refer to this line?
> And if IPA_CMD_UNKNOWN is really removed, then make sure its definition is removed
> from qeth_core_mpc.h as well.

That's a bug in the patch, sorry about that, I will resend :(

In an earlier version of the patch, IPA_CMD_UNKNOWN was removed, but
then I found it was more elegant to keep it so that the code in
qeth_get_ipa_cmd_name() and qeth_get_ipa_msg() would be the same. I
restored the definition in qeth_core_mpc.h but forgot to also restore
the last entry of qeth_ipa_cmd_names[].

Thanks for catching it and sorry again,
-- 
Jean Delvare
SUSE L3 Support
