Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgAHS6j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 13:58:39 -0500
Subject: Re: [kvm-unit-tests PATCH v5 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
 <20200108161317.268928-4-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ff1041f2-0262-ed89-4c5e-386f69d21cd0@redhat.com>
Date: Wed, 8 Jan 2020 19:58:27 +0100
MIME-Version: 1.0
In-Reply-To: <20200108161317.268928-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 08/01/2020 17.13, Claudio Imbrenda wrote:
> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> use it instead of using inline assembly everywhere.

Either some hunks are missing in this patch, or you should update the
patch description and remove the second part of the sentence ? ... at
least I did not spot the changes where you "use it instead of using
inline assembly everywhere".

 Thomas


> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 1a5e3c6..38c9dfa 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -284,4 +284,17 @@ static inline int servc(uint32_t command, unsigned long sccb)
>  	return cc;
>  }
>  
> +static inline void spx(uint32_t new_prefix)
> +{
> +	asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
> +}
> +
> +static inline uint32_t stpx(void)
> +{
> +	uint32_t prefix;
> +
> +	asm volatile("stpx %0" : "=Q" (prefix));
> +	return prefix;
> +}
> +
>  #endif
> 
