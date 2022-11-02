Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5FCC4167D
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKBXUP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKBXUA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:20:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5F2624
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:19:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e13-20020a17090301cd00b001871e6f8714so216317plh.14
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2jZZfFf52GmkjzF4UkJBFUQx8TRwCaNEoxRzKdccz/c=;
        b=eS+ADSAUDBr+3HDHnDb3Fr9sF+Jb8/UT2oH309j3Rm/86ObG6TRCn9IyhpjUkKBdpE
         kcCNHyv3vwGiHYQRvOqDpsz+Ka9M2XEJCdBD1BDMQE+yHelvK5eIZBtBOFMFVOay6VLL
         HRD1UaccDMN8QRmrJzaFGA2kakGK5P4xJGBM94BuLtDJAAqDK7hBLTZ7oOdfic4lXqK4
         Fr39ZfZInLrcHKiM8fxmsZrdE64FtenP1A0FKcDrTDJZkpQ1QUJo1/Y5EttLt8eZYz9U
         +9QTVq6+Q+Y4pZ8EkuhDPhDFtAlj3OJomhnuiK5WjSAlU9kpBh9BdzMjPScyheuXuiwK
         D0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jZZfFf52GmkjzF4UkJBFUQx8TRwCaNEoxRzKdccz/c=;
        b=0k+o/2GBKHQ87/u4PBGRQYaJt7bJZetbnE0CYQvApZHVLq3QjGXeszmEj0IY2ae3Gv
         o3Y4rkoVEbLVoPVACwlBLXQOfbCTdF+mP+V7xH+xeHh6m41QkFjpNHJiDFujIsnGCpKl
         2F6E7auPg+oE12PhdFkI32NeyguKhNbnQfOhkWgUUauROOEA41wcoGmW3aB9sRxVlDe+
         XocY8wYVDfvooCakAwgHfYJfwAHklhxQ///8Xld5APTEPb05Uc7mZBMRbVKwoEqP4kAx
         ZyK0P7/PMvoKYQW9ZGrynFesO+2TToJ4wgv4e9fIpFcDNrkmjrtHD0VcyPT6diOVZ2cG
         0QGw==
X-Gm-Message-State: ACrzQf3dPbBvpVe3/9GlSRu7GizWpF5qnN5y55A5ObLunyZqOS2ikvkC
        v6dgiBsgROs7xFZvw8J2ylRsxySxjsA=
X-Google-Smtp-Source: AMsMyM6vYYJQBYlQiDcX1wj97hZ9g1pk+rDBzdLxVoyiEkvTNhgYg+UmvFixquw/EG51V/dsQ+i+Sr9IedQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e7c5:b0:213:b7d8:1c4c with SMTP id
 kb5-20020a17090ae7c500b00213b7d81c4cmr25473196pjb.114.1667431166266; Wed, 02
 Nov 2022 16:19:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:34 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-8-seanjc@google.com>
Subject: [PATCH 07/44] KVM: x86: Do timer initialization after XCR0 configuration
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Move kvm_arch_init()'s call to kvm_timer_init() down a few lines below
the XCR0 configuration code.  A future patch will move hardware setup
into kvm_arch_init() and slot in vendor hardware setup before the call
to kvm_timer_init() so that timer initialization (among other stuff)
doesn't need to be unwound if vendor setup fails.  XCR0 setup on the
other hand needs to happen before vendor hardware setup.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd9eb13e2ed7..9a7702b1c563 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9320,13 +9320,13 @@ int kvm_arch_init(void *opaque)
 	if (r)
 		goto out_free_percpu;
 
-	kvm_timer_init();
-
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
 	}
 
+	kvm_timer_init();
+
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
 #ifdef CONFIG_X86_64
-- 
2.38.1.431.g37b22c650d-goog

