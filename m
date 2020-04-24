Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726489AbgDXKta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Apr 2020 06:49:30 -0400
Date: Fri, 24 Apr 2020 12:49:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 04/10] s390x: interrupt registration
Message-ID: <20200424124919.6c243286.cohuck@redhat.com>
In-Reply-To: <b5c02122-68a7-31e7-11e4-5f05403feb08@linux.ibm.com>
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
        <1582200043-21760-5-git-send-email-pmorel@linux.ibm.com>
        <c8d1081a-8e94-f28e-66e7-fe98aea31837@linux.ibm.com>
        <b5c02122-68a7-31e7-11e4-5f05403feb08@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

On Fri, 24 Apr 2020 12:44:16 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-04-24 10:27, Janosch Frank wrote:
> > On 2/20/20 1:00 PM, Pierre Morel wrote:  
> >> Let's make it possible to add and remove a custom io interrupt handler,
> >> that can be used instead of the normal one.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>   lib/s390x/interrupt.c | 22 +++++++++++++++++++++-
> >>   lib/s390x/interrupt.h |  7 +++++++
> >>   2 files changed, 28 insertions(+), 1 deletion(-)
> >>   create mode 100644 lib/s390x/interrupt.h
> >>

> >> +static void (*io_int_func)(void);
> >> +
> >>   void handle_io_int(void)
> >>   {
> >> +	if (*io_int_func)
> >> +		return (*io_int_func)();
> >>   	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
> >>   		     stap(), lc->io_old_psw.addr);
> >>   }
> >>   
> >> +int register_io_int_func(void (*f)(void))
> >> +{
> >> +	if (io_int_func)
> >> +		return -1;
> >> +	io_int_func = f;
> >> +	return 0;
> >> +}
> >> +
> >> +int unregister_io_int_func(void (*f)(void))
> >> +{
> >> +	if (io_int_func != f)
> >> +		return -1;
> >> +	io_int_func = NULL;
> >> +	return 0;
> >> +}  
> > 
> > I'm currently working on something similar for PGMs and I see no
> > additional value in two functions for this. Unregistering can be done by
> > doing register_io_int_func(NULL)
> > 
> > This should be enough:
> > 
> > int register_io_int_func(void (*f)(void))
> > {
> > 	io_int_func = f;
> > }

You can even make this void :)

> >   
> There are several ways to do this and I really don't mind how it is done.
> Since it has been reviewed by, I would like to have the others reviewers 
> opinion.

One version might make it easier to catch programming errors, while the
other one is more compact. I don't really have a preference on this,
either is fine with me.
