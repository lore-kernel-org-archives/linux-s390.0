Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/12] KVM: s390: provide query function for instructions returning 32 byte
Date: Mon, 29 Apr 2019 11:09:55 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-6-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some of the new features have a 32byte response for the query function.
Provide a new wrapper similar to __cpacf_query. We might want to factor
this out if other users come up, as of today there is none. So let us
keep the function within KVM.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0dad61ccde3d..336e591d94eb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -321,6 +321,19 @@ static inline int plo_test_bit(unsigned char nr)
 	return cc == 0;
 }
 
+static inline void __insn32_query(unsigned int opcode, u8 query[32])
+{
+	register unsigned long r0 asm("0") = 0;	/* query function */
+	register unsigned long r1 asm("1") = (unsigned long) query;
+
+	asm volatile(
+		/* Parameter regs are ignored */
+		"	.insn	rrf,%[opc] << 16,2,4,6,0\n"
+		: "=m" (*query)
+		: "d" (r0), "a" (r1), [opc] "i" (opcode)
+		: "cc");
+}
+
 static void kvm_s390_cpu_feat_init(void)
 {
 	int i;
-- 
2.19.1
