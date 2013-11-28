From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 8/9] KVM: s390: Add SIGP store-status-at-address order
Date: Thu, 28 Nov 2013 15:06:57 +0100
Message-ID: <1385647618-15541-9-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The STORE STATUS AT ADDRESS order of SIGP was still missing.
Now it is supported, using the common kvm_s390_store_status()
function.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c  |   35 +++++++++++++++++++++++++++++++++++
 arch/s390/kvm/trace.h |    1 +
 2 files changed, 36 insertions(+)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 6805601..c137ed3 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -275,6 +275,37 @@ out_fi:
 	return rc;
 }
 
+static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu, u16 cpu_id,
+					u32 addr, u64 *reg)
+{
+	struct kvm_vcpu *dst_vcpu = NULL;
+	int flags;
+	int rc;
+
+	if (cpu_id < KVM_MAX_VCPUS)
+		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_id);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+
+	spin_lock_bh(&dst_vcpu->arch.local_int.lock);
+	flags = atomic_read(dst_vcpu->arch.local_int.cpuflags);
+	spin_unlock_bh(&dst_vcpu->arch.local_int.lock);
+	if (!(flags & CPUSTAT_STOPPED)) {
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_INCORRECT_STATE;
+		return SIGP_CC_STATUS_STORED;
+	}
+
+	addr &= 0x7ffffe00;
+	rc = kvm_s390_store_status_unloaded(dst_vcpu, addr);
+	if (rc == -EFAULT) {
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_INVALID_PARAMETER;
+		rc = SIGP_CC_STATUS_STORED;
+	}
+	return rc;
+}
+
 static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 				u64 *reg)
 {
@@ -379,6 +410,10 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		rc = __sigp_stop(vcpu, cpu_addr, ACTION_STORE_ON_STOP |
 						 ACTION_STOP_ON_STOP);
 		break;
+	case SIGP_STORE_STATUS_AT_ADDRESS:
+		rc = __sigp_store_status_at_addr(vcpu, cpu_addr, parameter,
+						 &vcpu->run->s.regs.gprs[r1]);
+		break;
 	case SIGP_SET_ARCHITECTURE:
 		vcpu->stat.instruction_sigp_arch++;
 		rc = __sigp_set_arch(vcpu, parameter);
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 0c991c6..3db76b2 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -175,6 +175,7 @@ TRACE_EVENT(kvm_s390_intercept_validity,
 	{SIGP_STOP_AND_STORE_STATUS, "stop and store status"},	\
 	{SIGP_SET_ARCHITECTURE, "set architecture"},		\
 	{SIGP_SET_PREFIX, "set prefix"},			\
+	{SIGP_STORE_STATUS_AT_ADDRESS, "store status at addr"},	\
 	{SIGP_SENSE_RUNNING, "sense running"},			\
 	{SIGP_RESTART, "restart"}
 
-- 
1.7.9.5
