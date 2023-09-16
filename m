Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807DCCD37BE
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjIPAcz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjIPAcj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:32:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075B30C6
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d818fb959f4so2979715276.1
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824315; x=1695429115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PzobvpQc4vWfR42iy4RjYEgAb/kHLuzC5INLwcS+RqY=;
        b=YxihMmMOwAJDc/bohM/izVntYK4R7FAAA53ohMstPpD0qgnNu65NkYu2rM60V2XRl7
         SoSsFkx83Rdd2lw/hJ1tVX2Qd8mELlpNHREfNHu3j46tDd05Z9mzKhU6rlK0NCLUNPJk
         u0wHDKMdqWe6q8hJLnKIYgmtI0x/evwMYUsYMj1jZsB04PYfON5z6J7440wSOhZcr6U/
         I4Yw9GPYIayu+Y4uIafMn0jxhTMGSOmzI7AshUDpcZj9QzmP3AfH7ybM9cR4WGZ7qH9c
         6+XbKkh1B/ns7LBaT8q4OYPlxGDqOAoZVtWPDp1Dfc8mwumFYq9Sg/WjhDSTNnkdA9do
         vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824315; x=1695429115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzobvpQc4vWfR42iy4RjYEgAb/kHLuzC5INLwcS+RqY=;
        b=bXJgf1iJa1m//j+WGaK0myUrIbgAIFVUtLtJQ4lLoDxlczTtm8WC76OibSVDy87pqN
         YsFOh0mHFK7ZYVpPwgch5+JQqZWsmwb4rI0Lm4qGoD7kkUzvQbcQGxyaW89RUQdby+Cd
         MseMVzfalaZp7Nm14+ncjHAx0cDqNYdz59rk+09DGqb9+Ly/gbzQFieKfVH5CzmDIZnH
         WgVteuoJF/dKaVf01lEXrXzq4JoJ8vXjz81sKRw017hWMYxl52OpsVeN9I6+O6wCjQG/
         uoHpv1Ut41LLR2AeuP9wG2AAYr2+R0FNjlLZDxsOKuwo/pT3rCCgaWyflEr+054REjTP
         GGcg==
X-Gm-Message-State: AOJu0YxemZ0cAcALNgd+jAfg/1v3+j/inuj1hz4tRSh7rQUEqv0Zrl91
        uEA+QsA3Lx9mA0mBYvW3wsrpAzv0F88=
X-Google-Smtp-Source: AGHT+IEHyBaVn0yDFSDy5XyxKJ2PGYyocUtrZpuSTqYnDVflp7SqStNr9ZpB4/OYXqxtlzASuEez5Ye4vGU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2e06:0:b0:d77:fb4e:d85e with SMTP id
 u6-20020a252e06000000b00d77fb4ed85emr78448ybu.6.1694824314795; Fri, 15 Sep
 2023 17:31:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:09 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-18-seanjc@google.com>
Subject: [PATCH 17/26] KVM: PPC: Stop adding virt/kvm to the arch include path
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

Don't add virt/kvm to KVM PPC's include path, the headers in virt/kvm are
intended to be used only by other code in virt/kvm, i.e. are "private" to
the core KVM code.  It's not clear that PPC *ever* included a header from
virt/kvm, i.e. odds are good the "-Ivirt/kvm" was copied from a different
architecture's Makefile when PPC support was first added.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 5319d889b184..08a0e53d58c7 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
-ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
+ccflags-y := -Iarch/powerpc/kvm
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-- 
2.42.0.459.ge4e396fd5e-goog

