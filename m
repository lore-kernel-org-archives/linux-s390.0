Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/12] KVM: s390: Fix potential spectre warnings
Date: Mon, 29 Apr 2019 11:09:51 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

Fix some warnings from smatch:

arch/s390/kvm/interrupt.c:2310 get_io_adapter() warn: potential spectre issue 'kvm->arch.adapters' [r] (local cap)
arch/s390/kvm/interrupt.c:2341 register_io_adapter() warn: potential spectre issue 'dev->kvm->arch.adapters' [w]

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190417005414.47801-1-farman@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 82162867f378..bfd55ad34a3e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -14,6 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/hrtimer.h>
 #include <linux/mmu_context.h>
+#include <linux/nospec.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
@@ -2307,6 +2308,7 @@ static struct s390_io_adapter *get_io_adapter(struct kvm *kvm, unsigned int id)
 {
 	if (id >= MAX_S390_IO_ADAPTERS)
 		return NULL;
+	id = array_index_nospec(id, MAX_S390_IO_ADAPTERS);
 	return kvm->arch.adapters[id];
 }
 
@@ -2320,8 +2322,13 @@ static int register_io_adapter(struct kvm_device *dev,
 			   (void __user *)attr->addr, sizeof(adapter_info)))
 		return -EFAULT;
 
-	if ((adapter_info.id >= MAX_S390_IO_ADAPTERS) ||
-	    (dev->kvm->arch.adapters[adapter_info.id] != NULL))
+	if (adapter_info.id >= MAX_S390_IO_ADAPTERS)
+		return -EINVAL;
+
+	adapter_info.id = array_index_nospec(adapter_info.id,
+					     MAX_S390_IO_ADAPTERS);
+
+	if (dev->kvm->arch.adapters[adapter_info.id] != NULL)
 		return -EINVAL;
 
 	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
-- 
2.19.1
