Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61450CD37B0
	for <linux-s390@archiver.kernel.org>; Mon, 18 Sep 2023 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIRQCU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjIRQCP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Sep 2023 12:02:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB3010CE
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:56:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c577fea3dcso6812495ad.2
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695052362; x=1695657162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2U3xsG0fg5xdFpPmP8zowhEzmg+gfxwbZh9hlXMaF+c=;
        b=Xq+bULNzXtlK9fQ1gwep/ALD5g9KBT8NdqTZAMyLJSUU0LH0IUGMKfe2VTQdNrHL5Y
         UfsG6Fx8+BGtX+P9MhPlJ87fVrPojrpieBn7WhVUHFk+Mcc6QFQuYMEljzOv3krULNmI
         WoUBThqa1u+YktUZmud48otH1zrunEhvv5FVfw0nrjvXJR8cwQ8yHM7bGuv3pXgztj03
         iNxtXNA7emoYxaAwD4Yb8z7WaekcG/vOtAvipseGnNEWbJ3JxcikoGcP1dL7XUNtCSLw
         NA6nDlgsQD860uV4WUZzEgAcTocSVoZd3doqHpcpySL/ybGURSvz3fvSuf6KA9iCsMxj
         8fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052362; x=1695657162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U3xsG0fg5xdFpPmP8zowhEzmg+gfxwbZh9hlXMaF+c=;
        b=fVqSqJ+0DWhv0QBszZNF0uvanMSzmBsMzKyV1ZwkoB1KSPw7DAreeBklv4Vu/bheIU
         G+te09fR6o+qd6rVknQLVIJ8HFc6FeIcZ9L0qbYi3+XJ8EdSs6LmicrGs327wxIacRZW
         oLPQtsnfXiS7iyjxdI1SPTs8ZjEgayyVmw98H8rPk1R1naM/j4Spiwt0tFjzhFFKPKCe
         eSAZ51tipMzTK15J5d/lNktNdyFAM2RJ6AlmAvUn7cfzMVE+PFZBOwwomB28Lo9Qwlxb
         vfDLwFURJdM5mXf75rAKyXr5pAFJYLMpweOpfJ3lOPGYqsylIB3UNw4nOvzd9qBFJ1qy
         YXMg==
X-Gm-Message-State: AOJu0Yzp+12tFHFX8n0tJI+nc4ciIxF2bGdg11Ti0krYgBTgP127xtqb
        eZr3NGkXCgHbpbdqH2cJFBIxLazEbWs=
X-Google-Smtp-Source: AGHT+IGgNS2Vz9a89mB0wnbmpqOo9ipRBHkgWDp+LBnX1+UB/D0eQmGLqC9so7UJgprSn2d6kzcCXv9BIzw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c2:b0:1c1:fbec:bc39 with SMTP id
 u2-20020a17090341c200b001c1fbecbc39mr210522ple.4.1695052361665; Mon, 18 Sep
 2023 08:52:41 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:52:40 -0700
In-Reply-To: <20230918152946.GJ13795@ziepe.ca>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-7-seanjc@google.com>
 <20230918152946.GJ13795@ziepe.ca>
Message-ID: <ZQhySMjmuyW2Czas@google.com>
Subject: Re: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at KVM+VFIO
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 18, 2023, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 05:30:58PM -0700, Sean Christopherson wrote:
> > Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
> > and only if VFIO itself is enabled.  Similar to the recent change to have
> > VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
> > just because the architecture supports VFIO is nonsensical.
> > 
> > This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
> > fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
> > bug is benign as the only driver in all of Linux that actually uses the
> > KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.
> 
> Hmm, I recall that all the S390 drivers need it as well.
> 
> static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
> {
>         struct ap_matrix_mdev *matrix_mdev =
>                 container_of(vdev, struct ap_matrix_mdev, vdev);
> 
>         if (!vdev->kvm)
>                 return -EINVAL;
> 
>         return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);

Ah, I missed that the KVM reference was routed through VFIO in that case.

> I wonder if we should be making the VFIO drivers that need the kvm to
> ask for it? 'select CONFIG_NEED_VFIO_KVM' or something?

I wondered the same thing, if only to make it easier to track which drivers actually
end up interacting directly with KVM.

> Regardless, I fully agree with getting rid of the arch flag.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > --- a/virt/kvm/Makefile.kvm
> > +++ b/virt/kvm/Makefile.kvm
> > @@ -6,7 +6,9 @@
> >  KVM ?= ../../../virt/kvm
> >  
> >  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > -kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> > +ifdef CONFIG_VFIO
> > +kvm-y += $(KVM)/vfio.o
> > +endif
> 
> I wonder if kvm-m magically works in kbuild so you don't need the ifdef?

Yeah, that should work, no idea why I added the ifdef.
