From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 4/4] KVM: s390: add clear I/O irq operation for FLIC
Date: Wed, 20 Apr 2016 14:54:56 +0200
Message-ID: <1461156896-27006-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461156896-27006-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, jfrei@linux.vnet.ibm.com, agraf@suse.de, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Introduce a FLIC operation for clearing I/O interrupts for a subchannel.

Rationale: According to the platform specification, pending I/O
interruption requests have to be revoked in certain situations. For
instance, according to the Principles of Operation (page 17-27), a
subchannel put into the installed parameters initialized state is in the
same state as after an I/O system reset (just parameters possibly changed).
This implies that any I/O interrupts for that subchannel are no longer
pending (as I/O system resets clear I/O interrupts). Therefore, we need an
interface to clear pending I/O interrupts.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt |  6 ++++++
 arch/s390/include/uapi/asm/kvm.h                |  1 +
 arch/s390/kvm/interrupt.c                       | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index 646f474..8478de1 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -11,6 +11,7 @@ FLIC provides support to
 - add interrupts (KVM_DEV_FLIC_ENQUEUE)
 - inspect currently pending interrupts (KVM_FLIC_GET_ALL_IRQS)
 - purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
+- purge one pending floating I/O interrupt (KVM_DEV_FLIC_CLEAR_IO_IRQ)
 - enable/disable for the guest transparent async page faults
 - register and modify adapter interrupt sources (KVM_DEV_FLIC_ADAPTER_*)
 
@@ -40,6 +41,11 @@ Groups:
     Simply deletes all elements from the list of currently pending floating
     interrupts.  No interrupts are injected into the guest.
 
+  KVM_DEV_FLIC_CLEAR_IO_IRQ
+    Deletes one (if any) I/O interrupt for a subchannel identified by the
+    subsystem identification word passed via the buffer specified by
+    attr->addr (address) and attr->attr (length).
+
   KVM_DEV_FLIC_APF_ENABLE
     Enables async page faults for the guest. So in case of a major page fault
     the host is allowed to handle this async and continues the guest.
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 347fe5a..3b8e99e 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -25,6 +25,7 @@
 #define KVM_DEV_FLIC_APF_DISABLE_WAIT	5
 #define KVM_DEV_FLIC_ADAPTER_REGISTER	6
 #define KVM_DEV_FLIC_ADAPTER_MODIFY	7
+#define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4c2cdb2..e550404 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2034,6 +2034,27 @@ static int modify_io_adapter(struct kvm_device *dev,
 	return ret;
 }
 
+static int clear_io_irq(struct kvm *kvm, struct kvm_device_attr *attr)
+
+{
+	const u64 isc_mask = 0xffUL << 24; /* all iscs set */
+	u32 schid;
+
+	if (attr->flags)
+		return -EINVAL;
+	if (attr->attr != sizeof(schid))
+		return -EINVAL;
+	if (copy_from_user(&schid, (void __user *) attr->addr, sizeof(schid)))
+		return -EFAULT;
+	kfree(kvm_s390_get_io_int(kvm, isc_mask, schid));
+	/*
+	 * If userspace is conforming to the architecture, we can have at most
+	 * one pending I/O interrupt per subchannel, so this is effectively a
+	 * clear all.
+	 */
+	return 0;
+}
+
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
@@ -2067,6 +2088,9 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	case KVM_DEV_FLIC_ADAPTER_MODIFY:
 		r = modify_io_adapter(dev, attr);
 		break;
+	case KVM_DEV_FLIC_CLEAR_IO_IRQ:
+		r = clear_io_irq(dev->kvm, attr);
+		break;
 	default:
 		r = -EINVAL;
 	}
@@ -2085,6 +2109,7 @@ static int flic_has_attr(struct kvm_device *dev,
 	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
 	case KVM_DEV_FLIC_ADAPTER_REGISTER:
 	case KVM_DEV_FLIC_ADAPTER_MODIFY:
+	case KVM_DEV_FLIC_CLEAR_IO_IRQ:
 		return 0;
 	}
 	return -ENXIO;
-- 
2.8.1
