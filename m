Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: change default halt poll time to 50us
Date: Mon, 20 May 2019 12:30:55 +0200
In-Reply-To: <20190520103055.246818-1-borntraeger@de.ibm.com>
References: <20190520103055.246818-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190520103055.246818-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Recent measurements indicate that using 50us results in a reduced CPU
consumption, while still providing the benefit of halt polling. Let's
use 50us instead.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index bdbc81b5bc91..2b00a3ebee08 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -36,7 +36,7 @@
  */
 #define KVM_NR_IRQCHIPS 1
 #define KVM_IRQCHIP_NUM_PINS 4096
-#define KVM_HALT_POLL_NS_DEFAULT 80000
+#define KVM_HALT_POLL_NS_DEFAULT 50000
 
 /* s390-specific vcpu->requests bit members */
 #define KVM_REQ_ENABLE_IBS	KVM_ARCH_REQ(0)
-- 
2.21.0
