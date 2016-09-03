Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 14/17] s390/debug: Improve a size determination in
 debug_sprintf_format_fn()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <40fd0234-45c3-6856-43b3-c7528a794e8e@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:34:09 +0200
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
Date: Fri, 2 Sep 2016 14:32:08 +0200

Replace a multiplication by a reference for a local array variable
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 32ceb5e..6792a9c 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1486,7 +1486,7 @@ debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
 	/* number of arguments used for sprintf (without the format string) */
 	num_used_args   = min(DEBUG_SPRINTF_MAX_ARGS, (num_longs - 1));
 
-	memset(index, 0, DEBUG_SPRINTF_MAX_ARGS * sizeof(int));
+	memset(index, 0, sizeof(index));
 
 	for (i = 0; i < num_used_args; i++)
 		index[i] = i;
-- 
2.9.3
