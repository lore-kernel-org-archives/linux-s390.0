Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgFQIyr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 04:54:47 -0400
Date: Wed, 17 Jun 2020 10:54:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v9 11/12] s390x: css: msch, enable test
Message-ID: <20200617105433.6a79e92c.cohuck@redhat.com>
In-Reply-To: <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 15 Jun 2020 11:32:00 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> A second step when testing the channel subsystem is to prepare a channel
> for use.
> This includes:
> - Get the current subchannel Information Block (SCHIB) using STSCH
> - Update it in memory to set the ENABLE bit
> - Tell the CSS that the SCHIB has been modified using MSCH
> - Get the SCHIB from the CSS again to verify that the subchannel is
>   enabled.
> - If the command succeeds but subchannel is not enabled retry a
>   predefined retries count.
> - If the command fails, report the failure and do not retry, even
>   if cc indicates a busy/status pending as we do not expect this.
> 
> This tests the MSCH instruction to enable a channel succesfuly.
> This some retries are done and in case of error, and if the retries
> count is exceeded, a report is made.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css_lib.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/css.c         | 15 ++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index b0a0294..06a76db 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -15,6 +15,7 @@
>  #include <string.h>
>  #include <interrupt.h>
>  #include <asm/arch_def.h>
> +#include <asm/time.h>
>  
>  #include <css.h>
>  
> @@ -68,3 +69,62 @@ out:
>  		    scn, scn_found, dev_found);
>  	return schid;
>  }
> +
> +int css_enable(int schid)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int retry_count = 0;
> +	int cc;
> +
> +	/* Read the SCHIB for this subchannel */
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch failed with cc=%d", cc);

Mention the schid in the message?

> +		return cc;
> +	}
> +
> +	if (pmcw->flags & PMCW_ENABLE) {
> +		report_info("stsch: sch %08x already enabled", schid);
> +		return 0;
> +	}
> +
> +retry:
> +	/* Update the SCHIB to enable the channel */
> +	pmcw->flags |= PMCW_ENABLE;
> +
> +	/* Tell the CSS we want to modify the subchannel */
> +	cc = msch(schid, &schib);
> +	if (cc) {
> +		/*
> +		 * If the subchannel is status pending or
> +		 * if a function is in progress,
> +		 * we consider both cases as errors.
> +		 */
> +		report_info("msch failed with cc=%d", cc);
> +		return cc;
> +	}
> +
> +	/*
> +	 * Read the SCHIB again to verify the enablement
> +	 */
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch failed with cc=%d", cc);

Also add the schid here? Maybe also add a marker to distinguish the two
cases?

> +		return cc;
> +	}
> +
> +	if (pmcw->flags & PMCW_ENABLE) {
> +		report_info("Subchannel %08x enabled after %d retries",
> +			    schid, retry_count);
> +		return 0;
> +	}
> +
> +	if (retry_count++ < MAX_ENABLE_RETRIES) {
> +		mdelay(10); /* the hardware was not ready, give it some time */
> +		goto retry;
> +	}
> +
> +	report_info("msch: enabling sch %08x failed after %d retries. pmcw flags: %x",
> +		    schid, retry_count, pmcw->flags);
> +	return -1;
> +}

With the messages updated,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
