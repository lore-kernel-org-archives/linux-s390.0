Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C7C46CA1
	for <linux-s390@archiver.kernel.org>; Mon, 18 Sep 2023 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjIRQR6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIRQRu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Sep 2023 12:17:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071117D99
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 09:12:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso575553276.2
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695053541; x=1695658341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmpxNm78kWfejPgZcglZLNttpcA+aOzIbjCglm6BlEY=;
        b=PfOvp4DDqhsXIubO0v9nTeL3XolQ8fusDqLFhZBLDhdQeBTizOwDDD7u+zGSndajRO
         VCt74HzavqjVqiyuWAY7ukOp/t+wXT5jWLsYZIqKM98u68IS8qiJr1LVgdHXAFAFidsv
         ROr/TQ3m0MY9siTv18IuM0QV8I42iQzLd7tUlthucATqpLGJul3haGFI2CViLYBFTdfh
         Wo9imjguYJKJH7QNOG/ESWwH1rJaajYJ3TiT6CtXAbmprbXyPRuWnPkZj+23V1S+WqzY
         ZglCB4UOhivjoWvSb2FP2s/vP8R573T34SaTaAKcA+oOC5+uq+bY2jyq/xHLzThwQbGq
         V54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053541; x=1695658341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmpxNm78kWfejPgZcglZLNttpcA+aOzIbjCglm6BlEY=;
        b=YRfLuAbt37goFDGFnVEFQuYehkGEXzgv+A6o9WEzoa73yHSPdJCOHFllIMYSk0DPVt
         xRmxR5yYzVVLfFXtNQlTUVoJRkMWsJDdwVpRtSckfJXY6Z8DcYmnZpkVMg9FrKCvBUdt
         /144lKjthuIaGfqxoKSNbUfkWm4A5akfNOeYL3yjvO2bnGINwqDZocztcoyswr9KJy70
         HJ0HsohgdXYlpaHip+7kef2WQxsMjUtlUrtZ4XpgBrOv6qrY1fUycHVFWVWqLV+CrtPE
         Pnpf9lMj5zaeRnIk4v442pH4QVGFAyHV6s3llhS77qd9MmvgOgkXacAQ7nXe1yGkrkSp
         t4Xw==
X-Gm-Message-State: AOJu0Yyf52SlLxcrJWm5tixfDtSz2LJblc8lKPLTpsWGEhTn4YoIFGDh
        Ihgjl6M39yHHrjdly8ys+4Ztuv9R/f/VpWnBKLk=
X-Google-Smtp-Source: AGHT+IE5R1x821mq0T9l2iChMZP/v62/zLl2heVXzUEZigk+bm+oq/r6FG+m4/T/InbSxJxTjGr9mw==
X-Received: by 2002:a05:620a:2887:b0:76d:aa93:2e3c with SMTP id j7-20020a05620a288700b0076daa932e3cmr11157815qkp.24.1695050987781;
        Mon, 18 Sep 2023 08:29:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a16a400b0076d0312b8basm3183843qkj.131.2023.09.18.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:29:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiGC2-0005S2-Ku;
        Mon, 18 Sep 2023 12:29:46 -0300
Date:   Mon, 18 Sep 2023 12:29:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Subject: Re: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at KVM+VFIO
Message-ID: <20230918152946.GJ13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-7-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916003118.2540661-7-seanjc@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 15, 2023 at 05:30:58PM -0700, Sean Christopherson wrote:
> Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
> and only if VFIO itself is enabled.  Similar to the recent change to have
> VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
> just because the architecture supports VFIO is nonsensical.
> 
> This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
> fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
> bug is benign as the only driver in all of Linux that actually uses the
> KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.

Hmm, I recall that all the S390 drivers need it as well.

static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
{
        struct ap_matrix_mdev *matrix_mdev =
                container_of(vdev, struct ap_matrix_mdev, vdev);

        if (!vdev->kvm)
                return -EINVAL;

        return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);


I wonder if we should be making the VFIO drivers that need the kvm to
ask for it? 'select CONFIG_NEED_VFIO_KVM' or something?

Regardless, I fully agree with getting rid of the arch flag.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -6,7 +6,9 @@
>  KVM ?= ../../../virt/kvm
>  
>  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> -kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> +ifdef CONFIG_VFIO
> +kvm-y += $(KVM)/vfio.o
> +endif

I wonder if kvm-m magically works in kbuild so you don't need the ifdef?

Jason
