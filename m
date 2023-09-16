Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54682CD37B4
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbjIPAcu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbjIPAcZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:32:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8FF2D5D
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c08a15fcf4so25899575ad.3
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824306; x=1695429106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HQNUEYOJ/ozgdrFnqx+YRCy2I1exOHPHuH58RF8SFNA=;
        b=M0gIO6eCoTEr3GyvSoSXqbffxgpKcvL2iExYuoC1k1A0QMa49lgLHRLuf83fPt2EER
         p0/XkGy+aPVxOCMzm4qhlUVO/7ZRz0RX4ZihqJ7KPu43EhRaqjry7XDN6ggrYCUt1c6b
         tNceeQyuPYGXl4IN20FmDkP3TIvgnbd0ghe2QEmzk2zQrTObxyL31Qo9CebNV3oLQKZb
         kIih2H1Er1Y0nc45248g1TcaTDnKgzorYoWeRLQ5BxFSK6YQE/mY03l0aSYr+g4n556e
         tHJg3zYqqP9MZgotM5PRIhgFbRicKza8GjnFEYqjmqSe8gktBCVv50aAB1P1pWIB4r3Q
         +TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824306; x=1695429106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQNUEYOJ/ozgdrFnqx+YRCy2I1exOHPHuH58RF8SFNA=;
        b=XClRD8WFw39NE2wbP9d0RssP0i6kpxPmhuS7/ihgGrfSBzjid/e+CDlJ0Raodkvyeh
         rk4QIprePqMhKzo1e2xuUwbljTfCvPzX2XyueC0RjeuZt1quIlwWQMCA8qoY0PStxDvL
         Ib29Wocmha1ODOZ1RcB+E0/2VXQHKvtdTSegYi5uK+VO1PFvJ41Rucyu2JC9CY3NOso0
         bOrW7wDGk7Ufyg3vC2hG2uTcTc+NKfUXjs9pDebyZwlUNjV0xzZ77wwo7TkbJqyFC4cj
         mhOJs2koFzgO2DVr+n5RpNCOpeIgbb4ls/VdMzSLuLkZoeNfCme1OfRrvfZf0gUaoqpH
         WDJg==
X-Gm-Message-State: AOJu0YyM9pQnkk5yaI+0MJd7pgTsx6YPwRzK7FXLdM0pIMf6DYx0mE3N
        zMQkRJqoFZwpOhK2cXMmKg1qd6yVn8A=
X-Google-Smtp-Source: AGHT+IHwZjKrwGdEWszMvnFwhRAkOaZ4ZXt/sllxoteViYwmhz1Ar6ouDJgF8x4FFhszG2C3n1vTw2Lw6BE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32ca:b0:1b8:8c7:31e6 with SMTP id
 i10-20020a17090332ca00b001b808c731e6mr93755plr.1.1694824306427; Fri, 15 Sep
 2023 17:31:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:05 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-14-seanjc@google.com>
Subject: [PATCH 13/26] KVM: arm64: Include KVM headers to get forward declarations
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

Include include/uapi/linux/kvm.h and include/linux/kvm_types.h in ARM's
public arm_arch_timer.h and arm_pmu.h headers to get forward declarations
of things like "struct kvm_vcpu" and "struct kvm_device_attr", which are
referenced but never declared (neither file includes *any* KVM headers).

The missing includes don't currently cause problems because of the order
of includes in parent files, but that order is largely arbitrary and is
subject to change, e.g. a future commit will move the ARM specific headers
to arch/arm64/include/asm and reorder parent includes to maintain
alphabetic ordering.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/kvm/arm_arch_timer.h | 2 ++
 include/kvm/arm_pmu.h        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index bb3cb005873e..e22a15c66288 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -7,6 +7,8 @@
 #ifndef __ASM_ARM_KVM_ARCH_TIMER_H
 #define __ASM_ARM_KVM_ARCH_TIMER_H
 
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 31029f4f7be8..e80f1d090579 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -7,6 +7,8 @@
 #ifndef __ASM_ARM_KVM_PMU_H
 #define __ASM_ARM_KVM_PMU_H
 
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmuv3.h>
 
-- 
2.42.0.459.ge4e396fd5e-goog

