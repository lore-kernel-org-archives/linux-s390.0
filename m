From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 51/52] KVM: s390: trace and count all skey intercepts
Date: Tue, 14 Jun 2016 20:57:28 +0200
Message-ID: <201606141857.u5EIs1sb075140@mx0b-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's trace and count all skey handling operations, even if lazy skey
handling was already activated. Also, don't enable lazy skey handling if
anything went wrong while enabling skey handling for the SIE.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c  | 15 +++++++++------
 arch/s390/kvm/trace.h |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index b8327b8..6745c2a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -152,24 +152,27 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 static int __skey_check_enable(struct kvm_vcpu *vcpu)
 {
 	int rc = 0;
+
+	trace_kvm_s390_skey_related_inst(vcpu);
 	if (!(vcpu->arch.sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)))
 		return rc;
 
 	rc = s390_enable_skey();
-	VCPU_EVENT(vcpu, 3, "%s", "enabling storage keys for guest");
-	trace_kvm_s390_skey_related_inst(vcpu);
-	vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
+	if (!rc)
+		vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
 	return rc;
 }
 
 
 static int handle_skey(struct kvm_vcpu *vcpu)
 {
-	int rc = __skey_check_enable(vcpu);
+	int rc;
 
-	if (rc)
-		return rc;
 	vcpu->stat.instruction_storage_key++;
+	rc = __skey_check_enable(vcpu);
+	if (rc)
+		return rc;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 1c4586b..4fc9d4e 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -41,7 +41,7 @@ TRACE_EVENT(kvm_s390_skey_related_inst,
 	    TP_fast_assign(
 		    VCPU_ASSIGN_COMMON
 		    ),
-	    VCPU_TP_PRINTK("%s", "first instruction related to skeys on vcpu")
+	    VCPU_TP_PRINTK("%s", "storage key related instruction")
 	);
 
 TRACE_EVENT(kvm_s390_major_guest_pfault,
-- 
2.5.5
