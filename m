Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jul 2016 13:40:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] s390/smp: clean up a condition
Message-ID: <20160714104022.GF18175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I can never remember precedence rules.  Let's add some parenthesis so
this code is more clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The original code is correct right?  We didn't intend to say:

	sclp_max = sclp.max_cores * (sclp_max ?: nr_cpu_ids);

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 5c8f7ca..35531fe 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -887,7 +887,7 @@ void __init smp_fill_possible_mask(void)
 
 	sclp_max = max(sclp.mtid, sclp.mtid_cp) + 1;
 	sclp_max = min(smp_max_threads, sclp_max);
-	sclp_max = sclp.max_cores * sclp_max ?: nr_cpu_ids;
+	sclp_max = (sclp.max_cores * sclp_max) ?: nr_cpu_ids;
 	possible = setup_possible_cpus ?: nr_cpu_ids;
 	possible = min(possible, sclp_max);
 	for (cpu = 0; cpu < possible && cpu < nr_cpu_ids; cpu++)
