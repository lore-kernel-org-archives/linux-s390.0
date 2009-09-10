Return-Path: <linux-kernel-owner+w=401wt.eu-S1753262AbZIJX6A@vger.kernel.org>
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 04/10] s390: Convert BUG() to use unreachable()
Date: Thu, 10 Sep 2009 16:56:45 -0700
Message-Id: <1252627011-2933-4-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4AA991C1.1050800@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: linux390@de.ibm.com
CC: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 7efd0ab..efb74fd 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -49,7 +49,7 @@
 
 #define BUG() do {					\
 	__EMIT_BUG(0);					\
-	for (;;);					\
+	unreachable();					\
 } while (0)
 
 #define WARN_ON(x) ({					\
-- 
1.6.2.5
