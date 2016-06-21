From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 47/51] KVM: s390: don't use CPUSTAT_WAIT to detect if a VCPU is idle
Date: Tue, 21 Jun 2016 15:13:25 +0200
Message-ID: <1466514809-146638-48-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

As we want to make use of CPUSTAT_WAIT also when a VCPU is not idle but
to force interception of external calls, let's check in the bitmap instead.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h |  2 +-
 arch/s390/kvm/sigp.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index ffbbdd28..031f451 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -56,7 +56,7 @@ static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 
 static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
 {
-	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_WAIT;
+	return test_bit(vcpu->vcpu_id, vcpu->arch.local_int.float_int->idle_mask);
 }
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 28ea0ca..1a252f5 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -77,18 +77,18 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
 	const u64 psw_int_mask = PSW_MASK_IO | PSW_MASK_EXT;
 	u16 p_asn, s_asn;
 	psw_t *psw;
-	u32 flags;
+	bool idle;
 
-	flags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
+	idle = is_vcpu_idle(vcpu);
 	psw = &dst_vcpu->arch.sie_block->gpsw;
 	p_asn = dst_vcpu->arch.sie_block->gcr[4] & 0xffff;  /* Primary ASN */
 	s_asn = dst_vcpu->arch.sie_block->gcr[3] & 0xffff;  /* Secondary ASN */
 
 	/* Inject the emergency signal? */
-	if (!(flags & CPUSTAT_STOPPED)
+	if (!is_vcpu_stopped(vcpu)
 	    || (psw->mask & psw_int_mask) != psw_int_mask
-	    || ((flags & CPUSTAT_WAIT) && psw->addr != 0)
-	    || (!(flags & CPUSTAT_WAIT) && (asn == p_asn || asn == s_asn))) {
+	    || (idle && psw->addr != 0)
+	    || (!idle && (asn == p_asn || asn == s_asn))) {
 		return __inject_sigp_emergency(vcpu, dst_vcpu);
 	} else {
 		*reg &= 0xffffffff00000000UL;
-- 
2.5.5
