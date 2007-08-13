Return-Path: <linux-kernel-owner+w=401wt.eu-S938672AbXHMK0V@vger.kernel.org>
Date: Sun, 12 Aug 2007 23:35:05 -0700
From: joe@perches.com
Subject: [PATCH] [413/2many] MAINTAINERS - S390 NETWORK DRIVERS
Message-ID: <46bffb99.DLqG1Vss26ZTcy37%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, fpavlic@de.ibm.com, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 21b14d4..8589439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3939,6 +3939,7 @@ M:	linux390@de.ibm.com
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
+F:	drivers/s390/net/
 
 S390 ZFCP DRIVER
 P:	Swen Schillig
