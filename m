From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Subject: [PATCH] Fixes: 805de8f43c20 (atomic: Replace atomic_{set,clear}_mask() usage)
Date: Wed, 16 Sep 2015 09:13:50 -0400
Message-ID: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, peterz@infradead.org, tglx@linutronix.de, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The offending commit accidentally replaces an atomic_clear with an
atomic_or instead of an atomic_andnot in kvm_s390_vcpu_request_handled.
The symptom is that kvm guests on s390 hang on startup.
This patch simply replaces the incorrect atomic_or with atomic_andnot

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c91eb94..49e76be 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1574,7 +1574,7 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
 {
-	atomic_or(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
+	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
 }
 
 /*
-- 
1.9.1
