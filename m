Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447A361952
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559977; cv=pass; b=Zon69fn2d3ort1MRj2Z2DHukqQhwGZ/MIvh0FbX8xC3B1tPsoXm+gXf32mmLW4+VkE+xMIWw4DZ6kljA3dyQky6LjV91n93doFXOST82RbQ5zPrq1pexN2+Jc9FI+ntP5j0V3lCPLINk1zQySjbLn4tZPu1wh/JExmClnFvBRlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559977; c=relaxed/simple;
	bh=i+0vhK7KdeGd+TGTohnPLeaq8+FtlOZk1wYHZyh90FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBKmt5gveH7EA8TsHZo6HFOBqM0bHHgo5tcgtRYq23lPIuc2DKhEqfk16MgJQF6iQYOrfzazesNxGB8OoNgAojhM3lnGugCakzmhwNrq2iAcD7SgyC4N7jvg0Xs/7gafBk2tCqyIVxP2PihkbiM7TBHKmLMU22Sq2JHTmTTifYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nL9IQ2Xp; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nL9IQ2Xp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3286979a12.1
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2026 08:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791559973; cv=none;
        d=google.com; s=arc-20260327;
        b=jC6QvmFwchJusoxQmBQrfvpZv+ZPbiyP68YXBZILhwDB/frI+bqM7aq/8Cu3BCHErd
         4L4fyNEZNVUGTh+m8NnF3sJWsI0m9/v9RCzbxkIAmldpBqckSsYRUXWQ8f13BzZrK+EI
         wuZOStfqmg41+AQ7J5FHbl+TA8FBGTtrJ7IUBYttNMbdldp4/9JPc3lVX5bWnW730EJy
         BezKuIbdB3RCS6/Lrbc0CUz/qvDOE2Srqmlxga6WwsO0npLrPamyaDUw1NZE444PO065
         cnBwQ2kNUz3t17ivERfn/PQaclGFK8F49tkyNnGoF8lB5YxC+0pPb/b9Wp1OprSXMSsT
         rjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YuC8idDGGF55BIM+qITaoxGd31XXSYrZn6NB7JRdTHE=;
        fh=DMAF7ivjtQwJrjnl2tJRz0g0Eg4CRddfPTkCLj49kEM=;
        b=qN06crSrTjTQ9/1hJjfQFyCPvzGSZWwCudIzTn+3c/z/70fHOeo5U+d4YXom7a5WyZ
         Xnd2jwdiCu6q2XqL3v87lhHLU/B4RN0v2kikd7xKL5QUDepPigzMn7IXIwrGXbSLkKwv
         7wIAbEHkkvKMtoyowLMIvjKnkjBKZ3fOwSJq3skBFzGEu+OI7S3iZxmvwdrPsTqJum1o
         m313x49ywCBfY1AL5lZjxwq4feWg1Hxk7Lgj9OJ3aSAYUCcHnCEjoLLt2IFcFBJXGEZV
         ewJytPiilA5ook22ALsPXDQGPqqCsDJ3XCChSIxdm6S/DcKicbcuOONyNpFzlRbBT6Ys
         rnmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791559973; x=1792164773; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YuC8idDGGF55BIM+qITaoxGd31XXSYrZn6NB7JRdTHE=;
        b=nL9IQ2XpOxdF+76XDTti9EvrGGcTAC51eVul9glmye6t+TiQIyGTviO6TLlt9A9pdI
         sN9Sj7FAvOI9fDY5Fd4LzIXdROoCLwxBDS3kgszbTgpsmfGSSj4TqvYaQxasIdmvupR6
         HHoBr5bhsxR8jiVMDeEHVwm0W9oOApMK3KK3ZERKfLUAbsIHNT4v/+2NtpbghJEZok1q
         ZGf4gB8zv5cMglW0uovxdzb6Xvtg8TztUz9/kWCidQJhtvCAemZOc/LVWX3gWOs5eIz3
         MvfyCeKyNL6su2U3BCw9yW996Eu69FxU80wduM+YJHo98GknzYpeoe6iIMSBbP5EGpua
         OJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559973; x=1792164773;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YuC8idDGGF55BIM+qITaoxGd31XXSYrZn6NB7JRdTHE=;
        b=JCzBZDU+Vg2WeIkk2Jd1W9qkLSNM+W+vIugg0IXfr6bB8EzRLCackEn6pwpqKiEIhf
         dCsUUmvNfXyeyORisyLgc9Cl6pEhCnST+QhP14smPh6RvIvt5+dasmEyZTz0YNQogTkL
         D4NipUasY5I/8uvVaktnfGgLiBzn/MdY3qOzUZ8dR6xxL9QnltOStfyjqKdb+cegnK6X
         c4c+YoqgGQVJQ+fOdbGvq8Cp0Wz7OlgY1uIqtfprIQe62dkCsg6NmdAXoYKHHvTs+Ack
         aNFjwCJBMoo7W1qWwEu9qqa9yIjXwxGMDeWMomPe30Vk+aoOzDtSOzjoNpJGjfgj6+ED
         T0sg==
X-Forwarded-Encrypted: i=1; AKwUvBx1LuoFPc+4qf3dJPjN7DbL0waX+eTwnR91yT7yTO9+sGEufUIFSuhna28T3SKSuL5TCQqVyWJtKNNj@vger.kernel.org
X-Gm-Message-State: AFq9FYIvPOtbRhGXT+EuWZR1482Qmc5FjDj7wnihSlndvQ0SEreW8Ya0
	GDX+c3+arPOCmzCUqb5fz6YdrxByYH6VrYglL8W9ZnZAYphjCPX6/K7m5M+FilLffymNBLT5nmi
	HQstRwE2D2XVq5eEN0fpKi09GvuMFBn5FR37GzeUm2w==
X-Gm-Gg: AYBFou2Sr+w6QSj3Ky4qjKFIsHRdyZ9Z+b00ONPXqhNp/IdI/cP/0ITlDTTVF0l+Bq8
	FoGIiLce3y3v2dfTx9+XHUQ/iH9gOp5+lHFiZjeSjZ00ARqGytfG/LVyx1jjse2NPpkI1aANHqB
	FxDxbCQ28LlmGS5S6Jil+1IggYOr3GJBb1c4NzMpa3f8tx4xHKbPrvrlEFLNVNj1j45kd9QaufL
	ydW2QIYVX4aFdULhC7v7iNP9Jxm3qjv2ph1vK+Agz7nhALe+lpCpCTmeoOjieFqIiFgykOHribe
	HTAXXr10xiy8+oMJKQzN8G0ehErKHMAtTL1Ln/KW4bK2IqTVjt7kpGmYYfsplxZZWb3RnDtuXIf
	tVgulELxQoyvPcJM4bCGYiw==
X-Received: by 2002:a05:6402:a215:10b0:6af:a5bd:419d with SMTP id
 4fb4d7f45d1cf-6b17ae879d0mr1750601a12.4.1791559972891; Fri, 09 Oct 2026
 08:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com> <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
In-Reply-To: <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 17:32:41 +0200
X-Gm-Features: AclHuK8rsnsr2XjircQ2Y2044oxS5c-q2qAVaXI6vBuK4i4-8JPIJQDlG10RXcU
Message-ID: <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Mete Durlu <meted@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Chen Yu <yu.c.chen@intel.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 17:25, Mete Durlu <meted@linux.ibm.com> wrote:
>
> On 08/10/2026 16:58, Shrikanth Hegde wrote:
> > Hi Meter/Andrea.
> >
> > On 10/8/26 5:40 PM, Andrea Righi wrote:
> >> Hi Mete,
> >>
> >> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
> >>> Summary
> >>> ===========================================================================
> >>> On systems with asymmetric CPU capacities, the scheduler prefers
> >>> fully idle
> >>> cores over idle SMT siblings of busy cores. This works generally well
> >>> but
> >>> virtualized platforms where low capacity cores should be avoided are not
> >>> considered. Introduce a new config option and arch hook to prioritize
> >>> SMT utilization.
> >
> > That's true only under physical CPU contention right? or is it always?
>
> Right, because of that s390 treats all CPUs as equal and starts to
> assign lower capacities to CPUs with low entitlement once a certain
> steal time threshold is crossed (aka physical CPU contention).

I'm not sure to get what your topology is because "if s390 treats all
CPUs as equal"  then you should never use select_idle_capacity()
because  their capacity should be fixed and equal and
SD_ASYM_CPUCAPACITY_FULL never set.
If your hypervisor lowers the capacity once a certain threshold is
crossed, we already account for the steal time in the scheduler with
irq and remove it from the capacity available for tasks but the
original capacity doesn't change.

>
> >>>
> >>> Background
> >>> ===========================================================================
> >>> The scheduler has been moving toward better utilization of fully idle
> >>> cores
> >>> and avoiding SMT penalties. This trend (notably after commit
> >>> 25a32e400a14
> >>> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle
> >>> selection")
> >>> broke the behavior s390 is relying on to concentrate workloads on its
> >>> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
> >>> entitlement assigned by the hypervisor. The idle SMT siblings of busy
> >>> high-capacity cores start to perform better than fully idle low-capacity
> >>> cores as the whole machine(containing the logical partitions) starts
> >>> approaching to a {fully,over}loaded state. Grouping load on high-
> >>> capacity
> >>> cores keeps shared low-capacity cores(which are shared more
> >>> aggressively)
> >>> idle longer, reducing noise to neighboring partitions and improving
> >>> overall performance.
> >>>
>
> [...snip...]
>
> >>> Considerations and Open Questions
> >>> ===========================================================================
> >>> The main goal for this series is adding a simple mechanism for
> >>> architectures to switch between idle core and idle SMT priority while
> >>> keeping the introduced footprint as small as possible. But there are
> >>> some ideas and questions to consider;
> >>>
> >>> 1. Should arch_needs_idle_smt_prio() hook be removed?
> >>>     The architecture hook is there to allow for any sort of logic to
> >>>     dynamically decide when to flip the mechanism, but it can also be
> >>>     removed if everyone agrees that this behaviour is not something that
> >>>     should be dynamically flipped. It can be simply tied to detection of
> >>>     asymmetric capacities and selection of Kconfig option.
> >>>
> >>> 2. Is there a simpler way to implement this mechanism?
> >>>     The proposed approach is chosen as the other features effecting the
> >>>     scheduler's behavior, use the same method. If there is a more
> >>>     efficient way to implement the same mechanism I'd be glad to use
> >>>     that instead.
> >>>
> >>> 3. There are no performance measurements *yet*.
> >>>     On s390 the ideal conditions for this mechanism to be beneficial
> >>>     usually surface when the whole system is fully loaded and resource
> >>>     sharing between the logical partitions starts to get expensive.
> >>>     Creating such an environment requires time, therefore no benchmark
> >>>     results are available yet.
> >
> > If it only under contention, then you probably don't want to use low
> > cores for
> > anything right? If above is yes, then using steal governor would help to
> > avoid low
> > core if you mark them as non-preferred. (which i guess you guys are
> > exploring already)
>
> IMO it should be dynamically adjustable depending on the contention
> level. But yes, on worst case low capacity cores should be avoided by
> marking them as non-preferred.
>
> > But, find_new_ilb isn't aware of preferred CPU state as of initial patches.
> > I had thought of making a change to pick a idle preferred CPU instead of
> > a idle non-preferred
> > core for idle load balancing. It is not done due to below reasons.
> > - Performance numbers didn't show any major improvements with real life
> > workloads.
> > - Code becomes quite complex for find_new_ilb.
>
> IIUC, find_new_ilb() finds an idle CPU that can do load balancing
> for other idle CPUs. As long as the tasks don't land on non-preferred
> CPUs, where ilb occurs should not matter. (At least for s390)
>
> >>
> >> I'm wondering if we could build on Shrikanth's cpu_preferred_mask
> >> infrastructure
> >> to express a "soft preference" for the s390 higher-entitlement CPUs.
> >> Unlike the
> >> mask's current behavior, soft preference would allow tasks to spill
> >> onto other
> >> CPUs once the preferred CPUs have no idle threads available (we have
> >> something
> >> like this in sched_ext's scx_cosmos).
> >>
> >
> > cpu_preferred infra won't allow to spill over if preferred CPUs don't
> > have an idle CPU.
> > It rather enforces packing onto preferred CPUs even if it means rq has
> > more than 1 task.
>
> I think what Andrea has in mind is something similar to what he did with
> select_idle_capacity(). Depending on the state of the non-preferred mask
> and other factors cores and SMT siblings can be evaluated as ideal
> candidate somehow. Wouldn't it be possible to extend the
> infrastructure you introduced to achieve this?
>
> >> That might let us preserve the general preference for fully idle SMT
> >> cores while
> >> searching in this order: fully idle preferred cores, idle SMT threads on
> >> preferred cores, then non-preferred cores. This current patch series
> >> seems to
> >> drop the first distinction, allowing a partially idle preferred core
> >> to win even
> >> when another preferred core is fully idle.
> >>
> >> This would need to coexist with the steal governor's stronger use of
> >> cpu_preferred_mask, so I'm suggesting it as a potential direction to
> >> explore
> >> rather than a drop-in replacement.
>
> I think this makes a lot of sense. An approach to first fill preferred
> CPUs before spilling to the non-preferred cores until contention
> forces the evacuation of non-prefered CPUs.
>
> Shrikanth, would it make sense if I try to find a way to extend your
> current implementation in this way?
>
> Thanks!
> -Mete
