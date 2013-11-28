From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 2/9] KVM: s390: Removed VIRTIODESCSPACE
Date: Thu, 28 Nov 2013 15:06:51 +0100
Message-ID: <1385647618-15541-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

VIRTIODESCSPACE is completely unused nowadays and thus can be removed
without any problems.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index aad541f..fcd25b4 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -19,9 +19,6 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 
-/* The current code can have up to 256 pages for virtio */
-#define VIRTIODESCSPACE (256ul * 4096ul)
-
 typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 
 /* declare vfacilities extern */
-- 
1.7.9.5
