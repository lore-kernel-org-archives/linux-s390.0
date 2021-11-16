Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97025C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8104D63231
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhKPSq5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhKPSqz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Nov 2021 13:46:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05BC061746
        for <linux-s390@vger.kernel.org>; Tue, 16 Nov 2021 10:43:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y8so12748738plg.1
        for <linux-s390@vger.kernel.org>; Tue, 16 Nov 2021 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GcGOJgSWz7oEIbfl5QNUvPpuAyaNetXEQN0oWs9ap2w=;
        b=NfWEHKgpp9hvAVj4IrdvyWcutj+oRm5oA4DhrzE5j01yRw6SEr+OqI8zdgqPehlHuc
         lvLy/whsET41Ju6UmVvOInCo7Ww6t6yLH5qUrncwy6VAmxauCnt99O3r1yirLCVccCfN
         0Gay6uTBhe2zfp68q3FXHdSVfO1Z/lBlR6uw3b9mZM9XbPEBfKBoCa/a9sEvB1P9oZqk
         5YTcHvsnOOA5rsa3JP9041e/6BOvKA/Xr3X/sbaLIuC63lGrovFZ7b1eudI5InxTZkUr
         CdOzfVuUVUCDHbMPcWrZAb1YNJexcHENRayQEJiryVfwYQQPdJtpV9LDoK9LoF2MR12X
         8enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GcGOJgSWz7oEIbfl5QNUvPpuAyaNetXEQN0oWs9ap2w=;
        b=jncw9afry7vB7BOhURLoV0woN1/m/vjwYz6Ryoj+kMaBhEm4ESuer9HE47H9Oi42b1
         WYMayAld9swttWUtcqS/OWSamDoCLMqxA1/6wmS+PtNqHSppAwzETvZov4A1BAR99Gne
         RD0vFMATGyZI6N8v13CDZcYi60Zhr7XjZS65fRiomMTtvIxo3ELnn6/lAM9GXLi0+Bxg
         fGyceWJYjEsOgjfUeD71pN9P0s8PjnKe1dMa1XT6iLe7gr01JOo+GJG3n2wb21ki/ooS
         AuJm8NgmY6JGqFPgkUdH5KwfBB54QaFzfZ5E+vK8udGToRzusY6do3dUHTnBZaYc5+/V
         1YXg==
X-Gm-Message-State: AOAM532FNG4CuABLfAx+mkOMPsN8Rmu7RE6QgEUrHavJ+0PvsCVbJUWe
        n6+x+NisPohdzL8LOkRdj8pIlw==
X-Google-Smtp-Source: ABdhPJy95F12FbARJJuG3RP+KItNypekR2/l+xifaD1kKSsYtJFW/+wQ/332xG0BY0Bxhx2ISOUtlQ==
X-Received: by 2002:a17:90b:4b46:: with SMTP id mi6mr1449604pjb.188.1637088237573;
        Tue, 16 Nov 2021 10:43:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r8sm15237754pgp.30.2021.11.16.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:43:56 -0800 (PST)
Date:   Tue, 16 Nov 2021 18:43:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jmattson @ google . com" <jmattson@google.com>,
        "wanpengli @ tencent . com" <wanpengli@tencent.com>,
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
        kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/7] KVM: powerpc: Use Makefile.kvm for common files
Message-ID: <YZP76Un0mip17E1K@google.com>
References: <5047c2591310e503491850ef683f251395247d50.camel@infradead.org>
 <20211116115051.119956-1-dwmw2@infradead.org>
 <20211116115051.119956-6-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211116115051.119956-6-dwmw2@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 16, 2021, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> It's all fairly baroque but in the end, I don't think there's any reason
> for $(KVM)/irqchip.o to have been handled differently, as they all end
> up in $(kvm-y) in the end anyway, regardless of whether they get there
> via $(common-objs-y) and the CPU-specific object lists.
> 
> The generic Makefile.kvm uses HAVE_KVM_IRQCHIP for irqchip.o instead of
> HAVE_KVM_IRQ_ROUTING. That change is fine (and arguably correct) because
> they are both set together for KVM_MPIC, or neither is set.

Nope.

  Symbol: HAVE_KVM_IRQCHIP [=y]
  Type  : bool
  Defined at virt/kvm/Kconfig:7
  Selected by [m]:
    - KVM_XICS [=y] && VIRTUALIZATION [=y] && KVM_BOOK3S_64 [=m] && !KVM_MPIC [=n]
  Selected by [n]:
    - KVM_MPIC [=n] && VIRTUALIZATION [=y] && KVM [=y] && E500 [=n]

leads to this and a whole pile of other errors

arch/powerpc/kvm/../../../virt/kvm/irqchip.c: In function ‘kvm_irq_map_gsi’:
arch/powerpc/kvm/../../../virt/kvm/irqchip.c:31:35: error: invalid use of undefined type ‘struct kvm_irq_routing_table’
   31 |         if (irq_rt && gsi < irq_rt->nr_rt_entries) {
      |                                   ^~


Side topic, please don't post a new version/series in-reply-to a different series.
b4 also gets confused in this case, e.g. it tried to grab the original patch.  b4
has also made me really lazy, heaven forbid I actually had to manually grab these
from mutt :-)
