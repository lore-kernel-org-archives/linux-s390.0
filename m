Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 06/17] s390/debug: Rename jump labels in debug_info_copy()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8ea2ec9f-20b7-ecf6-0110-c6086622e8f0@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:20:02 +0200
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
Date: Thu, 1 Sep 2016 18:32:19 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c5da41b..1f32578 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -377,7 +377,7 @@ debug_info_copy(debug_info_t* in, int mode)
 			in->nr_areas, in->buf_size, in->level, mode);
 		spin_lock_irqsave(&in->lock, flags);
 		if (!rc)
-			goto out;
+			goto unlock;
 		/* has something changed in the meantime ? */
 		if ((rc->pages_per_area == in->pages_per_area) &&
 		   (rc->nr_areas == in->nr_areas)) {
@@ -388,12 +388,12 @@ debug_info_copy(debug_info_t* in, int mode)
 	} while (1);
 
 	if (mode == NO_AREAS)
-                goto out;
+		goto unlock;
 
 	for (i = 0; i < in->nr_areas; i++)
 		for (j = 0; j < in->pages_per_area; j++)
 			memcpy(rc->areas[i][j], in->areas[i][j], PAGE_SIZE);
-out:
+ unlock:
         spin_unlock_irqrestore(&in->lock, flags);
         return rc;
 }
-- 
2.9.3
