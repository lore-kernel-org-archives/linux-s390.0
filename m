Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084450.602026694@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/32] [PATCH] Replace ENOTSUPP usage with EOPNOTSUPP
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=116-stop-using-enotsupp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

ENOTSUPP is not supposed to leak to userspace so lets just use
EOPNOTSUPP everywhere.
Doesn't fix a bug, but makes future reviews easier.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |    4 ++--
 arch/s390/kernel/ipl.c       |    2 +-
 arch/s390/kvm/diag.c         |    4 ++--
 arch/s390/kvm/intercept.c    |   18 +++++++++---------
 arch/s390/kvm/interrupt.c    |    2 +-
 arch/s390/kvm/kvm-s390.c     |    2 +-
 arch/s390/kvm/priv.c         |    2 +-
 arch/s390/kvm/sigp.c         |    4 ++--
 arch/s390/mm/extmem.c        |   12 ++++++------
 9 files changed, 25 insertions(+), 25 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/hypfs_diag.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/hypfs_diag.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/hypfs/hypfs_diag.c	2010-02-24 09:44:26.000000000 +0100
@@ -488,7 +488,7 @@
 
 static int diag224(void *ptr)
 {
-	int rc = -ENOTSUPP;
+	int rc = -EOPNOTSUPP;
 
 	asm volatile(
 		"	diag	%1,%2,0x224\n"
@@ -507,7 +507,7 @@
 		return -ENOMEM;
 	if (diag224(diag224_cpu_names)) {
 		kfree(diag224_cpu_names);
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
 	return 0;
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/ipl.c	2010-02-24 09:44:26.000000000 +0100
@@ -1592,7 +1592,7 @@
 static int vmcmd_init(void)
 {
 	if (!MACHINE_IS_VM)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	vmcmd_kset = kset_create_and_add("vmcmd", NULL, firmware_kobj);
 	if (!vmcmd_kset)
 		return -ENOMEM;
Index: quilt-2.6/arch/s390/kvm/diag.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/diag.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/diag.c	2010-02-24 09:44:26.000000000 +0100
@@ -39,7 +39,7 @@
 		vcpu->run->s390_reset_flags = 0;
 		break;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
@@ -62,6 +62,6 @@
 	case 0x308:
 		return __diag_ipl_functions(vcpu);
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
Index: quilt-2.6/arch/s390/kvm/intercept.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/intercept.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/intercept.c	2010-02-24 09:44:26.000000000 +0100
@@ -32,7 +32,7 @@
 
 	vcpu->stat.instruction_lctlg++;
 	if ((vcpu->arch.sie_block->ipb & 0xff) != 0x2f)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	useraddr = disp2;
 	if (base2)
@@ -138,7 +138,7 @@
 		rc = __kvm_s390_vcpu_store_status(vcpu,
 						  KVM_S390_STORE_STATUS_NOADDR);
 		if (rc >= 0)
-			rc = -ENOTSUPP;
+			rc = -EOPNOTSUPP;
 	}
 
 	if (vcpu->arch.local_int.action_bits & ACTION_RELOADVCPU_ON_STOP) {
@@ -150,7 +150,7 @@
 	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP) {
 		vcpu->arch.local_int.action_bits &= ~ACTION_STOP_ON_STOP;
 		VCPU_EVENT(vcpu, 3, "%s", "cpu stopped");
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 	}
 
 	spin_unlock_bh(&vcpu->arch.local_int.lock);
@@ -171,9 +171,9 @@
 			 2*PAGE_SIZE);
 		if (rc)
 			/* user will receive sigsegv, exit to user */
-			rc = -ENOTSUPP;
+			rc = -EOPNOTSUPP;
 	} else
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 
 	if (rc)
 		VCPU_EVENT(vcpu, 2, "unhandled validity intercept code %d",
@@ -189,7 +189,7 @@
 	handler = instruction_handlers[vcpu->arch.sie_block->ipa >> 8];
 	if (handler)
 		return handler(vcpu);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int handle_prog(struct kvm_vcpu *vcpu)
@@ -206,7 +206,7 @@
 	rc = handle_instruction(vcpu);
 	rc2 = handle_prog(vcpu);
 
-	if (rc == -ENOTSUPP)
+	if (rc == -EOPNOTSUPP)
 		vcpu->arch.sie_block->icptcode = 0x04;
 	if (rc)
 		return rc;
@@ -231,9 +231,9 @@
 	u8 code = vcpu->arch.sie_block->icptcode;
 
 	if (code & 3 || (code >> 2) >= ARRAY_SIZE(intercept_funcs))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	func = intercept_funcs[code >> 2];
 	if (func)
 		return func(vcpu);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
Index: quilt-2.6/arch/s390/kvm/interrupt.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/interrupt.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/interrupt.c	2010-02-24 09:44:26.000000000 +0100
@@ -342,7 +342,7 @@
 	if (psw_interrupts_disabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "disabled wait");
 		__unset_cpu_idle(vcpu);
-		return -ENOTSUPP; /* disabled wait */
+		return -EOPNOTSUPP; /* disabled wait */
 	}
 
 	if (psw_extint_disabled(vcpu) ||
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c	2010-02-24 09:44:26.000000000 +0100
@@ -543,7 +543,7 @@
 		rc = -EINTR;
 	}
 
-	if (rc == -ENOTSUPP) {
+	if (rc == -EOPNOTSUPP) {
 		/* intercept cannot be handled in-kernel, prepare kvm-run */
 		kvm_run->exit_reason         = KVM_EXIT_S390_SIEIC;
 		kvm_run->s390_sieic.icptcode = vcpu->arch.sie_block->icptcode;
Index: quilt-2.6/arch/s390/kvm/priv.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/priv.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/priv.c	2010-02-24 09:44:26.000000000 +0100
@@ -323,5 +323,5 @@
 		else
 			return handler(vcpu);
 	}
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
Index: quilt-2.6/arch/s390/kvm/sigp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/sigp.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/sigp.c	2010-02-24 09:44:26.000000000 +0100
@@ -172,7 +172,7 @@
 		rc = 0; /* order accepted */
 		break;
 	default:
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 	}
 	return rc;
 }
@@ -293,7 +293,7 @@
 		vcpu->stat.instruction_sigp_restart++;
 		/* user space must know about restart */
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (rc < 0)
Index: quilt-2.6/arch/s390/mm/extmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/extmem.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/mm/extmem.c	2010-02-24 09:44:26.000000000 +0100
@@ -309,7 +309,7 @@
 	}
 #endif
 	if (qout->segcnt > 6) {
-		rc = -ENOTSUPP;
+		rc = -EOPNOTSUPP;
 		goto out_free;
 	}
 
@@ -324,11 +324,11 @@
 		for (i=0; i<qout->segcnt; i++) {
 			if (((qout->range[i].start & 0xff) != SEG_TYPE_EW) &&
 			    ((qout->range[i].start & 0xff) != SEG_TYPE_EN)) {
-				rc = -ENOTSUPP;
+				rc = -EOPNOTSUPP;
 				goto out_free;
 			}
 			if (start != qout->range[i].start >> PAGE_SHIFT) {
-				rc = -ENOTSUPP;
+				rc = -EOPNOTSUPP;
 				goto out_free;
 			}
 			start = (qout->range[i].end >> PAGE_SHIFT) + 1;
@@ -357,7 +357,7 @@
  * -ENOSYS  : we are not running on VM
  * -EIO     : could not perform query diagnose
  * -ENOENT  : no such segment
- * -ENOTSUPP: multi-part segment cannot be used with linux
+ * -EOPNOTSUPP: multi-part segment cannot be used with linux
  * -ENOMEM  : out of memory
  * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
  */
@@ -515,7 +515,7 @@
  * -ENOSYS  : we are not running on VM
  * -EIO     : could not perform query or load diagnose
  * -ENOENT  : no such segment
- * -ENOTSUPP: multi-part segment cannot be used with linux
+ * -EOPNOTSUPP: multi-part segment cannot be used with linux
  * -ENOSPC  : segment cannot be used (overlaps with storage)
  * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
  * -ERANGE  : segment cannot be used (exceeds kernel mapping range)
@@ -742,7 +742,7 @@
 		pr_err("Loading or querying DCSS %s resulted in a "
 		       "hardware error\n", seg_name);
 		break;
-	case -ENOTSUPP:
+	case -EOPNOTSUPP:
 		pr_err("DCSS %s has multiple page ranges and cannot be "
 		       "loaded or queried\n", seg_name);
 		break;
