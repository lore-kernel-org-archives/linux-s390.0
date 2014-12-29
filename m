Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 11/11 linux-next] s390/hmcdrv: remove unnecessary version.h inclusion
Date: Mon, 29 Dec 2014 15:34:39 +0100
Message-Id: <1419863679-24430-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1419863387-24233-1-git-send-email-fabf@skynet.be>
References: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Based on versioncheck.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/s390/char/hmcdrv_mod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/hmcdrv_mod.c b/drivers/s390/char/hmcdrv_mod.c
index 505c6a7..251a318 100644
--- a/drivers/s390/char/hmcdrv_mod.c
+++ b/drivers/s390/char/hmcdrv_mod.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/stat.h>
 
 #include "hmcdrv_ftp.h"
-- 
2.1.0
