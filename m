From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 4/7] s390: Move css limits from drivers/s390/cio/ to include/asm/.
Date: Tue,  7 Aug 2012 16:52:16 +0200
Message-ID: <1344351139-1793-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351139-1793-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351139-1793-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There's no need to keep __MAX_SUBCHANNEL and __MAX_SSID private to the
common I/O layer when __MAX_CSSID is usable by everybody.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/cio.h | 2 ++
 drivers/s390/cio/css.h      | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 77043aa..9b6cc82 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -9,6 +9,8 @@
 
 #define LPM_ANYPATH 0xff
 #define __MAX_CSSID 0
+#define __MAX_SUBCHANNEL 65535
+#define __MAX_SSID 3
 
 #include <asm/scsw.h>
 
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 33bb4d8..4af3dfe 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -112,9 +112,6 @@ extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 extern void css_reiterate_subchannels(void);
 void css_update_ssd_info(struct subchannel *sch);
 
-#define __MAX_SUBCHANNEL 65535
-#define __MAX_SSID 3
-
 struct channel_subsystem {
 	u8 cssid;
 	int valid;
-- 
1.7.11.4
