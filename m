Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726252AbgGNLiV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jul 2020 07:38:21 -0400
Subject: Re: [kvm-unit-tests PATCH v12 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1594725348-10034-1-git-send-email-pmorel@linux.ibm.com>
 <1594725348-10034-10-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <865cb20f-ac2d-f54a-6613-5d580675eb97@redhat.com>
Date: Tue, 14 Jul 2020 13:38:10 +0200
MIME-Version: 1.0
In-Reply-To: <1594725348-10034-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, drjones@redhat.com

On 14/07/2020 13.15, Pierre Morel wrote:
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
[...]
> @@ -102,6 +113,19 @@ struct irb {
>  	uint32_t emw[8];
>  } __attribute__ ((aligned(4)));
>  
> +#define CCW_CMD_SENSE_ID	0xe4
> +#define CSS_SENSEID_COMMON_LEN	8
> +struct senseid {
> +	/* common part */
> +	uint8_t reserved;        /* always 0x'FF' */
> +	uint16_t cu_type;        /* control unit type */
> +	uint8_t cu_model;        /* control unit model */
> +	uint16_t dev_type;       /* device type */
> +	uint8_t dev_model;       /* device model */
> +	uint8_t unused;          /* padding byte */
> +	uint8_t padding[256 - 10]; /* Extra padding for CCW */
> +} __attribute__ ((aligned(4))) __attribute__ ((packed));

Is that padding[256 - 10] right? If I count right, there are only 8
bytes before the padding field, so "10" sounds wrong here?

[...]
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index e47a945..274c293 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
[...]
> +/*
> + * css_residual_count
> + * Return the residual count, if it is valid.
> + *
> + * Return value:
> + * Success: the residual count
> + * Not meaningful: -1 (-1 can not be a valid count)
> + */
> +int css_residual_count(unsigned int schid)
> +{
> +
> +	if (!(irb.scsw.ctrl & (SCSW_SC_PENDING | SCSW_SC_PRIMARY)))
> +		goto invalid;
> +
> +	if (irb.scsw.dev_stat)
> +		if (irb.scsw.sch_stat & ~(SCSW_SCHS_PCI | SCSW_SCHS_IL))
> +			goto invalid;
> +
> +	return irb.scsw.count;
> +
> +invalid:
> +	return -1;
> +}

Cosmetical nit: Unless you want to add something between "invalid:" and
"return -1" later, I'd rather replace "goto invalid" with "return -1"
and get rid of the "invalid" label here.

 Thomas
