Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgFIHre (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 03:47:34 -0400
Subject: Re: [kvm-unit-tests PATCH v8 11/12] s390x: css: msch, enable test
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-12-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f888f043-6177-5bcc-f84f-437015457cf3@redhat.com>
Date: Tue, 9 Jun 2020 09:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <1591603981-16879-12-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 08/06/2020 10.13, Pierre Morel wrote:
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
>  s390x/css.c         | 18 ++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index dc5a512..831a116 100644
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
> diff --git a/s390x/css.c b/s390x/css.c
> index f0e8f47..6f58d4a 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -40,11 +40,29 @@ static void test_enumerate(void)
>  	}
>  }
>  
> +static void test_enable(void)
> +{
> +	int cc;
> +
> +	if (!test_device_sid) {
> +		report_skip("No device");
> +		return;
> +	}
> +
> +	cc = css_enable(test_device_sid);
> +
> +	if (cc)
> +		report(0, "Failed to enable subchannel %08x", test_device_sid);
> +	else
> +		report(1, "Subchannel %08x enabled", test_device_sid);

Could you please write this as:

	report(cc == 1, "Enable subchannel %08x", test_device_sid);

... checking for a right value is the whole point of the first parameter
of report() :-)

 Thanks,
  Thomas
