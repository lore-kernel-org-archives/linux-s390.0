Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 17/17] s390/debug: Improve another size determination in
 debug_info_alloc()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9bdb0620-4983-a3a3-c71c-54c698bc7d68@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:40:08 +0200
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
Date: Fri, 2 Sep 2016 14:41:02 +0200

Replace the specification of a data type by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 408a8da..ffc6af6 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -241,8 +241,7 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 	debug_info_t* rc;
 
 	/* alloc everything */
-
-	rc = kmalloc(sizeof(debug_info_t), GFP_KERNEL);
+	rc = kmalloc(sizeof(*rc), GFP_KERNEL);
 	if(!rc)
 		goto exit;
 	rc->active_entries = kcalloc(nr_areas, sizeof(int), GFP_KERNEL);
-- 
2.9.3
