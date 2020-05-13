Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725898AbgEMD2v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 May 2020 23:28:51 -0400
Subject: Re: s390x: kdump kernel can not boot if I load kernel and initrd
 images via the kexec_file_load syscall.
References: <4d7ff4bb-f09e-7aec-964f-f5cc2412e5b7@redhat.com>
 <20200511111558.2d3e3db3@laptop2-ibm.local>
 <20200511170146.28eaafed@laptop2-ibm.local>
 <19903f1e-b3ae-730e-8a02-ed30fb47e9ba@redhat.com>
 <559a3c8f-9da9-a64d-aa78-434365c4b271@redhat.com>
 <79241fab-3299-1ba3-1c2b-a29eb4e0af7c@redhat.com>
 <20200512193956.15ae3f23@laptop2-ibm.local>
From: lijiang <lijiang@redhat.com>
Message-ID: <426212ae-7687-87df-2275-f26ffd16fc8e@redhat.com>
Date: Wed, 13 May 2020 11:28:36 +0800
MIME-Version: 1.0
In-Reply-To: <20200512193956.15ae3f23@laptop2-ibm.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

在 2020年05月13日 01:39, Philipp Rudo 写道:
> Hi Lianbo,
> 
> stupid me obviously never tested the kdump+initrd combination...
> 
> The patch below fixed the problem for me. Could please give it a try, too.
> 

Thank you for the patch, Philipp. Kdump kernel can boot on s390x machine with this patch.

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

Good findings.

>  	data->parm->initrd_size = buf.memsz;
>  	data->memsz += buf.memsz;
>  
> 

Tested-by: Lianbo Jiang <lijiang@redhat.com>

Thanks.
Lianbo
