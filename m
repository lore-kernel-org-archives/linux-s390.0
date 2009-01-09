Return-Path: <linux-kernel-owner+w=401wt.eu-S1754413AbZAILtg@vger.kernel.org>
Subject: [GIT PULL] s390 patches for 2.6.29 #2
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 09 Jan 2009 12:49:16 +0100
Message-Id: <1231501756.13260.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (5):
      [S390] ptrace: no extern declarations for userspace
      [S390] types: add/fix types.h include in header files
      [S390] remove code for oldselect system call
      [S390] vdso: compile fix
      [S390] Use unsigned long long for u64 on 64bit.

Hendrik Brueckner (6):
      [S390] hvc_iucv: Change IUCV term id and use one device as default
      [S390] hvc_iucv: Limit rate of outgoing IUCV messages
      [S390] hvc_iucv: Update function documentation
      [S390] hvc_iucv: Refactor console and device initialization
      [S390] hvc_iucv: Special handling of IUCV HVC devices
      [S390] update documentation for hvc_iucv kernel parameter.

Holger Smolinski (1):
      [S390] dasd: add device attribute to disable blocking on lost paths

Huang Weiyi (1):
      [S390] gettimeofday.S: removed duplicated #includes

Jan Glauber (1):
      [S390] qdio: fix broken pointer in case of CONFIG_DEBUG_FS is disabled

Kamalesh Babulal (1):
      [S390] tape block: fix dependencies

Mike Frysinger (1):
      [S390] asm-s390/posix_types.h: drop __USE_ALL usage

Stefan Weinhuber (1):
      [S390] dasd: send change uevents for dasd block devices

 Documentation/kernel-parameters.txt    |    4 +-
 arch/s390/include/asm/chpid.h          |    2 +-
 arch/s390/include/asm/chsc.h           |    1 +
 arch/s390/include/asm/cmb.h            |    3 +
 arch/s390/include/asm/dasd.h           |    2 +
 arch/s390/include/asm/kvm.h            |    2 +-
 arch/s390/include/asm/posix_types.h    |    4 -
 arch/s390/include/asm/ptrace.h         |    7 +-
 arch/s390/include/asm/qeth.h           |    1 +
 arch/s390/include/asm/schid.h          |    2 +
 arch/s390/include/asm/swab.h           |    2 +-
 arch/s390/include/asm/types.h          |    6 +-
 arch/s390/kernel/entry.h               |    2 -
 arch/s390/kernel/smp.c                 |    3 +-
 arch/s390/kernel/sys_s390.c            |   19 --
 arch/s390/kernel/vdso.c                |    3 +-
 arch/s390/kernel/vdso32/gettimeofday.S |    4 -
 arch/s390/kvm/diag.c                   |    2 +-
 arch/s390/kvm/interrupt.c              |    6 +-
 arch/s390/kvm/priv.c                   |    2 +-
 drivers/char/hvc_iucv.c                |  420 ++++++++++++++++++++------------
 drivers/s390/block/dasd.c              |   21 ++-
 drivers/s390/block/dasd_devmap.c       |   48 ++++
 drivers/s390/block/dasd_diag.c         |    3 +-
 drivers/s390/block/dasd_eckd.c         |    3 +-
 drivers/s390/block/dasd_fba.c          |    3 +-
 drivers/s390/char/Kconfig              |    2 +-
 drivers/s390/cio/qdio_debug.c          |    2 +
 28 files changed, 376 insertions(+), 203 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fb84902..ed0a724 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -829,8 +829,8 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	hlt		[BUGS=ARM,SH]
 
-	hvc_iucv=	[S390] Number of z/VM IUCV Hypervisor console (HVC)
-			       back-ends. Valid parameters: 0..8
+	hvc_iucv=	[S390] Number of z/VM IUCV hypervisor console (HVC)
+			       terminal devices. Valid values: 0..8
 
 	i8042.debug	[HW] Toggle i8042 debug mode
 	i8042.direct	[HW] Put keyboard port into non-translated mode
diff --git a/arch/s390/include/asm/chpid.h b/arch/s390/include/asm/chpid.h
index dfe3c7f..fc71d8a 100644
--- a/arch/s390/include/asm/chpid.h
+++ b/arch/s390/include/asm/chpid.h
@@ -9,7 +9,7 @@
 #define _ASM_S390_CHPID_H _ASM_S390_CHPID_H
 
 #include <linux/string.h>
-#include <asm/types.h>
+#include <linux/types.h>
 
 #define __MAX_CHPID 255
 
diff --git a/arch/s390/include/asm/chsc.h b/arch/s390/include/asm/chsc.h
index d38d0cf..807997f 100644
--- a/arch/s390/include/asm/chsc.h
+++ b/arch/s390/include/asm/chsc.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_CHSC_H
 #define _ASM_CHSC_H
 
+#include <linux/types.h>
 #include <asm/chpid.h>
 #include <asm/schid.h>
 
diff --git a/arch/s390/include/asm/cmb.h b/arch/s390/include/asm/cmb.h
index 5019685..39ae032 100644
--- a/arch/s390/include/asm/cmb.h
+++ b/arch/s390/include/asm/cmb.h
@@ -1,5 +1,8 @@
 #ifndef S390_CMB_H
 #define S390_CMB_H
+
+#include <linux/types.h>
+
 /**
  * struct cmbdata - channel measurement block data for user space
  * @size: size of the stored data
diff --git a/arch/s390/include/asm/dasd.h b/arch/s390/include/asm/dasd.h
index 55b2b80..e2db6f1 100644
--- a/arch/s390/include/asm/dasd.h
+++ b/arch/s390/include/asm/dasd.h
@@ -14,6 +14,7 @@
 
 #ifndef DASD_H
 #define DASD_H
+#include <linux/types.h>
 #include <linux/ioctl.h>
 
 #define DASD_IOCTL_LETTER 'D'
@@ -78,6 +79,7 @@ typedef struct dasd_information2_t {
 #define DASD_FEATURE_USEDIAG	     0x02
 #define DASD_FEATURE_INITIAL_ONLINE  0x04
 #define DASD_FEATURE_ERPLOG	     0x08
+#define DASD_FEATURE_FAILFAST	     0x10
 
 #define DASD_PARTN_BITS 2
 
diff --git a/arch/s390/include/asm/kvm.h b/arch/s390/include/asm/kvm.h
index d74002f..e1f5465 100644
--- a/arch/s390/include/asm/kvm.h
+++ b/arch/s390/include/asm/kvm.h
@@ -13,7 +13,7 @@
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
-#include <asm/types.h>
+#include <linux/types.h>
 
 /* for KVM_GET_IRQCHIP and KVM_SET_IRQCHIP */
 struct kvm_pic_state {
diff --git a/arch/s390/include/asm/posix_types.h b/arch/s390/include/asm/posix_types.h
index 397d93f..8cc113f 100644
--- a/arch/s390/include/asm/posix_types.h
+++ b/arch/s390/include/asm/posix_types.h
@@ -68,11 +68,7 @@ typedef unsigned short __kernel_old_dev_t;
 #endif /* __s390x__ */
 
 typedef struct {
-#if defined(__KERNEL__) || defined(__USE_ALL)
         int     val[2];
-#else                        /* !defined(__KERNEL__) && !defined(__USE_ALL)*/
-        int     __val[2];
-#endif                       /* !defined(__KERNEL__) && !defined(__USE_ALL)*/
 } __kernel_fsid_t;
 
 
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 5396f9f..8920025 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -272,12 +272,15 @@ typedef struct
 #define PSW_ASC_SECONDARY	0x0000800000000000UL
 #define PSW_ASC_HOME		0x0000C00000000000UL
 
-extern long psw_user32_bits;
-
 #endif /* __s390x__ */
 
+#ifdef __KERNEL__
 extern long psw_kernel_bits;
 extern long psw_user_bits;
+#ifdef CONFIG_64BIT
+extern long psw_user32_bits;
+#endif
+#endif
 
 /* This macro merges a NEW PSW mask specified by the user into
    the currently active PSW mask CURRENT, modifying only those
diff --git a/arch/s390/include/asm/qeth.h b/arch/s390/include/asm/qeth.h
index 930d378..06cbd1e 100644
--- a/arch/s390/include/asm/qeth.h
+++ b/arch/s390/include/asm/qeth.h
@@ -10,6 +10,7 @@
  */
 #ifndef __ASM_S390_QETH_IOCTL_H__
 #define __ASM_S390_QETH_IOCTL_H__
+#include <linux/types.h>
 #include <linux/ioctl.h>
 
 #define SIOC_QETH_ARP_SET_NO_ENTRIES    (SIOCDEVPRIVATE)
diff --git a/arch/s390/include/asm/schid.h b/arch/s390/include/asm/schid.h
index 825503c..3e4d401 100644
--- a/arch/s390/include/asm/schid.h
+++ b/arch/s390/include/asm/schid.h
@@ -1,6 +1,8 @@
 #ifndef ASM_SCHID_H
 #define ASM_SCHID_H
 
+#include <linux/types.h>
+
 struct subchannel_id {
 	__u32 cssid : 8;
 	__u32 : 4;
diff --git a/arch/s390/include/asm/swab.h b/arch/s390/include/asm/swab.h
index bd9321a..eb18dc1 100644
--- a/arch/s390/include/asm/swab.h
+++ b/arch/s390/include/asm/swab.h
@@ -9,7 +9,7 @@
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
-#include <asm/types.h>
+#include <linux/types.h>
 
 #ifndef __s390x__
 # define __SWAB_64_THRU_32__
diff --git a/arch/s390/include/asm/types.h b/arch/s390/include/asm/types.h
index 41c5476..3dc3fc2 100644
--- a/arch/s390/include/asm/types.h
+++ b/arch/s390/include/asm/types.h
@@ -9,11 +9,7 @@
 #ifndef _S390_TYPES_H
 #define _S390_TYPES_H
 
-#ifndef __s390x__
-# include <asm-generic/int-ll64.h>
-#else
-# include <asm-generic/int-l64.h>
-#endif
+#include <asm-generic/int-ll64.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 6b18963..a65afc9 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -54,7 +54,5 @@ long sys_sigreturn(void);
 long sys_rt_sigreturn(void);
 long sys32_sigreturn(void);
 long sys32_rt_sigreturn(void);
-long old_select(struct sel_arg_struct __user *arg);
-long sys_ptrace(long request, long pid, long addr, long data);
 
 #endif /* _ENTRY_H */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 9c0ccb5..2d337cb 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -685,7 +685,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	if (MACHINE_HAS_IEEE)
 		lowcore->extended_save_area_addr = (u32) save_area;
 #else
-	BUG_ON(vdso_alloc_per_cpu(smp_processor_id(), lowcore));
+	if (vdso_alloc_per_cpu(smp_processor_id(), lowcore))
+		BUG();
 #endif
 	set_prefix((u32)(unsigned long) lowcore);
 	local_mcck_enable();
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 4fe952e..c34be45 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -103,25 +103,6 @@ out:
 	return error;
 }
 
-#ifndef CONFIG_64BIT
-struct sel_arg_struct {
-	unsigned long n;
-	fd_set __user *inp, *outp, *exp;
-	struct timeval __user *tvp;
-};
-
-asmlinkage long old_select(struct sel_arg_struct __user *arg)
-{
-	struct sel_arg_struct a;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		return -EFAULT;
-	/* sys_select() does the appropriate kernel locking */
-	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
-
-}
-#endif /* CONFIG_64BIT */
-
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
  *
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 25a6a82..690e178 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -322,7 +322,8 @@ static int __init vdso_init(void)
 	vdso64_pagelist[vdso64_pages - 1] = virt_to_page(vdso_data);
 	vdso64_pagelist[vdso64_pages] = NULL;
 #ifndef CONFIG_SMP
-	BUG_ON(vdso_alloc_per_cpu(0, S390_lowcore));
+	if (vdso_alloc_per_cpu(0, &S390_lowcore))
+		BUG();
 #endif
 	vdso_init_cr5();
 #endif /* CONFIG_64BIT */
diff --git a/arch/s390/kernel/vdso32/gettimeofday.S b/arch/s390/kernel/vdso32/gettimeofday.S
index c32f29c..ad8acfc 100644
--- a/arch/s390/kernel/vdso32/gettimeofday.S
+++ b/arch/s390/kernel/vdso32/gettimeofday.S
@@ -13,10 +13,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 
-#include <asm/vdso.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
 	.text
 	.align 4
 	.globl __kernel_gettimeofday
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index a0775e1..8300309 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -47,7 +47,7 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_IPL;
 	vcpu->run->s390_reset_flags |= KVM_S390_RESET_CPU_INIT;
 	vcpu->run->exit_reason = KVM_EXIT_S390_RESET;
-	VCPU_EVENT(vcpu, 3, "requesting userspace resets %lx",
+	VCPU_EVENT(vcpu, 3, "requesting userspace resets %llx",
 	  vcpu->run->s390_reset_flags);
 	return -EREMOTE;
 }
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2960702..f4fe28a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -160,7 +160,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		break;
 
 	case KVM_S390_INT_VIRTIO:
-		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%lx",
+		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
 			   inti->ext.ext_params, inti->ext.ext_params2);
 		vcpu->stat.deliver_virtio_interrupt++;
 		rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2603);
@@ -360,7 +360,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	vcpu->arch.ckc_timer.expires = jiffies + sltime;
 
 	add_timer(&vcpu->arch.ckc_timer);
-	VCPU_EVENT(vcpu, 5, "enabled wait timer:%lx jiffies", sltime);
+	VCPU_EVENT(vcpu, 5, "enabled wait timer:%llx jiffies", sltime);
 no_timer:
 	spin_lock_bh(&vcpu->arch.local_int.float_int->lock);
 	spin_lock_bh(&vcpu->arch.local_int.lock);
@@ -491,7 +491,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 
 	switch (s390int->type) {
 	case KVM_S390_INT_VIRTIO:
-		VM_EVENT(kvm, 5, "inject: virtio parm:%x,parm64:%lx",
+		VM_EVENT(kvm, 5, "inject: virtio parm:%x,parm64:%llx",
 			 s390int->parm, s390int->parm64);
 		inti->type = s390int->type;
 		inti->ext.ext_params = s390int->parm;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cce40ff..3605df4 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -118,7 +118,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	VCPU_EVENT(vcpu, 5, "storing cpu address to %lx", useraddr);
+	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", useraddr);
 out:
 	return 0;
 }
diff --git a/drivers/char/hvc_iucv.c b/drivers/char/hvc_iucv.c
index 5ea7d77..a534968 100644
--- a/drivers/char/hvc_iucv.c
+++ b/drivers/char/hvc_iucv.c
@@ -1,26 +1,30 @@
 /*
- * hvc_iucv.c - z/VM IUCV back-end for the Hypervisor Console (HVC)
+ * hvc_iucv.c - z/VM IUCV hypervisor console (HVC) device driver
  *
- * This back-end for HVC provides terminal access via
+ * This HVC device driver provides terminal access using
  * z/VM IUCV communication paths.
  *
- * Copyright IBM Corp. 2008.
+ * Copyright IBM Corp. 2008
  *
  * Author(s):	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  */
 #define KMSG_COMPONENT		"hvc_iucv"
+#define pr_fmt(fmt)		KMSG_COMPONENT ": " fmt
 
 #include <linux/types.h>
 #include <asm/ebcdic.h>
+#include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/wait.h>
 #include <net/iucv/iucv.h>
 
 #include "hvc_console.h"
 
 
-/* HVC backend for z/VM IUCV */
+/* General device driver settings */
 #define HVC_IUCV_MAGIC		0xc9e4c3e5
 #define MAX_HVC_IUCV_LINES	HVC_ALLOC_TTY_ADAPTERS
 #define MEMPOOL_MIN_NR		(PAGE_SIZE / sizeof(struct iucv_tty_buffer)/4)
@@ -33,14 +37,14 @@
 #define MSG_TYPE_WINSIZE	0x08	/* Terminal window size update */
 #define MSG_TYPE_DATA		0x10	/* Terminal data */
 
-#define MSG_SIZE(s)		((s) + offsetof(struct iucv_tty_msg, data))
 struct iucv_tty_msg {
 	u8	version;		/* Message version */
 	u8	type;			/* Message type */
-#define MSG_MAX_DATALEN		(~(u16)0)
+#define MSG_MAX_DATALEN		((u16)(~0))
 	u16	datalen;		/* Payload length */
 	u8	data[];			/* Payload buffer */
 } __attribute__((packed));
+#define MSG_SIZE(s)		((s) + offsetof(struct iucv_tty_msg, data))
 
 enum iucv_state_t {
 	IUCV_DISCONN	= 0,
@@ -54,19 +58,26 @@ enum tty_state_t {
 };
 
 struct hvc_iucv_private {
-	struct hvc_struct	*hvc; /* HVC console struct reference */
+	struct hvc_struct	*hvc;		/* HVC struct reference */
 	u8			srv_name[8];	/* IUCV service name (ebcdic) */
+	unsigned char		is_console;	/* Linux console usage flag */
 	enum iucv_state_t	iucv_state;	/* IUCV connection status */
 	enum tty_state_t	tty_state;	/* TTY status */
 	struct iucv_path	*path;		/* IUCV path pointer */
 	spinlock_t		lock;		/* hvc_iucv_private lock */
+#define SNDBUF_SIZE		(PAGE_SIZE)	/* must be < MSG_MAX_DATALEN */
+	void			*sndbuf;	/* send buffer		  */
+	size_t			sndbuf_len;	/* length of send buffer  */
+#define QUEUE_SNDBUF_DELAY	(HZ / 25)
+	struct delayed_work	sndbuf_work;	/* work: send iucv msg(s) */
+	wait_queue_head_t	sndbuf_waitq;	/* wait for send completion */
 	struct list_head	tty_outqueue;	/* outgoing IUCV messages */
 	struct list_head	tty_inqueue;	/* incoming IUCV messages */
 };
 
 struct iucv_tty_buffer {
 	struct list_head	list;	/* list pointer */
-	struct iucv_message	msg;	/* store an incoming IUCV message */
+	struct iucv_message	msg;	/* store an IUCV message */
 	size_t			offset;	/* data buffer offset */
 	struct iucv_tty_msg	*mbuf;	/* buffer to store input/output data */
 };
@@ -78,11 +89,12 @@ static void hvc_iucv_msg_pending(struct iucv_path *, struct iucv_message *);
 static void hvc_iucv_msg_complete(struct iucv_path *, struct iucv_message *);
 
 
-/* Kernel module parameters */
-static unsigned long hvc_iucv_devices;
+/* Kernel module parameter: use one terminal device as default */
+static unsigned long hvc_iucv_devices = 1;
 
 /* Array of allocated hvc iucv tty lines... */
 static struct hvc_iucv_private *hvc_iucv_table[MAX_HVC_IUCV_LINES];
+#define IUCV_HVC_CON_IDX	(0)
 
 /* Kmem cache and mempool for iucv_tty_buffer elements */
 static struct kmem_cache *hvc_iucv_buffer_cache;
@@ -112,7 +124,7 @@ struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
 }
 
 /**
- * alloc_tty_buffer() - Returns a new struct iucv_tty_buffer element.
+ * alloc_tty_buffer() - Return a new struct iucv_tty_buffer element.
  * @size:	Size of the internal buffer used to store data.
  * @flags:	Memory allocation flags passed to mempool.
  *
@@ -120,7 +132,6 @@ struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
  * allocates an internal data buffer with the specified size @size.
  * Note: The total message size arises from the internal buffer size and the
  *	 members of the iucv_tty_msg structure.
- *
  * The function returns NULL if memory allocation has failed.
  */
 static struct iucv_tty_buffer *alloc_tty_buffer(size_t size, gfp_t flags)
@@ -130,7 +141,7 @@ static struct iucv_tty_buffer *alloc_tty_buffer(size_t size, gfp_t flags)
 	bufp = mempool_alloc(hvc_iucv_mempool, flags);
 	if (!bufp)
 		return NULL;
-	memset(bufp, 0, sizeof(struct iucv_tty_buffer));
+	memset(bufp, 0, sizeof(*bufp));
 
 	if (size > 0) {
 		bufp->msg.length = MSG_SIZE(size);
@@ -149,9 +160,6 @@ static struct iucv_tty_buffer *alloc_tty_buffer(size_t size, gfp_t flags)
 /**
  * destroy_tty_buffer() - destroy struct iucv_tty_buffer element.
  * @bufp:	Pointer to a struct iucv_tty_buffer element, SHALL NOT be NULL.
- *
- * The destroy_tty_buffer() function frees the internal data buffer and returns
- * the struct iucv_tty_buffer element back to the mempool for freeing.
  */
 static void destroy_tty_buffer(struct iucv_tty_buffer *bufp)
 {
@@ -161,11 +169,7 @@ static void destroy_tty_buffer(struct iucv_tty_buffer *bufp)
 
 /**
  * destroy_tty_buffer_list() - call destroy_tty_buffer() for each list element.
- * @list:	List head pointer to a list containing struct iucv_tty_buffer
- *		elements.
- *
- * Calls destroy_tty_buffer() for each struct iucv_tty_buffer element in the
- * list @list.
+ * @list:	List containing struct iucv_tty_buffer elements.
  */
 static void destroy_tty_buffer_list(struct list_head *list)
 {
@@ -178,24 +182,24 @@ static void destroy_tty_buffer_list(struct list_head *list)
 }
 
 /**
- * hvc_iucv_write() - Receive IUCV message write data to HVC console buffer.
- * @priv:		Pointer to hvc_iucv_private structure.
- * @buf:		HVC console buffer for writing received terminal data.
- * @count:		HVC console buffer size.
+ * hvc_iucv_write() - Receive IUCV message & write data to HVC buffer.
+ * @priv:		Pointer to struct hvc_iucv_private
+ * @buf:		HVC buffer for writing received terminal data.
+ * @count:		HVC buffer size.
  * @has_more_data:	Pointer to an int variable.
  *
  * The function picks up pending messages from the input queue and receives
  * the message data that is then written to the specified buffer @buf.
- * If the buffer size @count is less than the data message size, then the
+ * If the buffer size @count is less than the data message size, the
  * message is kept on the input queue and @has_more_data is set to 1.
- * If the message data has been entirely written, the message is removed from
+ * If all message data has been written, the message is removed from
  * the input queue.
  *
  * The function returns the number of bytes written to the terminal, zero if
  * there are no pending data messages available or if there is no established
  * IUCV path.
  * If the IUCV path has been severed, then -EPIPE is returned to cause a
- * hang up (that is issued by the HVC console layer).
+ * hang up (that is issued by the HVC layer).
  */
 static int hvc_iucv_write(struct hvc_iucv_private *priv,
 			  char *buf, int count, int *has_more_data)
@@ -204,12 +208,12 @@ static int hvc_iucv_write(struct hvc_iucv_private *priv,
 	int written;
 	int rc;
 
-	/* Immediately return if there is no IUCV connection */
+	/* immediately return if there is no IUCV connection */
 	if (priv->iucv_state == IUCV_DISCONN)
 		return 0;
 
-	/* If the IUCV path has been severed, return -EPIPE to inform the
-	 * hvc console layer to hang up the tty device. */
+	/* if the IUCV path has been severed, return -EPIPE to inform the
+	 * HVC layer to hang up the tty device. */
 	if (priv->iucv_state == IUCV_SEVERED)
 		return -EPIPE;
 
@@ -217,7 +221,7 @@ static int hvc_iucv_write(struct hvc_iucv_private *priv,
 	if (list_empty(&priv->tty_inqueue))
 		return 0;
 
-	/* receive a iucv message and flip data to the tty (ldisc) */
+	/* receive an iucv message and flip data to the tty (ldisc) */
 	rb = list_first_entry(&priv->tty_inqueue, struct iucv_tty_buffer, list);
 
 	written = 0;
@@ -260,7 +264,7 @@ static int hvc_iucv_write(struct hvc_iucv_private *priv,
 	case MSG_TYPE_WINSIZE:
 		if (rb->mbuf->datalen != sizeof(struct winsize))
 			break;
-		hvc_resize(priv->hvc, *((struct winsize *)rb->mbuf->data));
+		hvc_resize(priv->hvc, *((struct winsize *) rb->mbuf->data));
 		break;
 
 	case MSG_TYPE_ERROR:	/* ignored ... */
@@ -284,10 +288,9 @@ out_written:
  * @buf:	Pointer to a buffer to store data
  * @count:	Size of buffer available for writing
  *
- * The hvc_console thread calls this method to read characters from
- * the terminal backend. If an IUCV communication path has been established,
- * pending IUCV messages are received and data is copied into buffer @buf
- * up to @count bytes.
+ * The HVC thread calls this method to read characters from the back-end.
+ * If an IUCV communication path has been established, pending IUCV messages
+ * are received and data is copied into buffer @buf up to @count bytes.
  *
  * Locking:	The routine gets called under an irqsave() spinlock; and
  *		the routine locks the struct hvc_iucv_private->lock to call
@@ -318,66 +321,122 @@ static int hvc_iucv_get_chars(uint32_t vtermno, char *buf, int count)
 }
 
 /**
- * hvc_iucv_send() - Send an IUCV message containing terminal data.
+ * hvc_iucv_queue() - Buffer terminal data for sending.
  * @priv:	Pointer to struct hvc_iucv_private instance.
  * @buf:	Buffer containing data to send.
- * @size:	Size of buffer and amount of data to send.
+ * @count:	Size of buffer and amount of data to send.
+ *
+ * The function queues data for sending. To actually send the buffered data,
+ * a work queue function is scheduled (with QUEUE_SNDBUF_DELAY).
+ * The function returns the number of data bytes that has been buffered.
  *
- * If an IUCV communication path is established, the function copies the buffer
- * data to a newly allocated struct iucv_tty_buffer element, sends the data and
- * puts the element to the outqueue.
+ * If the device is not connected, data is ignored and the function returns
+ * @count.
+ * If the buffer is full, the function returns 0.
+ * If an existing IUCV communicaton path has been severed, -EPIPE is returned
+ * (that can be passed to HVC layer to cause a tty hangup).
+ */
+static int hvc_iucv_queue(struct hvc_iucv_private *priv, const char *buf,
+			  int count)
+{
+	size_t len;
+
+	if (priv->iucv_state == IUCV_DISCONN)
+		return count;			/* ignore data */
+
+	if (priv->iucv_state == IUCV_SEVERED)
+		return -EPIPE;
+
+	len = min_t(size_t, count, SNDBUF_SIZE - priv->sndbuf_len);
+	if (!len)
+		return 0;
+
+	memcpy(priv->sndbuf + priv->sndbuf_len, buf, len);
+	priv->sndbuf_len += len;
+
+	if (priv->iucv_state == IUCV_CONNECTED)
+		schedule_delayed_work(&priv->sndbuf_work, QUEUE_SNDBUF_DELAY);
+
+	return len;
+}
+
+/**
+ * hvc_iucv_send() - Send an IUCV message containing terminal data.
+ * @priv:	Pointer to struct hvc_iucv_private instance.
  *
- * If there is no IUCV communication path established, the function returns 0.
- * If an existing IUCV communicaton path has been severed, the function returns
- * -EPIPE (can be passed to HVC layer to cause a tty hangup).
+ * If an IUCV communication path has been established, the buffered output data
+ * is sent via an IUCV message and the number of bytes sent is returned.
+ * Returns 0 if there is no established IUCV communication path or
+ * -EPIPE if an existing IUCV communicaton path has been severed.
  */
-static int hvc_iucv_send(struct hvc_iucv_private *priv, const char *buf,
-			 int count)
+static int hvc_iucv_send(struct hvc_iucv_private *priv)
 {
 	struct iucv_tty_buffer *sb;
-	int rc;
-	u16 len;
+	int rc, len;
 
 	if (priv->iucv_state == IUCV_SEVERED)
 		return -EPIPE;
 
 	if (priv->iucv_state == IUCV_DISCONN)
-		return 0;
+		return -EIO;
 
-	len = min_t(u16, MSG_MAX_DATALEN, count);
+	if (!priv->sndbuf_len)
+		return 0;
 
 	/* allocate internal buffer to store msg data and also compute total
 	 * message length */
-	sb = alloc_tty_buffer(len, GFP_ATOMIC);
+	sb = alloc_tty_buffer(priv->sndbuf_len, GFP_ATOMIC);
 	if (!sb)
 		return -ENOMEM;
 
-	sb->mbuf->datalen = len;
-	memcpy(sb->mbuf->data, buf, len);
+	memcpy(sb->mbuf->data, priv->sndbuf, priv->sndbuf_len);
+	sb->mbuf->datalen = (u16) priv->sndbuf_len;
+	sb->msg.length = MSG_SIZE(sb->mbuf->datalen);
 
 	list_add_tail(&sb->list, &priv->tty_outqueue);
 
 	rc = __iucv_message_send(priv->path, &sb->msg, 0, 0,
 				 (void *) sb->mbuf, sb->msg.length);
 	if (rc) {
+		/* drop the message here; however we might want to handle
+		 * 0x03 (msg limit reached) by trying again... */
 		list_del(&sb->list);
 		destroy_tty_buffer(sb);
-		len = 0;
 	}
+	len = priv->sndbuf_len;
+	priv->sndbuf_len = 0;
 
 	return len;
 }
 
 /**
+ * hvc_iucv_sndbuf_work() - Send buffered data over IUCV
+ * @work:	Work structure.
+ *
+ * This work queue function sends buffered output data over IUCV and,
+ * if not all buffered data could be sent, reschedules itself.
+ */
+static void hvc_iucv_sndbuf_work(struct work_struct *work)
+{
+	struct hvc_iucv_private *priv;
+
+	priv = container_of(work, struct hvc_iucv_private, sndbuf_work.work);
+	if (!priv)
+		return;
+
+	spin_lock_bh(&priv->lock);
+	hvc_iucv_send(priv);
+	spin_unlock_bh(&priv->lock);
+}
+
+/**
  * hvc_iucv_put_chars() - HVC put_chars operation.
  * @vtermno:	HVC virtual terminal number.
  * @buf:	Pointer to an buffer to read data from
  * @count:	Size of buffer available for reading
  *
- * The hvc_console thread calls this method to write characters from
- * to the terminal backend.
- * The function calls hvc_iucv_send() under the lock of the
- * struct hvc_iucv_private instance that corresponds to the tty @vtermno.
+ * The HVC thread calls this method to write characters to the back-end.
+ * The function calls hvc_iucv_queue() to queue terminal data for sending.
  *
  * Locking:	The method gets called under an irqsave() spinlock; and
  *		locks struct hvc_iucv_private->lock.
@@ -385,7 +444,7 @@ static int hvc_iucv_send(struct hvc_iucv_private *priv, const char *buf,
 static int hvc_iucv_put_chars(uint32_t vtermno, const char *buf, int count)
 {
 	struct hvc_iucv_private *priv = hvc_iucv_get_private(vtermno);
-	int sent;
+	int queued;
 
 	if (count <= 0)
 		return 0;
@@ -394,10 +453,10 @@ static int hvc_iucv_put_chars(uint32_t vtermno, const char *buf, int count)
 		return -ENODEV;
 
 	spin_lock(&priv->lock);
-	sent = hvc_iucv_send(priv, buf, count);
+	queued = hvc_iucv_queue(priv, buf, count);
 	spin_unlock(&priv->lock);
 
-	return sent;
+	return queued;
 }
 
 /**
@@ -406,7 +465,7 @@ static int hvc_iucv_put_chars(uint32_t vtermno, const char *buf, int count)
  * @id:	Additional data (originally passed to hvc_alloc): the index of an struct
  *	hvc_iucv_private instance.
  *
- * The function sets the tty state to TTY_OPEN for the struct hvc_iucv_private
+ * The function sets the tty state to TTY_OPENED for the struct hvc_iucv_private
  * instance that is derived from @id. Always returns 0.
  *
  * Locking:	struct hvc_iucv_private->lock, spin_lock_bh
@@ -427,12 +486,8 @@ static int hvc_iucv_notifier_add(struct hvc_struct *hp, int id)
 }
 
 /**
- * hvc_iucv_cleanup() - Clean up function if the tty portion is finally closed.
+ * hvc_iucv_cleanup() - Clean up and reset a z/VM IUCV HVC instance.
  * @priv:	Pointer to the struct hvc_iucv_private instance.
- *
- * The functions severs the established IUCV communication path (if any), and
- * destroy struct iucv_tty_buffer elements from the in- and outqueue. Finally,
- * the functions resets the states to TTY_CLOSED and IUCV_DISCONN.
  */
 static void hvc_iucv_cleanup(struct hvc_iucv_private *priv)
 {
@@ -441,25 +496,62 @@ static void hvc_iucv_cleanup(struct hvc_iucv_private *priv)
 
 	priv->tty_state = TTY_CLOSED;
 	priv->iucv_state = IUCV_DISCONN;
+
+	priv->sndbuf_len = 0;
 }
 
 /**
- * hvc_iucv_notifier_hangup() - HVC notifier for tty hangups.
- * @hp: Pointer to the HVC device (struct hvc_struct)
- * @id: Additional data (originally passed to hvc_alloc): the index of an struct
- *	hvc_iucv_private instance.
+ * tty_outqueue_empty() - Test if the tty outq is empty
+ * @priv:	Pointer to struct hvc_iucv_private instance.
+ */
+static inline int tty_outqueue_empty(struct hvc_iucv_private *priv)
+{
+	int rc;
+
+	spin_lock_bh(&priv->lock);
+	rc = list_empty(&priv->tty_outqueue);
+	spin_unlock_bh(&priv->lock);
+
+	return rc;
+}
+
+/**
+ * flush_sndbuf_sync() - Flush send buffer and wait for completion
+ * @priv:	Pointer to struct hvc_iucv_private instance.
  *
- * This routine notifies the HVC backend that a tty hangup (carrier loss,
- * virtual or otherwise) has occured.
+ * The routine cancels a pending sndbuf work, calls hvc_iucv_send()
+ * to flush any buffered terminal output data and waits for completion.
+ */
+static void flush_sndbuf_sync(struct hvc_iucv_private *priv)
+{
+	int sync_wait;
+
+	cancel_delayed_work_sync(&priv->sndbuf_work);
+
+	spin_lock_bh(&priv->lock);
+	hvc_iucv_send(priv);		/* force sending buffered data */
+	sync_wait = !list_empty(&priv->tty_outqueue); /* anything queued ? */
+	spin_unlock_bh(&priv->lock);
+
+	if (sync_wait)
+		wait_event_timeout(priv->sndbuf_waitq,
+				   tty_outqueue_empty(priv), HZ);
+}
+
+/**
+ * hvc_iucv_notifier_hangup() - HVC notifier for TTY hangups.
+ * @hp:		Pointer to the HVC device (struct hvc_struct)
+ * @id:		Additional data (originally passed to hvc_alloc):
+ *		the index of an struct hvc_iucv_private instance.
  *
- * The HVC backend for z/VM IUCV ignores virtual hangups (vhangup()), to keep
- * an existing IUCV communication path established.
+ * This routine notifies the HVC back-end that a tty hangup (carrier loss,
+ * virtual or otherwise) has occured.
+ * The z/VM IUCV HVC device driver ignores virtual hangups (vhangup())
+ * to keep an existing IUCV communication path established.
  * (Background: vhangup() is called from user space (by getty or login) to
  *		disable writing to the tty by other applications).
- *
- * If the tty has been opened (e.g. getty) and an established IUCV path has been
- * severed (we caused the tty hangup in that case), then the functions invokes
- * hvc_iucv_cleanup() to clean up.
+ * If the tty has been opened and an established IUCV path has been severed
+ * (we caused the tty hangup), the function calls hvc_iucv_cleanup().
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -471,12 +563,12 @@ static void hvc_iucv_notifier_hangup(struct hvc_struct *hp, int id)
 	if (!priv)
 		return;
 
+	flush_sndbuf_sync(priv);
+
 	spin_lock_bh(&priv->lock);
 	/* NOTE: If the hangup was scheduled by ourself (from the iucv
-	 *	 path_servered callback [IUCV_SEVERED]), then we have to
-	 *	 finally clean up the tty backend structure and set state to
-	 *	 TTY_CLOSED.
-	 *
+	 *	 path_servered callback [IUCV_SEVERED]), we have to clean up
+	 *	 our structure and to set state to TTY_CLOSED.
 	 *	 If the tty was hung up otherwise (e.g. vhangup()), then we
 	 *	 ignore this hangup and keep an established IUCV path open...
 	 *	 (...the reason is that we are not able to connect back to the
@@ -494,10 +586,9 @@ static void hvc_iucv_notifier_hangup(struct hvc_struct *hp, int id)
  * @id:		Additional data (originally passed to hvc_alloc):
  *		the index of an struct hvc_iucv_private instance.
  *
- * This routine notifies the HVC backend that the last tty device file
- * descriptor has been closed.
- * The function calls hvc_iucv_cleanup() to clean up the struct hvc_iucv_private
- * instance.
+ * This routine notifies the HVC back-end that the last tty device fd has been
+ * closed.  The function calls hvc_iucv_cleanup() to clean up the struct
+ * hvc_iucv_private instance.
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -510,6 +601,8 @@ static void hvc_iucv_notifier_del(struct hvc_struct *hp, int id)
 	if (!priv)
 		return;
 
+	flush_sndbuf_sync(priv);
+
 	spin_lock_bh(&priv->lock);
 	path = priv->path;		/* save reference to IUCV path */
 	priv->path = NULL;
@@ -527,20 +620,18 @@ static void hvc_iucv_notifier_del(struct hvc_struct *hp, int id)
 /**
  * hvc_iucv_path_pending() - IUCV handler to process a connection request.
  * @path:	Pending path (struct iucv_path)
- * @ipvmid:	Originator z/VM system identifier
+ * @ipvmid:	z/VM system identifier of originator
  * @ipuser:	User specified data for this path
  *		(AF_IUCV: port/service name and originator port)
  *
- * The function uses the @ipuser data to check to determine if the pending
- * path belongs to a terminal managed by this HVC backend.
- * If the check is successful, then an additional check is done to ensure
- * that a terminal cannot be accessed multiple times (only one connection
- * to a terminal is allowed). In that particular case, the pending path is
- * severed. If it is the first connection, the pending path is accepted and
- * associated to the struct hvc_iucv_private. The iucv state is updated to
- * reflect that a communication path has been established.
+ * The function uses the @ipuser data to determine if the pending path belongs
+ * to a terminal managed by this device driver.
+ * If the path belongs to this driver, ensure that the terminal is not accessed
+ * multiple times (only one connection to a terminal is allowed).
+ * If the terminal is not yet connected, the pending path is accepted and is
+ * associated to the appropriate struct hvc_iucv_private instance.
  *
- * Returns 0 if the path belongs to a terminal managed by the this HVC backend;
+ * Returns 0 if @path belongs to a terminal managed by the this device driver;
  * otherwise returns -ENODEV in order to dispatch this path to other handlers.
  *
  * Locking:	struct hvc_iucv_private->lock
@@ -559,7 +650,6 @@ static	int hvc_iucv_path_pending(struct iucv_path *path,
 			priv = hvc_iucv_table[i];
 			break;
 		}
-
 	if (!priv)
 		return -ENODEV;
 
@@ -588,6 +678,9 @@ static	int hvc_iucv_path_pending(struct iucv_path *path,
 	priv->path = path;
 	priv->iucv_state = IUCV_CONNECTED;
 
+	/* flush buffered output data... */
+	schedule_delayed_work(&priv->sndbuf_work, 5);
+
 out_path_handled:
 	spin_unlock(&priv->lock);
 	return 0;
@@ -603,8 +696,7 @@ out_path_handled:
  * sets the iucv state to IUCV_SEVERED for the associated struct
  * hvc_iucv_private instance. Later, the IUCV_SEVERED state triggers a tty
  * hangup (hvc_iucv_get_chars() / hvc_iucv_write()).
- *
- * If tty portion of the HVC is closed then clean up the outqueue in addition.
+ * If tty portion of the HVC is closed, clean up the outqueue.
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -615,15 +707,25 @@ static void hvc_iucv_path_severed(struct iucv_path *path, u8 ipuser[16])
 	spin_lock(&priv->lock);
 	priv->iucv_state = IUCV_SEVERED;
 
-	/* NOTE: If the tty has not yet been opened by a getty program
-	 *	 (e.g. to see console messages), then cleanup the
-	 *	 hvc_iucv_private structure to allow re-connects.
+	/* If the tty has not yet been opened, clean up the hvc_iucv_private
+	 * structure to allow re-connects.
+	 * This is also done for our console device because console hangups
+	 * are handled specially and no notifier is called by HVC.
+	 * The tty session is active (TTY_OPEN) and ready for re-connects...
 	 *
-	 *	 If the tty has been opened, the get_chars() callback returns
-	 *	 -EPIPE to signal the hvc console layer to hang up the tty. */
+	 * If it has been opened, let get_chars() return -EPIPE to signal the
+	 * HVC layer to hang up the tty.
+	 * If so, we need to wake up the HVC thread to call get_chars()...
+	 */
 	priv->path = NULL;
 	if (priv->tty_state == TTY_CLOSED)
 		hvc_iucv_cleanup(priv);
+	else
+		if (priv->is_console) {
+			hvc_iucv_cleanup(priv);
+			priv->tty_state = TTY_OPENED;
+		} else
+			hvc_kick();
 	spin_unlock(&priv->lock);
 
 	/* finally sever path (outside of priv->lock due to lock ordering) */
@@ -636,9 +738,9 @@ static void hvc_iucv_path_severed(struct iucv_path *path, u8 ipuser[16])
  * @path:	Pending path (struct iucv_path)
  * @msg:	Pointer to the IUCV message
  *
- * The function stores an incoming message on the input queue for later
+ * The function puts an incoming message on the input queue for later
  * processing (by hvc_iucv_get_chars() / hvc_iucv_write()).
- * However, if the tty has not yet been opened, the message is rejected.
+ * If the tty has not yet been opened, the message is rejected.
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -648,6 +750,12 @@ static void hvc_iucv_msg_pending(struct iucv_path *path,
 	struct hvc_iucv_private *priv = path->private;
 	struct iucv_tty_buffer *rb;
 
+	/* reject messages that exceed max size of iucv_tty_msg->datalen */
+	if (msg->length > MSG_SIZE(MSG_MAX_DATALEN)) {
+		iucv_message_reject(path, msg);
+		return;
+	}
+
 	spin_lock(&priv->lock);
 
 	/* reject messages if tty has not yet been opened */
@@ -656,7 +764,7 @@ static void hvc_iucv_msg_pending(struct iucv_path *path,
 		goto unlock_return;
 	}
 
-	/* allocate buffer an empty buffer element */
+	/* allocate tty buffer to save iucv msg only */
 	rb = alloc_tty_buffer(0, GFP_ATOMIC);
 	if (!rb) {
 		iucv_message_reject(path, msg);
@@ -666,7 +774,7 @@ static void hvc_iucv_msg_pending(struct iucv_path *path,
 
 	list_add_tail(&rb->list, &priv->tty_inqueue);
 
-	hvc_kick();	/* wakup hvc console thread */
+	hvc_kick();	/* wake up hvc thread */
 
 unlock_return:
 	spin_unlock(&priv->lock);
@@ -677,10 +785,10 @@ unlock_return:
  * @path:	Pending path (struct iucv_path)
  * @msg:	Pointer to the IUCV message
  *
- * The function is called upon completion of message delivery and the
- * message is removed from the outqueue. Additional delivery information
- * can be found in msg->audit: rejected messages (0x040000 (IPADRJCT)) and
- * purged messages (0x010000 (IPADPGNR)).
+ * The function is called upon completion of message delivery to remove the
+ * message from the outqueue. Additional delivery information can be found
+ * msg->audit: rejected messages (0x040000 (IPADRJCT)), and
+ *	       purged messages	 (0x010000 (IPADPGNR)).
  *
  * Locking:	struct hvc_iucv_private->lock
  */
@@ -697,6 +805,7 @@ static void hvc_iucv_msg_complete(struct iucv_path *path,
 			list_move(&ent->list, &list_remove);
 			break;
 		}
+	wake_up(&priv->sndbuf_waitq);
 	spin_unlock(&priv->lock);
 	destroy_tty_buffer_list(&list_remove);
 }
@@ -713,13 +822,14 @@ static struct hv_ops hvc_iucv_ops = {
 
 /**
  * hvc_iucv_alloc() - Allocates a new struct hvc_iucv_private instance
- * @id:	hvc_iucv_table index
+ * @id:			hvc_iucv_table index
+ * @is_console:		Flag if the instance is used as Linux console
  *
- * This function allocates a new hvc_iucv_private struct and put the
- * instance into hvc_iucv_table at index @id.
+ * This function allocates a new hvc_iucv_private structure and stores
+ * the instance in hvc_iucv_table at index @id.
  * Returns 0 on success; otherwise non-zero.
  */
-static int __init hvc_iucv_alloc(int id)
+static int __init hvc_iucv_alloc(int id, unsigned int is_console)
 {
 	struct hvc_iucv_private *priv;
 	char name[9];
@@ -732,18 +842,33 @@ static int __init hvc_iucv_alloc(int id)
 	spin_lock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->tty_outqueue);
 	INIT_LIST_HEAD(&priv->tty_inqueue);
+	INIT_DELAYED_WORK(&priv->sndbuf_work, hvc_iucv_sndbuf_work);
+	init_waitqueue_head(&priv->sndbuf_waitq);
+
+	priv->sndbuf = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!priv->sndbuf) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
+	/* set console flag */
+	priv->is_console = is_console;
 
-	/* Finally allocate hvc */
-	priv->hvc = hvc_alloc(HVC_IUCV_MAGIC + id,
-			      HVC_IUCV_MAGIC + id, &hvc_iucv_ops, PAGE_SIZE);
+	/* finally allocate hvc */
+	priv->hvc = hvc_alloc(HVC_IUCV_MAGIC + id, /*		  PAGE_SIZE */
+			      HVC_IUCV_MAGIC + id, &hvc_iucv_ops, 256);
 	if (IS_ERR(priv->hvc)) {
 		rc = PTR_ERR(priv->hvc);
+		free_page((unsigned long) priv->sndbuf);
 		kfree(priv);
 		return rc;
 	}
 
+	/* notify HVC thread instead of using polling */
+	priv->hvc->irq_requested = 1;
+
 	/* setup iucv related information */
-	snprintf(name, 9, "ihvc%-4d", id);
+	snprintf(name, 9, "lnxhvc%-2d", id);
 	memcpy(priv->srv_name, name, 8);
 	ASCEBC(priv->srv_name, 8);
 
@@ -752,15 +877,16 @@ static int __init hvc_iucv_alloc(int id)
 }
 
 /**
- * hvc_iucv_init() - Initialization of HVC backend for z/VM IUCV
+ * hvc_iucv_init() - z/VM IUCV HVC device driver initialization
  */
 static int __init hvc_iucv_init(void)
 {
-	int rc, i;
+	int rc;
+	unsigned int i;
 
 	if (!MACHINE_IS_VM) {
-		pr_warning("The z/VM IUCV Hypervisor console cannot be "
-			   "used without z/VM.\n");
+		pr_info("The z/VM IUCV HVC device driver cannot "
+			   "be used without z/VM\n");
 		return -ENODEV;
 	}
 
@@ -774,26 +900,33 @@ static int __init hvc_iucv_init(void)
 					   sizeof(struct iucv_tty_buffer),
 					   0, 0, NULL);
 	if (!hvc_iucv_buffer_cache) {
-		pr_err("Not enough memory for driver initialization "
-			"(rs=%d).\n", 1);
+		pr_err("Allocating memory failed with reason code=%d\n", 1);
 		return -ENOMEM;
 	}
 
 	hvc_iucv_mempool = mempool_create_slab_pool(MEMPOOL_MIN_NR,
 						    hvc_iucv_buffer_cache);
 	if (!hvc_iucv_mempool) {
-		pr_err("Not enough memory for driver initialization "
-			"(rs=%d).\n", 2);
+		pr_err("Allocating memory failed with reason code=%d\n", 2);
 		kmem_cache_destroy(hvc_iucv_buffer_cache);
 		return -ENOMEM;
 	}
 
+	/* register the first terminal device as console
+	 * (must be done before allocating hvc terminal devices) */
+	rc = hvc_instantiate(HVC_IUCV_MAGIC, IUCV_HVC_CON_IDX, &hvc_iucv_ops);
+	if (rc) {
+		pr_err("Registering HVC terminal device as "
+		       "Linux console failed\n");
+		goto out_error_memory;
+	}
+
 	/* allocate hvc_iucv_private structs */
 	for (i = 0; i < hvc_iucv_devices; i++) {
-		rc = hvc_iucv_alloc(i);
+		rc = hvc_iucv_alloc(i, (i == IUCV_HVC_CON_IDX) ? 1 : 0);
 		if (rc) {
-			pr_err("Could not create new z/VM IUCV HVC backend "
-				"rc=%d.\n", rc);
+			pr_err("Creating a new HVC terminal device "
+				"failed with error code=%d\n", rc);
 			goto out_error_hvc;
 		}
 	}
@@ -801,7 +934,8 @@ static int __init hvc_iucv_init(void)
 	/* register IUCV callback handler */
 	rc = iucv_register(&hvc_iucv_handler, 0);
 	if (rc) {
-		pr_err("Could not register iucv handler (rc=%d).\n", rc);
+		pr_err("Registering IUCV handlers failed with error code=%d\n",
+			rc);
 		goto out_error_iucv;
 	}
 
@@ -816,22 +950,13 @@ out_error_hvc:
 				hvc_remove(hvc_iucv_table[i]->hvc);
 			kfree(hvc_iucv_table[i]);
 		}
+out_error_memory:
 	mempool_destroy(hvc_iucv_mempool);
 	kmem_cache_destroy(hvc_iucv_buffer_cache);
 	return rc;
 }
 
 /**
- * hvc_iucv_console_init() - Early console initialization
- */
-static	int __init hvc_iucv_console_init(void)
-{
-	if (!MACHINE_IS_VM || !hvc_iucv_devices)
-		return -ENODEV;
-	return hvc_instantiate(HVC_IUCV_MAGIC, 0, &hvc_iucv_ops);
-}
-
-/**
  * hvc_iucv_config() - Parsing of hvc_iucv=  kernel command line parameter
  * @val:	Parameter value (numeric)
  */
@@ -841,10 +966,5 @@ static	int __init hvc_iucv_config(char *val)
 }
 
 
-module_init(hvc_iucv_init);
-console_initcall(hvc_iucv_console_init);
+device_initcall(hvc_iucv_init);
 __setup("hvc_iucv=", hvc_iucv_config);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("HVC back-end for z/VM IUCV.");
-MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 570ae59..bd59149 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -336,6 +336,9 @@ static int
 dasd_state_ready_to_online(struct dasd_device * device)
 {
 	int rc;
+	struct gendisk *disk;
+	struct disk_part_iter piter;
+	struct hd_struct *part;
 
 	if (device->discipline->ready_to_online) {
 		rc = device->discipline->ready_to_online(device);
@@ -343,8 +346,14 @@ dasd_state_ready_to_online(struct dasd_device * device)
 			return rc;
 	}
 	device->state = DASD_STATE_ONLINE;
-	if (device->block)
+	if (device->block) {
 		dasd_schedule_block_bh(device->block);
+		disk = device->block->bdev->bd_disk;
+		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
+		while ((part = disk_part_iter_next(&piter)))
+			kobject_uevent(&part_to_dev(part)->kobj, KOBJ_CHANGE);
+		disk_part_iter_exit(&piter);
+	}
 	return 0;
 }
 
@@ -354,6 +363,9 @@ dasd_state_ready_to_online(struct dasd_device * device)
 static int dasd_state_online_to_ready(struct dasd_device *device)
 {
 	int rc;
+	struct gendisk *disk;
+	struct disk_part_iter piter;
+	struct hd_struct *part;
 
 	if (device->discipline->online_to_ready) {
 		rc = device->discipline->online_to_ready(device);
@@ -361,6 +373,13 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 			return rc;
 	}
 	device->state = DASD_STATE_READY;
+	if (device->block) {
+		disk = device->block->bdev->bd_disk;
+		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
+		while ((part = disk_part_iter_next(&piter)))
+			kobject_uevent(&part_to_dev(part)->kobj, KOBJ_CHANGE);
+		disk_part_iter_exit(&piter);
+	}
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2ef2573..300e28a 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -206,6 +206,8 @@ dasd_feature_list(char *str, char **endp)
 			features |= DASD_FEATURE_USEDIAG;
 		else if (len == 6 && !strncmp(str, "erplog", 6))
 			features |= DASD_FEATURE_ERPLOG;
+		else if (len == 8 && !strncmp(str, "failfast", 8))
+			features |= DASD_FEATURE_FAILFAST;
 		else {
 			MESSAGE(KERN_WARNING,
 				"unsupported feature: %*s, "
@@ -667,6 +669,51 @@ dasd_device_from_cdev(struct ccw_device *cdev)
  */
 
 /*
+ * failfast controls the behaviour, if no path is available
+ */
+static ssize_t dasd_ff_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct dasd_devmap *devmap;
+	int ff_flag;
+
+	devmap = dasd_find_busid(dev->bus_id);
+	if (!IS_ERR(devmap))
+		ff_flag = (devmap->features & DASD_FEATURE_FAILFAST) != 0;
+	else
+		ff_flag = (DASD_FEATURE_DEFAULT & DASD_FEATURE_FAILFAST) != 0;
+	return snprintf(buf, PAGE_SIZE, ff_flag ? "1\n" : "0\n");
+}
+
+static ssize_t dasd_ff_store(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	int val;
+	char *endp;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (((endp + 1) < (buf + count)) || (val > 1))
+		return -EINVAL;
+
+	spin_lock(&dasd_devmap_lock);
+	if (val)
+		devmap->features |= DASD_FEATURE_FAILFAST;
+	else
+		devmap->features &= ~DASD_FEATURE_FAILFAST;
+	if (devmap->device)
+		devmap->device->features = devmap->features;
+	spin_unlock(&dasd_devmap_lock);
+	return count;
+}
+
+static DEVICE_ATTR(failfast, 0644, dasd_ff_show, dasd_ff_store);
+
+/*
  * readonly controls the readonly status of a dasd
  */
 static ssize_t
@@ -1020,6 +1067,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_use_diag.attr,
 	&dev_attr_eer_enabled.attr,
 	&dev_attr_erplog.attr,
+	&dev_attr_failfast.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 7844461..ef2a569 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -544,7 +544,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	}
 	cqr->retries = DIAG_MAX_RETRIES;
 	cqr->buildclk = get_clock();
-	if (blk_noretry_request(req))
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->startdev = memdev;
 	cqr->memdev = memdev;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bd2c52e..bdb8799 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1700,7 +1700,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 			recid++;
 		}
 	}
-	if (blk_noretry_request(req))
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->startdev = startdev;
 	cqr->memdev = startdev;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 7d442ae..f1d1760 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -355,7 +355,8 @@ static struct dasd_ccw_req *dasd_fba_build_cp(struct dasd_device * memdev,
 			recid++;
 		}
 	}
-	if (blk_noretry_request(req))
+	if (blk_noretry_request(req) ||
+	    block->base->features & DASD_FEATURE_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->startdev = memdev;
 	cqr->memdev = memdev;
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 6430338..0769ced 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -100,7 +100,7 @@ comment "S/390 tape interface support"
 
 config S390_TAPE_BLOCK
 	bool "Support for tape block devices"
-	depends on S390_TAPE
+	depends on S390_TAPE && BLOCK
 	help
 	  Select this option if you want to access your channel-attached tape
 	  devices using the block device interface.  This interface is similar
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index f8a3b69..da7afb0 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -169,6 +169,8 @@ static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
 		 q->nr);
 	debugfs_queues[i] = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
 						debugfs_root, q, &debugfs_fops);
+	if (IS_ERR(debugfs_queues[i]))
+		debugfs_queues[i] = NULL;
 }
 
 void qdio_setup_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
