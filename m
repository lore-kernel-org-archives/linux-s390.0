From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/7] KVM: s390: reenable LPP facility
Date: Mon,  9 Feb 2015 13:33:42 +0100
Message-ID: <1423485227-51721-3-git-send-email-borntraeger@de.ibm.com>
References: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 7be81a46695d ("KVM: s390/facilities: allow TOD-CLOCK steering
facility bit") accidentially disabled the "load program parameter"
facility bit during rebase for upstream submission (my fault).

Re-add that bit.

As this is only for a performance measurement helper instruction
(used by KVM itself) cc stable is not necessary see
http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a
(SA23-2260 The Load-Program-Parameter and CPU-Measurement Facilities)
for details about LPP and its usecase.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Fixes: 7be81a46695d ("KVM: s390/facilities: allow TOD-CLOCK steering")
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1dbab23..3acf08b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2074,7 +2074,7 @@ static int __init kvm_s390_init(void)
 		return -ENOMEM;
 	}
 	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
-	vfacilities[0] &= 0xff82fffbf47c2000UL;
+	vfacilities[0] &= 0xff82fffbf4fc2000UL;
 	vfacilities[1] &= 0x005c000000000000UL;
 	return 0;
 }
-- 
1.9.3
