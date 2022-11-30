Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B54C352A1
	for <linux-s390@archiver.kernel.org>; Wed, 30 Nov 2022 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK3XNR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiK3XMd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Nov 2022 18:12:33 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53898018
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id w2-20020a17090a8a0200b002119ea856edso3787800pjn.5
        for <linux-s390@vger.kernel.org>; Wed, 30 Nov 2022 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj+BMG24gpugAApyuMjfHhGTokqhj/HfOHcPzx/7Ixc=;
        b=rXveYksPcbHAdLQWx0Se3mgCcQvIusgWV2YBwsk350kO+gwstaEEoshUZTFpuvac++
         pLds7vX8HQyFV+EXcCsNs4Huph1CvEcQOXAAAxG85uCm3rCCbxscdft2ZxjRveL1foHX
         Lrax89MRhf3bE1bAwMOLphkpziYLo/XzKTjZtkj0KrWsaZWT2gVodfm1c5joltsrB5eF
         W0icMxnX0hgljPZjSz6UkymZcq3fcWnGh4feMzJb8fuOAJykHj0A+tcjteTkrK4SYiHc
         +b7l66OJ0teH4JUbB2xCLD5wxFKLZ8CELPJsM7W7cN4l69kYm6xFX8ZvCrFTJGzWVhEq
         HM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uj+BMG24gpugAApyuMjfHhGTokqhj/HfOHcPzx/7Ixc=;
        b=syjUdPPu6/LWhbGheRMLjvTMmDOXpTeOEDp2CgDWvCa400HZUVD8TvpOwj0V+syrPM
         lxlTgDOWb58hUSjfyhZKMr1mg4meSJ7ltOT8iss4UGMVDDLCwtxTVmhV7+bYlOh4LuQO
         Yeazj9LgtAiKHTn/7++IP+ilfJ7xgisNWyhAFsPmwzpd6I5OFgT8DvZN7d8l542nJK38
         WSyM7q4g98y5/Y+tS++nlwmEHi9pJUBslTIrTGje5fUOrS3mhqzMPfkC1IeoPfsP1fdM
         U+HpyKaCNBwmJxWN95G26myVspcuMqvaZfCMfhTL7mYmKRoGahlpfjVkw8iQYLhof+bp
         qLMA==
X-Gm-Message-State: ANoB5pkJqm5i651YVcNTBxWVkKrUufG/9VJtAxphZcFbowum6A7TfnPN
        dLeo1iuMCHvYqLHpDgSwcwY5dsSigVg=
X-Google-Smtp-Source: AA0mqf4xYnJCkXbWk/N31ZRo5enbQfT7p8hAsoCQiyumsmQYs6alw3yUJytbRmVQwuUcUkB1fPIndjJ7nUc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1624:b0:573:993b:ea6d with SMTP id
 e4-20020a056a00162400b00573993bea6dmr46050829pfc.10.1669849814934; Wed, 30
 Nov 2022 15:10:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:06 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-23-seanjc@google.com>
Subject: [PATCH v2 22/50] KVM: MIPS: Setup VZ emulation? directly from kvm_mips_init()
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Invoke kvm_mips_emulation_init() directly from kvm_mips_init() instead
of bouncing through kvm_init()=3D>kvm_arch_init().  Functionally, this is
a glorified nop as invoking kvm_arch_init() is the very first action
performed by kvm_init().

Emptying kvm_arch_init() will allow dropping the hook entirely once all
architecture implementations are nops.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
 arch/mips/kvm/mips.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index f0a6c245d1ff..75681281e2df 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1012,7 +1012,7 @@ long kvm_arch_vm_ioctl(struct file *filp, unsigned in=
t ioctl, unsigned long arg)
=20
 int kvm_arch_init(void *opaque)
 {
-	return kvm_mips_emulation_init();
+	return 0;
 }
=20
 void kvm_arch_exit(void)
@@ -1636,6 +1636,10 @@ static int __init kvm_mips_init(void)
 	if (ret)
 		return ret;
=20
+	ret =3D kvm_mips_emulation_init();
+	if (ret)
+		return ret;
+
 	ret =3D kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
=20
 	if (ret)
--=20
2.38.1.584.g0f3c55d4c2-goog

