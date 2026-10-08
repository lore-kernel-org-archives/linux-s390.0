Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861D439328;
	Thu,  8 Oct 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494974; cv=none; b=RYaDKclDxPnLe/bduu+/j0LnFuDIYT/KXzdmNybkwwFJBodtqYt1WccbcSnL0WrIYeCIYaI+2mpl/q+EiADax+PI4DsUfVfaJxbnAuGjfMPI79czEQNErcGNqDMh1RmF1PasT5p4VOWZIYpO8Ypo3xj9t8+kzRqrcMTAXGkboNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494974; c=relaxed/simple;
	bh=EiGZwByYUKxJnWm9QQlA+0mpal9A7lNZUKiPeMtBHgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUh+9ZbeYDm9V0/Cj4EJAxToTlUiIGculWxvieJNaQVqFhM/ANXfPvUdevu0/W3o4D8lN5qp6qlr+/94okvND6LNEZG7w0xXMhPa/VaMEpZ1V/byXjSdv1dgH///kcnA8apculJhVLjhN83HO2gv/lgZRWXsnYxYnaMmHFYJ/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/gCUme1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/gCUme1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494973; x=1823030973;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EiGZwByYUKxJnWm9QQlA+0mpal9A7lNZUKiPeMtBHgg=;
  b=k/gCUme1nxQglP204HDauCRd6BpMe6TDERr2UzSrmKWih5JMxtm54C/Q
   Q0z7IDeRsDWKbhiT3+dlTxsB4VCZqu6Q5EuDJN2OQ9ds+irbVoKH4iGWi
   DCe4r9HCTIeLfzPIRSPsXKVaZnYFVwrbdOd6pl9472PmBD77DaQ+rylKs
   YmX6FyJLBpncBZSEAM7RtUKd2tNjSGCCUPC2V65fKk9hAMBwZAl+es5RD
   RJ++OifhspAaGbAvizJQCmIT4ToIK87lyVlxXE5YZZIpb4dmWvfz0HLI2
   GPT2QDoC+dB1vaDq9A4geqbL+X2v+35FUlGgSGyVGVh86YVBiFf7MIFOr
   g==;
X-CSE-ConnectionGUID: KIDjdo2dQziYBI5ZctjORA==
X-CSE-MsgGUID: 7U2uoqM9Tmqnf8esd3m6eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="170968"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="170968"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:29:32 -0700
X-CSE-ConnectionGUID: 1qBymP2QR7qa4dwwhkJfvg==
X-CSE-MsgGUID: Adj6RNJPQXu56ZfsJkGOwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="476419"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:29:31 -0700
Message-ID: <76e09124223f7adb7f486fd861ead3bdbf595016.camel@linux.intel.com>
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for
 asymmetric capacity systems
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Mete Durlu <meted@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot	 <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Shrikanth Hegde	 <sshegde@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Andrea Righi <arighi@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Date: Thu, 08 Oct 2026 14:29:30 -0700
In-Reply-To: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-08 at 10:30 +0200, Mete Durlu wrote:
> Summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> On systems with asymmetric CPU capacities, the scheduler prefers fully id=
le
> cores over idle SMT siblings of busy cores. This works generally well but
> virtualized platforms where low capacity cores should be avoided are not
> considered. Introduce a new config option and arch hook to prioritize
> SMT utilization.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> The scheduler has been moving toward better utilization of fully idle cor=
es
> and avoiding SMT penalties. This trend (notably after commit 25a32e400a14
> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selection=
")
> broke the behavior s390 is relying on to concentrate workloads on its
> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
> entitlement assigned by the hypervisor. The idle SMT siblings of busy
> high-capacity cores start to perform better than fully idle low-capacity
> cores as the whole machine(containing the logical partitions) starts
> approaching to a {fully,over}loaded state. Grouping load on high-capacity
> cores keeps shared low-capacity cores(which are shared more aggressively)
> idle longer, reducing noise to neighboring partitions and improving
> overall performance.
>=20
> Approach
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> This series introduces SCHED_IDLE_SMT_PRIO config option and the
> sched_idle_smt_prio static branch, allowing architectures to treat idle
> SMT siblings of busy cores as equal candidates during asymmetric capacity
> load balancing.
> Static branch checks are placed at paths considering fully idle cores
> over idle SMT threads in presence of asymmetric CPU capacities within
> scheduling groups. Inserted checks mostly override hints for idle core
> selection or cause early exits favoring idle SMT siblings.
> One more static branch check is added to new task path in order to favor
> high capacity SMT siblings during initial task placement, therefore the
> tasks are immediately placed in high capacity SMT siblings instead of
> considering most idle but low capacity cores.
>=20
> Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
> implementing arch_needs_idle_smt_prio(), which is evaluated during each
> asym_cpu_capacity_scan() to track the state as runtime topology changes.
>=20
> The second patch enables the feature for s390 when running on
> hardware-backed topology in an LPAR with vertical polarization active
> and system is approaching to a target state.
> Otherwise the branch stays disabled and the scheduler falls back to the
> standard idle-core preference.
>=20
> No functional change on architectures that do not select
> ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO.
>=20
> Performance Results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Since this change effects the {fully,over}loaded state it is difficult
> to test at the moment. Therefore there are no concrete numbers or
> metrics for now for s390.
> For architectures which do not opt in to this feature, no performance
> change is expected.
>=20
> Considerations and Open Questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> The main goal for this series is adding a simple mechanism for
> architectures to switch between idle core and idle SMT priority while
> keeping the introduced footprint as small as possible. But there are
> some ideas and questions to consider;
>=20
> 1. Should arch_needs_idle_smt_prio() hook be removed?

Hi Mete,=20

One assumption in the series should be made explicit, and I think
it answers your question 1.=20

The idea only works if two CPUs that the guest sees as SMT siblings
really run on the same physical core. "An idle sibling of a busy
high-capacity core" is cheaper than a fully idle low-capacity core
only because it uses a physical core the partition already has. That
holds on an LPAR, where hypervisor dispatches whole cores. It does not
hold in general for a guest whose hypervisor schedules vCPUs one at a
time, such as a typical KVM guest with "threads=3D2". There the guest's
sibling masks are just a description, and packing onto "siblings"
gives no benefit.

Nothing in the series checks this, and it is not documented:

- In patch 1, the default arch_needs_idle_smt_prio() returns true,
  and the Kconfig help does not mention that siblings must share a
  physical core. Any arch that selects
  ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO takes this on without being told.

- In patch 2, the hook checks only the topology mode:

> +bool arch_needs_idle_smt_prio(void)
> +{
> +     if (topology_mode !=3D TOPOLOGY_MODE_HW)
> +             return false;
> +     return true;
> +}

Today s390 seems to be safe because sibling masks are
only built in HW mode.  It is the only place where this
precondition can be enforced.

So I would keep the hook. It is the only place where this
precondition can be enforced. Removing it and tying the feature to
"Kconfig + asymmetric capacities" would drop the check entirely.
Concretely:

1) Document the contract in the Kconfig help and above the hook,
   for example: "Only select this if CPUs reported as SMT siblings
   are always dispatched on the same physical core."

2) Make the s390 hook test the conditions from the cover letter,
   something like:

        return machine_is_lpar() &&
               topology_mode =3D=3D TOPOLOGY_MODE_HW &&
               smp_cpu_mtid;

Tim

>    The architecture hook is there to allow for any sort of logic to
>    dynamically decide when to flip the mechanism, but it can also be
>    removed if everyone agrees that this behaviour is not something that
>    should be dynamically flipped. It can be simply tied to detection of
>    asymmetric capacities and selection of Kconfig option.
>=20
> 2. Is there a simpler way to implement this mechanism?
>    The proposed approach is chosen as the other features effecting the
>    scheduler's behavior, use the same method. If there is a more
>    efficient way to implement the same mechanism I'd be glad to use
>    that instead.
>=20
> 3. There are no performance measurements *yet*.
>    On s390 the ideal conditions for this mechanism to be beneficial
>    usually surface when the whole system is fully loaded and resource
>    sharing between the logical partitions starts to get expensive.
>    Creating such an environment requires time, therefore no benchmark
>    results are available yet.
>=20
> ---
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
>=20
> Mete Durlu (2):
>       kernel/sched: Introduce idle SMT priority
>       s390/topology: Enable SCHED_IDLE_SMT_PRIO
>=20
>  arch/Kconfig                     | 14 +++++++++
>  arch/s390/Kconfig                |  1 +
>  arch/s390/include/asm/topology.h |  5 +++
>  arch/s390/kernel/topology.c      |  9 ++++++
>  include/linux/sched/topology.h   |  9 ++++++
>  kernel/sched/fair.c              | 67 +++++++++++++++++++++++++++++-----=
------
>  kernel/sched/sched.h             | 10 ++++++
>  kernel/sched/topology.c          | 17 ++++++++++
>  8 files changed, 114 insertions(+), 18 deletions(-)
