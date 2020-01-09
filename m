Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbgAINrY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 08:47:24 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
Date: Thu,  9 Jan 2020 14:47:13 +0100
Message-Id: <20200109134713.14755-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

On s390, we only allow userspace to create an in-kernel irqchip
if it has first enabled the KVM_CAP_S390_IRQCHIP vm capability.
Let's assume that a userspace that enabled that capability has
created an irqchip as well.

Fixes: 84223598778b ("KVM: s390: irq routing for adapter interrupts.")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

A more precise check would be to add a field in kvm_arch that tracks
whether an irqchip has actually been created; not sure if that is
really needed.

Found while trying to hunt down QEMU crashes with kvm-irqchip=3Doff;
this is not sufficient, though. I *think* everything but irqfds
should work without kvm-irqchip as well, but have not found the problem
yet.

---
 arch/s390/kvm/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
index 484608c71dd0..30e13d031379 100644
--- a/arch/s390/kvm/irq.h
+++ b/arch/s390/kvm/irq.h
@@ -13,7 +13,7 @@
=20
 static inline int irqchip_in_kernel(struct kvm *kvm)
 {
-	return 1;
+	return !!kvm->arch.use_irqchip;
 }
=20
 #endif
--=20
2.21.1
