Return-Path: <linux-kernel-owner+w=401wt.eu-S1756841AbZDNN46@vger.kernel.org>
Message-Id: <20090414135348.874771700@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/14] smp: fix cpu_possible_map initialization
Content-Disposition: inline; filename=010-cpu-possible-map.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The cpu_possible_map by default is initialized with all ones in s390.
If the kernel paramert possible_cpus=<x> is passed the cpu_possible_map
is supposed to have x bits set.
However the current code just sets the x bits without clearing the NR_CPUS
bits that were already set. So we end up with an unchanged map that has
all bits set.
To fix this just clear the map before setting any new bits.

This broke with def6cfb70bab83c0094bc0cedd27c4eda563043e
"[S390] cpumask: Use accessors code."

Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -591,7 +591,8 @@ static int __init setup_possible_cpus(ch
 	int pcpus, cpu;
 
 	pcpus = simple_strtoul(s, NULL, 0);
-	for (cpu = 0; cpu < pcpus && cpu < nr_cpu_ids; cpu++)
+	init_cpu_possible(cpumask_of(0));
+	for (cpu = 1; cpu < pcpus && cpu < nr_cpu_ids; cpu++)
 		set_cpu_possible(cpu, true);
 	return 0;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
