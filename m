From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 22/23] KVM: s390: remove pointless test_facility(2) check
Date: Wed,  2 Dec 2015 12:06:23 +0100
Message-ID: <1449054384-76374-23-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This evaluates always to 'true'.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 49d3319..77724ce 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1027,7 +1027,7 @@ static int kvm_s390_apxa_installed(void)
 	u8 config[128];
 	int cc;
 
-	if (test_facility(2) && test_facility(12)) {
+	if (test_facility(12)) {
 		cc = kvm_s390_query_ap_config(config);
 
 		if (cc)
-- 
2.3.0
