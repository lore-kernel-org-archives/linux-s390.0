Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729189AbgEMI2C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 04:28:02 -0400
Subject: Re: s390x: kdump kernel can not boot if I load kernel and initrd
 images via the kexec_file_load syscall.
References: <4d7ff4bb-f09e-7aec-964f-f5cc2412e5b7@redhat.com>
 <20200511111558.2d3e3db3@laptop2-ibm.local>
 <20200511170146.28eaafed@laptop2-ibm.local>
 <19903f1e-b3ae-730e-8a02-ed30fb47e9ba@redhat.com>
 <559a3c8f-9da9-a64d-aa78-434365c4b271@redhat.com>
 <79241fab-3299-1ba3-1c2b-a29eb4e0af7c@redhat.com>
 <20200512193956.15ae3f23@laptop2-ibm.local>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ea013211-575e-993d-9437-ba961ef64fe0@de.ibm.com>
Date: Wed, 13 May 2020 10:27:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200512193956.15ae3f23@laptop2-ibm.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>, lijiang <lijiang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 12.05.20 19:39, Philipp Rudo wrote:
> Hi Lianbo,
> 
> stupid me obviously never tested the kdump+initrd combination...
> 
> The patch below fixed the problem for me. Could please give it a try, too.
> 
> Thanks
> Philipp
> 
> ---
> 
> From 3f77088c9139582261d2e3ee6476324fc1ded401 Mon Sep 17 00:00:00 2001
> From: Philipp Rudo <prudo@linux.ibm.com>
> Date: Tue, 12 May 2020 19:25:14 +0200
> Subject: [PATCH] s390/kexec_file: fix initrd location for kdump kernel
> 
> initrd_start must not point at the location the initrd is loaded into
> the crashkernel memory but at the location it will be after the
> crashkernel memory is swapped with the memory at 0.
> 
> Fixes: ee337f5469fd ("s390/kexec_file: Add crash support to image loader")
> Reported-by: Lianbo Jiang <lijiang@redhat.com>
> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8415ae7d2a23..f9e4baa64b67 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct kimage *image,
>  		buf.mem += crashk_res.start;
>  	buf.memsz = buf.bufsz;
>  
> -	data->parm->initrd_start = buf.mem;
> +	data->parm->initrd_start = data->memsz;
>  	data->parm->initrd_size = buf.memsz;
>  	data->memsz += buf.memsz;


Thanks, applied. 
