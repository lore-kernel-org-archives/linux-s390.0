Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0026/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:35:21 +0800
Message-Id: <20160802103521.15501-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, phacht@linux.vnet.ibm.com, keescook@chromium.org
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/mm/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 79ddd58..3f608e1 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -27,7 +27,7 @@
 static char *cmm_default_sender = "VMRMSVM";
 #endif
 static char *sender;
-module_param(sender, charp, 0400);
+module_param(sender, charp, S_IRUSR);
 MODULE_PARM_DESC(sender,
 		 "Guest name that may send SMSG messages (default VMRMSVM)");
 
-- 
2.9.2
