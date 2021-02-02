Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237487AbhBBRb2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 12:31:28 -0500
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: css: simplifications of the
 tests
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <daf7ef77-98fc-3e29-d753-78b933a494d5@redhat.com>
Date: Tue, 2 Feb 2021 18:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 29/01/2021 15.34, Pierre Morel wrote:
> In order to ease the writing of tests based on:
> - interrupt
> - enabling a subchannel
> - using multiple I/O on a channel without disabling it
> 
> We do the following simplifications:
> - the I/O interrupt handler is registered on CSS initialization
> - We do not enable again a subchannel in senseid if it is already
>    enabled
> - we add a css_enabled() function to test if a subchannel is enabled
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
[...]
> diff --git a/s390x/css.c b/s390x/css.c
> index 18dbf01..230f819 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -56,36 +56,27 @@ static void test_enable(void)
>    * - We need the test device as the first recognized
>    *   device by the enumeration.
>    */
> -static void test_sense(void)
> +static bool do_test_sense(void)
>   {
>   	struct ccw1 *ccw;
> +	bool retval = false;
>   	int ret;
>   	int len;
>   
>   	if (!test_device_sid) {
>   		report_skip("No device");
> -		return;
> +		return retval;
>   	}
>   
> -	ret = css_enable(test_device_sid, IO_SCH_ISC);
> -	if (ret) {
> -		report(0, "Could not enable the subchannel: %08x",
> -		       test_device_sid);
> -		return;
> +	if (!css_enabled(test_device_sid)) {
> +		report(0, "enabled subchannel: %08x", test_device_sid);
> +		return retval;
>   	}
>   
> -	ret = register_io_int_func(css_irq_io);
> -	if (ret) {
> -		report(0, "Could not register IRQ handler");
> -		return;
> -	}
> -
> -	lowcore_ptr->io_int_param = 0;
> -
>   	senseid = alloc_io_mem(sizeof(*senseid), 0);
>   	if (!senseid) {
>   		report(0, "Allocation of senseid");
> -		goto error_senseid;
> +		return retval;
>   	}
>   
>   	ccw = ccw_alloc(CCW_CMD_SENSE_ID, senseid, sizeof(*senseid), CCW_F_SLI);
> @@ -129,16 +120,21 @@ static void test_sense(void)
>   	report_info("reserved 0x%02x cu_type 0x%04x cu_model 0x%02x dev_type 0x%04x dev_model 0x%02x",
>   		    senseid->reserved, senseid->cu_type, senseid->cu_model,
>   		    senseid->dev_type, senseid->dev_model);
> +	report_info("cu_type expected 0x%04x got 0x%04x", (uint16_t)cu_type,
> +		    senseid->cu_type);
>   
> -	report(senseid->cu_type == cu_type, "cu_type expected 0x%04x got 0x%04x",
> -	       (uint16_t)cu_type, senseid->cu_type);
> +	retval = senseid->cu_type == cu_type;
>   
>   error:
>   	free_io_mem(ccw, sizeof(*ccw));
>   error_ccw:
>   	free_io_mem(senseid, sizeof(*senseid));
> -error_senseid:
> -	unregister_io_int_func(css_irq_io);
> +	return retval;
> +}

Maybe use "success" as a name for the variable instead of "retval"? ... 
since it's a boolean value...

  Thomas
