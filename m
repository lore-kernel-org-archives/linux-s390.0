Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D2C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5F60FD8
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 11:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhHaLF6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:05:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241296AbhHaLF5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 07:05:57 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VB42tX008940;
        Tue, 31 Aug 2021 07:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=znvVo5dk3O/0GhRVX28CmNiYNDumMBrsTYux2Dhg0gE=;
 b=sNbQ82Udab6eZOmr/YrQwg4rZickzJz2huX8Bw/bPZFBw6ef9xPyJm0gpiLp6WrLNld3
 TShb9LJChcNIfsgtByRDPMHqYZUadml7psk3N0jUK/AbF88xZb5rzx6ux9+EAAxLicRw
 gIkuHcRAv0Cfuu4eqB6njnG3hedccTLnT3bNT8FYibigysJAssmEI8W7B9YilD3fR9T0
 zEBWQAwNhMyK3tF2tH0t+rikEet915eAiXp5o/lF3+UC/GbaK13KAodd5y2bqI8AnjQY
 NSRSds6u7Y5HvfisSjm+nNtB9btvxN8Gnvor39TVFpuT8QWQlOJ0btfI0YR1F/ePPsvx 7w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asj931skm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 07:04:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VAvaJn025034;
        Tue, 31 Aug 2021 11:04:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3aqcs8ynvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 11:04:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VB4NWh54329702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:04:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12765AE32C;
        Tue, 31 Aug 2021 11:04:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5D17AE36C;
        Tue, 31 Aug 2021 11:04:22 +0000 (GMT)
Received: from osiris (unknown [9.145.60.147])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 31 Aug 2021 11:04:22 +0000 (GMT)
Date:   Tue, 31 Aug 2021 13:04:21 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 5.14
Message-ID: <YS4MtcuvAhpJL4/J@osiris>
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net>
 <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
 <YS1NltjDz/Xo8nHt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS1NltjDz/Xo8nHt@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h5eJj-zsNOWUGY_Pwt6dqUBgiZQ53crx
X-Proofpoint-ORIG-GUID: h5eJj-zsNOWUGY_Pwt6dqUBgiZQ53crx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_04:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 30, 2021 at 11:28:54PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 30, 2021 at 01:15:37PM -0700, Linus Torvalds wrote:
> > On Mon, Aug 30, 2021 at 1:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > So far so good, but there is a brand new runtime warning, seen when booting
> > > s390 images.
> > >
> > > [    3.218816] ------------[ cut here ]------------
> > > [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
> > > [    3.222845] Call Trace:
> > > [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
> > > [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
> > > [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
> > > [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
> > > [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
> > > [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
> > > [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
> > > [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
> > >
> > > Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
> > > CPUs") seems to be the culprit. Indeed, the warning is gone after reverting
> > > this commit.
> > 
> > Ouch, not great timing.
> > 
> > Adding the s390 people to the cc too, just to make sure everybody
> > involved is aware.
> 
> 'Funny' thing, Sven actually tested that on s390. I had already comitted
> the patch which is why his tag isn't on the commit:
> 
>   https://lkml.kernel.org/r/yt9dy28o8q0o.fsf@linux.ibm.com
> 
> Anyway, looks like Thomas found something fishy in their topology code.
> Lemme go catch up.

Sven provided the patch below which should fix the topology problem.
If it fixes everything it will go upstream with a stable tag, but it
first needs to see our CI to hopefully make sure it doesn't introduce
new regressions.

From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390: fix topology information when calling cpu hotplug notifiers

The cpu hotplug notifiers are called without updating the core/thread
masks when a new CPU is added. This causes problems with code setting
up data structures in a cpu hotplug notifier, and relying on that later
in normal code.

This caused a crash in the new core scheduling code (SCHED_CORE),
where rq->core was set up in a notifier depending on cpu masks.

To fix this, add a cpu_setup_mask which is used in update_cpu_masks()
instead of the cpu_online_mask to determine whether the cpu masks should
be set for a certain cpu. Also move update_cpu_masks() to update the
masks before calling notify_cpu_starting() so that the notifiers are
seeing the updated masks.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/smp.h |  1 +
 arch/s390/kernel/smp.c      |  9 +++++++--
 arch/s390/kernel/topology.c | 10 +++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index e317fd4866c1..f16f4d054ae2 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -18,6 +18,7 @@ extern struct mutex smp_cpu_state_mutex;
 extern unsigned int smp_cpu_mt_shift;
 extern unsigned int smp_cpu_mtid;
 extern __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
+extern cpumask_t cpu_setup_mask;
 
 extern int __cpu_up(unsigned int cpu, struct task_struct *tidle);
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 2a991e43ead3..1a04e5bdf655 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -95,6 +95,7 @@ __vector128 __initdata boot_cpu_vector_save_area[__NUM_VXRS];
 #endif
 
 static unsigned int smp_max_threads __initdata = -1U;
+cpumask_t cpu_setup_mask;
 
 static int __init early_nosmt(char *s)
 {
@@ -902,13 +903,14 @@ static void smp_start_secondary(void *cpuvoid)
 	vtime_init();
 	vdso_getcpu_init();
 	pfault_init();
+	cpumask_set_cpu(cpu, &cpu_setup_mask);
+	update_cpu_masks();
 	notify_cpu_starting(cpu);
 	if (topology_cpu_dedicated(cpu))
 		set_cpu_flag(CIF_DEDICATED_CPU);
 	else
 		clear_cpu_flag(CIF_DEDICATED_CPU);
 	set_cpu_online(cpu, true);
-	update_cpu_masks();
 	inc_irq_stat(CPU_RST);
 	local_irq_enable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
@@ -950,10 +952,13 @@ early_param("possible_cpus", _setup_possible_cpus);
 int __cpu_disable(void)
 {
 	unsigned long cregs[16];
+	int cpu;
 
 	/* Handle possible pending IPIs */
 	smp_handle_ext_call();
-	set_cpu_online(smp_processor_id(), false);
+	cpu = smp_processor_id();
+	set_cpu_online(cpu, false);
+	cpumask_clear_cpu(cpu, &cpu_setup_mask);
 	update_cpu_masks();
 	/* Disable pseudo page faults on this cpu. */
 	pfault_fini();
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index d2458a29618f..5cc7aeae4610 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -67,9 +67,8 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 	static cpumask_t mask;
 
 	cpumask_clear(&mask);
-	if (!cpu_online(cpu))
+	if (!cpumask_test_cpu(cpu, &cpu_setup_mask))
 		goto out;
-	cpumask_set_cpu(cpu, &mask);
 	switch (topology_mode) {
 	case TOPOLOGY_MODE_HW:
 		while (info) {
@@ -89,6 +88,7 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 		break;
 	}
 	cpumask_and(&mask, &mask, cpu_online_mask);
+	cpumask_set_cpu(cpu, &mask);
 out:
 	cpumask_copy(dst, &mask);
 }
@@ -99,16 +99,15 @@ static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 	int i;
 
 	cpumask_clear(&mask);
-	if (!cpu_online(cpu))
+	if (!cpumask_test_cpu(cpu, &cpu_setup_mask))
 		goto out;
 	cpumask_set_cpu(cpu, &mask);
 	if (topology_mode != TOPOLOGY_MODE_HW)
 		goto out;
 	cpu -= cpu % (smp_cpu_mtid + 1);
 	for (i = 0; i <= smp_cpu_mtid; i++)
-		if (cpu_present(cpu + i))
+		if (cpu_online(cpu + i))
 			cpumask_set_cpu(cpu + i, &mask);
-	cpumask_and(&mask, &mask, cpu_online_mask);
 out:
 	cpumask_copy(dst, &mask);
 }
@@ -569,6 +568,7 @@ void __init topology_init_early(void)
 	alloc_masks(info, &book_info, 2);
 	alloc_masks(info, &drawer_info, 3);
 out:
+	cpumask_set_cpu(0, &cpu_setup_mask);
 	__arch_update_cpu_topology();
 	__arch_update_dedicated_flag(NULL);
 }
-- 
2.25.1
