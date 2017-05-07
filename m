Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/4] s390/sysinfo: Replace six seq_printf() calls by
 seq_puts()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Message-ID: <590c30d3-fff8-dc73-5d14-ad78b6a65c51@users.sourceforge.net>
Date: Sun, 7 May 2017 19:16:15 +0200
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
Date: Sun, 7 May 2017 18:18:45 +0200

Six strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/kernel/sysinfo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index eefcb54872a5..e7061fcd047a 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -139,13 +139,13 @@ static void stsi_15_1_x(struct seq_file *m, struct sysinfo_15_1_x *info)
 		return;
 	if (stsi(info, 15, 1, topology_max_mnest))
 		return;
-	seq_printf(m, "CPU Topology HW:     ");
+	seq_puts(m, "CPU Topology HW:     ");
 	for (i = 0; i < TOPOLOGY_NR_MAG; i++)
 		seq_printf(m, " %d", info->mag[i]);
 	seq_putc(m, '\n');
 #ifdef CONFIG_SCHED_TOPOLOGY
 	store_topology(info);
-	seq_printf(m, "CPU Topology SW:     ");
+	seq_puts(m, "CPU Topology SW:     ");
 	for (i = 0; i < TOPOLOGY_NR_MAG; i++)
 		seq_printf(m, " %d", info->mag[i]);
 	seq_putc(m, '\n');
@@ -202,13 +202,13 @@ static void stsi_2_2_2(struct seq_file *m, struct sysinfo_2_2_2 *info)
 	EBCASC(info->name, sizeof(info->name));
 	seq_putc(m, '\n');
 	seq_printf(m, "LPAR Number:          %d\n", info->lpar_number);
-	seq_printf(m, "LPAR Characteristics: ");
+	seq_puts(m, "LPAR Characteristics: ");
 	if (info->characteristics & LPAR_CHAR_DEDICATED)
-		seq_printf(m, "Dedicated ");
+		seq_puts(m, "Dedicated ");
 	if (info->characteristics & LPAR_CHAR_SHARED)
-		seq_printf(m, "Shared ");
+		seq_puts(m, "Shared ");
 	if (info->characteristics & LPAR_CHAR_LIMITED)
-		seq_printf(m, "Limited ");
+		seq_puts(m, "Limited ");
 	seq_putc(m, '\n');
 	seq_printf(m, "LPAR Name:            %-8.8s\n", info->name);
 	seq_printf(m, "LPAR Adjustment:      %d\n", info->caf);
-- 
2.12.2
