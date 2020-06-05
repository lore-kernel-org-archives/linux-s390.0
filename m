Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgFEJDA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 05:03:00 -0400
Date: Fri, 5 Jun 2020 11:02:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 11/12] s390x: css: ssch/tsch with
 sense and interrupt
Message-ID: <20200605110250.461ea3b7.cohuck@redhat.com>
In-Reply-To: <a53f84e9-8e32-2ac2-2af1-0edd911841c4@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-12-git-send-email-pmorel@linux.ibm.com>
        <20200527120905.5fb20a4e.cohuck@redhat.com>
        <a53f84e9-8e32-2ac2-2af1-0edd911841c4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 5 Jun 2020 09:37:39 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-05-27 12:09, Cornelia Huck wrote:
> > On Mon, 18 May 2020 18:07:30 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> We add a new css_lib file to contain the I/O functions we may
> >> share with different tests.
> >> First function is the subchannel_enable() function.
> >>
> >> When a channel is enabled we can start a SENSE_ID command using
> >> the SSCH instruction to recognize the control unit and device.
> >>
> >> This tests the success of SSCH, the I/O interruption and the TSCH
> >> instructions.
> >>
> >> The test expects a device with a control unit type of 0xC0CA as the
> >> first subchannel of the CSS.  
> > 
> > It might make sense to extend this to be able to check for any expected
> > type (e.g. 0x3832, should my suggestion to split css tests and css-pong
> > tests make sense.)  
> 
> right.
> 
> >   
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   lib/s390x/css.h     |  20 ++++++
> >>   lib/s390x/css_lib.c |  55 +++++++++++++++++
> >>   s390x/Makefile      |   1 +
> >>   s390x/css.c         | 145 ++++++++++++++++++++++++++++++++++++++++++++
> >>   4 files changed, 221 insertions(+)
> >>   create mode 100644 lib/s390x/css_lib.c  
> > 
> > (...)
> >   
> >> +int enable_subchannel(unsigned int sid)
> >> +{
> >> +	struct schib schib;
> >> +	struct pmcw *pmcw = &schib.pmcw;
> >> +	int try_count = 5;
> >> +	int cc;
> >> +
> >> +	if (!(sid & SID_ONE))
> >> +		return -1;  
> > 
> > Hm... this error is indistinguishable for the caller from a cc 1 for
> > the msch. Use something else (as this is a coding error)?  
> 
> right it is a coding error -> assert ?

Sounds good to me.
