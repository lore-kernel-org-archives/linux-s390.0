Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA3C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF93761177
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 16:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhJ2QeO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhJ2QeO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Oct 2021 12:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635525105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbWwVV+hbGE8rMi2XL6X6jxBbZPWjHobzY3RTESINF4=;
        b=F1zfIjYRuiv6nLNRS/QwcSfLXTco5ttmp8tWfb3na5gbslovdhI/jE79c7Rd6evCw1KIde
        xjkIiq2DPSZ9wd28gUVsqhmeFDYbE2nte2gZ4H7JmUKXxky+W5LyYsOhAUkFPnowAoqTL4
        zdaa+v3FkjB32UGjkNYBqu7q2jRipo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-i6DUpVqoMI-6IH-xfuwpdA-1; Fri, 29 Oct 2021 12:31:40 -0400
X-MC-Unique: i6DUpVqoMI-6IH-xfuwpdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C3618D6A25;
        Fri, 29 Oct 2021 16:31:39 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43DC860936;
        Fri, 29 Oct 2021 16:31:35 +0000 (UTC)
Date:   Fri, 29 Oct 2021 18:31:32 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] s390/kexec: fix memory leak of ipl report buffer
Message-ID: <20211029183132.20839ad0@rhtmp>
In-Reply-To: <20211029092635.14804-1-bhe@redhat.com>
References: <20211029092635.14804-1-bhe@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Baoquan,

On Fri, 29 Oct 2021 17:26:35 +0800
Baoquan He <bhe@redhat.com> wrote:

> A memory leak is reported by kmemleak scanning:
> 
> unreferenced object 0x38000195000 (size 4096):
>   comm "kexec", pid 8548, jiffies 4294953647 (age 32443.270s)
>   hex dump (first 32 bytes):
>     00 00 00 c8 20 00 00 00 00 00 00 c0 02 80 00 00  .... ...........
>     40 40 40 40 40 40 40 40 00 00 00 00 00 00 00 00  @@@@@@@@........
>   backtrace:
>     [<0000000011a2f199>] __vmalloc_node_range+0xc0/0x140
>     [<0000000081fa2752>] vzalloc+0x5a/0x70
>     [<0000000063a4c92d>] ipl_report_finish+0x2c/0x180
>     [<00000000553304da>] kexec_file_add_ipl_report+0xf4/0x150
>     [<00000000862d033f>] kexec_file_add_components+0x124/0x160
>     [<000000000d2717bb>] arch_kexec_kernel_image_load+0x62/0x90
>     [<000000002e0373b6>] kimage_file_alloc_init+0x1aa/0x2e0
>     [<0000000060f2d14f>] __do_sys_kexec_file_load+0x17c/0x2c0
>     [<000000008c86fe5a>] __s390x_sys_kexec_file_load+0x40/0x50
>     [<000000001fdb9dac>] __do_syscall+0x1bc/0x1f0
>     [<000000003ee4258d>] system_call+0x78/0xa0
> 
> The ipl report buffer is allocated via vmalloc, while has no chance to free
> if the kexe loading is unloaded. This will cause obvious memory leak
> when kexec/kdump kernel is reloaded, manually, or triggered, e.g by
> memory hotplug.
> 
> Here, add struct kimage_arch to s390 to pass out the ipl report buffer
> address, and introduce arch dependent function
> arch_kimage_file_post_load_cleanup() to free it when unloaded.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

other than a missing

Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to
next kernel")

the patch looks good to me.

Reviewed-by: Philipp Rudo <prudo@redhat.com>

> ---
>  arch/s390/include/asm/kexec.h         | 7 +++++++
>  arch/s390/kernel/machine_kexec_file.c | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
> index ea398a05f643..9f16e99fb882 100644
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -74,6 +74,13 @@ void *kexec_file_add_components(struct kimage *image,
>  int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
>  			 unsigned long addr);
>  
> +#define ARCH_HAS_KIMAGE_ARCH
> +
> +struct kimage_arch {
> +	void *ipl_buf;
> +};
> +
> +
>  extern const struct kexec_file_ops s390_kexec_image_ops;
>  extern const struct kexec_file_ops s390_kexec_elf_ops;
>  
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index f9e4baa64b67..584c48b631b2 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -202,6 +202,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
>  	buf.buffer = ipl_report_finish(data->report);
>  	buf.bufsz = data->report->size;
>  	buf.memsz = buf.bufsz;
> +	image->arch.ipl_buf = buf.buffer;
>  
>  	data->memsz += buf.memsz;
>  
> @@ -321,3 +322,11 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  
>  	return kexec_image_probe_default(image, buf, buf_len);
>  }
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	kvfree(image->arch.ipl_buf);
> +	image->arch.ipl_buf = NULL;
> +
> +	return kexec_image_post_load_cleanup_default(image);
> +}

