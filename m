Return-Path: <linux-kernel-owner+w=401wt.eu-S1761744AbXLQThL@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH] arch/s390/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:16 -0800
Message-Id: <1197919875-5288-17-git-send-email-joe@perches.com>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/crypto/prng.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 8eb3a1a..23ed094 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -90,7 +90,7 @@ static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
 	int ret = 0;
 	int tmp;
 
-	/* nbytes can be arbitrary long, we spilt it into chunks */
+	/* nbytes can be arbitrary length, we split it into chunks */
 	while (nbytes) {
 		/* same as in extract_entropy_user in random.c */
 		if (need_resched()) {
-- 
1.5.3.7.949.g2221a6
