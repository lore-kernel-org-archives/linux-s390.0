From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH v2 03/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_run
Date: Wed, 29 Nov 2017 17:41:03 +0100
Message-ID: <20171129164116.16167-4-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_run().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c       |  3 +++
 arch/powerpc/kvm/powerpc.c |  6 +++++-
 arch/s390/kvm/kvm-s390.c   | 10 ++++++++--
 arch/x86/kvm/x86.c         |  3 +++
 virt/kvm/arm/arm.c         | 15 +++++++++++----
 virt/kvm/kvm_main.c        |  2 --
 6 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index d535edc..b5c28f0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -447,6 +447,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r = -EINTR;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -483,6 +485,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6b6c53c..c06bc95 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1409,6 +1409,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	if (vcpu->mmio_needed) {
 		vcpu->mmio_needed = 0;
 		if (!vcpu->mmio_is_write)
@@ -1423,7 +1425,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			r = kvmppc_emulate_mmio_vsx_loadstore(vcpu, run);
 			if (r == RESUME_HOST) {
 				vcpu->mmio_needed = 1;
-				return r;
+				goto out;
 			}
 		}
 #endif
@@ -1459,6 +1461,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+out:
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 98ad8b9..2b3e874 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3377,9 +3377,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (kvm_run->immediate_exit)
 		return -EINTR;
 
+	vcpu_load(vcpu);
+
 	if (guestdbg_exit_pending(vcpu)) {
 		kvm_s390_prepare_debug_exit(vcpu);
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	if (vcpu->sigset_active)
@@ -3390,7 +3393,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	} else if (is_vcpu_stopped(vcpu)) {
 		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	sync_regs(vcpu, kvm_run);
@@ -3421,6 +3425,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	vcpu->stat.exit_userspace++;
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b8f864..d9deb62 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7252,6 +7252,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int r;
 	sigset_t sigsaved;
 
+	vcpu_load(vcpu);
+
 	fpu__initialize(fpu);
 
 	if (vcpu->sigset_active)
@@ -7301,6 +7303,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a6524ff..1f448b2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -620,18 +620,22 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
+	vcpu_load(vcpu);
+
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	if (run->immediate_exit)
-		return -EINTR;
+	if (run->immediate_exit) {
+		ret = -EINTR;
+		goto out;
+	}
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
@@ -771,6 +775,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+out:
+	vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 480b16c..198f2f9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2531,7 +2531,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 		if (arg)
 			goto out;
-		vcpu_load(vcpu);
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2543,7 +2542,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
-		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
-- 
2.7.4
