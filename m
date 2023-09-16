Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7ACD37B1
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjIPAe5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjIPAeY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:34:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D53173C
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:32:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59285f1e267so71333847b3.0
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824325; x=1695429125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xxhu5mShS80K2/3vPmWMk/nseLaV4p5fitYU0fke5+k=;
        b=I0twIbH0JWDnve96saXAKVyhd09K4ELG8M0LyS636cxkXlCdGwfc8cMH/2napwy6L6
         kwxP8eYF66+YeOwkMvIAfRGMqc+Idqqzof6dupRSi7LsejOODbUYP43KPeQzeITwE5pu
         Rq442nYS09zx/bwnt9NFvBkQ7bJ8b8rZhUNM99sGT3cE1Vmu0I6QA0ngcoF/0AFqt/3g
         abOA5+iG7SRrFJKspHTWyb0K7zSMVzmVb0QhxUtsK7vEsDBABuS9q7jnsYrmVP9PTar4
         aa3kYKL8Rxgh2n+rtckXA9FfTVW3KksoNht9J/SSkTQlGfbIUf4Quy9U9kfsgwP4Zc14
         fgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824325; x=1695429125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxhu5mShS80K2/3vPmWMk/nseLaV4p5fitYU0fke5+k=;
        b=fltV2Lx4sc7R52THjVp+ng72muWiVrW4x6Q8AOjOE8vVznbZMUp40NN7PMnCmiDxhg
         g7pc378oOnVtgfC6c2LXDRyNLp3a39d6/eP06G1CXlXJTMPhomdbTUzkIS30c0DrT6Pu
         Mz86hDyElxxoIvfofxv/w6zzqe7iS8dbd5X6/bnzqCj6CxbPuj2pe2MnB0a11c9dW0WC
         t8MGm3kr1GyosvLaba0hKSfzPTJRJjo5GfqyliF4xXgVfDKq6/Ip/8v1YqUChnEw1r/y
         qyRQTcKklQMDTOGyA/dhJQ2dzPSCj7GuBYNBwrcdw6CSd3pQcu10KoHGfgQbj3A0DkEE
         fSDw==
X-Gm-Message-State: AOJu0YxpAqKppalv/HEY8Bo6KkRTiLyk8Vc6T0rDTgfG+HeKpaorP/aE
        w1HzWfriKX1MY+Ep8ycGGkbo0XtBR5U=
X-Google-Smtp-Source: AGHT+IFivAqBzULaKYZ+rdlM5WV3p7FxezM4z6b9SH0+UFxp1erLN5VtiAhqE4c7vi4i2igDi9x6k3utDco=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2f05:b0:589:a533:405b with SMTP id
 ev5-20020a05690c2f0500b00589a533405bmr205315ywb.3.1694824325035; Fri, 15 Sep
 2023 17:32:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:14 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-23-seanjc@google.com>
Subject: [PATCH 22/26] entry/kvm: KVM: Move KVM details related to
 signal/-EINTR into KVM proper
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

Move KVM's morphing of pending signals into exits to userspace into KVM
proper, and drop the @vcpu param from xfer_to_guest_mode_handle_work().
How KVM responds to -EINTR is a detail that really belongs in KVM itself,
and removing the non-KVM call to kvm_handle_signal_exit() will allow
hiding said API and the definition of "struct kvm_vcpu" from the kernel.

Alternatively, entry/kvm.c could be treated as part of KVM, i.e. be given
access to KVM internals, but that's not obviously better than having KVM
react to -EINTR (though it's not obviously worse either).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c      |  3 +--
 arch/riscv/kvm/vcpu.c     |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  1 -
 arch/x86/kvm/x86.c        |  3 +--
 include/linux/entry-kvm.h |  3 +--
 include/linux/kvm_host.h  | 13 ++++++++++++-
 kernel/entry/kvm.c        | 11 ++++-------
 7 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6480628197b4..641df091e46b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -6,7 +6,6 @@
 
 #include <linux/bug.h>
 #include <linux/cpu_pm.h>
-#include <linux/entry-kvm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -929,7 +928,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		/*
 		 * Check conditions before entering the guest
 		 */
-		ret = xfer_to_guest_mode_handle_work(vcpu);
+		ret = kvm_xfer_to_guest_mode_handle_work(vcpu);
 		if (!ret)
 			ret = 1;
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 82229db1ce73..c313f4e90e70 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -667,7 +667,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	while (ret > 0) {
 		/* Check conditions before entering the guest */
-		ret = xfer_to_guest_mode_handle_work(vcpu);
+		ret = kvm_xfer_to_guest_mode_handle_work(vcpu);
 		if (ret)
 			continue;
 		ret = 1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index faf0071566ef..43b87ad5fde8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
-#include <linux/entry-kvm.h>
 
 #include <asm/apic.h>
 #include <asm/asm.h>
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c9c81e82e65..aab095f89d9e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -59,7 +59,6 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
-#include <linux/entry-kvm.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
 
@@ -10987,7 +10986,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 
 		if (__xfer_to_guest_mode_work_pending()) {
 			kvm_vcpu_srcu_read_unlock(vcpu);
-			r = xfer_to_guest_mode_handle_work(vcpu);
+			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
 			kvm_vcpu_srcu_read_lock(vcpu);
 			if (r)
 				return r;
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index e7d90d06e566..e235a91d28fc 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -42,11 +42,10 @@ static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work)
 /**
  * xfer_to_guest_mode_handle_work - Check and handle pending work which needs
  *				    to be handled before going to guest mode
- * @vcpu:	Pointer to current's VCPU data
  *
  * Returns: 0 or an error code
  */
-int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
+int xfer_to_guest_mode_handle_work(void);
 
 /**
  * xfer_to_guest_mode_prepare - Perform last minute preparation work that
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fb6c6109fdca..d520d6801070 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2,7 +2,7 @@
 #ifndef __KVM_HOST_H
 #define __KVM_HOST_H
 
-
+#include <linux/entry-kvm.h>
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
@@ -2293,6 +2293,17 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 	vcpu->run->exit_reason = KVM_EXIT_INTR;
 	vcpu->stat.signal_exits++;
 }
+
+static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+{
+	int r = xfer_to_guest_mode_handle_work();
+
+	if (r) {
+		WARN_ON_ONCE(r != -EINTR);
+		kvm_handle_signal_exit(vcpu);
+	}
+	return r;
+}
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
 /*
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index c2fc39824157..872617468b4a 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -1,17 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/entry-kvm.h>
-#include <linux/kvm_host.h>
 
-static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+static int xfer_to_guest_mode_work(unsigned long ti_work)
 {
 	do {
 		int ret;
 
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-			kvm_handle_signal_exit(vcpu);
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			return -EINTR;
-		}
 
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
@@ -28,7 +25,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	return 0;
 }
 
-int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+int xfer_to_guest_mode_handle_work(void)
 {
 	unsigned long ti_work;
 
@@ -44,6 +41,6 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
 		return 0;
 
-	return xfer_to_guest_mode_work(vcpu, ti_work);
+	return xfer_to_guest_mode_work(ti_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
-- 
2.42.0.459.ge4e396fd5e-goog

