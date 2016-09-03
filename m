Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 08/17] s390/debug: Fix a jump target in debug_register_mode()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d4bbf62a-abc1-2132-3f61-9021c86e937c@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:23:18 +0200
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
Date: Thu, 1 Sep 2016 19:26:16 +0200

* Move an error message.

* Adjust a jump target according to the current Linux coding
  style convention.

* Delete a repeated check which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 1cce76a..c4a4641 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -700,14 +700,14 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
         /* create new debug_info */
 
 	rc = debug_info_create(name, pages_per_area, nr_areas, buf_size, mode);
-	if (!rc)
-		goto out;
+	if (!rc) {
+		pr_err("Registering debug feature %s failed\n", name);
+		goto unlock;
+	}
 	debug_register_view(rc, &debug_level_view);
         debug_register_view(rc, &debug_flush_view);
 	debug_register_view(rc, &debug_pages_view);
-out:
-	if (!rc)
-		pr_err("Registering debug feature %s failed\n", name);
+ unlock:
 	mutex_unlock(&debug_mutex);
 	return rc;
 }
-- 
2.9.3
