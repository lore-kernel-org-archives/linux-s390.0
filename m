From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 38/52] KVM: s390: provide logging for diagnose 0x500
Date: Tue, 14 Jun 2016 20:57:15 +0200
Message-ID: <1465930649-181383-39-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We might need to debug some virtio things, so better have diagnose 500
logged.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 1ea4095..ce865bd 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -212,6 +212,11 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
 		return -EOPNOTSUPP;
 
+	VCPU_EVENT(vcpu, 4, "diag 0x500 schid 0x%8.8x queue 0x%x cookie 0x%llx",
+			    (u32) vcpu->run->s.regs.gprs[2],
+			    (u32) vcpu->run->s.regs.gprs[3],
+			    vcpu->run->s.regs.gprs[4]);
+
 	/*
 	 * The layout is as follows:
 	 * - gpr 2 contains the subchannel id (passed as addr)
-- 
2.5.5
