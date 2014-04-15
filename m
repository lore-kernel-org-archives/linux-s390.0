From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 46/47] KVM: s390: replace TDB_ADDR by __LC_PGM_TDB
Date: Tue, 15 Apr 2014 14:00:49 +0200
Message-ID: <1397563250-3089-47-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The generically assembled low core labels already contain the
address for the TDB.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 3 ++-
 arch/s390/kvm/kvm-s390.h  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index f61c800..f391604 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 
 #include <asm/kvm_host.h>
+#include <asm/asm-offsets.h>
 
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -193,7 +194,7 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 	if (current->thread.per_flags & PER_FLAG_NO_TE)
 		goto skip_itdb;
 	itdb = (struct kvm_s390_itdb *)vcpu->arch.sie_block->itdba;
-	rc = write_guest_lc(vcpu, TDB_ADDR, itdb, sizeof(*itdb));
+	rc = write_guest_lc(vcpu, __LC_PGM_TDB, itdb, sizeof(*itdb));
 	if (rc)
 		return rc;
 	memset(itdb, 0, sizeof(*itdb));
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c93ed5f..9b5680d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -28,7 +28,6 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
 
 /* Transactional Memory Execution related macros */
 #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & 0x10))
-#define TDB_ADDR		0x1800UL
 #define TDB_FORMAT1		1
 #define IS_ITDB_VALID(vcpu)	((*(char *)vcpu->arch.sie_block->itdba == TDB_FORMAT1))
 
-- 
1.8.4.2
