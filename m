From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/9] KVM: s390: introduce adapter interrupt inject function
Date: Fri,  7 Apr 2017 12:48:01 +0200
Message-ID: <1491562082-6392-9-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Inject adapter interrupts on a specified adapter which allows to
retrieve the adapter flags, e.g. if the adapter is subject to AIS
facility or not. And add documentation for this interface.

For adapters subject to AIS, handle the airq injection suppression
for a given ISC according to the interruption mode:
- before injection, if NO-Interruptions Mode, just return 0 and
  suppress, otherwise, allow the injection.
- after injection, if SINGLE-Interruption Mode, change it to
  NO-Interruptions Mode to suppress the following interrupts.

Besides, add tracepoint for suppressed airq and AIS mode transitions.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt |  9 +++++
 arch/s390/include/uapi/asm/kvm.h                |  1 +
 arch/s390/kvm/interrupt.c                       | 53 ++++++++++++++++++++++---
 arch/s390/kvm/trace-s390.h                      | 21 ++++++++++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index dfd42fd..c2518ce 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -15,6 +15,7 @@ FLIC provides support to
 - enable/disable for the guest transparent async page faults
 - register and modify adapter interrupt sources (KVM_DEV_FLIC_ADAPTER_*)
 - modify AIS (adapter-interruption-suppression) mode state (KVM_DEV_FLIC_AISM)
+- inject adapter interrupts on a specified adapter (KVM_DEV_FLIC_AIRQ_INJECT)
 
 Groups:
   KVM_DEV_FLIC_ENQUEUE
@@ -127,6 +128,14 @@ struct kvm_s390_ais_req {
       will be suppressed until the mode is set again to ALL-Interruptions
       or SINGLE-Interruption mode.
 
+  KVM_DEV_FLIC_AIRQ_INJECT
+    Inject adapter interrupts on a specified adapter.
+    attr->attr contains the unique id for the adapter, which allows for
+    adapter-specific checks and actions.
+    For adapters subject to AIS, handle the airq injection suppression for
+    an isc according to the adapter-interruption-suppression mode on condition
+    that the AIS capability is enabled.
+
 Note: The KVM_SET_DEVICE_ATTR/KVM_GET_DEVICE_ATTR device ioctls executed on
 FLIC with an unknown group or attribute gives the error code EINVAL (instead of
 ENXIO, as specified in the API documentation). It is not possible to conclude
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 50d2a92..2c9ad25 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -27,6 +27,7 @@
 #define KVM_DEV_FLIC_ADAPTER_MODIFY	7
 #define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
 #define KVM_DEV_FLIC_AISM		9
+#define KVM_DEV_FLIC_AIRQ_INJECT	10
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 96b689e..482673e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2191,6 +2191,48 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+static int kvm_s390_inject_airq(struct kvm *kvm,
+				struct s390_io_adapter *adapter)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct kvm_s390_interrupt s390int = {
+		.type = KVM_S390_INT_IO(1, 0, 0, 0),
+		.parm = 0,
+		.parm64 = (adapter->isc << 27) | 0x80000000,
+	};
+	int ret = 0;
+
+	if (!fi->ais_enabled || !adapter->suppressible)
+		return kvm_s390_inject_vm(kvm, &s390int);
+
+	mutex_lock(&fi->ais_lock);
+	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
+		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
+		goto out;
+	}
+
+	ret = kvm_s390_inject_vm(kvm, &s390int);
+	if (!ret && (fi->simm & AIS_MODE_MASK(adapter->isc))) {
+		fi->nimm |= AIS_MODE_MASK(adapter->isc);
+		trace_kvm_s390_modify_ais_mode(adapter->isc,
+					       KVM_S390_AIS_MODE_SINGLE, 2);
+	}
+out:
+	mutex_unlock(&fi->ais_lock);
+	return ret;
+}
+
+static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	unsigned int id = attr->attr;
+	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
+
+	if (!adapter)
+		return -EINVAL;
+
+	return kvm_s390_inject_airq(kvm, adapter);
+}
+
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
@@ -2230,6 +2272,9 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	case KVM_DEV_FLIC_AISM:
 		r = modify_ais_mode(dev->kvm, attr);
 		break;
+	case KVM_DEV_FLIC_AIRQ_INJECT:
+		r = flic_inject_airq(dev->kvm, attr);
+		break;
 	default:
 		r = -EINVAL;
 	}
@@ -2250,6 +2295,7 @@ static int flic_has_attr(struct kvm_device *dev,
 	case KVM_DEV_FLIC_ADAPTER_MODIFY:
 	case KVM_DEV_FLIC_CLEAR_IO_IRQ:
 	case KVM_DEV_FLIC_AISM:
+	case KVM_DEV_FLIC_AIRQ_INJECT:
 		return 0;
 	}
 	return -ENXIO;
@@ -2360,12 +2406,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	ret = adapter_indicators_set(kvm, adapter, &e->adapter);
 	up_read(&adapter->maps_lock);
 	if ((ret > 0) && !adapter->masked) {
-		struct kvm_s390_interrupt s390int = {
-			.type = KVM_S390_INT_IO(1, 0, 0, 0),
-			.parm = 0,
-			.parm64 = (adapter->isc << 27) | 0x80000000,
-		};
-		ret = kvm_s390_inject_vm(kvm, &s390int);
+		ret = kvm_s390_inject_airq(kvm, adapter);
 		if (ret == 0)
 			ret = 1;
 	}
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index b32994d..78b7e84 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -311,6 +311,27 @@ TRACE_EVENT(kvm_s390_modify_ais_mode,
 		      "Single-Interruption Mode" : "No-Interruptions Mode")
 	);
 
+/*
+ * Trace point for suppressed adapter I/O interrupt.
+ */
+TRACE_EVENT(kvm_s390_airq_suppressed,
+	    TP_PROTO(__u32 id, __u8 isc),
+	    TP_ARGS(id, isc),
+
+	    TP_STRUCT__entry(
+		    __field(__u32, id)
+		    __field(__u8, isc)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->id = id;
+		    __entry->isc = isc;
+		    ),
+
+	    TP_printk("adapter I/O interrupt suppressed (id:%x isc:%x)",
+		      __entry->id, __entry->isc)
+	);
+
 
 #endif /* _TRACE_KVMS390_H */
 
-- 
2.7.4
