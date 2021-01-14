Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbhANOqY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 09:46:24 -0500
Date: Thu, 14 Jan 2021 15:45:25 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 9/9] s390x: sclp: Add CPU entry offset
 comment
Message-ID: <20210114154525.2dcdb1d6@ibm-vm>
In-Reply-To: <20210112132054.49756-10-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-10-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Tue, 12 Jan 2021 08:20:54 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's make it clear that there is something at the end of the
> struct. The exact offset is reported by the cpu_offset member.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/sclp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index dccbaa8..395895f 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -134,7 +134,10 @@ typedef struct ReadInfo {
>  	uint8_t reserved7[134 - 128];
>  	uint8_t byte_134_diag318 : 1;
>  	uint8_t : 7;
> -	struct CPUEntry entries[0];
> +	/*
> +	 * The cpu entries follow, they start at the offset specified
> +	 * in offset_cpu.
> +	 */
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct ReadCpuInfo {

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
