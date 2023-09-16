Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7BDCD37BB
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjIPAcw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjIPAcZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:32:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859B1B8
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818fb959f4so2979491276.1
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824296; x=1695429096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2bGNmVCdNvvogzEXgW0zNdAXreJziaadtBBldNfFmhI=;
        b=4WEhzq8YYbH5MYS8LF3fNZDW9/doxPBMM5mnRkHh7rJfKucqCpmHfMn8Dk8I5T1Vjw
         r7GKVcMcJezlwbwZdQwe5awi4/JsVEXewSxl/8kp7Zq7Jsnufc0JDsztP0h7mR5pI0hk
         90GGOrwszrDkx1ckPXbKoPWJITxFpbbVdVMfjuB1P12117rdZoMXWD/T6fi2bLBNYM37
         qNnR1Xa0L12cfVJN4IQcUJIBgcxgx3WqXFeJlD79YjBEClF6YfD2xbgF61lTjSnKppKl
         wuTsp8sAceoHv77LPkGb4unAjBl8gAta2F+LLf2CZKmCUljmlURPF6ZLjRkpYyfMkyjv
         k+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824296; x=1695429096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bGNmVCdNvvogzEXgW0zNdAXreJziaadtBBldNfFmhI=;
        b=htkq3IyzTOq/nWBTr05bUjArfXOkAyAbFkZ7QJzESim3ZVZF7xaZAwgqRyUD9hL+KJ
         ImFngMvy9ZlHUWgH26amphKmbpWdk360/8sN8qFpj4utv/6BMX297X0kvn0SugxVlq3j
         DWzkaNxWJ+LjoEHIaHPEUhhn2iwd9GNZQKOC30IbfskPrfvIwIE6TQO/tj2/pkxdnKs5
         95G04IRHvrpcEphkhMHqP54dsj14PCAu3ihpRs4lSj+BL0o0IsTlbX/hz6jgOHSZfs/7
         nXWb7B3LoLV8iuJFysZu66WmWGov1+Qbjuf33XvMzk5oyb6nvU4dACYTtOwmCV54CLx2
         rWPg==
X-Gm-Message-State: AOJu0YwfCy4n7auncPajRSh53Oma0E6HS7Toas2x7V+CRgBOTbMhf7xD
        lmm9GCR3+khhwAIndrDP9GS7cPSgTPU=
X-Google-Smtp-Source: AGHT+IEii4782d+JzWBACVp4gsfxYcFW3PZ67SLHnb796XbOz2rrTeQdE9Xb83Qlv7LO8McNRbBpWAwnK1E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2982:0:b0:d05:98ef:c16b with SMTP id
 p124-20020a252982000000b00d0598efc16bmr77753ybp.5.1694824296181; Fri, 15 Sep
 2023 17:31:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:00 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-9-seanjc@google.com>
Subject: [PATCH 08/26] KVM: x86: Stop selecting and depending on HAVE_KVM
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

Now that nothing in x86 or architecture agnostic code consumes HAVE_KVM,
stop selecting it in x86.  This is one of several steps towards deleting
HAVE_KVM from the common KVM Kconfig.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/Kconfig     | 1 -
 arch/x86/kvm/Kconfig | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..32eb288a4e3a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -240,7 +240,6 @@ config X86
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
 	select HAVE_RETHOOK
-	select HAVE_KVM
 	select HAVE_LIVEPATCH			if X86_64
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 0f01e5600b5f..8c5fb7f57b4c 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -7,7 +7,6 @@ source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
-	depends on HAVE_KVM || X86
 	default y
 	help
 	  Say Y here to get to see options for using your Linux host to run other
@@ -20,7 +19,6 @@ if VIRTUALIZATION
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
-	depends on HAVE_KVM
 	depends on HIGH_RES_TIMERS
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
-- 
2.42.0.459.ge4e396fd5e-goog

