From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/23] KVM: s390: Generalize access to IPTE controls
Date: Wed,  2 Dec 2015 12:06:07 +0100
Message-ID: <1449054384-76374-7-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

This patch generalizes access to the IPTE controls, which is a part of SCA.
This is to prepare for upcoming introduction of Extended SCA support.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c  | 10 +++++-----
 arch/s390/kvm/kvm-s390.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index a7559f7..06f7edb 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -259,7 +259,7 @@ struct aste {
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
-	union ipte_control *ic = &vcpu->kvm->arch.sca->ipte_control;
+	union ipte_control *ic = kvm_s390_get_ipte_control(vcpu->kvm);
 
 	if (vcpu->arch.sie_block->eca & 1)
 		return ic->kh != 0;
@@ -274,7 +274,7 @@ static void ipte_lock_simple(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.ipte_lock_count++;
 	if (vcpu->kvm->arch.ipte_lock_count > 1)
 		goto out;
-	ic = &vcpu->kvm->arch.sca->ipte_control;
+	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
 		while (old.k) {
@@ -296,7 +296,7 @@ static void ipte_unlock_simple(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.ipte_lock_count--;
 	if (vcpu->kvm->arch.ipte_lock_count)
 		goto out;
-	ic = &vcpu->kvm->arch.sca->ipte_control;
+	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
 		new = old;
@@ -311,7 +311,7 @@ static void ipte_lock_siif(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
-	ic = &vcpu->kvm->arch.sca->ipte_control;
+	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
 		while (old.kg) {
@@ -328,7 +328,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 {
 	union ipte_control old, new, *ic;
 
-	ic = &vcpu->kvm->arch.sca->ipte_control;
+	ic = kvm_s390_get_ipte_control(vcpu->kvm);
 	do {
 		old = READ_ONCE(*ic);
 		new = old;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1e70e00..844f711 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -340,4 +340,9 @@ void kvm_s390_clear_bp_data(struct kvm_vcpu *vcpu);
 void kvm_s390_prepare_debug_exit(struct kvm_vcpu *vcpu);
 void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
 
+/* support for Basic/Extended SCA handling */
+static inline union ipte_control *kvm_s390_get_ipte_control(struct kvm *kvm)
+{
+	return &kvm->arch.sca->ipte_control;
+}
 #endif
-- 
2.3.0
