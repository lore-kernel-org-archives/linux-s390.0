Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37593 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgGIOW1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 10:22:27 -0400
Date: Thu, 9 Jul 2020 16:22:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v11 8/9] s390x: css: msch, enable test
Message-ID: <20200709162210.7fe6f9cb.cohuck@redhat.com>
In-Reply-To: <d9c0724c-1818-ba50-451f-c433fcd0ca1f@linux.ibm.com>
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
        <1594282068-11054-9-git-send-email-pmorel@linux.ibm.com>
        <20200709134056.0d267b6c.cohuck@redhat.com>
        <d55c3e5b-8adf-8f7f-2b97-c270fb6598b4@linux.ibm.com>
        <20200709153055.6f2b5e59.cohuck@redhat.com>
        <4f861a9c-179b-5376-5f0f-dce30f31da71@linux.ibm.com>
        <20200709155241.3014e3d6.cohuck@redhat.com>
        <d9c0724c-1818-ba50-451f-c433fcd0ca1f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com

On Thu, 9 Jul 2020 15:58:07 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-07-09 15:52, Cornelia Huck wrote:
> > On Thu, 9 Jul 2020 15:41:56 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> On 2020-07-09 15:30, Cornelia Huck wrote:  
> >>> On Thu, 9 Jul 2020 15:12:05 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>      
> >>>> On 2020-07-09 13:40, Cornelia Huck wrote:  
> >>>>> On Thu,  9 Jul 2020 10:07:47 +0200
> >>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:

> >>>>> (...)
> >>>>>         
> >>>>>> +/*
> >>>>>> + * css_msch: enable subchannel and set with specified ISC  
> >>>>>
> >>>>> "css_enable: enable the subchannel with the specified ISC"
> >>>>>
> >>>>> ?
> >>>>>         
> >>>>>> + * @schid: Subchannel Identifier
> >>>>>> + * @isc  : number of the interruption subclass to use
> >>>>>> + * Return value:
> >>>>>> + *   On success: 0
> >>>>>> + *   On error the CC of the faulty instruction
> >>>>>> + *      or -1 if the retry count is exceeded.
> >>>>>> + */
> >>>>>> +int css_enable(int schid, int isc)
> >>>>>> +{
> >>>>>> +	struct pmcw *pmcw = &schib.pmcw;
> >>>>>> +	int retry_count = 0;
> >>>>>> +	uint16_t flags;
> >>>>>> +	int cc;
> >>>>>> +
> >>>>>> +	/* Read the SCHIB for this subchannel */
> >>>>>> +	cc = stsch(schid, &schib);
> >>>>>> +	if (cc) {
> >>>>>> +		report_info("stsch: sch %08x failed with cc=%d", schid, cc);
> >>>>>> +		return cc;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	flags = PMCW_ENABLE | (isc << PMCW_ISC_SHIFT);
> >>>>>> +	if ((pmcw->flags & flags) == flags) {  
> >>>>>
> >>>>> I think you want (pmcw->flags & PMCW_ENABLE) == PMCW_ENABLE -- this
> >>>>> catches the case of "subchannel has been enabled before, but with a
> >>>>> different isc".  
> >>>>
> >>>> If with a different ISC, we need to modify the ISC.
> >>>> Don't we ?  
> >>>
> >>> I think that's a policy decision (I would probably fail and require a
> >>> disable before setting another isc, but that's a matter of taste).
> >>>
> >>> Regardless, I think the current check doesn't even catch the 'different
> >>> isc' case?  
> >>
> >> hum, right.
> >> If it is OK I remove this one.
> >> And I must rework the same test I do later
> >>    in this patch.  
> > 
> > So, you mean checking for PMCW_ENABLE? Or not at all?
> > 
> > (I'd check for PMCW_ENABLE.)
> >   
> 
> -       if ((pmcw->flags & flags) == flags) {
> +       if ((pmcw->flags & (PMCW_ISC_MASK | PMCW_ENABLE)) == flags) {
>                  report_info("stsch: sch %08x already enabled", schid);
>                  return 0;
>          }
> 
> I keep both, otherwise I return 0 without setting the ISC.

Ah, I missed the 'return 0'.

>   then I have another error:
> 
>   retry:
>          /* Update the SCHIB to enable the channel and set the ISC */
> +       pmcw->flags &= ~(PMCW_ISC_MASK | PMCW_ENABLE);

Maybe ~PMCW_ISC_MASK is enough?

>          pmcw->flags |= flags;
> 
> and finaly the same as the first later...
> 
> -       if ((pmcw->flags & flags) == flags) {
> +       if ((pmcw->flags & (PMCW_ISC_MASK | PMCW_ENABLE)) == flags) {

I think you can keep that as-is.

>                  report_info("stsch: sch %08x successfully modified 
> after %d retries",
>                              schid, retry_count);
> 
> 
> is better I think.
> What do you think?

It's probably the right direction.
