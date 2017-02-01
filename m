From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/12] KVM: s390: prepare to read random guest instructions
Date: Wed,  1 Feb 2017 12:38:11 +0100
Message-ID: <1485949094-138708-10-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We will have to read instructions not residing at the current PSW
address.

Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h  | 9 +++++----
 arch/s390/kvm/kvm-s390.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 5c9cc18..7ce47fd 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -247,10 +247,11 @@ int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 /**
  * read_guest_instr - copy instruction data from guest space to kernel space
  * @vcpu: virtual cpu
+ * @ga: guest address
  * @data: destination address in kernel space
  * @len: number of bytes to copy
  *
- * Copy @len bytes from the current psw address (guest space) to @data (kernel
+ * Copy @len bytes from the given address (guest space) to @data (kernel
  * space).
  *
  * The behaviour of read_guest_instr is identical to read_guest, except that
@@ -258,10 +259,10 @@ int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
  * address-space mode.
  */
 static inline __must_check
-int read_guest_instr(struct kvm_vcpu *vcpu, void *data, unsigned long len)
+int read_guest_instr(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+		     unsigned long len)
 {
-	return access_guest(vcpu, vcpu->arch.sie_block->gpsw.addr, 0, data, len,
-			    GACC_IFETCH);
+	return access_guest(vcpu, ga, 0, data, len, GACC_IFETCH);
 }
 
 /**
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 69401b8..66e73f4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2588,7 +2588,7 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	 * to look up the current opcode to get the length of the instruction
 	 * to be able to forward the PSW.
 	 */
-	rc = read_guest_instr(vcpu, &opcode, 1);
+	rc = read_guest_instr(vcpu, vcpu->arch.sie_block->gpsw.addr, &opcode, 1);
 	ilen = insn_length(opcode);
 	if (rc < 0) {
 		return rc;
-- 
2.7.4
