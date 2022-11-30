Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA9C4321E
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiK3XMw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiK3XLv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:11:51 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABF9AE18
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s15-20020a170902ea0f00b0018970bb67bfso15430683plg.3
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eiSwfPmu4ewAiGcYbvYY+86df6I0KPgxP3gGecAMxPE=;
        b=iL8L003XqB+GKgCwHArr5kcxs4MyewOQ/xo1XysK8lk71q/4iO5w3SKvia9KqD7amd
         nXu1/r0fblzdTNOJpq/EYl9gFk0lysyFVV/7oFccNNQgU1JhwDr1/0HsYHMNLSclslmA
         UAtezhSD+JCAni39XkYX4QGkvZksvWY0lR4tjm/jCfiuQLeieGvg5A3LN33ihkcJ66/D
         QbO+O4mX6xEZLgdpufHO4gE+50I1GNIH2gNitP+ZjnsiKLl2r5s0LRLVS15/Koi+mQZn
         TJODgWK9oIR1COz+tFiDAPrhXmMt5j7wHvbTN67IWmBvfAG9+GHxtj6LR7jSg7tvIMuj
         4E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiSwfPmu4ewAiGcYbvYY+86df6I0KPgxP3gGecAMxPE=;
        b=kaV1Jf1su78/i6sB4kWEdq16IhYqtCLrBf0TPrl676vC/nNnP5tOwKketVb0+mq13v
         gI1jd8wgVz91QlfcfZMOWEUzApW2UjvAoWGMA4X2LwwKkGmMZTMQDn7+COe1yEW56t4h
         dyGgPKDk7/joL1eX2ikNPiTIHw1rple2rtOHlEkDu2lVv06X9eeuQqR/C9K1MZJqVgcB
         RLNAFk+Bh+sGgBa2xmcmmhJ84j2qk1T+sF59SDPvFXb3zltP6QhGj4HNaNJUdxCkvqDG
         8ZxL8ohto77eWPOTfHUXa1vH6LqH4/Cy2DkkwljkijTZIMlcc/UNOzOuIDlmrHv4S7WG
         5o6g==
X-Gm-Message-State: ANoB5pnJkm6ON/WT2icPp/AZNLhUjtRCnqtQZOHU6z3u1WTvjI3t10t1
        p9W+o8fLeMZVza01Aei83Xk9uL6qQwY=
X-Google-Smtp-Source: AA0mqf6KEmE4iPJ9U98BX162/oz5Lzb4cw+ziaGyrlJEvv/WGc/WSrrcrRcdtUijxIw8BMhf6X3VggubLl4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ce05:b0:219:23ea:b314 with SMTP id
 f5-20020a17090ace0500b0021923eab314mr23130247pju.230.1669849806254; Wed, 30
 Nov 2022 15:10:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:01 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-18-seanjc@google.com>
Subject: [PATCH v2 17/50] KVM: arm64: Free hypervisor allocations if vector
 slot init fails
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

Teardown hypervisor mode if vector slot setup fails in order to avoid
leaking any allocations done by init_hyp_mode().

Fixes: b881cdce77b4 ("KVM: arm64: Allocate hyp vectors statically")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 07f5cef5c33b..fa986ebb4793 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2237,18 +2237,18 @@ int kvm_arch_init(void *opaque)
 	err = kvm_init_vector_slots();
 	if (err) {
 		kvm_err("Cannot initialise vector slots\n");
-		goto out_err;
-	}
-
-	err = init_subsystems();
-	if (err)
 		goto out_hyp;
+	}
+
+	err = init_subsystems();
+	if (err)
+		goto out_subs;
 
 	if (!in_hyp_mode) {
 		err = finalize_hyp_mode();
 		if (err) {
 			kvm_err("Failed to finalize Hyp protection\n");
-			goto out_hyp;
+			goto out_subs;
 		}
 	}
 
@@ -2262,8 +2262,9 @@ int kvm_arch_init(void *opaque)
 
 	return 0;
 
-out_hyp:
+out_subs:
 	hyp_cpu_pm_exit();
+out_hyp:
 	if (!in_hyp_mode)
 		teardown_hyp_mode();
 out_err:
-- 
2.38.1.584.g0f3c55d4c2-goog

