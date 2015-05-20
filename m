Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 08/12] s390/sclp: Use DECLARE_BITMAP
Date: Tue, 19 May 2015 18:37:56 -0700
Message-Id: <2b099ee415c01294fdcf57393b2ee0c7a53860fe.1432085659.git.joe@perches.com>
In-Reply-To: <cover.1432085659.git.joe@perches.com>
References: <cover.1432085659.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Use the generic mechanism to declare a bitmap instead of unsigned long.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/char/sclp_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index a186918..f74c040 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -186,7 +186,7 @@ int sclp_cpu_deconfigure(u8 cpu)
 static DEFINE_MUTEX(sclp_mem_mutex);
 static LIST_HEAD(sclp_mem_list);
 static u8 sclp_max_storage_id;
-static unsigned long sclp_storage_ids[256 / BITS_PER_LONG];
+static DECLARE_BITMAP(sclp_storage_ids, 256);
 static int sclp_mem_state_changed;
 
 struct memory_increment {
-- 
2.1.2
