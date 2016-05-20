Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jason Baron <jbaron@akamai.com>
Subject: [PATCH v2 3/4] s390: add explicit <linux/stringify.h> for jump label
Date: Fri, 20 May 2016 17:16:35 -0400
Message-Id: <f242f753b4c819b8da5351007d81ed055b4b8bdf.1463778029.git.jbaron@akamai.com>
In-Reply-To: <cover.1463778029.git.jbaron@akamai.com>
References: <cover.1463778029.git.jbaron@akamai.com>
In-Reply-To: <cover.1463778029.git.jbaron@akamai.com>
References: <cover.1463778029.git.jbaron@akamai.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ensure that we always have __stringify().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/s390/include/asm/jump_label.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 7f9fd5e..9be198f5 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -4,6 +4,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
+#include <linux/stringify.h>
 
 #define JUMP_LABEL_NOP_SIZE 6
 #define JUMP_LABEL_NOP_OFFSET 2
-- 
2.6.1
