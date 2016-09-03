Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 01/17] s390/debug: Use kmalloc_array() in debug_areas_alloc()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <405a67ff-0f3b-a172-b8f1-2867cdd5ce07@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:10:03 +0200
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
Date: Thu, 1 Sep 2016 14:41:01 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "kmalloc_array".

* Replace the specification of data types by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index aa12de7..8e2be30 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -196,14 +196,13 @@ debug_areas_alloc(int pages_per_area, int nr_areas)
 	debug_entry_t*** areas;
 	int i,j;
 
-	areas = kmalloc(nr_areas *
-					sizeof(debug_entry_t**),
-					GFP_KERNEL);
+	areas = kmalloc_array(nr_areas, sizeof(*areas), GFP_KERNEL);
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
-		areas[i] = kmalloc(pages_per_area *
-				sizeof(debug_entry_t*),GFP_KERNEL);
+		areas[i] = kmalloc_array(pages_per_area,
+					 sizeof(*areas[i]),
+					 GFP_KERNEL);
 		if (!areas[i]) {
 			goto fail_malloc_areas2;
 		}
-- 
2.9.3
