Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgCXLHC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 07:07:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OB4AXj075241
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 07:07:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7t5pn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 07:07:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 24 Mar 2020 11:06:57 -0000
Subject: Re: [kvm-unit-tests PATCH 10/10] s390x: Fix library constant
 definitions
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-11-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Mar 2020 12:06:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200324081251.28810-11-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d7e69eff-b3b5-eb66-18bb-79d9417ba78c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com



On 24.03.20 09:12, Janosch Frank wrote:
> Seems like I uppercased the whole region instead of only the ULs when
> I added those definitions. Lets make the x lowercase again.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49ca97c9964..1b3bb0c1e7e1b626 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -19,10 +19,10 @@ struct psw {
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  
> -#define CR0_EXTM_SCLP			0X0000000000000200UL
> -#define CR0_EXTM_EXTC			0X0000000000002000UL
> -#define CR0_EXTM_EMGC			0X0000000000004000UL
> -#define CR0_EXTM_MASK			0X0000000000006200UL
> +#define CR0_EXTM_SCLP			0x0000000000000200UL
> +#define CR0_EXTM_EXTC			0x0000000000002000UL
> +#define CR0_EXTM_EMGC			0x0000000000004000UL
> +#define CR0_EXTM_MASK			0x0000000000006200UL
>  
>  struct lowcore {
>  	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
> 
