From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 28 Oct 2018 11:23:15 +0000
Subject: [PATCH 1/1] s390/config: Enable CONFIG_PRINTK_TIME in defconfig
Message-Id: <20181028112315.29462-1-pvorel@suse.cz>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

s390 defconfig uses the same value default value for CONFIG_LOG_BUF_SHIFT
(currently 17), which is the same as other s390 configs, which enable
CONFIG_PRINTK_TIME. There is no need to have it disabled for defconfig.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 arch/s390/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 7cb6a52f727d..646244a6885d 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -248,3 +248,4 @@ CONFIG_CRC7=m
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
 CONFIG_CMM=m
+CONFIG_PRINTK_TIME=y
-- 
2.12.3
