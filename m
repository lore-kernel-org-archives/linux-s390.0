From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: Enable the KVM-VFIO device
Date: Tue, 26 Jan 2016 16:17:05 +0100
Message-ID: <1453821426-94778-3-git-send-email-borntraeger@de.ibm.com>
References: <1453821426-94778-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1453821426-94778-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

The KVM-VFIO device is used by the QEMU VFIO device. It is used to
record the list of in-use VFIO groups so that KVM can manipulate
them.
While we don't need this on s390 currently, let's try to be like
everyone else.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/Kconfig  | 1 +
 arch/s390/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 5fce52c..5ea5af3 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
 	select SRCU
+	select KVM_VFIO
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index b3b5534..d42fa38 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -7,7 +7,7 @@
 # as published by the Free Software Foundation.
 
 KVM := ../../../virt/kvm
-common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o
+common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
-- 
2.3.0
