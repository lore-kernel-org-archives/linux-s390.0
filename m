Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbgGILlJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 07:41:09 -0400
Date: Thu, 9 Jul 2020 13:40:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v11 8/9] s390x: css: msch, enable test
Message-ID: <20200709134056.0d267b6c.cohuck@redhat.com>
In-Reply-To: <1594282068-11054-9-git-send-email-pmorel@linux.ibm.com>
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
        <1594282068-11054-9-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com

On Thu,  9 Jul 2020 10:07:47 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> A second step when testing the channel subsystem is to prepare a channel
> for use.
> This includes:
> - Get the current subchannel Information Block (SCHIB) using STSCH
> - Update it in memory to set the ENABLE bit and the specified ISC
> - Tell the CSS that the SCHIB has been modified using MSCH
> - Get the SCHIB from the CSS again to verify that the subchannel is
>   enabled and uses the specified ISC.
> - If the command succeeds but subchannel is not enabled or the ISC
>   field is not as expected, retry a predefined retries count.
> - If the command fails, report the failure and do not retry, even
>   if cc indicates a busy/status pending as we do not expect this.
> 
> This tests the MSCH instruction to enable a channel successfully.
> Retries are done and in case of error, and if the retries count
> is exceeded, a report is made.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/css.h     |  8 +++--
>  lib/s390x/css_lib.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/css.c         | 15 ++++++++++
>  3 files changed, 92 insertions(+), 3 deletions(-)

(...)

> +/*
> + * css_msch: enable subchannel and set with specified ISC

"css_enable: enable the subchannel with the specified ISC"

?

> + * @schid: Subchannel Identifier
> + * @isc  : number of the interruption subclass to use
> + * Return value:
> + *   On success: 0
> + *   On error the CC of the faulty instruction
> + *      or -1 if the retry count is exceeded.
> + */
> +int css_enable(int schid, int isc)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int retry_count = 0;
> +	uint16_t flags;
> +	int cc;
> +
> +	/* Read the SCHIB for this subchannel */
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch: sch %08x failed with cc=%d", schid, cc);
> +		return cc;
> +	}
> +
> +	flags = PMCW_ENABLE | (isc << PMCW_ISC_SHIFT);
> +	if ((pmcw->flags & flags) == flags) {

I think you want (pmcw->flags & PMCW_ENABLE) == PMCW_ENABLE -- this
catches the case of "subchannel has been enabled before, but with a
different isc".

> +		report_info("stsch: sch %08x already enabled", schid);
> +		return 0;
> +	}

(...)
