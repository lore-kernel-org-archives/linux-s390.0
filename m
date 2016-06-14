From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/52] KVM: s390: Add mnemonic print to kvm_s390_intercept_prog
Date: Tue, 14 Jun 2016 20:56:45 +0200
Message-ID: <1465930649-181383-9-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

We have a table of mnemonic names for intercepted program
interruptions, let's print readable name of the interruption in the
kvm_s390_intercept_prog trace event.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/trace.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index a429ef9..1c4586b 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -185,8 +185,10 @@ TRACE_EVENT(kvm_s390_intercept_prog,
 		    __entry->code = code;
 		    ),
 
-	    VCPU_TP_PRINTK("intercepted program interruption %04x",
-			   __entry->code)
+	    VCPU_TP_PRINTK("intercepted program interruption %04x (%s)",
+			   __entry->code,
+			   __print_symbolic(__entry->code,
+					    icpt_prog_codes))
 	);
 
 /*
-- 
2.5.5
