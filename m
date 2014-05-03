From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] KVM: s390: return -EFAULT if copy_from_user() fails
Date: Sat, 3 May 2014 23:18:11 +0300
Message-ID: <20140503201811.GA32753@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux390@de.ibm.com, Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When copy_from_user() fails, this code returns the number of bytes
remaining instead of a negative error code.  The positive number is
returned to the user but otherwise it is harmless.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I am not able to compile this.

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
