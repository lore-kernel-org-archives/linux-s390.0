Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13500 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233186AbhBAKME (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 05:12:04 -0500
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: css: simplifications of the
 tests
Message-ID: <4f5ca0b9-378e-431c-33ec-79946bdf21b2@linux.ibm.com>
Date: Mon, 1 Feb 2021 11:11:16 +0100
MIME-Version: 1.0
In-Reply-To: <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 1/29/21 3:34 PM, Pierre Morel wrote:
> In order to ease the writing of tests based on:
> - interrupt
> - enabling a subchannel
> - using multiple I/O on a channel without disabling it
> 
> We do the following simplifications:
> - the I/O interrupt handler is registered on CSS initialization
> - We do not enable again a subchannel in senseid if it is already
>   enabled
> - we add a css_enabled() function to test if a subchannel is enabled
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h     |  1 +
>  lib/s390x/css_lib.c | 37 ++++++++++++++++++++++++----------
>  s390x/css.c         | 49 +++++++++++++++++++++++++--------------------
>  3 files changed, 54 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> index bc0530d..f8bfa37 100644
> --- a/lib/s390x/css.h
> +++ b/lib/s390x/css.h
> @@ -278,6 +278,7 @@ int css_enumerate(void);
>  
>  #define IO_SCH_ISC      3
>  int css_enable(int schid, int isc);
> +bool css_enabled(int schid);
>  
>  /* Library functions */
>  int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw);
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index fe05021..f300969 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -118,6 +118,31 @@ out:
>  	return schid;
>  }
>  
> +/*
> + * css_enable: enable the subchannel with the specified ISC

enabled or enable?

I.e. do you test if it is enabled or do you want to enable it.

> + * @schid: Subchannel Identifier
> + * Return value:
> + *   true if the subchannel is enabled
> + *   false otherwise
> + */
> +bool css_enabled(int schid)
> +{
> +	struct pmcw *pmcw = &schib.pmcw;
> +	int cc;
> +
> +	cc = stsch(schid, &schib);
> +	if (cc) {
> +		report_info("stsch: updating sch %08x failed with cc=%d",
> +			    schid, cc);
> +		return false;
> +	}
> +
> +	if (!(pmcw->flags & PMCW_ENABLE)) {
> +		report_info("stsch: sch %08x not enabled", schid);
> +		return 0;

Please stay with true/false or change the return type to int and use ints.

> +	}
> +	return true;
> +}
>  /*
>   * css_enable: enable the subchannel with the specified ISC
>   * @schid: Subchannel Identifier
> @@ -167,18 +192,8 @@ retry:
>  	/*
>  	 * Read the SCHIB again to verify the enablement
>  	 */
> -	cc = stsch(schid, &schib);
> -	if (cc) {
> -		report_info("stsch: updating sch %08x failed with cc=%d",
> -			    schid, cc);
> -		return cc;
> -	}
> -
> -	if ((pmcw->flags & flags) == flags) {
> -		report_info("stsch: sch %08x successfully modified after %d retries",
> -			    schid, retry_count);
> +	if (css_enabled(schid))
>  		return 0;
> -	}
>  
>  	if (retry_count++ < MAX_ENABLE_RETRIES) {
>  		mdelay(10); /* the hardware was not ready, give it some time */
> diff --git a/s390x/css.c b/s390x/css.c
> index 18dbf01..230f819 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -56,36 +56,27 @@ static void test_enable(void)
>   * - We need the test device as the first recognized
>   *   device by the enumeration.
>   */
> -static void test_sense(void)
> +static bool do_test_sense(void)
>  {
>  	struct ccw1 *ccw;
> +	bool retval = false;
>  	int ret;
>  	int len;
>  
>  	if (!test_device_sid) {
>  		report_skip("No device");
> -		return;
> +		return retval;
>  	}
>  
> -	ret = css_enable(test_device_sid, IO_SCH_ISC);
> -	if (ret) {
> -		report(0, "Could not enable the subchannel: %08x",
> -		       test_device_sid);
> -		return;
> +	if (!css_enabled(test_device_sid)) {
> +		report(0, "enabled subchannel: %08x", test_device_sid);
> +		return retval;
>  	}
>  
> -	ret = register_io_int_func(css_irq_io);
> -	if (ret) {
> -		report(0, "Could not register IRQ handler");
> -		return;
> -	}
> -
> -	lowcore_ptr->io_int_param = 0;
> -
>  	senseid = alloc_io_mem(sizeof(*senseid), 0);
>  	if (!senseid) {
>  		report(0, "Allocation of senseid");
> -		goto error_senseid;
> +		return retval;
>  	}
>  
>  	ccw = ccw_alloc(CCW_CMD_SENSE_ID, senseid, sizeof(*senseid), CCW_F_SLI);
> @@ -129,16 +120,21 @@ static void test_sense(void)
>  	report_info("reserved 0x%02x cu_type 0x%04x cu_model 0x%02x dev_type 0x%04x dev_model 0x%02x",
>  		    senseid->reserved, senseid->cu_type, senseid->cu_model,
>  		    senseid->dev_type, senseid->dev_model);
> +	report_info("cu_type expected 0x%04x got 0x%04x", (uint16_t)cu_type,
> +		    senseid->cu_type);
>  
> -	report(senseid->cu_type == cu_type, "cu_type expected 0x%04x got 0x%04x",
> -	       (uint16_t)cu_type, senseid->cu_type);
> +	retval = senseid->cu_type == cu_type;
>  
>  error:
>  	free_io_mem(ccw, sizeof(*ccw));
>  error_ccw:
>  	free_io_mem(senseid, sizeof(*senseid));
> -error_senseid:
> -	unregister_io_int_func(css_irq_io);
> +	return retval;

Could you return senseid->cu_type == cu_type here?

> +}
> +
> +static void test_sense(void)
> +{
> +	report(do_test_sense(), "Got CU type expected");
>  }
>  
>  static void css_init(void)
> @@ -146,8 +142,17 @@ static void css_init(void)
>  	int ret;
>  
>  	ret = get_chsc_scsc();
> -	if (!ret)
> -		report(1, " ");
> +	if (ret)
> +		return;
> +
> +	ret = register_io_int_func(css_irq_io);
> +	if (ret) {
> +		report(0, "Could not register IRQ handler");
> +		return;
> +	}
> +	lowcore_ptr->io_int_param = 0;
> +
> +	report(1, "CSS initialized");
>  }
>  
>  static struct {
> 
