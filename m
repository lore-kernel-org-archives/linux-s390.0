Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084449.961187611@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/32] [PATCH] sysinfo: fix SYSIB 3,2,2 structure
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=113-sysinfo-fix-sysib322.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The size of the field that contains the description block count is
only four bits instead of eight bits.
The first four bits are reserved but this might change and break.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/sysinfo.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/include/asm/sysinfo.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sysinfo.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/sysinfo.h	2010-02-24 09:44:25.000000000 +0100
@@ -87,7 +87,8 @@
 
 struct sysinfo_3_2_2 {
 	char reserved_0[31];
-	unsigned char count;
+	unsigned char :4;
+	unsigned char count:4;
 	struct {
 		char reserved_0[4];
 		unsigned short cpus_total;
