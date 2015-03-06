From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/20] KVM: s390: fix handling of write errors in the tpi handler
Date: Fri,  6 Mar 2015 14:16:39 +0100
Message-ID: <1425647812-61838-8-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, 3.16+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If the I/O interrupt could not be written to the guest provided
area (e.g. access exception), a program exception was injected into the
guest but "inti" wasn't freed, therefore resulting in a memory leak.

In addition, the I/O interrupt wasn't reinjected. Therefore the dequeued
interrupt is lost.

This patch fixes the problem while cleaning up the function and making the
cc and rc logic easier to handle.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 3.16+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c7fee9d..be7138e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -229,18 +229,19 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	struct kvm_s390_interrupt_info *inti;
 	unsigned long len;
 	u32 tpi_data[3];
-	int cc, rc;
+	int rc;
 	u64 addr;
 
-	rc = 0;
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	cc = 0;
+
 	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->arch.sie_block->gcr[6], 0);
-	if (!inti)
-		goto no_interrupt;
-	cc = 1;
+	if (!inti) {
+		kvm_s390_set_psw_cc(vcpu, 0);
+		return 0;
+	}
+
 	tpi_data[0] = inti->io.subchannel_id << 16 | inti->io.subchannel_nr;
 	tpi_data[1] = inti->io.io_int_parm;
 	tpi_data[2] = inti->io.io_int_word;
@@ -251,30 +252,35 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 		 */
 		len = sizeof(tpi_data) - 4;
 		rc = write_guest(vcpu, addr, &tpi_data, len);
-		if (rc)
-			return kvm_s390_inject_prog_cond(vcpu, rc);
+		if (rc) {
+			rc = kvm_s390_inject_prog_cond(vcpu, rc);
+			goto reinject_interrupt;
+		}
 	} else {
 		/*
 		 * Store the three-word I/O interruption code into
 		 * the appropriate lowcore area.
 		 */
 		len = sizeof(tpi_data);
-		if (write_guest_lc(vcpu, __LC_SUBCHANNEL_ID, &tpi_data, len))
+		if (write_guest_lc(vcpu, __LC_SUBCHANNEL_ID, &tpi_data, len)) {
+			/* failed writes to the low core are not recoverable */
 			rc = -EFAULT;
+			goto reinject_interrupt;
+		}
 	}
+
+	/* irq was successfully handed to the guest */
+	kfree(inti);
+	kvm_s390_set_psw_cc(vcpu, 1);
+	return 0;
+reinject_interrupt:
 	/*
 	 * If we encounter a problem storing the interruption code, the
 	 * instruction is suppressed from the guest's view: reinject the
 	 * interrupt.
 	 */
-	if (!rc)
-		kfree(inti);
-	else
-		kvm_s390_reinject_io_int(vcpu->kvm, inti);
-no_interrupt:
-	/* Set condition code and we're done. */
-	if (!rc)
-		kvm_s390_set_psw_cc(vcpu, cc);
+	kvm_s390_reinject_io_int(vcpu->kvm, inti);
+	/* don't set the cc, a pgm irq was injected or we drop to user space */
 	return rc ? -EFAULT : 0;
 }
 
-- 
2.3.0
