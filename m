Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C2CD37AF
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjIPAdU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbjIPAcs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:32:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272630C0
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c240e637aso11256777b3.3
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824313; x=1695429113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7bBxxWVXjTf9iTQwKV6iNN5dTCLVhIVjlh92R6IC4=;
        b=zOLzyvf9Xh9Oyip0BwJ83PeBHCS/GkeIkYW7amwKWpbVRBulRSs+M2ewlVHSYEk8Y1
         fZi/rLeXSktTS8MyrHSb7oSjjoji3mP8DLBFys3HTkweHkzNEjUj/MYjO6bhCObLf6WI
         C4epHaQCDHjamTfPTIFUVJo9uV7rJeD8D3Ev5VTy1GaRUXNCbP9vUakULPRry3f2UmYw
         gyw5WDenpiA4SZAJNYLZ4b5c/W6CHbsXfPj0GoeSA/wcWsneuM9gT86MPn9Q/cBxCCsq
         e6qXt7/vwX6T3FspiyVRjD7e2hTXM1HQsLlpY6p8Z4vdzbokFmWoStzOeNzcENym+vhB
         +SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824313; x=1695429113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pl7bBxxWVXjTf9iTQwKV6iNN5dTCLVhIVjlh92R6IC4=;
        b=HC4neKs/yk63zc+qRsGJTEX5soXVpcrAQwqCt8Cvvb/z0DA7lm5TMhuyPkSFAwIe1b
         bkn3W00NeEnCfH3jd1hDr8GFGcXyfx4wlk9+GAXERc9HcvlLjHbraxlrG2zo9XkXz862
         iOFMmAHOlKGfochscXyoZnBbP0aPua+iciUYB02mSe9Q9ZcYsAkgZjntBpjGQ0JqBu2m
         QgZ+R7C/ttf3Awtt4jYeJBLis8UfYDfgSPKsbn1TY+dZJxcooXcPMHHQSN4rBSWNduJI
         ozJhywYjnuxkQgycTmoS8wYRw+bM3hry7Q7DOllLzKRryxfSIdNrPWRkdA5ImS5olrRM
         JDnw==
X-Gm-Message-State: AOJu0YyxFCb67PRfsI6oBqwAn63NQkWXpLOVkt3XLd65ELZpkawzWPKl
        OB+BNVTAg/6N9YvLidRDnYhmmFVlVVg=
X-Google-Smtp-Source: AGHT+IHIEoJ5Qp0cT7058FSDnFlcgu0NfKZ+k2cnwo0UQE0i+ifeNt8ssvIZEJlieWuqLdMggeWcLX6T9W4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4cf:b0:d7b:92d7:5629 with SMTP id
 v15-20020a05690204cf00b00d7b92d75629mr82335ybs.8.1694824312956; Fri, 15 Sep
 2023 17:31:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:08 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-17-seanjc@google.com>
Subject: [PATCH 16/26] KVM: MIPS: Stop adding virt/kvm to the arch include path
From:   Sean Christopherson <seanjc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Don't add virt/kvm to KVM MIPS' include path, the headers in virt/kvm are
intended to be used only by other code in virt/kvm, i.e. are "private" to
the core KVM code.  It's not clear that MIPS *ever* included a header from
virt/kvm, i.e. odds are good the "-Ivirt/kvm" was copied from a different
architecture's Makefile when MIPS support was first added.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 805aeea2166e..96a7cd21b140 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -4,7 +4,7 @@
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-ccflags-y += -Ivirt/kvm -Iarch/mips/kvm
+ccflags-y += -Iarch/mips/kvm
 
 kvm-$(CONFIG_CPU_HAS_MSA) += msa.o
 
-- 
2.42.0.459.ge4e396fd5e-goog

