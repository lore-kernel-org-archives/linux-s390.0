From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/12] KVM: s390: Use intercept_insn decoder in trace event
Date: Fri, 16 May 2014 16:09:45 +0200
Message-ID: <1400249388-3969-10-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

The current trace definition doesn't work very well with the perf tool.
Perf shows a "insn_to_mnemonic not found" message. Let's handle the
decoding completely in a parseable format.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/trace.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 00f57a5..579b42a 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -154,7 +154,6 @@ TRACE_EVENT(kvm_s390_intercept_instruction,
 	    TP_STRUCT__entry(
 		    VCPU_FIELD_COMMON
 		    __field(__u64, instruction)
-		    __field(char, insn[8])
 		    ),
 
 	    TP_fast_assign(
@@ -165,10 +164,8 @@ TRACE_EVENT(kvm_s390_intercept_instruction,
 
 	    VCPU_TP_PRINTK("intercepted instruction %016llx (%s)",
 			   __entry->instruction,
-			   insn_to_mnemonic((unsigned char *)
-					    &__entry->instruction,
-					 __entry->insn, sizeof(__entry->insn)) ?
-			   "unknown" : __entry->insn)
+			   __print_symbolic(icpt_insn_decoder(__entry->instruction),
+					    icpt_insn_codes))
 	);
 
 /*
-- 
1.8.4.2
