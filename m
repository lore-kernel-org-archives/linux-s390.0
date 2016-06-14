From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 24/52] KVM: s390: enable CMMA if the interpration is available
Date: Tue, 14 Jun 2016 20:57:01 +0200
Message-ID: <201606141857.u5EIs0B2036530@mx0b-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Now that we can detect if collaborative-memory-management interpretation
is available, replace the heuristic by a real hardware detection.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e477c8e..005e664 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -485,9 +485,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	unsigned int idx;
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_ENABLE_CMMA:
-		/* enable CMMA only for z10 and later (EDAT_1) */
 		ret = -EINVAL;
-		if (!MACHINE_IS_LPAR || !MACHINE_HAS_EDAT1)
+		if (!sclp.has_cmma)
 			break;
 
 		ret = -EBUSY;
-- 
2.5.5
