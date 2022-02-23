Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99EC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 01:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiBWBnU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbiBWBnS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Feb 2022 20:43:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C73506E4
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 17:42:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qe15so1282994pjb.3
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sgQ4pvXgGqOVO+N8moxatmc5jwRe/+fI7Xu5f8+JqZo=;
        b=KgXpJPPMQwH9w8gozOo+zTZ1a384KP+JFjDoioBZIi6s8smONJs4TyFo+kGbejpfJD
         AnUvVpcCwYJXDkegOkRKwenDm9Bcy1n1aQgGolNklkCPtpDxRjodlPh8ROfIoqqQGWgw
         wc1Z3UQMXWImfkfneDskrMp1PLZpvMb2xrw9QAWiCjPSyKH5ztHVZbroTQ6dmTqG6Lc2
         A4xkJ+LfVum26Hb76lucaasDCRzDWvpeo7LmSfqxJdE8LUVUlFGq9YldMUlujQM5YwMQ
         6E9ukyeoRGTs5m/d/477F+RzD75Ilmmnh/nact1JsbYH8PJzUdJ7E9F83aVz2wOyHISi
         mxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sgQ4pvXgGqOVO+N8moxatmc5jwRe/+fI7Xu5f8+JqZo=;
        b=kGuyBExGfNgYJlr6FP4vcHwmilRu5cVRe80mQoOmG0kV0tMrLCVSsjBDr2TKV+r/Ry
         GC8EZWJ79qybeoTCKdRCp8+fwgxLuQu5W701U83/uCoQTPPMH14/Vg0236ByEAqfbAwk
         rn4OgkWfjy4/IkDjOhz/mer+rA4tKxmOdcqK+4nGYT+i+QBaE8Pbe0mDjpD92qnynIj4
         C786rJXcQw/GS8SG0Muq9rF2Fk/GUC2+nYkt0EI1wx9RV5aQ5sQFAO8iHxFgQKnYXyTg
         ggDNa+tEvo6w4Za0Ac+8eAoC/5SP6YdfogJy3UhXn036CvM7sMEC2OCCECo2U2teGjXR
         7i5A==
X-Gm-Message-State: AOAM533lwLQrt1x4/eMmQufQtoBsUmeMDv97DGL3vwPbdpvCvQzyTKou
        Fjir2Ya5HCxXpbBBxduRzOtXng==
X-Google-Smtp-Source: ABdhPJxkNmlCxKcZY6Nd/iFQ4JtJcxqvcyi1rl2zS5ckqmSSgYGC4lT0zZsv8apBv/K5LTxvkvT3FA==
X-Received: by 2002:a17:90b:197:b0:1bc:5037:7c52 with SMTP id t23-20020a17090b019700b001bc50377c52mr6928726pjs.174.1645580570678;
        Tue, 22 Feb 2022 17:42:50 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id o125sm17941244pfb.116.2022.02.22.17.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:42:50 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:42:50 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 15:31:01 PST (-0800)
Subject:     Re: [PATCH V5 12/21] riscv: compat: syscall: Add entry.S implementation
In-Reply-To: <20220201150545.1512822-13-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        anup@brainfault.org, Greg KH <gregkh@linuxfoundation.org>,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, Christoph Hellwig <hch@lst.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-27e65ada-d969-45b9-aa94-e69469cdf095@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 01 Feb 2022 07:05:36 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement the entry of compat_sys_call_table[] in asm. Ref to
> riscv-privileged spec 4.1.1 Supervisor Status Register (sstatus):
>
>  BIT[32:33] = UXL[1:0]:
>  - 1:32
>  - 2:64
>  - 3:128
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  arch/riscv/include/asm/csr.h |  7 +++++++
>  arch/riscv/kernel/entry.S    | 18 ++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index ae711692eec9..eed96fa62d66 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -36,6 +36,13 @@
>  #define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
>  #endif
>
> +#ifdef CONFIG_COMPAT
> +#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
> +#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
> +#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
> +#define SR_UXL_SHIFT	32
> +#endif
> +
>  /* SATP flags */
>  #ifndef CONFIG_64BIT
>  #define SATP_PPN	_AC(0x003FFFFF, UL)
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index ed29e9c8f660..1951743f09b3 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -207,13 +207,27 @@ check_syscall_nr:
>  	 * Syscall number held in a7.
>  	 * If syscall number is above allowed value, redirect to ni_syscall.
>  	 */
> -	bgeu a7, t0, 1f
> +	bgeu a7, t0, 3f
> +#ifdef CONFIG_COMPAT
> +	REG_L s0, PT_STATUS(sp)
> +	srli s0, s0, SR_UXL_SHIFT
> +	andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
> +	li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
> +	sub t0, s0, t0
> +	bnez t0, 1f
> +
> +	/* Call compat_syscall */
> +	la s0, compat_sys_call_table
> +	j 2f
> +1:
> +#endif
>  	/* Call syscall */
>  	la s0, sys_call_table
> +2:
>  	slli t0, a7, RISCV_LGPTR
>  	add s0, s0, t0
>  	REG_L s0, 0(s0)
> -1:
> +3:
>  	jalr s0
>
>  ret_from_syscall:

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
