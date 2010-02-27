Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 53/66] drivers/s390/cio/blacklist.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:34 +0100
Message-Id: <1267289508-31031-54-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

drivers/s390/cio/blacklist.h:4: WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/s390/cio/blacklist.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/cio/blacklist.h b/drivers/s390/cio/blacklist.h
index 95e25c1..4a78e64 100644
--- a/drivers/s390/cio/blacklist.h
+++ b/drivers/s390/cio/blacklist.h
@@ -1,6 +1,6 @@
 #ifndef S390_BLACKLIST_H
 #define S390_BLACKLIST_H
 
-extern int is_blacklisted (int ssid, int devno);
+extern int is_blacklisted(int ssid, int devno);
 
 #endif
-- 
1.7.0.90.g251a4
