Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D358C47088
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiK3XKZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiK3XKG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:10:06 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962A975FB
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pq17-20020a17090b3d9100b0020a4c65c3a9so203181pjb.0
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g1stMgF+unVz+1wniuTG4sBb8H6V2BLTtzNNraJ+L2g=;
        b=Qu2Gj2AQMSdn5ynZ5uRxUGFqbeHyl2Ed5IXeJ2cS9b8RyxUmxP+UPpwD4AXe0Ud2wQ
         GLE5fpqUn5yzNfMmkf1QqZp6YlOWxyIHZvzY2PTHyliCph5U92Ri7VRil5QNW2hbhlro
         eqLV3fzPciK364AgPpAWure/pils1YFI032lNHB5vYzqLYNGO/HTaCFu4SnHfGbx0IJL
         YzVxc9OdZl6JuUto8jah8ZZUeY5Nlgmu8NeURLW2FfXGR4hkpIETaC3DDgh3Y+VWw9aT
         wnj+XTBDiyARsefNZ1R+h94oYnfXDMDFEaIxFxgvi52xPOyDG50iBdiNI6MjV0enlZkj
         ltag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1stMgF+unVz+1wniuTG4sBb8H6V2BLTtzNNraJ+L2g=;
        b=pg0DyrEvhNxJ1FYeTHQVyB4KSi19f5re2Cn+9yxjKY2w7rwv4TQ4MaqEBe7fpUcfd7
         KZbr2diAdjqIU/iwhNVylCj3Q9ufIhbqRrQwRLX0PoR6RKF/wS8vxLNeMVJ+eKqDF0z+
         5TRHNUAZiPdjpdzD1riEJvPzMtxmiCIpG77vGJW7ZrOvBASYpKsRaiCNKTGntRdgVPaH
         zuNumTjS39ci9brMKOVKe0HXIknx0Lx7yG+Z6YWtmAQAys2PYDKMA/m4Wa4CsaZ5bZ4D
         MyvQt7UCAntHbH9bdanUZb9qtVJgzzGmvoAp/0Twshp3oY1mYliVWPJIdyG6gtV7+rTs
         oPKQ==
X-Gm-Message-State: ANoB5plb9TbhllxOzeJyOhJGW/NE3WMxkTVIVtFpgaqi6/xgz4mnCo41
        Mk4Di4kQm2U2ytcLms/X2ZI5u5fAWdM=
X-Google-Smtp-Source: AA0mqf66P6cZGe+dew2XFgeia1skilH4V8u9knhT3C8CLrninF2nDNQmOIJQuI+E9fZev+1MNEWaGc+MIJs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9a47:b0:189:acf9:87af with SMTP id
 x7-20020a1709029a4700b00189acf987afmr3514511plv.160.1669849789646; Wed, 30
 Nov 2022 15:09:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:08:51 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-8-seanjc@google.com>
Subject: [PATCH v2 07/50] KVM: x86: Do timer initialization after XCR0 configuration
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>
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
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
index f18f579ebde8..a873618564cd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9326,13 +9326,13 @@ int kvm_arch_init(void *opaque)
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
2.38.1.584.g0f3c55d4c2-goog

