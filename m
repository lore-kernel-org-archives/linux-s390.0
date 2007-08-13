Return-Path: <linux-kernel-owner+w=401wt.eu-S938845AbXHMK0t@vger.kernel.org>
Date: Sun, 12 Aug 2007 23:35:07 -0700
From: joe@perches.com
Subject: [PATCH] [414/2many] MAINTAINERS - S390 ZFCP DRIVER
Message-ID: <46bffb9b.o95rnmgi2XCBv8aA%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org, swen@vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 8589439..02a59dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3948,6 +3948,8 @@ M:	linux390@de.ibm.com
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
+F:	Documentation/s390/zfcpdump.txt
+F:	drivers/s390/scsi/zfcp_*
 
 SAA7146 VIDEO4LINUX-2 DRIVER
 P:	Michael Hunold
