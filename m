From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390/facilities: allow TOD-CLOCK steering facility bit
Date: Wed,  1 Oct 2014 16:02:49 +0200
Message-ID: <1412172170-13472-2-git-send-email-borntraeger@de.ibm.com>
References: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There is nothing to do for KVM to support TOD-CLOCK steering.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 56a411c..0d5aa88 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1786,7 +1786,7 @@ static int __init kvm_s390_init(void)
 		return -ENOMEM;
 	}
 	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
-	vfacilities[0] &= 0xff82fff3f4fc2000UL;
+	vfacilities[0] &= 0xff82fffbf47c2000UL;
 	vfacilities[1] &= 0x005c000000000000UL;
 	return 0;
 }
-- 
1.9.3
