Return-Path: <linux-kernel-owner+w=401wt.eu-S1756518AbZJZUC3@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add s390 drivers block
From: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Oct 2009 13:02:31 -0700
Message-ID: <1256587351.1865.132.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

There are currently 4 directories in drivers/s390
(block, char, cio, kvm) without maintainers
that could point to the s390 mailing list.

Add a block for all drivers/s390
List status as "Odd Fixes"

Add a W: link for drivers/s390/crypto/

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index f40dcce..fe37ef3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4466,6 +4466,12 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	arch/s390/
 
+S390 DRIVERS
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Odd Fixes
+F:	drivers/s390/
+
 S390 NETWORK DRIVERS
 M:	Ursula Braun <ursula.braun@de.ibm.com>
 M:	Frank Blaschka <blaschka@linux.vnet.ibm.com>
@@ -4480,6 +4486,7 @@ M:	Felix Beck <felix.beck@de.ibm.com>
 M:	Ralph Wuerthner <ralph.wuerthner@de.ibm.com>
 M:	linux390@de.ibm.com
 L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
