From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] virtio/s390: keep early_put_chars
Date: Thu,  7 Jul 2016 17:07:56 +0200
Message-ID: <1467904077-1887-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

In case the registration of the hvc tty never happens AND the kernel
thinks that hvc0 is the preferred console we should keep the early
printk function to avoid a kernel panic due to code being removed.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/virtio/kvm_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
index 1d060fd..b0a849f 100644
--- a/drivers/s390/virtio/kvm_virtio.c
+++ b/drivers/s390/virtio/kvm_virtio.c
@@ -482,7 +482,7 @@ static int __init kvm_devices_init(void)
 }
 
 /* code for early console output with virtio_console */
-static __init int early_put_chars(u32 vtermno, const char *buf, int count)
+static int early_put_chars(u32 vtermno, const char *buf, int count)
 {
 	char scratch[17];
 	unsigned int len = count;
-- 
2.6.6
