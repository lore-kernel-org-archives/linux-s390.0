Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: fix typo in parameter description
Date: Mon, 20 May 2019 12:30:54 +0200
In-Reply-To: <20190520103055.246818-1-borntraeger@de.ibm.com>
References: <20190520103055.246818-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190520103055.246818-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix typo in parameter description.

Fixes: 8b905d28ee17 ("KVM: s390: provide kvm_arch_no_poll function")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Message-Id: <20190504065145.53665-1-weiyongjun1@huawei.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8d6d75db8de6..ac6163c334d6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -181,7 +181,7 @@ MODULE_PARM_DESC(hpage, "1m huge page backing support");
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
-MODULE_PARM_DESC(hpage, "Maximum percentage of steal time to allow polling");
+MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
 
 /*
  * For now we handle at most 16 double words as this is what the s390 base
-- 
2.21.0
