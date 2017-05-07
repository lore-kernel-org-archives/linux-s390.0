Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/4] s390/cache: Combine two function calls into one in
 show_cacheinfo()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Message-ID: <e3d24bcc-782b-5c05-1d46-cdcbbbe3bbdf@users.sourceforge.net>
Date: Sun, 7 May 2017 19:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Vegard Nossum <vegard.nossum@oracle.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 May 2017 17:53:31 +0200

A bit of data was put into a sequence by two separate function calls.
Print the same data by a single function call instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/cache.c b/arch/s390/kernel/cache.c
index c8a83276a4dc..9e9752ce3233 100644
--- a/arch/s390/kernel/cache.c
+++ b/arch/s390/kernel/cache.c
@@ -82,8 +82,8 @@ void show_cacheinfo(struct seq_file *m)
 			   cache->disable_sysfs ? "Shared" : "Private");
 		seq_printf(m, "size=%dK ", cache->size >> 10);
 		seq_printf(m, "line_size=%u ", cache->coherency_line_size);
-		seq_printf(m, "associativity=%d", cache->ways_of_associativity);
-		seq_puts(m, "\n");
+		seq_printf(m, "associativity=%d\n",
+			   cache->ways_of_associativity);
 	}
 }
 
-- 
2.12.2
