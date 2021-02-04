Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] KVM: s390: Return the correct errno code
Date: Thu, 4 Feb 2021 16:05:23 +0800
Message-ID: <20210204080523.18943-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, Zheng Yongjun <zhengyongjun3@huawei.com>

When valloc failed, should return ENOMEM rather than ENOBUF.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2f177298c663..6b7acc27cfa2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2252,7 +2252,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 	 */
 	buf = vzalloc(len);
 	if (!buf)
-		return -ENOBUFS;
+		return -ENOMEM;
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
-- 
2.22.0
