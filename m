Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54948 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729591AbfLLOKO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 09:10:14 -0500
Date: Thu, 12 Dec 2019 15:10:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: css: msch, enable test
Message-ID: <20191212151002.1c7ca4eb.cohuck@redhat.com>
In-Reply-To: <83d45c31-30c3-36e1-1d68-51b88448f4af@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
        <20191212130111.0f75fe7f.cohuck@redhat.com>
        <83d45c31-30c3-36e1-1d68-51b88448f4af@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 12 Dec 2019 15:01:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-12-12 13:01, Cornelia Huck wrote:
> > On Wed, 11 Dec 2019 16:46:08 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> A second step when testing the channel subsystem is to prepare a channel
> >> for use.
> >> This includes:
> >> - Get the current SubCHannel Information Block (SCHIB) using STSCH
> >> - Update it in memory to set the ENABLE bit
> >> - Tell the CSS that the SCHIB has been modified using MSCH
> >> - Get the SCHIB from the CSS again to verify that the subchannel is
> >>    enabled.
> >>
> >> This tests the success of the MSCH instruction by enabling a channel.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   s390x/css.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 65 insertions(+)

> >> +	/* Read the SCHIB for this subchannel */
> >> +	cc = stsch(test_device_sid, &schib);
> >> +	if (cc) {
> >> +		report(0, "stsch cc=%d", cc);
> >> +		return;
> >> +	}
> >> +
> >> +	/* Update the SCHIB to enable the channel */
> >> +	pmcw->flags |= PMCW_ENABLE;
> >> +
> >> +	/* Tell the CSS we want to modify the subchannel */
> >> +	cc = msch(test_device_sid, &schib);
> >> +	if (cc) {
> >> +		/*
> >> +		 * If the subchannel is status pending or
> >> +		 * if a function is in progress,
> >> +		 * we consider both cases as errors.
> >> +		 */
> >> +		report(0, "msch cc=%d", cc);
> >> +		return;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Read the SCHIB again to verify the enablement
> >> +	 * insert a little delay and try 5 times.
> >> +	 */
> >> +	do {
> >> +		cc = stsch(test_device_sid, &schib);
> >> +		if (cc) {
> >> +			report(0, "stsch cc=%d", cc);
> >> +			return;
> >> +		}
> >> +		delay(10);  
> > 
> > That's just a short delay to avoid a busy loop, right? msch should be
> > immediate,  
> 
> Thought you told to me that it may not be immediate in zVM did I 
> misunderstand?

Maybe I have been confusing... what I'm referring to is this
programming note for msch:

"It is recommended that the program inspect the
contents of the subchannel by subsequently
issuing STORE SUBCHANNEL when MODIFY
SUBCHANNEL sets condition code 0. Use of
STORE SUBCHANNEL is a method for deter-
mining if the designated subchannel was
changed or not. Failure to inspect the subchan-
nel following the setting of condition code 0 by
MODIFY SUBCHANNEL may result in conditions
that the program does not expect to occur."

That's exactly what we had to do under z/VM back then: do the msch,
check via stsch, redo the msch if needed, check again via stsch. It
usually worked with the second msch the latest.

> 
> > and you probably should not delay on success?  
> 
> yes, it is not optimized, I can test PMCW_ENABLE in the loop this way we 
> can see if, in the zVM case we need to do retries or not.
> 
> 
> >   
> >> +	} while (!(pmcw->flags & PMCW_ENABLE) && count++ < 5);  
> > 
> > How is this supposed to work? Doesn't the stsch overwrite the control
> > block again, so you need to re-set the enable bit before you retry?  
> 
> I do not think so, there is no msch() in the loop.
> Do I miss something?

Well, _I_ missed that the msch() was missing :) You need it (see above);
just waiting and re-doing the stsch is useless, as msch is a
synchronous instruction which has finished its processing after the cc
has been set.
