Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F6CD37BA
	for <linux-s390@archiver.kernel.org>; Sat, 16 Sep 2023 00:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjIPAcT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbjIPAcJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Sep 2023 20:32:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FBF19AE
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925fb6087bso33959557b3.2
        for <linux-s390@vger.kernel.org>; Fri, 15 Sep 2023 17:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824283; x=1695429083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CcWcgzjI/Sjr3SKdjnMS4CWAtaq/GpOs1NzqJV8HV48=;
        b=OuiUusccrI1dBz823+RYFHRz4umrPXI3ePQ4joT6b9h1bX+K5wr0pKY7/NAepdzJ+8
         N0LPT7ScUngYtOsaCgIuR7i0NDFbd/iuyX/GrqTub/2H4g8mBRJ3BiCuT/2TOAwOI+cU
         31c1gRAfBEXY5+SsEVVK2ewPce5CCjAGwumjaXeiPEVU4dwXIS052fKYD6sdA5hNbwNK
         qbKbpVfZxrbUEcdWAfvmCIASXx1xeaTzzZDXfGsA4bSki6ozzrhs6AIP0SLDD8UbOeSl
         uVwl7/q4+nHxHIghDOEdOOXBUrmqaOd95gA7v28rO2+NtD7uAdx8RfT83WmbxuPgeTO9
         DIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824283; x=1695429083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcWcgzjI/Sjr3SKdjnMS4CWAtaq/GpOs1NzqJV8HV48=;
        b=YuPjmL2u5zg9xbS0BIIBep9xSuqPDDUHCsPCNhXCZMwjftCRWaKsY5LfjGCfYXUl+Q
         5xuUiUq4xL9m6iDpQw7KH4/oYvGKpTOxDi9kHb9sBeEdOUq/fgmZu5nxA1aX5LT5T4j/
         udPEj2V6tFWa7iP8Wq+lxoQIWXGT0HqtNGjlNFY2vF8q+04tRkt769fhYddQ4afYgwn1
         +fpL75/ekM2PgEVmycsSAvpt6AmXxJqbr5LyY9TEUKH0w2h6nPM39wViRZMRT8FZZSww
         569anNxTir4tb2y64ukU6GicAbDvuyzZxvWgHI8shKa7YezcgWStZd4fkiYFbRHArnl9
         h+Gg==
X-Gm-Message-State: AOJu0Yw3RTmO4X7AwJeIBR8uIAGHvuDBaHimuwTnLouoi5MvEf0o9m9J
        aB+D9M7OZx+OMYgAB98RMTJ2Nt6r4hk=
X-Google-Smtp-Source: AGHT+IEjplB8N3p+oR/7zKlMcxL9iCUBmO4vshw551ibG3RHlQehJcUKg5dHZyrgSIjo7xUVmV5xBYFOkj8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b612:0:b0:565:9bee:22e0 with SMTP id
 u18-20020a81b612000000b005659bee22e0mr85362ywh.0.1694824282871; Fri, 15 Sep
 2023 17:31:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:30:53 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-2-seanjc@google.com>
Subject: [PATCH 01/26] vfio: Wrap KVM helpers with CONFIG_KVM instead of CONFIG_HAVE_KVM
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

Wrap the helpers for getting references to KVM instances with a check on
CONFIG_KVM being enabled, not on CONFIG_HAVE_KVM being defined.  PPC does
NOT select HAVE_KVM, despite obviously supporting KVM, and guarding code
to get references to KVM based on whether or not the architecture supports
KVM is nonsensical.

Drop the guard around linux/kvm_host.h entirely, conditionally including a
generic headers is completely unnecessary.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/vfio/vfio.h      | 2 +-
 drivers/vfio/vfio_main.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 307e3f29b527..c26d1ad68105 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -434,7 +434,7 @@ static inline void vfio_virqfd_exit(void)
 }
 #endif
 
-#ifdef CONFIG_HAVE_KVM
+#if IS_ENABLED(CONFIG_KVM)
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 40732e8ed4c6..80e39f7a6d8f 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -16,9 +16,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
-#ifdef CONFIG_HAVE_KVM
 #include <linux/kvm_host.h>
-#endif
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -383,7 +381,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 }
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
-#ifdef CONFIG_HAVE_KVM
+#if IS_ENABLED(CONFIG_KVM)
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 {
 	void (*pfn)(struct kvm *kvm);
-- 
2.42.0.459.ge4e396fd5e-goog

