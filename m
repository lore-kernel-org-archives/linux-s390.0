Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084447.343908760@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/32] [PATCH] adapt text to cu3088-removal
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=101-cu3088-docu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

cu3088 layer for lcs and ctcm has been removed. Thus the reference
to cu3088 in this text is to be removed as well.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/driver-model.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/Documentation/s390/driver-model.txt
===================================================================
--- quilt-2.6.orig/Documentation/s390/driver-model.txt	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/Documentation/s390/driver-model.txt	2010-02-24 09:44:23.000000000 +0100
@@ -223,8 +223,8 @@
 private data.
 
 To implement a ccwgroup driver, please refer to include/asm/ccwgroup.h. Keep in
-mind that most drivers will need to implement both a ccwgroup and a ccw driver
-(unless you have a meta ccw driver, like cu3088 for lcs and ctc).
+mind that most drivers will need to implement both a ccwgroup and a ccw
+driver.
 
 
 2. Channel paths
