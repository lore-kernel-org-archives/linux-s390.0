Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCH] s390/jump_label: Correct asm contraint
Date: Wed, 23 Jan 2019 13:55:13 +0100
Message-Id: <20190123125513.20210-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There's a build failure with gcc9:

 ./arch/s390/include/asm/jump_label.h: Assembler messages:
 ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
 ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
 make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1

According to the toolchain people, the actual issue is the use of
"X" constraint which is too permissive. Switch to using "i" instead.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1668703
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/s390/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index e2d3e6c43395..41dabfd8518d 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -22,7 +22,7 @@ static inline bool arch_static_branch(struct static_key *key, bool branch)
 			  ".long	0b-.,%l[label]-.\n"
 			  ".quad	%0-.\n"
 			  ".popsection\n"
-			  : : "X" (&((char *)key)[branch]) : : label);
+			  : : "i" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
@@ -36,7 +36,7 @@ static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 			  ".long	0b-.,%l[label]-.\n"
 			  ".quad	%0-.\n"
 			  ".popsection\n"
-			  : : "X" (&((char *)key)[branch]) : : label);
+			  : : "i" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
-- 
2.20.1
