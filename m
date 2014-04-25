From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 03/11] KVM: s390: decoder of SIE intercepted instructions
Date: Fri, 25 Apr 2014 11:12:25 +0200
Message-ID: <1398417153-57347-4-git-send-email-borntraeger@de.ibm.com>
References: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398417153-57347-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

This patch adds a new decoder of SIE intercepted instructions.

The decoder implemented as a macro and potentially can be used in
both kernelspace and userspace.

Note that this simplified instruction decoder is only intended to be
used with the subset of instructions that may cause a SIE intercept.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/sie.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index 5f942a2..30e8ee7 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -209,4 +209,37 @@
 	{ 0x40, "I/O instruction" },				\
 	{ 0x48, "Timing subset" }
 
+/*
+ * This is the simple interceptable instructions decoder.
+ *
+ * It will be used as userspace interface and it can be used in places
+ * that does not allow to use general decoder functions,
+ * such as trace events declarations.
+ *
+ * Some userspace tools may want to parse this code
+ * and would be confused by switch(), if() and other statements,
+ * but they can understand conditional operator.
+ */
+#define INSN_DECODE_IPA0(ipa0, insn, rshift, mask)               \
+	(insn >> 56) == (ipa0) ?				 \
+		((ipa0 << 8) | ((insn >> rshift) & mask)) :
+
+#define INSN_DECODE(insn) (insn >> 56)
+
+/*
+ * The macro icpt_insn_decoder() takes an intercepted instruction
+ * and returns a key, which can be used to find a mnemonic name
+ * of the instruction in the icpt_insn_codes table.
+ */
+#define icpt_insn_decoder(insn)			\
+	INSN_DECODE_IPA0(0x01, insn, 48, 0xff)	\
+	INSN_DECODE_IPA0(0xaa, insn, 48, 0x0f)	\
+	INSN_DECODE_IPA0(0xb2, insn, 48, 0xff)	\
+	INSN_DECODE_IPA0(0xb9, insn, 48, 0xff)	\
+	INSN_DECODE_IPA0(0xe3, insn, 48, 0xff)	\
+	INSN_DECODE_IPA0(0xe5, insn, 48, 0xff)	\
+	INSN_DECODE_IPA0(0xeb, insn, 16, 0xff)	\
+	INSN_DECODE_IPA0(0xc8, insn, 48, 0x0f)	\
+	INSN_DECODE(insn)
+
 #endif /* _UAPI_ASM_S390_SIE_H */
-- 
1.8.4.2
