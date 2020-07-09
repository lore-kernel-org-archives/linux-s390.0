Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgGIMOB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 08:14:01 -0400
Date: Thu, 9 Jul 2020 14:13:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v11 9/9] s390x: css: ssch/tsch with sense
 and interrupt
Message-ID: <20200709141348.6ae5ff18.cohuck@redhat.com>
In-Reply-To: <1594282068-11054-10-git-send-email-pmorel@linux.ibm.com>
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
        <1594282068-11054-10-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com

On Thu,  9 Jul 2020 10:07:48 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> After a channel is enabled we start a SENSE_ID command using
> the SSCH instruction to recognize the control unit and device.
> 
> This tests the success of SSCH, the I/O interruption and the TSCH
> instructions.
> 
> The SENSE_ID command response is tested to report 0xff inside
> its reserved field and to report the same control unit type
> as the cu_type kernel argument.
> 
> Without the cu_type kernel argument, the test expects a device
> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h |   1 +
>  lib/s390x/css.h          |  35 ++++++++
>  lib/s390x/css_lib.c      | 183 +++++++++++++++++++++++++++++++++++++++
>  s390x/css.c              |  80 +++++++++++++++++
>  4 files changed, 299 insertions(+)

(...)

> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index eda68a4..c64edd5 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -16,6 +16,7 @@
>  #include <interrupt.h>
>  #include <asm/arch_def.h>
>  #include <asm/time.h>
> +#include <asm/arch_def.h>
>  
>  #include <css.h>
>  
> @@ -103,6 +104,9 @@ retry:
>  	/* Update the SCHIB to enable the channel and set the ISC */
>  	pmcw->flags |= flags;
>  
> +	/* Set Interruption Subclass to IO_SCH_ISC */
> +	pmcw->flags |= (isc << PMCW_ISC_SHIFT);

But isn't the isc already contained in 'flags'? I think you should just
delete these two lines.

> +
>  	/* Tell the CSS we want to modify the subchannel */
>  	cc = msch(schid, &schib);
>  	if (cc) {

(...)

> +/* wait_and_check_io_completion:
> + * @schid: the subchannel ID
> + *
> + * Makes the most common check to validate a successful I/O
> + * completion.
> + * Only report failures.
> + */
> +int wait_and_check_io_completion(int schid)
> +{
> +	int ret = 0;
> +
> +	wait_for_interrupt(PSW_MASK_IO);
> +
> +	report_prefix_push("check I/O completion");
> +
> +	if (lowcore_ptr->io_int_param != schid) {
> +		report(0, "interrupt parameter: expected %08x got %08x",
> +		       schid, lowcore_ptr->io_int_param);
> +		ret = -1;
> +		goto end;
> +	}
> +
> +	/* Verify that device status is valid */
> +	if (!(irb.scsw.ctrl & SCSW_SC_PENDING)) {
> +		report(0, "No status pending after interrupt. Subch Ctrl: %08x",
> +		       irb.scsw.ctrl);
> +		ret = -1;
> +		goto end;
> +	}
> +
> +	if (!(irb.scsw.ctrl & (SCSW_SC_SECONDARY | SCSW_SC_PRIMARY))) {
> +		report(0, "Primary or secondary status missing. Subch Ctrl: %08x",
> +		       irb.scsw.ctrl);
> +		ret = -1;
> +		goto end;
> +	}
> +
> +	if (!(irb.scsw.dev_stat & (SCSW_DEVS_DEV_END | SCSW_DEVS_SCH_END))) {
> +		report(0, "No device end nor sch end. Dev. status: %02x",

s/nor/or/ ?

> +		       irb.scsw.dev_stat);
> +		ret = -1;
> +		goto end;
> +	}
> +
> +	if (irb.scsw.sch_stat & !(SCSW_SCHS_PCI | SCSW_SCHS_IL)) {

Did you mean ~(SCSW_SCHS_PCI | SCSW_SCHS_IL)?

If yes, why do think a PCI may show up?

> +		report_info("Unexpected Subch. status %02x", irb.scsw.sch_stat);
> +		ret = -1;
> +		goto end;
> +	}
> +
> +end:
> +	report_prefix_pop();
> +	return ret;

(...)
