From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] KVM: s390: kvm/sigp.c: fix memory leakage
Date: Tue, 15 Jan 2013 11:17:29 +0100
Message-ID: <1358245049-37155-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1358245049-37155-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358245049-37155-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cong Ding <dinggnu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cong Ding <dinggnu@gmail.com>

the variable inti should be freed in the branch CPUSTAT_STOPPED.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 461e841..1c48ab2 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -137,8 +137,10 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	inti->type = KVM_S390_SIGP_STOP;
 
 	spin_lock_bh(&li->lock);
-	if ((atomic_read(li->cpuflags) & CPUSTAT_STOPPED))
+	if ((atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
+		kfree(inti);
 		goto out;
+	}
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
 	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
-- 
1.7.12.4
