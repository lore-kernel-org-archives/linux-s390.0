Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232620AbhBIPWy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 10:22:54 -0500
Subject: Re: [kvm-unit-tests PATCH v1 1/4] libcflat: add SZ_1M and SZ_2G
References: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
 <20210209143835.1031617-2-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bc698e30-883f-495f-c3c3-11cdffaf4152@redhat.com>
Date: Tue, 9 Feb 2021 16:21:19 +0100
MIME-Version: 1.0
In-Reply-To: <20210209143835.1031617-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, frankja@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com

On 09/02/2021 15.38, Claudio Imbrenda wrote:
> Add SZ_1M and SZ_2G to libcflat.h
> 
> s390x needs those for large/huge pages
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/libcflat.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/libcflat.h b/lib/libcflat.h
> index 460a1234..8dac0621 100644
> --- a/lib/libcflat.h
> +++ b/lib/libcflat.h
> @@ -157,7 +157,9 @@ extern void setup_vm(void);
>   #define SZ_8K			(1 << 13)
>   #define SZ_16K			(1 << 14)
>   #define SZ_64K			(1 << 16)
> +#define SZ_1M			(1 << 20)
>   #define SZ_2M			(1 << 21)
>   #define SZ_1G			(1 << 30)
> +#define SZ_2G			(1ul << 31)
>   
>   #endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
