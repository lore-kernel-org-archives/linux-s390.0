From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Sat, 21 Jan 2017 17:03:35 +0100
Message-ID: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 16:52:23 +0100

A local variable was set to an error code in two cases before a concrete
error situation was detected. Thus move the corresponding assignments into
if branches to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kvm/kvm-s390.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4f74511015b8..bc875d08b838 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -443,16 +443,17 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 	int is_dirty = 0;
 
 	mutex_lock(&kvm->slots_lock);
-
-	r = -EINVAL;
-	if (log->slot >= KVM_USER_MEM_SLOTS)
+	if (log->slot >= KVM_USER_MEM_SLOTS) {
+		r = -EINVAL;
 		goto out;
+	}
 
 	slots = kvm_memslots(kvm);
 	memslot = id_to_memslot(slots, log->slot);
-	r = -ENOENT;
-	if (!memslot->dirty_bitmap)
+	if (!memslot->dirty_bitmap) {
+		r = -ENOENT;
 		goto out;
+	}
 
 	kvm_s390_sync_dirty_log(kvm, memslot);
 	r = kvm_get_dirty_log(kvm, log, &is_dirty);
-- 
2.11.0
