From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: set halt polling to 80 microseconds
Date: Fri, 13 May 2016 12:16:36 +0200
Message-ID: <1463134596-19470-3-git-send-email-borntraeger@de.ibm.com>
References: <1463134596-19470-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1463134596-19470-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

on s390 we disabled the halt polling with commit 920552b213e3
("KVM: disable halt_poll_ns as default for s390x"), as floating
interrupts would let all CPUs have a successful poll, resulting
in much higher CPU usage (on otherwise idle systems).

With the improved selection of polls we can now retry halt polling.
Performance measurements with different choices like 25,50,80,100,200
microseconds showed that 80 microseconds seems to improve several cases
without increasing the CPU costs too much. Higher values would improve
the performance even more but increased the cpu time as well.
So let's start small and use this value of 80 microseconds on s390 until
we have a better understanding of cost/benefit of higher values.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 53d7945..37b9017 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -38,7 +38,7 @@
  */
 #define KVM_NR_IRQCHIPS 1
 #define KVM_IRQCHIP_NUM_PINS 4096
-#define KVM_HALT_POLL_NS_DEFAULT 0
+#define KVM_HALT_POLL_NS_DEFAULT 80000
 
 /* s390-specific vcpu->requests bit members */
 #define KVM_REQ_ENABLE_IBS         8
-- 
2.5.5
