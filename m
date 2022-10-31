Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8027AFA3741
	for <linux-s390@archiver.kernel.org>; Mon, 31 Oct 2022 15:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiJaPzP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJaPzO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 31 Oct 2022 11:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F315B120A7
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 08:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EC8612C3
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 15:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D07FC433D6;
        Mon, 31 Oct 2022 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667231711;
        bh=KXf3/8x/6/T3BpgZrBg6fcTUJNxO9c6a6yfM3qV9fyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewcG9xzWx6TO16v+yu8yAiK0OABkNeWVx4TfKv1QGCAZiQp4eeSG9uN5x8ZnDTgwI
         tpN9EyJKQ54SRLKzD94FOPVi90EeC/iCqIgC1KqNf0qByDDVv38WHFc04r5TUQ9Sgw
         Pi6k7tLo/xvHfDXoidmKmkDcQfkUVlo7YT+bIYiLc14dpVwxTSlV829215chMHDOBW
         /r75stqALo3os/4JQ9OGh+FnTuzGIupNikepYs6sGzic0nxLP8jyjPULPN0T9qW6sX
         QD4gwmWztLogCCnAqOF/crKFi2Hi6Jyrfzs6ZBOzQ0YN+jWL12nGW2kEq/hb1uU/5K
         HiGWhD1Q+3JVQ==
Date:   Mon, 31 Oct 2022 08:55:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: always build relocatable kernel
Message-ID: <Y1/v3TwIT1yEFm+o@dev-arch.thelio-3990X>
References: <20221030182202.2062705-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030182202.2062705-1-hca@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Oct 30, 2022 at 07:22:02PM +0100, Heiko Carstens wrote:
> Nathan Chancellor reported several link errors on s390 with
> CONFIG_RELOCATABLE disabled, after binutils commit 906f69cf65da ("IBM
> zSystems: Issue error for *DBL relocs on misaligned symbols"). The binutils
> commit reveals potential miscompiles that might have happened already
> before with linker script defined symbols at odd addresses.
> 
> A similar bug was recently fixed in the kernel with commit c9305b6c1f52
> ("s390: fix nospec table alignments").
> 
> See https://github.com/ClangBuiltLinux/linux/issues/1747 for an analysis
> from Ulich Weigand.
> 
> Therefore always build a relocatable kernel to avoid this problem. There is
> hardly any use-case for non-relocatable kernels, so this shouldn't be
> controversial.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1747
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/s390/Kconfig        | 6 +++---
>  arch/s390/Makefile       | 2 --
>  arch/s390/boot/Makefile  | 3 +--
>  arch/s390/boot/startup.c | 3 +--
>  4 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 318fce77601d..de575af02ffe 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -568,8 +568,7 @@ config EXPOLINE_FULL
>  endchoice
>  
>  config RELOCATABLE
> -	bool "Build a relocatable kernel"
> -	default y
> +	def_bool y
>  	help
>  	  This builds a kernel image that retains relocation information
>  	  so it can be loaded at an arbitrary address.
> @@ -578,10 +577,11 @@ config RELOCATABLE
>  	  bootup process.
>  	  The relocations make the kernel image about 15% larger (compressed
>  	  10%), but are discarded at runtime.
> +	  Note: this option exists only for documentation purposes, please do
> +	  not remove it.
>  
>  config RANDOMIZE_BASE
>  	bool "Randomize the address of the kernel image (KASLR)"
> -	depends on RELOCATABLE
>  	default y
>  	help
>  	  In support of Kernel Address Space Layout Randomization (KASLR),
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index de6d8b2ea4d8..b3235ab0ace8 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -14,10 +14,8 @@ KBUILD_AFLAGS_MODULE += -fPIC
>  KBUILD_CFLAGS_MODULE += -fPIC
>  KBUILD_AFLAGS	+= -m64
>  KBUILD_CFLAGS	+= -m64
> -ifeq ($(CONFIG_RELOCATABLE),y)
>  KBUILD_CFLAGS	+= -fPIE
>  LDFLAGS_vmlinux	:= -pie
> -endif
>  aflags_dwarf	:= -Wa,-gdwarf-2
>  KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  ifndef CONFIG_AS_IS_LLVM
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index 883357a211a3..d52c3e2e16bc 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -37,9 +37,8 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>  
>  obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
>  obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
> -obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o
> +obj-y	+= version.o pgm_check_info.o ctype.o ipl_data.o machine_kexec_reloc.o
>  obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+= uv.o
> -obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
>  obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
>  obj-y	+= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
>  obj-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o
> diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
> index 6e7f01ca53e6..47ca3264c023 100644
> --- a/arch/s390/boot/startup.c
> +++ b/arch/s390/boot/startup.c
> @@ -291,8 +291,7 @@ void startup_kernel(void)
>  
>  	clear_bss_section();
>  	copy_bootdata();
> -	if (IS_ENABLED(CONFIG_RELOCATABLE))
> -		handle_relocs(__kaslr_offset);
> +	handle_relocs(__kaslr_offset);
>  
>  	if (__kaslr_offset) {
>  		/*
> -- 
> 2.34.1
> 
