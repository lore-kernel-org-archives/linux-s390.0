Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728093AbgAUJSH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jan 2020 04:18:07 -0500
Subject: Re: [kvm-unit-tests PATCH v8 3/6] s390x: lib: fix stfl wrapper asm
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <20200120184256.188698-4-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9f89b339-f9e1-57e5-da0a-d8a090b558cc@redhat.com>
Date: Tue, 21 Jan 2020 10:17:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200120184256.188698-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 20.01.20 19:42, Claudio Imbrenda wrote:
> the stfl wrapper in lib/s390x/asm/facility.h was lacking the "memory"
> clobber in the inline asm.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/facility.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/asm/facility.h b/lib/s390x/asm/facility.h
> index 5103dd4..e34dc2c 100644
> --- a/lib/s390x/asm/facility.h
> +++ b/lib/s390x/asm/facility.h
> @@ -24,7 +24,7 @@ static inline bool test_facility(int nr)
>  
>  static inline void stfl(void)
>  {
> -	asm volatile("	stfl	0(0)\n");
> +	asm volatile("	stfl	0(0)\n" : : : "memory");
>  }
>  
>  static inline void stfle(uint8_t *fac, unsigned int len)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
