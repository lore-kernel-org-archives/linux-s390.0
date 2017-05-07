Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 4/4] s390/sysinfo: Combine two function calls into one
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Message-ID: <04517191-f1f5-19ca-d4bc-d3d5331b4556@users.sourceforge.net>
Date: Sun, 7 May 2017 19:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Vegard Nossum <vegard.nossum@oracle.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 May 2017 18:48:39 +0200

A bit of data was put into a sequence by two separate function calls
at four places. Print the same data by single function calls instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/sysinfo.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index e7061fcd047a..7f81d40c8f90 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -98,8 +98,7 @@ static void stsi_1_1_1(struct seq_file *m, struct sysinfo_1_1_1 *info)
 	seq_printf(m, "Model:                %-16.16s", info->model_capacity);
 	if (info->model[0] != '\0')
 		seq_printf(m, " %-16.16s", info->model);
-	seq_putc(m, '\n');
-	seq_printf(m, "Sequence Code:        %-16.16s\n", info->sequence);
+	seq_printf(m, "\nSequence Code:        %-16.16s\n", info->sequence);
 	seq_printf(m, "Plant:                %-4.4s\n", info->plant);
 	seq_printf(m, "Model Capacity:       %-16.16s %08u\n",
 		   info->model_capacity, info->model_cap_rating);
@@ -200,8 +199,7 @@ static void stsi_2_2_2(struct seq_file *m, struct sysinfo_2_2_2 *info)
 	if (stsi(info, 2, 2, 2))
 		return;
 	EBCASC(info->name, sizeof(info->name));
-	seq_putc(m, '\n');
-	seq_printf(m, "LPAR Number:          %d\n", info->lpar_number);
+	seq_printf(m, "\nLPAR Number:          %d\n", info->lpar_number);
 	seq_puts(m, "LPAR Characteristics: ");
 	if (info->characteristics & LPAR_CHAR_DEDICATED)
 		seq_puts(m, "Dedicated ");
@@ -209,8 +207,7 @@ static void stsi_2_2_2(struct seq_file *m, struct sysinfo_2_2_2 *info)
 		seq_puts(m, "Shared ");
 	if (info->characteristics & LPAR_CHAR_LIMITED)
 		seq_puts(m, "Limited ");
-	seq_putc(m, '\n');
-	seq_printf(m, "LPAR Name:            %-8.8s\n", info->name);
+	seq_printf(m, "\nLPAR Name:            %-8.8s\n", info->name);
 	seq_printf(m, "LPAR Adjustment:      %d\n", info->caf);
 	seq_printf(m, "LPAR CPUs Total:      %d\n", info->cpus_total);
 	seq_printf(m, "LPAR CPUs Configured: %d\n", info->cpus_configured);
@@ -256,8 +253,8 @@ static void stsi_3_2_2(struct seq_file *m, struct sysinfo_3_2_2 *info)
 	for (i = 0; i < info->count; i++) {
 		EBCASC(info->vm[i].name, sizeof(info->vm[i].name));
 		EBCASC(info->vm[i].cpi, sizeof(info->vm[i].cpi));
-		seq_putc(m, '\n');
-		seq_printf(m, "VM%02d Name:            %-8.8s\n", i, info->vm[i].name);
+		seq_printf(m, "\nVM%02d Name:            %-8.8s\n",
+			   i, info->vm[i].name);
 		seq_printf(m, "VM%02d Control Program: %-16.16s\n", i, info->vm[i].cpi);
 		seq_printf(m, "VM%02d Adjustment:      %d\n", i, info->vm[i].caf);
 		seq_printf(m, "VM%02d CPUs Total:      %d\n", i, info->vm[i].cpus_total);
-- 
2.12.2
