From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 10/47] KVM: s390: add 'pgm' member to kvm_vcpu_arch and helper function
Date: Tue, 15 Apr 2014 14:00:13 +0200
Message-ID: <1397563250-3089-11-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add a 'struct kvm_s390_pgm_info pgm' member to kvm_vcpu_arch. This
structure will be used if during instruction emulation in the context
of a vcpu exception data needs to be stored somewhere.

Also add a helper function kvm_s390_inject_prog_cond() which can inject
vcpu's last exception if needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.h         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 90905ca..c290d44 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -286,6 +286,7 @@ struct kvm_vcpu_arch {
 	struct kvm_s390_local_interrupt local_int;
 	struct hrtimer    ckc_timer;
 	struct tasklet_struct tasklet;
+	struct kvm_s390_pgm_info pgm;
 	union  {
 		struct cpuid	cpu_id;
 		u64		stidp_data;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index f3ab9fc..11ed0a5 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -170,6 +170,39 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 			     struct kvm_s390_pgm_info *pgm_info);
 
+/**
+ * kvm_s390_inject_prog_cond - conditionally inject a program check
+ * @vcpu: virtual cpu
+ * @rc: original return/error code
+ *
+ * This function is supposed to be used after regular guest access functions
+ * failed, to conditionally inject a program check to a vcpu. The typical
+ * pattern would look like
+ *
+ * rc = write_guest(vcpu, addr, data, len);
+ * if (rc)
+ *	return kvm_s390_inject_prog_cond(vcpu, rc);
+ *
+ * A negative return code from guest access functions implies an internal error
+ * like e.g. out of memory. In these cases no program check should be injected
+ * to the guest.
+ * A positive value implies that an exception happened while accessing a guest's
+ * memory. In this case all data belonging to the corresponding program check
+ * has been stored in vcpu->arch.pgm and can be injected with
+ * kvm_s390_inject_prog_irq().
+ *
+ * Returns: - the original @rc value if @rc was negative (internal error)
+ *	    - zero if @rc was already zero
+ *	    - zero or error code from injecting if @rc was positive
+ *	      (program check injected to @vcpu)
+ */
+static inline int kvm_s390_inject_prog_cond(struct kvm_vcpu *vcpu, int rc)
+{
+	if (rc <= 0)
+		return rc;
+	return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
+}
+
 /* implemented in interrupt.c */
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
-- 
1.8.4.2
