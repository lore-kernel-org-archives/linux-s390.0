Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7141DE0D;
	Thu,  8 Oct 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448302; cv=none; b=IviIpbXjPmRFo5YYKKltOyhMWEYoDs6zrKyYF9dP0gkjbejzoLlBNPrLkloAhOnS/7ALKtWN8Zj3eyl8PH4zV+KgJ3ME4vDMq3BhyPPxi19+GQGr7gd1OWJMR1097blF3DqqJAy/AGw94eDTKrvlOQKqG7ql90cV43rnk4BiF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448302; c=relaxed/simple;
	bh=uuacIaPLNM18Hsjg1u/5qXRyyFiX9bfvP/kki6VT08E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gmu40+YOIF20+K11zlCKX4Oqrct5jd2agXytiuswDqWaBWekXe/0/NbdzAnP6f3A8lZAKXQK6M+P1BBfAp63JFpZeuDT0brSWfsOQc0jl5DYtkkv2aenJe/gibZLNu4Q8G28vVisALcRsOm6oNj6S22cbuHXLj+QrLQ56iSiuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qVZv6NGo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qVZv6NGo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZWJM3705302;
	Thu, 8 Oct 2026 08:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ytTwUr86eNJYckVvHDid8ZEkvzra
	3zrnia+uJJs3nyQ=; b=qVZv6NGohDJRnB5M0qjMXiW6GDkPfSv1Rsu1wNdOjDRC
	zKeb8U2R2qxpP6OIlWpupqHqupLhRM2bmQlqmjFhP5YudRjSOvGsX5eTF2LADKoE
	6JWJaG2CwhKLhk81ox6tENNb2SUCnhtgulWcYXMUWZ39h5L6zVFbfDU9Uyx9c/XU
	4yramRfdzSNV3gOJPgata9lUMGK8/0ig+BbCuFE+edO2lGuI49LZbrUmr80P0WsK
	omyHkD+9vaf5g5HeIiB5HXr4uNaoeE0G8fiZ/jfApr7fFq9+cbLjywFKhLfM1z96
	wEkZ7E5HeolMMzsN13+xuldKRBCn9cv+Pw6Ldz1tKg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1a6ka-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987Ic3W3107280;
	Thu, 8 Oct 2026 08:31:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek6jsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6988VGVb40763826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:31:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2DD420043;
	Thu,  8 Oct 2026 08:31:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBD020040;
	Thu,  8 Oct 2026 08:31:13 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:31:13 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
Date: Thu, 08 Oct 2026 10:30:46 +0200
Message-Id: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNywrCMBREf6XctSlJWk3rShD8ALfSRXOTmgv2Q
 VJLpeTfDcWdyznDnNkgWE82wDnbwNuFAo1DCuKQAbp2eFpGJmWQXJ54LUrmaLLeUJjaGV1HK5N
 1iVypAispIc0mbxPelQ+4367QJOgozKP/7DeL2Kuf8fhvXATjDIXSRldYdJpfXjS815x0n+PYQ
 xNj/AKxe43kuQAAAA==
X-Change-ID: 20260914-hiperdispatchfix-294c0773c822
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac754d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=YzCiCCVzqlv1HUvDBbYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX+l4HzNbIzfsP
 xjZt/FMyP+msi8c9+DhO1szZmajUz3thNrG6AewBpGdAYMyb/lGxgxDCOsphguKFU3ju9j7L3Pv
 vJ+rs9+GdIQdC0SPaa7fnFxOVjbs0AwedQ4RSaNWa1WWqV4/ahuhhpAOcJU4Ri6vxn55eWp+Kqz
 UAtU6Z5CifiaD1NfdDQOlTg3LXijepDeut3PAF1rDpuyn96fOMI7oIUyItdwzLYKSyheUPiza9Z
 52GQzzyOWuO1DHOusDqHvaWEWISGlLIr9X6VTrDgarRiPJDX8S2T4rxGucTcMvTLu7SF9O46rZG
 JtE42lwctDcRhJlcE3VsGmdwhcu3e5YDXBivp/Qx64JOq9kWupGhyj3izRsXA2Aw3vjXmAsitq7
 tGUcIK75OabR7Xcnr7EI4xFNhiicNHKxw2Jsb8WW722EKOdQ1bEImGg2LM8cJ2IAHB+Ao0TXGYM
 2LO+YB85+xVCb1L5/Wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX5hmDyGvp63F4
 agugktdibWtcrSKjHpOx0hJXw+l1INtS4QuW0Gjx5kx8G82Efibglb+8HxGWhJ1g1uy7FTv7djm
 zlooa6d3KUtCPxIA1JGuyz+K6SWKbMQ=
X-Proofpoint-GUID: 2rCdagU5lNnohfRvbdEP5k6fqZq66m-S
X-Proofpoint-ORIG-GUID: GIoLoVc6f2po_Uieqnt4pXCnm23QoiXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

Summary
===========================================================================
On systems with asymmetric CPU capacities, the scheduler prefers fully idle
cores over idle SMT siblings of busy cores. This works generally well but
virtualized platforms where low capacity cores should be avoided are not
considered. Introduce a new config option and arch hook to prioritize
SMT utilization.

Background
===========================================================================
The scheduler has been moving toward better utilization of fully idle cores
and avoiding SMT penalties. This trend (notably after commit 25a32e400a14
("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selection")
broke the behavior s390 is relying on to concentrate workloads on its
high-capacity cores. On s390 CPU capacities represent the CPUs runtime
entitlement assigned by the hypervisor. The idle SMT siblings of busy
high-capacity cores start to perform better than fully idle low-capacity
cores as the whole machine(containing the logical partitions) starts
approaching to a {fully,over}loaded state. Grouping load on high-capacity
cores keeps shared low-capacity cores(which are shared more aggressively)
idle longer, reducing noise to neighboring partitions and improving
overall performance.

Approach
===========================================================================
This series introduces SCHED_IDLE_SMT_PRIO config option and the
sched_idle_smt_prio static branch, allowing architectures to treat idle
SMT siblings of busy cores as equal candidates during asymmetric capacity
load balancing.
Static branch checks are placed at paths considering fully idle cores
over idle SMT threads in presence of asymmetric CPU capacities within
scheduling groups. Inserted checks mostly override hints for idle core
selection or cause early exits favoring idle SMT siblings.
One more static branch check is added to new task path in order to favor
high capacity SMT siblings during initial task placement, therefore the
tasks are immediately placed in high capacity SMT siblings instead of
considering most idle but low capacity cores.

Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
implementing arch_needs_idle_smt_prio(), which is evaluated during each
asym_cpu_capacity_scan() to track the state as runtime topology changes.

The second patch enables the feature for s390 when running on
hardware-backed topology in an LPAR with vertical polarization active
and system is approaching to a target state.
Otherwise the branch stays disabled and the scheduler falls back to the
standard idle-core preference.

No functional change on architectures that do not select
ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO.

Performance Results
===========================================================================
Since this change effects the {fully,over}loaded state it is difficult
to test at the moment. Therefore there are no concrete numbers or
metrics for now for s390.
For architectures which do not opt in to this feature, no performance
change is expected.

Considerations and Open Questions
===========================================================================
The main goal for this series is adding a simple mechanism for
architectures to switch between idle core and idle SMT priority while
keeping the introduced footprint as small as possible. But there are
some ideas and questions to consider;

1. Should arch_needs_idle_smt_prio() hook be removed?
   The architecture hook is there to allow for any sort of logic to
   dynamically decide when to flip the mechanism, but it can also be
   removed if everyone agrees that this behaviour is not something that
   should be dynamically flipped. It can be simply tied to detection of
   asymmetric capacities and selection of Kconfig option.

2. Is there a simpler way to implement this mechanism?
   The proposed approach is chosen as the other features effecting the
   scheduler's behavior, use the same method. If there is a more
   efficient way to implement the same mechanism I'd be glad to use
   that instead.

3. There are no performance measurements *yet*.
   On s390 the ideal conditions for this mechanism to be beneficial
   usually surface when the whole system is fully loaded and resource
   sharing between the logical partitions starts to get expensive.
   Creating such an environment requires time, therefore no benchmark
   results are available yet.

---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4

Mete Durlu (2):
      kernel/sched: Introduce idle SMT priority
      s390/topology: Enable SCHED_IDLE_SMT_PRIO

 arch/Kconfig                     | 14 +++++++++
 arch/s390/Kconfig                |  1 +
 arch/s390/include/asm/topology.h |  5 +++
 arch/s390/kernel/topology.c      |  9 ++++++
 include/linux/sched/topology.h   |  9 ++++++
 kernel/sched/fair.c              | 67 +++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h             | 10 ++++++
 kernel/sched/topology.c          | 17 ++++++++++
 8 files changed, 114 insertions(+), 18 deletions(-)

