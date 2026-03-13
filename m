Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7023D281;
	Fri, 13 Mar 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435715; cv=none; b=rc+yTaVsjS9ZtY3LjLe3tDPy5kZgEYbcnwzIlyqHTwDyrR4035j683UhdloDOPl+bKjdsyw5t++GfRSZbibhtTPkcoNOZpYRQjKYjqtCyjVJK45tJStveSGAEblI8y5sM7KqeeuszVpbUSw436pvryqSzQunwN/bz3wj3hUTnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435715; c=relaxed/simple;
	bh=6wByqVucn1HppWOOQjPplLzjC9lUHR9GrWWXOkgckGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4QEyhr9XCyA3Zko6R0xC0fejb24xczveN7rH9B4wkCPtfYLGFXb4du6RsmrPRuTApeaEIO4r6NFVZucmUcAUuE85aDKM0X1zfrSQiMljNNXoQB3Al353I6TYVUrMvBINYc9AwUXjp4W1IqwEQwOAIuBlE2kkrUhdnzfeGhaNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvsGM6ur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvsGM6ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92944C19421;
	Fri, 13 Mar 2026 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773435715;
	bh=6wByqVucn1HppWOOQjPplLzjC9lUHR9GrWWXOkgckGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvsGM6urlplIpyHI2gd1kSO0pBDHJVbqtH8BG+11C3TuH57UBTWy8drvMGnv1XkBd
	 42/Equ3SvPBtJfrT9gmbQ//3ayyPH3GmY+MMPwU0VIp3jqG4ZOtppm8sLebXt3bpoO
	 sOthEJ3p3mgEV9ojWhNgjxIxUtshhOAOBau2hhNsTRdYq+UsEKUhT03n+P0Ai91zt4
	 as2Ac1f+dTpvyxKKuvxiFPaT48W4BdpjmuGYinhUhIKECOCyXnz2ad/SwvaPUwfzx/
	 Z9gIUMiDxayDGrunsyLvGkGHdrgu5977xwjSHsDBAwfZ0rme4Dvbjmz/TnfrfjQAKH
	 s0fXWfi1rB7zg==
Date: Fri, 13 Mar 2026 14:01:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
Message-ID: <abR7QU_bDGref9II@google.com>
References: <20260312031928.1494864-1-irogers@google.com>
 <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com>
 <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
 <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
 <CAP-5=fWeicz7iFMM8vw32OCQXkBcCeWS4qA7k-iNJ6r7izpBbw@mail.gmail.com>
 <0f693db5-89d4-4346-be6f-d740b4493ad9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f693db5-89d4-4346-be6f-d740b4493ad9@linux.ibm.com>

On Fri, Mar 13, 2026 at 10:46:49AM +0100, Thomas Richter wrote:
> On 3/12/26 17:46, Ian Rogers wrote:
> > On Thu, Mar 12, 2026 at 8:54 AM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Thu, Mar 12, 2026 at 5:45 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >>>
> >>> On 3/12/26 07:16, Ian Rogers wrote:
> >>>> Frame pointer callchains are not supported on s390. Ignore the option
> >>>> and print a warning.
> >>>>
> >>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>> ---
> >>>> v2: Only disable user callchains as AI is telling me native "kernel"
> >>>>     callchains are supported on s390.
> >>>> ---
> >>>>  tools/perf/util/evsel.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>> index bd14d9bbc91f..fa21b48cba86 100644
> >>>> --- a/tools/perf/util/evsel.c
> >>>> +++ b/tools/perf/util/evsel.c
> >>>> @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
> >>>>               attr->exclude_callchain_user = 1;
> >>>>       }
> >>>>
> >>>> +     if (EM_HOST == EM_S390 && (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> >>>> +         !evsel->core.attr.exclude_callchain_user) {
> >>>> +             pr_warning("Excluding user callchains that are not supported on s390. Try '--call-graph dwarf'\n");
> >>>> +             evsel->core.attr.exclude_callchain_user = 1;
> >>>> +     }
> >>>> +
> >>>>       if (param->defer && !attr->exclude_callchain_user)
> >>>>               attr->defer_callchain = 1;
> >>>>  }
> >>>
> >>> Ian, thanks very much.
> >>> Your patch set helps a lot. However there is a small nit (which is mandatory). Please add these lines
> >>>
> >>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_CALLCHAIN;
> >>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_REGS_USER;
> >>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_STACK_USER;
> >>
> >> So these lines are dropping callchain from the sample_type which means
> >> the kernel stack won't be sampled. AI was telling me this worked, but
> >> I'm guess it was wrong. I think rather than this it is just cleaner
> >> never to set the bits in the perf_event_attr, more like what v1 of the
> >> patch did:
> >> https://lore.kernel.org/lkml/20260312031928.1494864-3-irogers@google.com/
> >>
> 
> Let me try to answer your and Namhyung questions in one reply.
> s390 has many PMUs, there is one for counting (cpum_cf) and one for sampling (cpum_sf),
> which are totally different hardware components.
> Hardware sampling 
> 1. writes into a large buffer, data is timestamp and IP (instruction pointer), no registers, no PID.
> 2. when buffer gets full an interrupt occurs and the interrupt handler scans the
>    hardware samples and converts valid samples to perf format and saves them in perf ring buffer.
> This means we can not reconstruct register values for an individual sample. Current Pid is saved by
> other means somewhere and added to perf data during perf ring buffer write.

Thanks for the explanation!

Sounds like ARM SPE.  Off-topic but I just wonder if it's possible to
adjust the buffer size so that it can fire for each sample.

> 
> For s390 when we need callchains, we always use event cpu-clock, never hardware event cycles.

I see.

> 
> 
> >>> to the new if(EM_HOST == ...) above.
> >>> The s390 CPU Measurement sampling device driver does not check on the attr.core.exclude_callchain_user
> >>> member, but on the sample_type bit mask. It returns -EOPNOTSUPP when this bit PERF_SAMPLE_CALLCHAIN
> >>> is set. This solves the invocation with command line flag -g as in
> >>>  # ./perf record -v -e cycles  -g  -- perf test -w noploop
> >>>  ...
> >>>  perf record: Captured and wrote 0.183 MB perf.data ]
> >>
> >> Right because the callchain was removed from all the samples. We can't
> >> fix old kernels (other than by using fix tags); is there a possibility
> >> of adding the exclude_callchain_user to the s390 perf driver for the
> >> sake of kernel callchains? It seems better than providing no
> >> callchain.
> >>
> >>> Also I discovered that the fallback when using --call-graph dwarf command line flag still fails:
> >>>  # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noploop
> >>>  ...
> >>>  Warning:
> >>>  Trying to fall back to excluding guest samples
> >>>  Error:
> >>>  Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be removed.
> >>>  cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. Try 'perf stat'
> >>>  Error:
> >>>  Failure to open any events for recording.
> >>>
> >>> The reason is in __evsel__config_callchain() which calls evsel__set_sample_bit(evsel, CALLCHAIN)
> >>> and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type. It also sets the
> >>> member attr->exclude_callchain_user = 1 and sets bits REGS_USER and _STACK_USER.
> >>> All three bits are not supported by s390.
> >>
> >> I'm confused by this and your previous testing that showed the
> >> `--call-graph dwarf` worked. You need the sampled registers for dwarf
> >> unwinding to provide initial register values for the unwinder.
> >>
> 
> Right, as explained shortly above, we have to use '-e cpu-clock --call-graph dwarf'
> to get valid call chain data.
> 
> >>> I have modified your 2nd patch and appended it.
> >>>
> >>> I find all these bits in sample_type and the attr.exclude_XXX stuff very confusing. If there
> >>> is a more consistant way of checking these feature, please let me know.
> > 
> > I forgot to mention, yeah the exclude thing is maddening. It takes
> > about 100 lines to convert the command line modifiers to those in the
> > perf_event_attr, there's a priority to them, and so on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/parse-events.c#n1759
> > Fwiw, I was thinking for patch 1 of holding onto the parsed modifiers
> > so that we could reset the excludes based on them when switching to
> > the software event.
> > 
> >> Ok, let me check it out.
> > 
> > So looking at the cpum_cf driver it fails events for having sampling enabled:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_cf.c#n859
> > ```
> > if (is_sampling_event(event)) /* No sampling support */
> > ```
> > and the cpum_sf driver fails for any kind of callchain:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_sf.c#n839
> > ```
> > static bool is_callchain_event(struct perf_event *event)
> > {
> > u64 sample_type = event->attr.sample_type;
> > 
> > return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
> >      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
> > }
> > 
> > static int cpumsf_pmu_event_init(struct perf_event *event)
> > {
> > int err;
> > 
> > /* No support for taken branch sampling */
> > /* No support for callchain, stacks and registers */
> > if (has_branch_stack(event) || is_callchain_event(event))
> > return -EOPNOTSUPP;
> > ```
> > Perhaps there is an oversight in the cpum_cf driver wrt branch stacks
> > (LBR on x86). The PERF_SAMPLE_CALLCHAIN bit is set for perf call-graph
> > options currently:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evsel.c#n1024
> > 
> > I think cpum_sf is the PMU we care about for the default cycles event?
> 
> Right this PMU does sampling on s390
> 
> > Since callchains of any flavor don't work with cpum_sf we can do a few
> > things:
> > 1) Disable the callchain and allow hardware sampling to continue,
> > 2) Switch to a software event like cpu-clock,
> > 3) Fail for the callchain option with this PMU, which is currently
> > happening anyway.
> 
> @Namhyung:
> It fails to open event cycles for PMU cpum_sf.

Ok, I assume it'd reject events with PERF_SAMPLE_CALLCHAIN.

> 
> > 
> > I dislike option 3 because it requires special s390 logic for many
> > tests, and we lose testing coverage of hardware events. Option 1 is a
> > smaller patch, an early return in __evsel__config_callchain if on
> > s390. Option 2 feels most like what the user would want given they
> > asked for a callchain. We could change evlist__new_default to take a
> > "with callchain" boolean and on s390 that could switch the event to a
> > software one. Only two non-test callers use evlist__new__default
> > (record and top), so it isn't a huge change.
> > 
> > Wdyt Thomas, option 1 or 2?
> > 
> > Thanks,
> > Ian
> 
> I actually prefer option 2. when call chains are requested by the user
> switch to cpu-clock event.

I think the current code will do the job already.  But we missed to
remove some exclude_* bits before that.  And moving callchain setting
from FP to DWARF is a separate issue.

> 
> Thanks a lot for your patience.

The same goes to you. :)

Thanks,
Namhyung

> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
