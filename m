From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] kvm/s390: drop unpaired smp_mb
Date: Fri,  8 Jan 2016 10:14:37 +0100
Message-ID: <1452244478-151381-2-git-send-email-borntraeger@de.ibm.com>
References: <1452244478-151381-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1452244478-151381-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

smp_mb on vcpu destroy isn't paired with anything, violating pairing
rules, and seems to be useless.

Drop it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <1452010811-25486-1-git-send-email-mst@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 940e9ff..9f8eea3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1221,7 +1221,6 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		sca_del_vcpu(vcpu);
-	smp_mb();
 
 	if (kvm_is_ucontrol(vcpu->kvm))
 		gmap_free(vcpu->arch.gmap);
-- 
2.3.0
