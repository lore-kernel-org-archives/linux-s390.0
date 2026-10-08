Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D53EA957;
	Thu,  8 Oct 2026 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496338; cv=none; b=Z3Q0WQOfLUo+2CJKl2Cp1KZL+edokVC0Sf+amZa4IjQ1o8b5Wo8ldT9IORMn9HeIWMyLEi33PMwrZjLySXkVZ8mtfZ7yuAqZ8wnk2B+1RXIACZFXCdmm+zzoh36pfN/LY/MlHNZ+lQFktdanUcgJdNwVKfQ20ZMMxFcPeyYUKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496338; c=relaxed/simple;
	bh=VFMtpDGQ6NtHr0UNClV9iiXHAtjgfbnLbgOLKDEkDvA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQSdkp+2quGeo7H0HvYG2V2XtEvyf2Sics6qCRks4QyeS4wTsXVwmDkqGOtcEZXIPuXanl7c4xxXBMk1hJK0ehxQpUFfnwAsZfFJKVt0PBQKFxaeEPhfgP8WWpwZ7wAEveeaZbs3ZCh0Nb5/UFQux8ajIvbrmq9JswkP9mX7ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWyp9vHe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWyp9vHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496337; x=1823032337;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VFMtpDGQ6NtHr0UNClV9iiXHAtjgfbnLbgOLKDEkDvA=;
  b=IWyp9vHeoWENJ4lbIwt/VFR7zB0ocFER9UMAW2xFHIiobE0FYtVPe+/S
   B9o9gbH5He8ObClhdGopE3YY2NLxbxUjow/1GHDRFEWC3M0HR3cduEsDi
   7zIP8VZjm3kFqMIjj3LE/loGEM0mFDwZz61b2NRso1eWCGnXOwt4OUCyR
   Ws+T5ZiH/6loi7hjgSJ4WOQVl4jMh0pUX32Z0F9oIJjINUKUMXvXMZ9d3
   jMTJx7VpmOt5beHseg4F8R6CWSqH2KZyKs7qKcM/bbCAu/IR0RNuMDabT
   WQ/LjV3R8+QBINkn3igdpAH9juHOvVPy8p5Vzo9NRNj5WJ3kD6KDyWLPB
   Q==;
X-CSE-ConnectionGUID: nSOqQxioT4uyLKsQNPzAiw==
X-CSE-MsgGUID: DZCl9TGaTSGMxO0D7yxHmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="293869"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="293869"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:52:15 -0700
X-CSE-ConnectionGUID: fE5RVaruQxWcpjQJ7FDELw==
X-CSE-MsgGUID: oBvg58+kT/SL/EOp4ZFNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="269742"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:52:14 -0700
Message-ID: <30e586ab643a8911f6c3cd930796292a7da460ef.camel@linux.intel.com>
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for
 asymmetric capacity systems
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Andrea Righi <arighi@nvidia.com>, Mete Durlu <meted@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Chen Yu <yu.c.chen@intel.com>,  Ilya Leoshkevich	
 <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Date: Thu, 08 Oct 2026 14:52:14 -0700
In-Reply-To: <aseIPhrDGCYFtJNE@gpd4>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
	 <aseIPhrDGCYFtJNE@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-08 at 14:10 +0200, Andrea Righi wrote:
> Hi Mete,
>=20
> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > On systems with asymmetric CPU capacities, the scheduler prefers fully =
idle
> > cores over idle SMT siblings of busy cores. This works generally well b=
ut
> > virtualized platforms where low capacity cores should be avoided are no=
t
> > considered. Introduce a new config option and arch hook to prioritize
> > SMT utilization.
> >=20
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > The scheduler has been moving toward better utilization of fully idle c=
ores
> > and avoiding SMT penalties. This trend (notably after commit 25a32e400a=
14
> > ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selecti=
on")
> > broke the behavior s390 is relying on to concentrate workloads on its
> > high-capacity cores. On s390 CPU capacities represent the CPUs runtime
> > entitlement assigned by the hypervisor. The idle SMT siblings of busy
> > high-capacity cores start to perform better than fully idle low-capacit=
y
> > cores as the whole machine(containing the logical partitions) starts
> > approaching to a {fully,over}loaded state. Grouping load on high-capaci=
ty
> > cores keeps shared low-capacity cores(which are shared more aggressivel=
y)
> > idle longer, reducing noise to neighboring partitions and improving
> > overall performance.
> >=20
> > Approach
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > This series introduces SCHED_IDLE_SMT_PRIO config option and the
> > sched_idle_smt_prio static branch, allowing architectures to treat idle
> > SMT siblings of busy cores as equal candidates during asymmetric capaci=
ty
> > load balancing.
> > Static branch checks are placed at paths considering fully idle cores
> > over idle SMT threads in presence of asymmetric CPU capacities within
> > scheduling groups. Inserted checks mostly override hints for idle core
> > selection or cause early exits favoring idle SMT siblings.
> > One more static branch check is added to new task path in order to favo=
r
> > high capacity SMT siblings during initial task placement, therefore the
> > tasks are immediately placed in high capacity SMT siblings instead of
> > considering most idle but low capacity cores.
> >=20
> > Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
> > implementing arch_needs_idle_smt_prio(), which is evaluated during each
> > asym_cpu_capacity_scan() to track the state as runtime topology changes=
.
> >=20
> > The second patch enables the feature for s390 when running on
> > hardware-backed topology in an LPAR with vertical polarization active
> > and system is approaching to a target state.
> > Otherwise the branch stays disabled and the scheduler falls back to the
> > standard idle-core preference.
> >=20
> > No functional change on architectures that do not select
> > ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO.
> >=20
> > Performance Results
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > Since this change effects the {fully,over}loaded state it is difficult
> > to test at the moment. Therefore there are no concrete numbers or
> > metrics for now for s390.
> > For architectures which do not opt in to this feature, no performance
> > change is expected.
> >=20
> > Considerations and Open Questions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > The main goal for this series is adding a simple mechanism for
> > architectures to switch between idle core and idle SMT priority while
> > keeping the introduced footprint as small as possible. But there are
> > some ideas and questions to consider;
> >=20
> > 1. Should arch_needs_idle_smt_prio() hook be removed?
> >    The architecture hook is there to allow for any sort of logic to
> >    dynamically decide when to flip the mechanism, but it can also be
> >    removed if everyone agrees that this behaviour is not something that
> >    should be dynamically flipped. It can be simply tied to detection of
> >    asymmetric capacities and selection of Kconfig option.
> >=20
> > 2. Is there a simpler way to implement this mechanism?
> >    The proposed approach is chosen as the other features effecting the
> >    scheduler's behavior, use the same method. If there is a more
> >    efficient way to implement the same mechanism I'd be glad to use
> >    that instead.
> >=20
> > 3. There are no performance measurements *yet*.
> >    On s390 the ideal conditions for this mechanism to be beneficial
> >    usually surface when the whole system is fully loaded and resource
> >    sharing between the logical partitions starts to get expensive.
> >    Creating such an environment requires time, therefore no benchmark
> >    results are available yet.
>=20
> I'm wondering if we could build on Shrikanth's cpu_preferred_mask infrast=
ructure
> to express a "soft preference" for the s390 higher-entitlement CPUs. Unli=
ke the
> mask's current behavior, soft preference would allow tasks to spill onto =
other
> CPUs once the preferred CPUs have no idle threads available (we have some=
thing
> like this in sched_ext's scx_cosmos).

Soft preference is okay if contention is low.
But if steal% remains high, we may still need to transition to hard
boundaries/preferences on the cores to run on to bring steal% down.

Tim

>=20
> That might let us preserve the general preference for fully idle SMT core=
s while
> searching in this order: fully idle preferred cores, idle SMT threads on
> preferred cores, then non-preferred cores. This current patch series seem=
s to
> drop the first distinction, allowing a partially idle preferred core to w=
in even
> when another preferred core is fully idle.
>=20
> This would need to coexist with the steal governor's stronger use of
> cpu_preferred_mask, so I'm suggesting it as a potential direction to expl=
ore
> rather than a drop-in replacement.
>=20
> What do you think (Mete / Shrikanth)?
>=20
> Thanks,
> -Andrea
