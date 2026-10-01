Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2214570C3;
	Thu,  1 Oct 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882980; cv=fail; b=MQqaOF9SVcfI1AyKazIpipoMFtn7sBN12CuE2wvSk2WDL+585QHrrpfGQhrvJORJVvlbtDsAswtloCcOH9Ut1G8H8Lo0gKpJnx5m5CypStKsP2K/7C8wG/jr9IpFKLHj6DuDVauG8V7ItBLIBAB30efVjh04qJGPfze6uwPxisM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882980; c=relaxed/simple;
	bh=GTNzEQytVwRxwx4NqUwoXmoXV2kEkmlLOm4mXDtIjwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvDiHXcwQYijOnDGsE6XGqTANnaR2yz4Yn3iR0aQxKfe0KSHRgja9wSBwsSWS7ijAYSOK6xPnJtZkvIvRwuu+t9TQTL+WETjJ16QPj2M4e6AIyvCsZSOErBxHVMiG95mih0LTkN7BAPjVOBk6LLC3gBNkHx72pNL4BYllhrcBdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7Qx0WCe; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7Qx0WCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co1wPtBL4+2xhbqPTutiHyPGVdjUEtGCFFYIm9JFTVTlO5sg20z9hYe3VTg90oBW2lbM1pvS8+dUqcOt+rnj2l2dcqxFC6Q+SVCVwBfHeixQC1BdwYKOKcPdfwBk092cK20Hy/IqcKn8t6fEgi0YMrjxXzFS1NMQak/0u51w4p629kdGrh9cWSnBMOogcFud6O2rutN5gJ0cArOcXSBnjdgtiTplTi+5HepcqUJmihedeJQlAtjkHi44Ddupb4nzh8aeTVCdHWe2pOQN8hGVe9IW8XZdWMTqBj5QgmsUZFGJD/qh1rDpD4XoEdtE11qUSMkVyPSiyNULNDwM0/iXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGJ3jwvGFblM0+CVKsSoN6D8K0bRS0IM/9iPLUFC9Zs=;
 b=o71wNY1vG3IfI6iFVMWyNS3JkP/dBSXhqrqodmqvZy5HWPL5STKGGuN8TrwauVynTSHQv/R+4qNyKMyP0qgQG52xZwknajlSthWgBBsa5AO2+NYujIqO2EojwsHKN5xOa9YGVCDTgztLUCZQsIPVAcPd56m0lNApwJiyXspYBYjWc7XQlnwnuxgOfiPRSEsx3dWGCLS0z+L6nNUIV71PUas6zUzx83TkteN+/cZB/SE9UxDfqrYc9CaCd5vXzhtTKzm7GJDPDTcL3kVc3cPsZRwOcQfAfuOhk8mbBuq6TGiyzTXgk+qHvdYKdmhv4G+FRLlB87ybMsPGJpic80/Fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJ3jwvGFblM0+CVKsSoN6D8K0bRS0IM/9iPLUFC9Zs=;
 b=A7Qx0WCeWu5uvGCVKsKH/pr7FWSpvIcoDdVCgQJSCStgZYqBlo/sKmxWBWBDeLvOP0g6pU2whe6B1VW3igLNVAZjKmsTU+iLj079td0fuaTOeuTZmkZqvE0xxRfXdkOscrwwI36YkVdt9oJuzbQxg0aFk/F/rSrZg1plcUiWzbA=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:29:30 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::87) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 19:29:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:29:28 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:29:15 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sudeep Holla <sudeep.holla@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "WANG
 Xuerui" <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Christian Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v3 00/13] lib, sched: Introduce sparsebitmap (sbm)
Date: Thu, 1 Oct 2026 19:28:36 +0000
Message-ID: <20261001192849.74788-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c85b217-0365-4d88-8fb9-08df1ff24f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|7416014|82310400026|376014|23010399003|1800799024|36860700016|6133799003|56012099006|11063799006|3023799007|10067099003|18002099003|13003099007|921020|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	SlK14QKlzJxq1JYQBOI6eH5mtxUm5frjLDB7sKeiahBvjgxNYdb1O6p53zm111N2m47qwerXrMQclnGnpj/iFLjVGt2KC35EWTzqtJmvv+JmmbGmwbKI4u1eRdqJ2w05wIpw+n2dWVfW43fDMyn+qlup+QHBzKFC9SG8jLCfWmLgtIUINDIkFu2HaiLSb7qJJO4A+UVoHHbGhjHPKGs9NH7ydIjMaG6a3pLIVVU3LNkG9W/OCpjAHDU34/UYnRNuRm9DiwHdLXzGTl2jDBljiL5Vyk3jGQQDlvw56y8yh70lQu2Y0xe82LHn0DaOZKZJ2IP9migHldz4w/j1rt6LBThydhWIE1NO0r88iMqkRaT9E3d47Y3p7WcF9nABikPRq2pGdp10h9Jb6dYaE0WQpTZwIIBu5YsHKyCpI6pbaKSLe5Zev3oewJF9A06R8snwGV747ZfToBfOFafZqi240OZgPwVGepUXY+4YKA7FMV9HCiNAbHMHX2PsvygHBg4m3Q1stsuEo6roAABcXj+bfE72MynO58ZqbHDQErJ6s2CbZ5MY9BOIqrDrLm4IhHLyFJpXhwphfbRBnysTAvLZ6nz2WU8tvI5euDl3/cr0gJ9/TfAzL+EXrJuaiik/BrwwvrO/tOAw7Bpk/iuij9nlyf9aAml/zUzM15tAlaUG+nc/6saG+SJB+1vaNm/V2zM76yZLgdjBW0A5Sx2aKf+DC5QssLToQGyV0Cb7v6uyoAnpp/FU6HhZg0nR0cmx/G+y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(7416014)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(56012099006)(11063799006)(3023799007)(10067099003)(18002099003)(13003099007)(921020)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9h4kRKi+qwZkoZ7QvIiL+6NT+w73k9s9Zy+yuXRrRDmLI/oYustrT4xjiMXihqcwwl872UKoVR4wl4x6zh20rYjKEYciRd8iTrOZiphN58nj2JxiS7DsJOUUQye3ZN0ZtKW6rIVeXRPAJmR1C/5K0tSHvu4oygwifhAU2+ouX4MZkxL/Wd879gqJS/lzKa6VwozB89j/M5btC40BUysEnpwe+RCRrYoqTXDbHTxXhv1+TlhqtwPMjbM5EQOKo5c59svt+4N0f/kkwRsfdQGJhkQbveM5nz2l3QihQAojDg2aFF7nRrYjz14YZrkAHiPpxQvIBhd6MS4HJJIORCbuzq0D7/vyi+9YuRdn+ZsaKByDNg8XPQ9JS7PUlEdvfzpKv/mowy08NVCuWtJ15CEM+V/116xKdI0GrTi7kgr1YbqlJ0GpOp4GNOmmLkyJPm7p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:29:28.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85b217-0365-4d88-8fb9-08df1ff24f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

Problem
=======

Global cpumasks on a large multi-node systems experience an abundance of
C2C ping ponging, especially the ones that are updated very frequently
like the ones that track scheduler and timer states.


Solution
========

One great solution to this problem is to have a separate cpumask
instance per node to avoid C2C ping poinging for updates.

Replicating cpumasks in its entirity solves the challenges of updates by
keeping the writes local to the LLC domain but introduces burden on
traversal.

Steve Sistare had (almost a decade back) introduced a concept called
sparsemask [1] where each cacheline-aligned bitmap word can only
represent a small number of CPUs with 8 CPUs per bitmap word being
chosen during that time.

Although it worked, the initial sparsemask implementation had no
knowledge of topology. That changed early this year when Peter provided
a minimal implementation of sparsebitmap (sparsebitmask?) aka sbm in
[2].

This builds on Peter's idea to make the sbm implementation generic and
available to all architectures.


Aren't sbitmap built for that purpose?
======================================

It is true sbitmap (scalable bitmap) in lib/sbitmap.c was build for a
similar problem in the block layer but sbitmap is heavy handed with each
sbitmap leaf occupying two cachelines with added semantics of "cleared"
range that don't contend with a set operation on the adjacent cacheline.

sbm is to sbitmap what cpumask is to plain bitmap - they are essentially
the same concept albeit executed slightly differently.

If there is enough interest, I don't mind adapting my implementation to
fit with the sbitmap scheme with perhaps a sbitmap-lite variant :-)


Implementation
==============

Similar to how cpumaks allows architectures to define nr_cpumask_bit and
later adapt a simple bitmap to cover that range, sbm allows
architectures to define "num_instances" (leaves) and
"max_threads_per_instance" (max CPUs that can be represented in one
instance) and uses them to compute the worst-case size for a sparse
mapping of CPUs.

sbm_alloc() essentially hands a large array based on the set topology
that cba cover any CPU mapping as long as they fall within the
architecture imposed constraints.

When CPUs are brought active, a sbm index is assigned to them. An sbm
index essentailly encodes two parts:

    +----------------+---------------------------+
    | index in array | bit in that array element |
    +----------------+---------------------------+

The size of each encoding is determined during sbm initialization based
on the topology provided. If arch/ did not provide a topology, a backup
topology is used that divdes entire system in BITS_PER_LONG chunks.

Using the topology two attributes are derived:

  __sbm_shift: Bits to shift right to obtain just index in array
  __sbm_mask:  Lower bits to mask to get the position in the bitfield

Metadata is tracked separately by core and idx <-> cpu mappings are
cached in separate arrays.

This builds on Peter's ideas in [2] which used the x86 topology parsing
nuances to derive the mask and shift during early boot.


Topology parsing nuances
========================

Each architecture has a unique approach to describing system topology
but most offer a way to get the entire system topology during
smp_prepare() with one exception of PowerPC.

PowerPC and specifically pSeries hotplug seems to indicate a CPU can be
removed and re-added with the logical CPU <-> node relation completely
changing.

This creates a unique challenge since estimating the number of sbm
leaves and bits per leaf is hard and the worst case scenario is taken to
construct them.


Shameless plug
==============

If you find yourself at LPC'26, I have a small talk at Scheduling and
Real-Time Microconference.

If I have got some topology nuances for your architecture horribly
wrong, you have a chance to punch me in the face directly :-) (and maybe
help direct me in the right direction after).


Performance
===========

To measure any performance impact, the global nohz.idle_cpus_mask which
tracks the set of CPUs in NOHZ idle state have been converted to sbm
based distributed mask.

Performance is comparable to base with sbm variant performing slightly
better (~ 1-2%) on average. On worst case scenario (one event per
context switch), the distributed masks take 1/100th the cost of update
when compared to global cpumask. Quoting data from [3]:

                                            %cycles vs global mask operation

global mask                                     : 100.0000%  (var: 3.28%)
per-NUMA mask                                   :  32.9209%  (var: 7.77%)
per-LLC mask                                    :   1.2977%  (var: 4.85%)
per-LLC mask (u8 operation; no LOCK prefix)     :   0.4930%  (var: 0.83%)


Future work
===========

o Interoperability with cpumaks since sbm lose the crucial optimizations
  that come naturally from for_each_cpu_and() iterations.

o Different data representation - using the u8 variant for updates and
  then perform a "gather" operation to build a dense mask.

o Extending sbm work to help in wakeup (and possibly resurrect Mel's
  optimization from [4] in some form). The current sbm is still far away
  from being used for wakeups since  updates  to sbm leaf, even on a
  16CPUs per LLC system is visible in benchmark performance (~8-10%).


References
==========

[1] https://lore.kernel.org/lkml/1541767840-93588-2-git-send-email-steven.sistare@oracle.com/
[2] https://lore.kernel.org/lkml/20260324120008.GB3738010@noisy.programming.kicks-ass.net/
[3] https://lore.kernel.org/lkml/e093d930-79df-4285-a492-cc6d40b3cd51@amd.com/
[4] https://lore.kernel.org/lkml/20210726102247.21437-1-mgorman@techsingularity.net/

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 1fb28c664a19 ("virt/steal_governor: Enable the driver").

Respective arch/ maintainers have been Cc'd on the arch sepcific
changes, everyone is Cc'd on cover letter and sbm bits. Scheduler
and lib folks along with the lists will get the entire series.


Changelog
=========

v2..v3:

o Added enablement for other architectures apart from x86.
o Dynamically establish CPU <-> sbm index relations.

This is a spiritual successor to Chenyu's v2 at
https://lore.kernel.org/lkml/20260510155920.2587431-1-yu.c.chen@intel.com/

---
K Prateek Nayak (10):
  lib/sbm: Introduce helpers for architectures to configure LLC
    properties
  drivers/base/arch_topology: Add support for initializing sbm topology
  LoongArch: Initialize CPU _PXM relation for disabled CPUs from SRAT
  LoongArch: Configure sbm topology during SMP preparation
  MIPS: Initialize sbm topology on multi-node systems
  powerpc/setup: Initialize sbm topology based on coregroup / NUMA
    topology
  s390/topology: Initialize sbm topology during topology_init_early()
  sparc64: Initialize sbm topology on multi-LLC system
  lib/sbm: Dynamically allocate sbm index when CPU is activated
  sched/fair: Allocate nohz.idle_cpus_mask during sched_init_smp()

Peter Zijlstra (3):
  x86/cpu/topology: Initialize sbm topology after topology parsing
  lib/sbm: Add helpers to allocate, set, clear, and traverse the bits on
    sbm
  sched/fair: Switch nohz.idle_cpus to use sbm

 arch/loongarch/kernel/acpi.c                 |  20 +-
 arch/loongarch/kernel/smp.c                  |  36 +++
 arch/mips/include/asm/topology.h             |   6 +
 arch/mips/kernel/topology.c                  |  43 ++++
 arch/mips/loongson64/smp.c                   |   3 +
 arch/mips/sgi-ip27/ip27-smp.c                |   3 +
 arch/powerpc/kernel/setup-common.c           |  88 +++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  10 +
 arch/s390/kernel/topology.c                  |  52 ++++
 arch/sparc/kernel/setup_64.c                 |  45 ++++
 arch/x86/kernel/cpu/topology.c               |  40 ++-
 drivers/base/arch_topology.c                 | 122 ++++++++-
 include/asm-generic/vmlinux.lds.h            |   6 +-
 include/linux/sbm.h                          | 107 ++++++++
 init/main.c                                  |   6 +
 kernel/sched/core.c                          |  19 ++
 kernel/sched/fair.c                          |  72 +++---
 kernel/sched/sched.h                         |   1 +
 lib/Makefile                                 |   2 +-
 lib/sbm.c                                    | 253 +++++++++++++++++++
 20 files changed, 883 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/sbm.h
 create mode 100644 lib/sbm.c


base-commit: 1fb28c664a19df8d45a6afa04d28d102b04ea680
-- 
2.34.1

