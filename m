From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 3/8] KVM: s390: Simplify online vcpus counting for stsi
Date: Tue,  4 Mar 2014 12:27:13 +0100
Message-ID: <1393932438-58848-4-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

We don't need to loop over all cpus to get the number of
vcpus. Let's use the available counter online_vcpus instead.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 75beea6..ae9e8ee 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -396,15 +396,10 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 
 static void handle_stsi_3_2_2(struct kvm_vcpu *vcpu, struct sysinfo_3_2_2 *mem)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	int cpus = 0;
 	int n;
 
-	spin_lock(&fi->lock);
-	for (n = 0; n < KVM_MAX_VCPUS; n++)
-		if (fi->local_int[n])
-			cpus++;
-	spin_unlock(&fi->lock);
+	cpus = atomic_read(&vcpu->kvm->online_vcpus);
 
 	/* deal with other level 3 hypervisors */
 	if (stsi(mem, 3, 2, 2))
-- 
1.8.4.2
