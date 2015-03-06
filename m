From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/20] KVM: s390: Fix trivial typo in comments
Date: Fri,  6 Mar 2015 14:16:45 +0100
Message-ID: <1425647812-61838-14-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Yannick Guerrini <yguerrini@tomshardware.fr>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Yannick Guerrini <yguerrini@tomshardware.fr>

Change 'architecuture' to 'architecture'

Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>
Message-Id: <1424989004-14412-1-git-send-email-yguerrini@tomshardware.fr>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 267523c..633fe9b 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -333,7 +333,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  * @write: indicates if access is a write access
  *
  * Translate a guest virtual address into a guest absolute address by means
- * of dynamic address translation as specified by the architecuture.
+ * of dynamic address translation as specified by the architecture.
  * If the resulting absolute address is not available in the configuration
  * an addressing exception is indicated and @gpa will not be changed.
  *
-- 
2.3.0
