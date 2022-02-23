Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B9C43219
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 01:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiBWBnS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiBWBnQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Feb 2022 20:43:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50D0506F2
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 17:42:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so727373pjb.5
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 17:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=N2UCfbLp79h/dkfWTGY4WIVSQeEuINCqmpbos16sW34=;
        b=4LFj9bz4NwjfZrhnHEdaivZOeq/+lWRcuq5Y1wzU2pkH5M1EbGGH+iS2dAWte4zzK0
         uhfsYDkF8v/YwKD4UrkItpNjka+Xnb5VDUm1+nNaSTfiwLfufG7rXr/ximrBJWWJ3I98
         SVPPLrKIpK7zmmK0mTw99x5pVOqdEe7hcOHvTEa4Vd3384rUHgzjAjmsWfjUCq+/kFkH
         LdIKEFlWMPZJtDKZwldMNodHN+jWw5yu0bDJ44NRvdh2aClgYR4rkjeegQmMBQE1UbfI
         CHqHwSMlqOGdpTnIqkYZYWyNY/pga1f2aIBpTtYLUdCay8XLPTHf+igsHER5SXIaDjrF
         Bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=N2UCfbLp79h/dkfWTGY4WIVSQeEuINCqmpbos16sW34=;
        b=5XM8Mx9OeO6RO00RtloqRwBpZRE2DOsc3D//gQuvSjyyEG3JxDOfvsjtIl8YdlMUB+
         1Oo7BA4Me684zxTxRw0rMY820foYSe7OAbY+aObkO/dD9FtFCbASzRHBmZGEelcF3NiC
         T4vaz2B1KOcsOXS5fSVZt5XxMyJzH5jo0eUijq0xhhZANnmFOu2pBLCzU46xPddEu/vH
         P7iw5uazVEGtzmechht1rIsGPN7qLejzT6mgjYUJoYQZoCWMYL8++OybVbjSClKHt+yA
         byplNa1TZu/F7RAnbqr6p4zrvBP2RTnhbDmROGjfRtTpckWHTnHWnzpEXPHk2RNv63MI
         vUjw==
X-Gm-Message-State: AOAM5339eJxBtfm6YlDkaSxLZtoZ1yz2b4ojtVs8DzjCLo8BGbd+pVE3
        NCA/oVGSrHslY5dlsoFwxP+a2w==
X-Google-Smtp-Source: ABdhPJziibP3VeHPcI77/p+oZjngxSrgPOeEDAz92xaYnjXHit/HBL3E+aw7A2/vfSyzdBkgFOVIog==
X-Received: by 2002:a17:90a:a502:b0:1bc:8dd6:a859 with SMTP id a2-20020a17090aa50200b001bc8dd6a859mr2404594pjq.46.1645580569193;
        Tue, 22 Feb 2022 17:42:49 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id bd13sm4528769pfb.60.2022.02.22.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:42:48 -0800 (PST)
Date:   Tue, 22 Feb 2022 17:42:48 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 15:29:49 PST (-0800)
Subject:     Re: [PATCH V5 13/21] riscv: compat: process: Add UXL_32 support in start_thread
In-Reply-To: <20220201150545.1512822-14-guoren@kernel.org>
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
Message-ID: <mhng-5c3b969c-9a23-48dc-ab10-a1addc6a5349@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 01 Feb 2022 07:05:37 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> If the current task is in COMPAT mode, set SR_UXL_32 in status for
> returning userspace. We need CONFIG _COMPAT to prevent compiling
> errors with rv32 defconfig.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  arch/riscv/kernel/process.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 03ac3aa611f5..1a666ad299b4 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  	}
>  	regs->epc = pc;
>  	regs->sp = sp;
> +
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_task())
> +		regs->status |= SR_UXL_32;

Not sure if I'm just misunderstanding the bit ops here, but aren't we 
trying to set the UXL field to 1 (for UXL=32)?  That should be a bit 
field set op, not just an OR.

> +#endif
>  }
>
>  void flush_thread(void)

Additionally: this isn't really an issue so much with this patch, but it 
does bring up that we're relying on someone else to have set UXL=64 on 
CONFIG_COMPAT=n systems.  I don't see that in any spec anywhere, so we 
should really be setting UXL in Linux for all systems (ie, not just those with
COMPAT=y).
