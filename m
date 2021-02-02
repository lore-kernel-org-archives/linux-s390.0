Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237312AbhBBR0v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 12:26:51 -0500
Subject: Re: [kvm-unit-tests PATCH v1 1/5] s390x: css: Store CSS
 Characteristics
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-2-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <74ad7962-9217-5110-4089-9b83d519cfc1@redhat.com>
Date: Tue, 2 Feb 2021 18:25:15 +0100
MIME-Version: 1.0
In-Reply-To: <1611930869-25745-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 29/01/2021 15.34, Pierre Morel wrote:
> CSS characteristics exposes the features of the Channel SubSystem.
> Let's use Store Channel Subsystem Characteristics to retrieve
> the features of the CSS.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   lib/s390x/css.h     | 57 +++++++++++++++++++++++++++++++++++++++++++++
>   lib/s390x/css_lib.c | 50 ++++++++++++++++++++++++++++++++++++++-
>   s390x/css.c         | 12 ++++++++++
>   3 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
> index 3e57445..bc0530d 100644
> --- a/lib/s390x/css.h
> +++ b/lib/s390x/css.h
> @@ -288,4 +288,61 @@ int css_residual_count(unsigned int schid);
>   void enable_io_isc(uint8_t isc);
>   int wait_and_check_io_completion(int schid);
>   
> +/*
> + * CHSC definitions
> + */
> +struct chsc_header {
> +	u16 len;
> +	u16 code;
> +};
> +
> +/* Store Channel Subsystem Characteristics */
> +struct chsc_scsc {
> +	struct chsc_header req;
> +	u32 reserved1;
> +	u32 reserved2;
> +	u32 reserved3;
> +	struct chsc_header res;
> +	u32 format;
> +	u64 general_char[255];
> +	u64 chsc_char[254];
> +};
> +extern struct chsc_scsc *chsc_scsc;
> +
> +#define CSS_GENERAL_FEAT_BITLEN	(255 * 64)
> +#define CSS_CHSC_FEAT_BITLEN	(254 * 64)
> +
> +int get_chsc_scsc(void);
> +
> +static inline int _chsc(void *p)
> +{
> +	int cc;
> +
> +	asm volatile(
> +		"	.insn   rre,0xb25f0000,%2,0\n"
> +		"	ipm     %0\n"
> +		"	srl     %0,28\n"
> +		: "=d" (cc), "=m" (p)
> +		: "d" (p), "m" (p)
> +		: "cc");
> +
> +	return cc;
> +}
> +
> +#define CHSC_SCSC	0x0010
> +#define CHSC_SCSC_LEN	0x0010
> +
> +static inline int chsc(void *p, uint16_t code, uint16_t len)
> +{
> +	struct chsc_header *h = p;
> +
> +	h->code = code;
> +	h->len = len;
> +	return _chsc(p);
> +}
> +
> +#include <bitops.h>
> +#define css_general_feature(bit) test_bit_inv(bit, chsc_scsc->general_char)
> +#define css_chsc_feature(bit) test_bit_inv(bit, chsc_scsc->chsc_char)
> +
>   #endif
> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
> index 3c24480..fe05021 100644
> --- a/lib/s390x/css_lib.c
> +++ b/lib/s390x/css_lib.c
> @@ -15,11 +15,59 @@
>   #include <asm/arch_def.h>
>   #include <asm/time.h>
>   #include <asm/arch_def.h>
> -
> +#include <alloc_page.h>
>   #include <malloc_io.h>
>   #include <css.h>
>   
>   static struct schib schib;
> +struct chsc_scsc *chsc_scsc;
> +
> +int get_chsc_scsc(void)
> +{
> +	int i, n;
> +	int ret = 0;
> +	char buffer[510];
> +	char *p;
> +
> +	report_prefix_push("Channel Subsystem Call");
> +
> +	if (chsc_scsc) {
> +		report_info("chsc_scsc already initialized");
> +		goto end;
> +	}
> +
> +	chsc_scsc = alloc_pages(0);
> +	report_info("scsc_scsc at: %016lx", (u64)chsc_scsc);
> +	if (!chsc_scsc) {
> +		ret = -1;
> +		report(0, "could not allocate chsc_scsc page!");
> +		goto end;
> +	}
> +
> +	ret = chsc(chsc_scsc, CHSC_SCSC, CHSC_SCSC_LEN);
> +	if (ret) {
> +		report(0, "chsc: CC %d", ret);
> +		goto end;
> +	}
> +
> +	for (i = 0, p = buffer; i < CSS_GENERAL_FEAT_BITLEN; i++)
> +		if (css_general_feature(i)) {
> +			n = snprintf(p, sizeof(buffer) - ret, "%d,", i);
> +			p += n;
> +		}
> +	report_info("General features: %s", buffer);
> +
> +	for (i = 0, p = buffer, ret = 0; i < CSS_CHSC_FEAT_BITLEN; i++)
> +		if (css_chsc_feature(i)) {
> +			n = snprintf(p, sizeof(buffer) - ret, "%d,", i);
> +			p += n;
> +		}

Please use curly braces for the for-loops here, too. Rationale: Kernel 
coding style:

"Also, use braces when a loop contains more than a single simple statement"

  Thanks,
   Thomas
