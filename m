From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/3] s390/ccwdev: Include asm/schid.h.
Date: Fri, 14 Dec 2012 17:02:17 +0100
Message-ID: <1355500938-35344-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1355500938-35344-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1355500938-35344-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Get the definition of struct subchannel_id.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/ccwdev.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 6d1f357..e606161 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -12,15 +12,13 @@
 #include <linux/mod_devicetable.h>
 #include <asm/fcx.h>
 #include <asm/irq.h>
+#include <asm/schid.h>
 
 /* structs from asm/cio.h */
 struct irb;
 struct ccw1;
 struct ccw_dev_id;
 
-/* from asm/schid.h */
-struct subchannel_id;
-
 /* simplified initializers for struct ccw_device:
  * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
  * entry in your MODULE_DEVICE_TABLE and set the match_flag correctly */
-- 
1.7.12.4
