Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] s390: mmap base does not depend on ADDR_NO_RANDOMIZE personality
Date: Thu,  4 Apr 2019 02:19:56 -0400
Message-Id: <20190404061956.25507-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti <alex@ghiti.fr>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

randomize_stack_top() checks for current task flag PF_RANDOMIZE in order
to use stack randomization and PF_RANDOMIZE is set when
ADDR_NO_RANDOMIZE is unset, so no need to check for ADDR_NO_RANDOMIZE
in stack_maxrandom_size.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/s390/mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 687f2a4d3459..5185ed0a0463 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -24,8 +24,7 @@ static unsigned long stack_maxrandom_size(void)
 {
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
-	if (current->personality & ADDR_NO_RANDOMIZE)
-		return 0;
+
 	return STACK_RND_MASK << PAGE_SHIFT;
 }
 
-- 
2.20.1
