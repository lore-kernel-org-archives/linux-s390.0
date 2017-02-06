From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/14] KVM: s390: Disable dirty log retrieval for UCONTROL guests
Date: Mon,  6 Feb 2017 12:46:31 +0100
Message-ID: <1486381592-12949-2-git-send-email-borntraeger@de.ibm.com>
References: <1486381592-12949-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1486381592-12949-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, stable@vger.kernel.org#3.16+
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

User controlled KVM guests do not support the dirty log, as they have
no single gmap that we can check for changes.

As they have no single gmap, kvm->arch.gmap is NULL and all further
referencing to it for dirty checking will result in a NULL
dereference.

Let's return -EINVAL if a caller tries to sync dirty logs for a
UCONTROL guest.

Fixes: 15f36eb ("KVM: s390: Add proper dirty bitmap support to S390 kvm.")
Cc: <stable@vger.kernel.org> # 3.16+

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reported-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dabd3b15..502de74 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -442,6 +442,9 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 	struct kvm_memory_slot *memslot;
 	int is_dirty = 0;
 
+	if (kvm_is_ucontrol(kvm))
+		return -EINVAL;
+
 	mutex_lock(&kvm->slots_lock);
 
 	r = -EINVAL;
-- 
2.7.4
