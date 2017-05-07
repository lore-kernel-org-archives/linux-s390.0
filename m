Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/4] s390/processor: Use seq_putc() in show_cpu_summary()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Message-ID: <0d2e6c6c-00d9-b83e-0631-ee8bae32b750@users.sourceforge.net>
Date: Sun, 7 May 2017 19:14:55 +0200
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
Date: Sun, 7 May 2017 18:03:11 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 778cd6536175..b9a40c81e3d8 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -128,7 +128,7 @@ static void show_cpu_summary(struct seq_file *m, void *v)
 	for (i = 0; i < ARRAY_SIZE(int_hwcap_str); i++)
 		if (int_hwcap_str[i] && (int_hwcap & (1UL << i)))
 			seq_printf(m, "%s ", int_hwcap_str[i]);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	show_facilities(m);
 	show_cacheinfo(m);
 	for_each_online_cpu(cpu) {
-- 
2.12.2
