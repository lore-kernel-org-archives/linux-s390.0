Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7526280C;
	Mon, 24 Mar 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835509; cv=none; b=X+3Gnc8FXMFGOu1Zo11OEJHFbp4ZebQyBmZ64TQ1qd1uHlwUxO+pr63Y7z8hN21LzWsuLn/TR6zNbywSWj8anwKB+69Sd0Kbw7QWCswq2Q5YJ0UPqrlDsLtB1GAhPeUkPtoDyk1vM0KFLar8cMliHoQsGWA6GAAWS/V8cxa5xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835509; c=relaxed/simple;
	bh=0GCORFHkVl27DtJY6Jv2rIfJjLLMApRij6IOFjOqViE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx2VJFH3u6/OOifEVdb7+9+wYY3Jn0I0j9e1d2S+DQe3irYBcUwHdku+rPS09AsvUf2XTKOAc0mHJ/yqLA1Ssa6bJMSfj05sAcStZ2wX2H2BDXv/7dfyuQtdM5l5LGvkjJr7AHT1Xl3meQeDDCOOoH3ZT1OK0RwKWLD62sAyhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRfGRLdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRfGRLdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB86FC4CEDD;
	Mon, 24 Mar 2025 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835509;
	bh=0GCORFHkVl27DtJY6Jv2rIfJjLLMApRij6IOFjOqViE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRfGRLdpyFsAKuU4ileaRuVt0Ly46qv9vql6J0mJShYM799VhYF4d3McqNDTXh6Ke
	 PwA6RmO5UZQt4a+juKSBNq7vS6+RicEyLEV+YqTY5jS4dRKjNlPu5QE7HlUeLCd7Yl
	 0bdcSGAoaS1rFJ/AzaC/QwKtZ7erMrxBjwocXNfAEDgMDlgX/4ZRjxlX1W8lKnVoB5
	 8o33Bv835TVkSxODQwSzZkFlCtOyWJQHubfiHgjmrWhcehEpi+lAjayF7xtQuSXwdw
	 V/Q+xA93BtJrXpIW7CVmndWwj8HEeJbjMCEhnrkn0Gj8I9IZ4K3YRP30DPKXJjABxP
	 o7ID4uR5CI/Zw==
Date: Mon, 24 Mar 2025 09:58:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, james.clark@linaro.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
Message-ID: <Z-GPLzaCxboJXAkT@google.com>
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
 <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
 <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>

Hello,

On Mon, Mar 24, 2025 at 08:50:36AM -0700, Ian Rogers wrote:
> On Mon, Mar 24, 2025 at 8:38 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 8:28 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > >
> > > In linux-next
> > > commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> > > causes the perf tests 100 126 to fail on s390:
> > >
> > > Output before:
> > >  # ./perf test 100
> > >  100: perf trace BTF general tests         : FAILED!
> > >  #
> > >
> > > The root cause is the change from int to int16_t for the
> > > cpu maps. The size of the CPU key value pair changes from
> > > four bytes to two bytes. However a two byte key size is
> > > not supported for bpf_map__update_elem().
> >
> > Nice catch!
> >
> > > Note: validate_map_op() in libbpf.c emits warning
> > >  libbpf: map '__augmented_syscalls__': \
> > >          unexpected key size 2 provided, expected 4
> > > when key size is set to int16_t.
> >
> > Wow, weird.
> 
> Ah, I guess it is a mismatch with the declaration in
> tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c?h=perf-tools-next#n31
> ```
> /* bpf-output associated map */
> struct __augmented_syscalls__ {
>        __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>        __type(key, int);
>        __type(value, __u32);
>        __uint(max_entries, MAX_CPUS);
> } __augmented_syscalls__ SEC(".maps");
> ```
> but this looks wrong. The values are file descriptors, so should be
> ints. I think it should be:
> ```
> struct __augmented_syscalls__ {
>        __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>        __type(key, int16_t);
>        __type(value, int);
>        __uint(max_entries, MAX_CPUS);
> } __augmented_syscalls__ SEC(".maps");
> ```
> I'm not sure if max_entries can be a uint16_t too. I suspect this may
> well interfere with BPF_MAP_TYPE_PERF_EVENT_ARRAY and its use by
> bpf_perf_event_output. Probably best to keep things in the BPF code as
> they are and do your builtin-trace.c fix. Perhaps someone else can
> clean this up.

I don't think max_entries can be uint16_t.  Also I'm skeptical to change
the key type to int16_t as you said.  I'll pick Thomas's patch up.

Thanks,
Namhyung

> 
> > > Therefore change to variable size back to 4 bytes for
> > > invocation of bpf_map__update_elem().
> > >
> > > Output after:
> > >  # ./perf test 100
> > >  100: perf trace BTF general tests         : Ok
> > >  #
> > >
> > > Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > ---
> > >  tools/perf/builtin-trace.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 092c5f6404ba..464c97a11852 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> > >                  * CPU the bpf-output event's file descriptor.
> > >                  */
> > >                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
> > > +                       int mycpu = cpu.cpu;
> > > +
> > >                         bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> > > -                                       &cpu.cpu, sizeof(int),
> > > +                                       &mycpu, sizeof(int),
> >
> > nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
> > problems like the one this fix is fixing. And I'm blamed for the bad
> > code in:
> > 5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks for the fixes!
> > Ian
> >
> > >                                         xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
> > > -                                                      cpu.cpu, 0),
> > > +                                                      mycpu, 0),
> > >                                         sizeof(__u32), BPF_ANY);
> > >                 }
> > >         }
> > > --
> > > 2.48.1
> > >
