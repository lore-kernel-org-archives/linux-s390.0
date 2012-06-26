From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 6/6] KVM: s390: Fix sigp sense handling.
Date: Tue, 26 Jun 2012 16:06:41 +0200
Message-ID: <1340719601-11867-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

If sigp sense doesn't have any status bits to report, it should set
cc 0 and leave the register as-is.

Since we know about the external call pending bit, we should report
it if it is set as well.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/sigp.h |    1 +
 arch/s390/kvm/sigp.c         |   14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index 7306270..5a87d16 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -24,6 +24,7 @@
 
 #define SIGP_STATUS_CHECK_STOP		0x00000010UL
 #define SIGP_STATUS_STOPPED		0x00000040UL
+#define SIGP_STATUS_EXT_CALL_PENDING	0x00000080UL
 #define SIGP_STATUS_INVALID_PARAMETER	0x00000100UL
 #define SIGP_STATUS_INCORRECT_STATE	0x00000200UL
 #define SIGP_STATUS_NOT_RUNNING		0x00000400UL
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 97c9f36..6ed8175 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -32,12 +32,16 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	if (fi->local_int[cpu_addr] == NULL)
 		rc = SIGP_CC_NOT_OPERATIONAL;
 	else if (!(atomic_read(fi->local_int[cpu_addr]->cpuflags)
-		  & CPUSTAT_STOPPED)) {
-		*reg &= 0xffffffff00000000UL;
-		rc = SIGP_CC_STATUS_STORED;
-	} else {
+		   & (CPUSTAT_ECALL_PEND | CPUSTAT_STOPPED)))
+		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
+	else {
 		*reg &= 0xffffffff00000000UL;
-		*reg |= SIGP_STATUS_STOPPED;
+		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
+		    & CPUSTAT_ECALL_PEND)
+			*reg |= SIGP_STATUS_EXT_CALL_PENDING;
+		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
+		    & CPUSTAT_STOPPED)
+			*reg |= SIGP_STATUS_STOPPED;
 		rc = SIGP_CC_STATUS_STORED;
 	}
 	spin_unlock(&fi->lock);
-- 
1.7.10.4
