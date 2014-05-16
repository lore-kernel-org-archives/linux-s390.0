From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/12] KVM: s390: Improve is_valid_psw()
Date: Fri, 16 May 2014 16:09:38 +0200
Message-ID: <1400249388-3969-3-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

As a program status word is also invalid (and thus generates an
specification exception) if the instruction address is not even,
we should test this in is_valid_psw(), too. This patch also exports
the function so that it becomes available for other parts of the
S390 KVM code as well.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h | 1 +
 arch/s390/kvm/priv.c     | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c28423a..38b589d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -142,6 +142,7 @@ void kvm_s390_reinject_io_int(struct kvm *kvm,
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
 
 /* implemented in priv.c */
+int is_valid_psw(psw_t *psw);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 07d0c10..d99f5f0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -365,7 +365,8 @@ static void handle_new_psw(struct kvm_vcpu *vcpu)
 #define PSW_ADDR_24 0x0000000000ffffffUL
 #define PSW_ADDR_31 0x000000007fffffffUL
 
-static int is_valid_psw(psw_t *psw) {
+int is_valid_psw(psw_t *psw)
+{
 	if (psw->mask & PSW_MASK_UNASSIGNED)
 		return 0;
 	if ((psw->mask & PSW_MASK_ADDR_MODE) == PSW_MASK_BA) {
@@ -376,6 +377,8 @@ static int is_valid_psw(psw_t *psw) {
 		return 0;
 	if ((psw->mask & PSW_MASK_ADDR_MODE) ==  PSW_MASK_EA)
 		return 0;
+	if (psw->addr & 1)
+		return 0;
 	return 1;
 }
 
-- 
1.8.4.2
