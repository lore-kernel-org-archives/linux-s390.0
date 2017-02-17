From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/2] s390/smp: export smp_send_reschedule
Date: Fri, 17 Feb 2017 14:10:06 +0100
Message-ID: <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

needed by KVM common code.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 4c9ebb3..a4d7124 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -513,6 +513,7 @@ void smp_send_reschedule(int cpu)
 {
 	pcpu_ec_call(pcpu_devices + cpu, ec_schedule);
 }
+EXPORT_SYMBOL_GPL(smp_send_reschedule);
 
 /*
  * parameter area for the set/clear control bit callbacks
-- 
2.7.4
