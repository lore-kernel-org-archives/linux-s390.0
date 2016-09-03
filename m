Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 09/17] s390/debug: Return directly if a null pointer was
 passed to debug_unregister()
References: <566ABCD9.1060404@users.sourceforge.net>
 <e4359dc9-9e20-e33b-9743-9ebade853268@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9c7f85c9-75db-99fb-88ce-b3e6f01b69db@users.sourceforge.net>
Date: Sat, 3 Sep 2016 14:24:57 +0200
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
Date: Thu, 1 Sep 2016 19:34:45 +0200

Return directly at the beginning if a null pointer was passed for
the input parameter of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/debug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c4a4641..d137150 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -736,13 +736,10 @@ void
 debug_unregister(debug_info_t * id)
 {
 	if (!id)
-		goto out;
+		return;
 	mutex_lock(&debug_mutex);
 	debug_info_put(id);
 	mutex_unlock(&debug_mutex);
-
-out:
-	return;
 }
 EXPORT_SYMBOL(debug_unregister);
 
-- 
2.9.3
