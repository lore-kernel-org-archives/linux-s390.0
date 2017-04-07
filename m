From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/9] KVM: s390: interface for suppressible I/O adapters
Date: Fri,  7 Apr 2017 12:47:59 +0200
Message-ID: <1491562082-6392-7-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Fei Li <sherrylf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

In order to properly implement adapter-interruption suppression, we
need a way for userspace to specify which adapters are subject to
suppression. Let's convert the existing (and unused) 'pad' field into
a 'flags' field and define a flag value for suppressible adapters.

Besides, add documentation for the interface.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt | 12 +++++++++---
 arch/s390/include/asm/kvm_host.h                |  1 +
 arch/s390/include/uapi/asm/kvm.h                |  4 +++-
 arch/s390/kvm/interrupt.c                       |  2 ++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index 6b0e115..e8ee3b6 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -64,12 +64,18 @@ struct kvm_s390_io_adapter {
 	__u8 isc;
 	__u8 maskable;
 	__u8 swap;
-	__u8 pad;
+	__u8 flags;
 };
 
    id contains the unique id for the adapter, isc the I/O interruption subclass
-   to use, maskable whether this adapter may be masked (interrupts turned off)
-   and swap whether the indicators need to be byte swapped.
+   to use, maskable whether this adapter may be masked (interrupts turned off),
+   swap whether the indicators need to be byte swapped, and flags contains
+   further characteristics of the adapter.
+   Currently defined values for 'flags' are:
+   - KVM_S390_ADAPTER_SUPPRESSIBLE: adapter is subject to AIS
+     (adapter-interrupt-suppression) facility. This flag only has an effect if
+     the AIS capability is enabled.
+   Unknown flag values are ignored.
 
 
   KVM_DEV_FLIC_ADAPTER_MODIFY
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1af090d..499c72c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -621,6 +621,7 @@ struct s390_io_adapter {
 	bool maskable;
 	bool masked;
 	bool swap;
+	bool suppressible;
 	struct rw_semaphore maps_lock;
 	struct list_head maps;
 	atomic_t nr_maps;
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 5bd23cf..5fa144d 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -41,9 +41,11 @@ struct kvm_s390_io_adapter {
 	__u8 isc;
 	__u8 maskable;
 	__u8 swap;
-	__u8 pad;
+	__u8 flags;
 };
 
+#define KVM_S390_ADAPTER_SUPPRESSIBLE 0x01
+
 #define KVM_S390_IO_ADAPTER_MASK 1
 #define KVM_S390_IO_ADAPTER_MAP 2
 #define KVM_S390_IO_ADAPTER_UNMAP 3
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 311eef0..dba51ad 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1997,6 +1997,8 @@ static int register_io_adapter(struct kvm_device *dev,
 	adapter->maskable = adapter_info.maskable;
 	adapter->masked = false;
 	adapter->swap = adapter_info.swap;
+	adapter->suppressible = (adapter_info.flags) &
+				KVM_S390_ADAPTER_SUPPRESSIBLE;
 	dev->kvm->arch.adapters[adapter->id] = adapter;
 
 	return 0;
-- 
2.7.4
