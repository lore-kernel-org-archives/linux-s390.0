Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Jun 2017 07:04:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] one last s390 patch for 4.12-rc8/4.12
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170626070445.003029a5@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Revert the re-IPL semantics back to the v4.7 state. It turned out that
the memory layout may change due to memory hotplug if load-normal is used.

Heiko Carstens (1):
      s390/ipl: revert Load Normal semantics for LPAR CCW-type re-IPL

 arch/s390/kernel/ipl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e545ffe..8e622bb5 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -564,8 +564,6 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
-	if (MACHINE_IS_LPAR && ipl_info.type == IPL_TYPE_CCW)
-		diag308(DIAG308_LOAD_NORMAL_DUMP, NULL);
 	diag308(DIAG308_LOAD_CLEAR, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
@@ -1088,10 +1086,7 @@ static void __reipl_run(void *unused)
 		break;
 	case REIPL_METHOD_CCW_DIAG:
 		diag308(DIAG308_SET, reipl_block_ccw);
-		if (MACHINE_IS_LPAR)
-			diag308(DIAG308_LOAD_NORMAL_DUMP, NULL);
-		else
-			diag308(DIAG308_LOAD_CLEAR, NULL);
+		diag308(DIAG308_LOAD_CLEAR, NULL);
 		break;
 	case REIPL_METHOD_FCP_RW_DIAG:
 		diag308(DIAG308_SET, reipl_block_fcp);
