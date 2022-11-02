Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435BC433FE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Nov 2022 23:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKBXYv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKBXYG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Nov 2022 19:24:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE679CE09
        for <linux-s390@vger.kernel.org>; Wed,  2 Nov 2022 16:20:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36fde8f2cdcso456197b3.23
        for <linux-s390@vger.kernel.org>; Wed, 02 Nov 2022 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xdi2HIR5lDsLzEB1UZrukxTClMK6e7wt2nFiWo5gXdY=;
        b=sb/k/6YChcjl+a9VYlAXhWYOgQyjQV32YX7EFiw9qqpx/WWSDY3oo2CdFxdxpN5cQ+
         bsen7KFdwbaDgiY7tE/ARuN34CNUQVNfQj40KonMSYzWyRevQJIJ8ucvWSt+5e0xldbM
         dG1h+yI8VvXovjZl23qRN2G1h0VDtyVIK/a8wCZyDk3med1nNg8la66zBWDcMMULCuHG
         GgMxZJTuhnm9Kg3Kf6izcH6H9MKXIo5IEEs5iURRrxNb+NCxH6KXLxeRheLVzOIs5Da0
         /j3GVJG8PRl/KZMyimVoe+5FEyijlgyVWBHJWpAL02rmgy07fT/EQi1GCc1WFNc58HpZ
         GW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdi2HIR5lDsLzEB1UZrukxTClMK6e7wt2nFiWo5gXdY=;
        b=isOWAQ9f6YwihgpiOhPb7yi0RFyIVh+oaE90zlwp78yFbgv0tw4drywfmbcZTZ+W3z
         2Gu+7gmG1NojPbXijLRTd2yUPYK9WdRU2+kldrWJJfxygOG7Qs+DTydmWWc6xrbLoTNs
         TursFVrlUay7GLl1BGDVWndId8wwjaUAesj4wPSOSQLxMy0B85KIeN5fwDkSExBzuEOg
         JeHA0ve//X4FiRy70xudpTp746iHyxKAsS1pCCB9fANBDalKZf4gWU1IqdF/ARwBAcUx
         VofF8dYHD1qhP65frPUS8hTbPXQwIi+YFiBAQx5FhjYzgWkbR4PRDQg/FeZmNKtY5JZA
         wTKw==
X-Gm-Message-State: ACrzQf0emOFjEFpltB3weGpxdkKs3ITMmkId9dsPnL+xpBtS9o6g0s0K
        Rd+z8eLtlt3AP3/WGvOVX2l1WGS5mt8=
X-Google-Smtp-Source: AMsMyM7e+TGdJRwAqNyPJfnKmxSn80oz3hoXq+YWtTdlfH8WIBioJcR7xPecdYC8HpWoY/uUAUWZTvNWC7g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:443:0:b0:6bc:e3d1:8990 with SMTP id
 s3-20020a5b0443000000b006bce3d18990mr28148778ybp.191.1667431207141; Wed, 02
 Nov 2022 16:20:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:58 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-32-seanjc@google.com>
Subject: [PATCH 31/44] KVM: x86: Use KBUILD_MODNAME to specify vendor module name
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

Use KBUILD_MODNAME to specify the vendor module name instead of manually
writing out the name to make it a bit more obvious that the name isn't
completely arbitrary.  A future patch will also use KBUILD_MODNAME to
define pr_fmt, at which point using KBUILD_MODNAME for kvm_x86_ops.name
further reinforces the intended usage of kvm_x86_ops.name.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 99c1ac2d9c84..13457aa68112 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4737,7 +4737,7 @@ static int svm_vm_init(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops svm_x86_ops __initdata = {
-	.name = "kvm_amd",
+	.name = KBUILD_MODNAME,
 
 	.hardware_unsetup = svm_hardware_unsetup,
 	.hardware_enable = svm_hardware_enable,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 25e28d368274..a563c9756e36 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8074,7 +8074,7 @@ static void vmx_vm_destroy(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.name = "kvm_intel",
+	.name = KBUILD_MODNAME,
 
 	.hardware_unsetup = vmx_hardware_unsetup,
 
-- 
2.38.1.431.g37b22c650d-goog

