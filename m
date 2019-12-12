Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726492AbfLLMBV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Dec 2019 07:01:21 -0500
Date: Thu, 12 Dec 2019 13:01:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: css: msch, enable test
Message-ID: <20191212130111.0f75fe7f.cohuck@redhat.com>
In-Reply-To: <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Wed, 11 Dec 2019 16:46:08 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> A second step when testing the channel subsystem is to prepare a channel
> for use.
> This includes:
> - Get the current SubCHannel Information Block (SCHIB) using STSCH
> - Update it in memory to set the ENABLE bit
> - Tell the CSS that the SCHIB has been modified using MSCH
> - Get the SCHIB from the CSS again to verify that the subchannel is
>   enabled.
> 
> This tests the success of the MSCH instruction by enabling a channel.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/s390x/css.c b/s390x/css.c
> index dfab35f..b8824ad 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -19,12 +19,24 @@
>  #include <asm/time.h>
>  
>  #include <css.h>
> +#include <asm/time.h>
>  
>  #define SID_ONE		0x00010000
>  
>  static struct schib schib;
>  static int test_device_sid;
>  
> +static inline void delay(unsigned long ms)
> +{
> +	unsigned long startclk;
> +
> +	startclk = get_clock_ms();
> +	for (;;) {
> +		if (get_clock_ms() - startclk > ms)
> +			break;
> +	}
> +}

Would this function be useful for other callers as well? I.e., should
it go into a common header?

> +
>  static void test_enumerate(void)
>  {
>  	struct pmcw *pmcw = &schib.pmcw;
> @@ -64,11 +76,64 @@ out:
>  	report(1, "Devices, tested: %d, I/O type: %d", scn, scn_found);
>  }
>  
> +static void test_enable(void)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +		int count = 0;

Odd indentation.

> +	int cc;
> +
> +	if (!test_device_sid) {
> +		report_skip("No device");
> +		return;
> +	}
> +	/* Read the SCHIB for this subchannel */
> +	cc = stsch(test_device_sid, &schib);
> +	if (cc) {
> +		report(0, "stsch cc=%d", cc);
> +		return;
> +	}
> +
> +	/* Update the SCHIB to enable the channel */
> +	pmcw->flags |= PMCW_ENABLE;
> +
> +	/* Tell the CSS we want to modify the subchannel */
> +	cc = msch(test_device_sid, &schib);
> +	if (cc) {
> +		/*
> +		 * If the subchannel is status pending or
> +		 * if a function is in progress,
> +		 * we consider both cases as errors.
> +		 */
> +		report(0, "msch cc=%d", cc);
> +		return;
> +	}
> +
> +	/*
> +	 * Read the SCHIB again to verify the enablement
> +	 * insert a little delay and try 5 times.
> +	 */
> +	do {
> +		cc = stsch(test_device_sid, &schib);
> +		if (cc) {
> +			report(0, "stsch cc=%d", cc);
> +			return;
> +		}
> +		delay(10);

That's just a short delay to avoid a busy loop, right? msch should be
immediate, and you probably should not delay on success?

> +	} while (!(pmcw->flags & PMCW_ENABLE) && count++ < 5);

How is this supposed to work? Doesn't the stsch overwrite the control
block again, so you need to re-set the enable bit before you retry?

> +
> +	if (!(pmcw->flags & PMCW_ENABLE)) {
> +		report(0, "Enable failed. pmcw: %x", pmcw->flags);
> +		return;
> +	}
> +	report(1, "Tested");
> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
>  } tests[] = {
>  	{ "enumerate (stsch)", test_enumerate },
> +	{ "enable (msch)", test_enable },
>  	{ NULL, NULL }
>  };
>  
