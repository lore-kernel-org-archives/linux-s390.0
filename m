Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfJ2H0z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 03:26:55 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T7G0fq061580
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 03:26:54 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxf6ujv0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 03:26:54 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 29 Oct 2019 07:26:51 -0000
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Tue, 29 Oct 2019 08:26:47 +0100
MIME-Version: 1.0
In-Reply-To: <20191028210559.8289-7-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 28.10.19 22:05, Richard Henderson wrote:
> We cannot use the pointer output without validating the
> success of the random read.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/archrandom.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
> index c67b82dfa558..f3f1ee0a8c38 100644
> --- a/arch/s390/include/asm/archrandom.h
> +++ b/arch/s390/include/asm/archrandom.h
> @@ -33,17 +33,17 @@ static inline bool arch_has_random_seed(void)
>  	return false;
>  }
>
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>  	return false;
>  }
>
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>  	return false;
>  }
>
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
>  		return s390_arch_random_generate((u8 *)v, sizeof(*v));
> @@ -51,7 +51,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
>  	return false;
>  }
>
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
>  		return s390_arch_random_generate((u8 *)v, sizeof(*v));
Fine with me, Thanks, reviewed, build and tested.
You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
However, will this go into the kernel tree via crypto or s390 subsystem ?
