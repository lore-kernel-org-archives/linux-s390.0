Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 12/17] s390/debug: Use memdup_user() rather than duplicating
 its implementation
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f70a1782-993e-6643-c8aa-ac9e36ce54be@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:30:02 +0200
MIME-Version: 1.0
In-Reply-To: <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Sep 2016 08:45:26 +0200

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 4a12faf..a9fcf72 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1162,13 +1162,9 @@ debug_get_user_string(const char __user *user_buf, size_t user_len)
 {
 	char* buffer;
 
-	buffer = kmalloc(user_len + 1, GFP_KERNEL);
-	if (!buffer)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(buffer, user_buf, user_len) != 0) {
-		kfree(buffer);
-		return ERR_PTR(-EFAULT);
-	}
+	buffer = memdup_user(user_buf, user_len + 1);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
 	/* got the string, now strip linefeed. */
 	if (buffer[user_len - 1] == '\n')
 		buffer[user_len - 1] = 0;
-- 
2.9.3
