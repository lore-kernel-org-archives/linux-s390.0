Return-Path: <linux-kernel-owner+w=401wt.eu-S1756897AbYK0Koj@vger.kernel.org>
Message-Id: <20081127103137.267899851@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/60] add new machine types to setup_hwcaps.
Content-Disposition: inline; filename=133-elf-platform.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add the machine types for z9-bc, z10-ec and z10-bc to the elf_platform
detection in setup_hwcaps.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -722,8 +722,13 @@ static void __init setup_hwcaps(void)
 		strcpy(elf_platform, "z990");
 		break;
 	case 0x2094:
+	case 0x2096:
 		strcpy(elf_platform, "z9-109");
 		break;
+	case 0x2097:
+	case 0x2098:
+		strcpy(elf_platform, "z10");
+		break;
 	}
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
