From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 11/11] KVM: s390: Enable KVM_CAP_NR_MEMSLOTS on s390
Date: Mon, 25 Mar 2013 17:22:58 +0100
Message-ID: <1364228578-20528-12-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Nick Wang <jfwang@us.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Nick Wang <jfwang@us.ibm.com>

Return KVM_USER_MEM_SLOTS in kvm_dev_ioctl_check_extension().

Signed-off-by: Nick Wang <jfwang@us.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b322ff1..c1c7c68 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -149,6 +149,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
 		break;
+	case KVM_CAP_NR_MEMSLOTS:
+		r = KVM_USER_MEM_SLOTS;
+		break;
 	case KVM_CAP_S390_COW:
 		r = MACHINE_HAS_ESOP;
 		break;
-- 
1.7.12.4
