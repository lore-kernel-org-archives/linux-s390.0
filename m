From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/10] KVM: s390: document KVM_CAP_S390_RI
Date: Mon,  9 May 2016 11:20:18 +0200
Message-ID: <1462785621-12600-8-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We forgot to document that capability, let's add documentation.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4d0542c..8cc857f 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3788,6 +3788,14 @@ a KVM_EXIT_IOAPIC_EOI vmexit will be reported to userspace.
 Fails if VCPU has already been created, or if the irqchip is already in the
 kernel (i.e. KVM_CREATE_IRQCHIP has already been called).
 
+7.6 KVM_CAP_S390_RI
+
+Architectures: s390
+Parameters: none
+
+Allows use of runtime-instrumentation introduced with zEC12 processor.
+Will return -EINVAL if the machine does not support runtime-instrumentation.
+Will return -EBUSY if a VCPU has already been created.
 
 8. Other capabilities.
 ----------------------
-- 
2.5.5
