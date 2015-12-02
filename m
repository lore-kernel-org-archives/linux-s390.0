From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/23] KVM: s390: don't switch to ESCA for ucontrol
Date: Wed,  2 Dec 2015 12:06:19 +0100
Message-ID: <1449054384-76374-19-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

sca_add_vpcu is not called for ucontrol guests. We must also not
apply the sca checking for sca_can_add_vcpu as ucontrol guests
do not have to follow the sca limits.

As common code already checks that id < KVM_MAX_VCPUS all other
data structures are safe as well.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d9d71bb..539d385 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1588,7 +1588,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	struct sie_page *sie_page;
 	int rc = -EINVAL;
 
-	if (!sca_can_add_vcpu(kvm, id))
+	if (!kvm_is_ucontrol(kvm) && !sca_can_add_vcpu(kvm, id))
 		goto out;
 
 	rc = -ENOMEM;
-- 
2.3.0
