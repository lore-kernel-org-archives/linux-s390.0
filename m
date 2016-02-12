From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/18] KVM: s390: bail out early on fatal signal in dirty logging
Date: Fri, 12 Feb 2016 14:23:02 +0100
Message-ID: <1455283382-62999-19-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

A KVM_GET_DIRTY_LOG ioctl might take a long time.
This can result in fatal signals seemingly being ignored.
Lets bail out during the dirty bit sync, if a fatal signal
is pending.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bb99ca2..28bd5ea 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -281,6 +281,8 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
 
 		if (gmap_test_and_clear_dirty(address, gmap))
 			mark_page_dirty(kvm, cur_gfn);
+		if (fatal_signal_pending(current))
+			return;
 		cond_resched();
 	}
 }
-- 
2.3.0
