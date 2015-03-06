From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/20] KVM: s390: fix instruction interception trace point
Date: Fri,  6 Mar 2015 14:16:46 +0100
Message-ID: <1425647812-61838-15-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

trace-cmd fails to parse the instruction interception trace point:
  "Error: expected type 5 but read 4
   failed to read event print fmt for kvm_s390_intercept_instruction"
The result is an unformatted string in the output, with a warning:
  "kvm_s390_intercept_instruction: [FAILED TO PARSE]..."

So let's add parentheses around the instruction parser macro to fix the format
parsing.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/sie.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index d4096fd..ee69c08 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -230,7 +230,7 @@
  * and returns a key, which can be used to find a mnemonic name
  * of the instruction in the icpt_insn_codes table.
  */
-#define icpt_insn_decoder(insn)			\
+#define icpt_insn_decoder(insn) (		\
 	INSN_DECODE_IPA0(0x01, insn, 48, 0xff)	\
 	INSN_DECODE_IPA0(0xaa, insn, 48, 0x0f)	\
 	INSN_DECODE_IPA0(0xb2, insn, 48, 0xff)	\
@@ -239,6 +239,6 @@
 	INSN_DECODE_IPA0(0xe5, insn, 48, 0xff)	\
 	INSN_DECODE_IPA0(0xeb, insn, 16, 0xff)	\
 	INSN_DECODE_IPA0(0xc8, insn, 48, 0x0f)	\
-	INSN_DECODE(insn)
+	INSN_DECODE(insn))
 
 #endif /* _UAPI_ASM_S390_SIE_H */
-- 
2.3.0
