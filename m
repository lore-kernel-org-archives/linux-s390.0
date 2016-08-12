From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: reset KVM_REQ_MMU_RELOAD if mapping the prefix failed
Date: Fri, 12 Aug 2016 10:06:36 +0200
Message-ID: <1470989196-95234-3-git-send-email-borntraeger@de.ibm.com>
References: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1470989196-95234-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Julius Niedworok <jniedwor@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julius Niedworok <jniedwor@linux.vnet.ibm.com>

When triggering KVM_RUN without a user memory region being mapped
(KVM_SET_USER_MEMORY_REGION) a validity intercept occurs. This could
happen, if the user memory region was not mapped initially or if it
was unmapped after the vcpu is initialized. The function
kvm_s390_handle_requests checks for the KVM_REQ_MMU_RELOAD bit. The
check function always clears this bit. If gmap_mprotect_notify
returns an error code, the mapping failed, but the KVM_REQ_MMU_RELOAD
was not set anymore. So the next time kvm_s390_handle_requests is
called, the execution would fall trough the check for
KVM_REQ_MMU_RELOAD. The bit needs to be resetted, if
gmap_mprotect_notify returns an error code. Resetting the bit with
kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu) fixes the bug.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Julius Niedworok <jniedwor@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e63f6ed..f142215 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2362,8 +2362,10 @@ retry:
 		rc = gmap_mprotect_notify(vcpu->arch.gmap,
 					  kvm_s390_get_prefix(vcpu),
 					  PAGE_SIZE * 2, PROT_WRITE);
-		if (rc)
+		if (rc) {
+			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 			return rc;
+		}
 		goto retry;
 	}
 
-- 
2.5.5
