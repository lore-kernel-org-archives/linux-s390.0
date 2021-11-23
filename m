Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F0C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 09:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhKWJPn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKWJPn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 04:15:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E6C06173E
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 01:12:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d5so37754618wrc.1
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYs1wzwF6+J9dSOANXB9y6loDw9qWfCXBI2HZhWySNA=;
        b=wltUiAygiHWsBEmc25AjNkPWeRE3z9px4T/cVrqarPBht3N5GOBcMj472TjSJxLh+F
         0GPEkZ82ElidOxCepsH3qkVpZpghdJFzn6w8QY0bBYX7GfBGAa5PebvvpwYx1AMsWy+/
         Hy0tXtM5hguM8ULFAxaSFY9L9pHflRmc5oBmZlGzdmDGxSVWLmJgoXyeLvirR3+EDdYc
         x6uL63V8O6CZSV6meLPQPSVnuq81aNx6LBTQbWdIxp70MyirIsOfKBJ+3yy5wRokBv7P
         ZHDdSS5XrKlSNk/fVqI4v77GmiM6rni3n8Pmp1gAXvY2q32B2g9mUwyOWVLBU2DWazev
         nV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYs1wzwF6+J9dSOANXB9y6loDw9qWfCXBI2HZhWySNA=;
        b=vRarO3y2qmIdctsZ4LtnzoLJtO0CC7gemierS2bOPrUFRvgrJ9ZEGPQT8FgTJHArCd
         3oGbxnSgcOgEzW9Y0BSazDdrAHA4agNPXDHyjPxNsqVtmALdRfh7ROIS0pD28bhoA+zw
         fxeG2RZ4jZNoWqhDEb+xByIUPawDidL4zzEtbuOmcy6c3Mc/cQ9lWmiZeWvpV7rJZo5b
         wxsv4JgreOevMMFW4v+SCpCqsxtLZryuXrjpqIo0apppvQdSq9l9fBt4hrtD61UFTwH2
         /KQ8cQG2Jre3fmz2NobkD7ajshTZkJaIV/+QHvzywyNp6+cwaveWBLhPVsu9Ksi/Fgfh
         StUA==
X-Gm-Message-State: AOAM531PNjd/V84yW7WoXECn2CebBAm8H2Q4777ggy8UMSPQw+0+QjTP
        kaZWvxZHCvg/oY9kzv2PtC9Uk03uNY0bdGsIjBeBoA==
X-Google-Smtp-Source: ABdhPJw3107qjhtYHlg0VKfoxcrKNwhATIgpuvcrTNAjZTbcT3w/UYNbeW1BEW91PyajE9x5O252/D9Dk01cQ3/AShU=
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr5400365wry.306.1637658753498;
 Tue, 23 Nov 2021 01:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20211121125451.9489-1-dwmw2@infradead.org> <20211121125451.9489-6-dwmw2@infradead.org>
In-Reply-To: <20211121125451.9489-6-dwmw2@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 23 Nov 2021 14:42:21 +0530
Message-ID: <CAAhSdy307DqNuQEFCu2ze2jXJ7taDE6y6SwY9nHGA8yNPfggiQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] KVM: RISC-V: Use Makefile.kvm for common files
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jmattson @ google . com" <jmattson@google.com>,
        "wanpengli @ tencent . com" <wanpengli@tencent.com>,
        "seanjc @ google . com" <seanjc@google.com>,
        "vkuznets @ redhat . com" <vkuznets@redhat.com>,
        "mtosatti @ redhat . com" <mtosatti@redhat.com>,
        "joro @ 8bytes . org" <joro@8bytes.org>, karahmed@amazon.com,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Anup Patel <anup.patel@wdc.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Nov 21, 2021 at 6:25 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Looks good to me.

For KVM RISC-V,
Acked-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Anup Patel <anup.patel@wdc.com>

Thanks,
Anup

> ---
>  arch/riscv/kvm/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 30cdd1df0098..300590225348 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -5,14 +5,10 @@
>
>  ccflags-y += -I $(srctree)/$(src)
>
> -KVM := ../../../virt/kvm
> +include $(srctree)/virt/kvm/Makefile.kvm
>
>  obj-$(CONFIG_KVM) += kvm.o
>
> -kvm-y += $(KVM)/kvm_main.o
> -kvm-y += $(KVM)/coalesced_mmio.o
> -kvm-y += $(KVM)/binary_stats.o
> -kvm-y += $(KVM)/eventfd.o
>  kvm-y += main.o
>  kvm-y += vm.o
>  kvm-y += vmid.o
> --
> 2.31.1
>
