Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392154AbhALPwp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 10:52:45 -0500
Subject: Re: [kvm-unit-tests PATCH v4 9/9] s390x: sclp: Add CPU entry offset
 comment
References: <20210112132054.49756-1-frankja@linux.ibm.com>
 <20210112132054.49756-10-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <72a9f9e7-5a3d-0cd3-6bfb-1b4bb3350ae3@redhat.com>
Date: Tue, 12 Jan 2021 16:51:06 +0100
MIME-Version: 1.0
In-Reply-To: <20210112132054.49756-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/01/2021 14.20, Janosch Frank wrote:
> Let's make it clear that there is something at the end of the
> struct. The exact offset is reported by the cpu_offset member.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/sclp.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index dccbaa8..395895f 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -134,7 +134,10 @@ typedef struct ReadInfo {
>   	uint8_t reserved7[134 - 128];
>   	uint8_t byte_134_diag318 : 1;
>   	uint8_t : 7;
> -	struct CPUEntry entries[0];
> +	/*
> +	 * The cpu entries follow, they start at the offset specified
> +	 * in offset_cpu.
> +	 */
>   } __attribute__((packed)) ReadInfo;
>   
>   typedef struct ReadCpuInfo {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
