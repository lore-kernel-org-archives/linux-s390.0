From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: return -EFAULT if copy_from_user() fails
Date: Tue,  6 May 2014 15:58:27 +0200
Message-ID: <1399384709-21339-2-git-send-email-borntraeger@de.ibm.com>
References: <1399384709-21339-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1399384709-21339-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dan Carpenter <dan.carpenter@oracle.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

When copy_from_user() fails, this code returns the number of bytes
remaining instead of a negative error code.  The positive number is
returned to the user but otherwise it is harmless.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 757ccef..3e8d409 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -223,9 +223,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 		goto error;
 	}
 
-	ret = copy_from_user(bp_data, dbg->arch.hw_bp, size);
-	if (ret)
+	if (copy_from_user(bp_data, dbg->arch.hw_bp, size)) {
+		ret = -EFAULT;
 		goto error;
+	}
 
 	for (i = 0; i < dbg->arch.nr_hw_bp; i++) {
 		switch (bp_data[i].type) {
-- 
1.8.4.2
