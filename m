Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB3335064;
	Thu, 30 Apr 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517852; cv=none; b=speiBgss83+Myg0xGqON3WdWkhEfbldpSgu10R4XSQIIToSByJU4hXrhlZsCUu6Ti56paHh3pfovCxGTQ1UAIA8+YCvNXZIBSyj0eH6Lo6oW6+Ie64OMSFQeCA0XYm9xIFLNX+3PzaEqF5SP4bAtVhKlXJaT0ETQNQ3j+9iLdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517852; c=relaxed/simple;
	bh=WWDHuN6KlX23gWiFtx2Nh0bUKaZPUis/C4/D7ggZTz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2q33KPM8nW3ghjOvOWIu+AFzRbI5jDvB0mhsuWiKomzlS+9M4lla5TLG9xa+iK4Vsk2C31ZcUXyz2vMcfeDJ5XtDVTAcgG4EpIWllorNGgXDGWjrUmypAPOVZaQj9XQC6oeii20yab7FUFLTNXZ3ZPCV+hEHneP6kJs1/JFlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1ZbOrwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ZbOrwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386F6C2BCB8;
	Thu, 30 Apr 2026 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777517851;
	bh=WWDHuN6KlX23gWiFtx2Nh0bUKaZPUis/C4/D7ggZTz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1ZbOrwXjutciMx5tEkdM1wGxG3q36SBK/oeKeAfkTr7yKSuL37sp4kOhWaoVRcVA
	 hpfg5oCfqWdVBy/bkTiJBvPcNle/a0MAGN9zoNYaMgAZnsWxQnyTvkx+sYlIS+bCZO
	 bhrBFaY6UTO7kdeIOizCh7lxo2RVFfIBjGnq9I+Ne0wJT8GdEcKQKYHHrK6pZ+uRSx
	 K2Nu9ZBslhxYMisQhkC99HxSt5ktF4JhwdK4EGVX6Xfeq8plCqtjk/82o+G8CgIK6G
	 TaWoEVaq83EexbsLEeyZwSNZza4MTbEnvVSk+rRGvu2WxaYKn2CE8mGpjyQpZ1D3AV
	 WtXoYRwj1Wjhw==
Date: Wed, 29 Apr 2026 19:57:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
Message-ID: <afLFGZcaEY2sW0ci@google.com>
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
 <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>

On Wed, Apr 29, 2026 at 09:14:38AM +0200, Thomas Richter wrote:
> On 4/21/26 18:30, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Apr 14, 2026 at 02:42:41PM +0200, Thomas Richter wrote:
> >> perf test 'perf inject to convert DWARF callchains to regular ones'
> >> fails on s390. It was introduced with
> >> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> >>
> >> The failure comes the difference in output. Without the inject script to
> >> convert DWARF the callchains is:
> >>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
> >>  # ./perf report -i perf.data --stdio --no-children -q \
> >> 					 --percent-limit=1 > /tmp/111
> >>  # cat /tmp/111
> >>     99.30%  perf-noploop  perf               [.] noploop
> >>             |
> >>             ---noploop
> >>                run_workload (inlined)
> >>                cmd_test
> >>                run_builtin (inlined)
> >>                handle_internal_command
> >>                run_argv (inlined)
> >>                main
> >>                __libc_start_call_main
> >>                __libc_start_main_impl (inlined)
> >>                _start
> >>  #
> >>
> >> With the inject script step the output is:
> >>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
> >>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
> >> 		--percent-limit=1 > /tmp/222
> >>  # cat /tmp/222
> >>     99.40%  perf-noploop  perf               [.] noploop
> >>             |
> >>             ---noploop
> >>                run_workload (inlined)
> >>                cmd_test
> >>                run_builtin (inlined)
> >>                handle_internal_command
> >>                run_argv (inlined)
> >>                main
> >>                _start
> >>  # diff /tmp/111 /tmp/222
> >>  1c1
> >>  <     99.30%  perf-noploop  perf               [.] noploop
> >>  ---
> >>  >     99.40%  perf-noploop  perf               [.] noploop
> >>  10,11d9
> >>  <                __libc_start_call_main
> >>  <                __libc_start_main_impl (inlined)
> >>  #
> >>
> >> The difference are the symbols __libc_start_call_main and
> >> __libc_start_main_impl.
> >>
> >> On x86_64, kernel and user space share a single virtual address space,
> >> with the kernel mapped to the upper end of memory. The instruction
> >> pointer value alone is sufficient to distinguish between user space
> >> and kernel space addresses. This is not true for s390, which uses
> >> separate address spaces for user and kernel. The same virtual address
> >> can be valid in both address spaces, so the instruction pointer value
> >> alone cannot determine whether an address belongs to the kernel or
> >> user space. Instead, perf must rely on the cpumode metadata derived
> >> from the processor status word (PSW) at sample time.
> >>
> >> In function perf_event__convert_sample_callchain() the first part
> >> copies a kernel callchain and context entries, if any.
> >> It then appends additional entries ignoring the address space
> >> architecture. Taking that into account, the symbols at addresses
> >>
> >>    0x3ff970348cb __libc_start_call_main
> >>    0x3ff970349c5 __libc_start_main_impl
> >>
> >> (located after the kernel address space on s390) are now included.
> >>
> >> Output before:
> >>  # ./perf test 83
> >>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
> >>
> >> Output after:
> >>  # ./perf test 83
> >>  83: perf inject to convert DWARF callchains to regular ones : Ok
> >>
> >> Question to Namhyung:
> >> In function perf_event__convert_sample_callchain() just before the
> >> for() loop this patch modifies, the kernel callchain is copied,
> >> see this comment and the next 5 lines:
> >>    /* copy kernel callchain and context entries */ 
> >> Then why is machine__kernel_ip() needed in the for() loop, when
> >> the kernel entries have been copied just before the loop?
> > 
> > IIRC I wanted to make sure to have PERF_CONTEXT_* part in the raw
> > callchains.
> > 
> >>
> >> Note: This patch was tested on x86_64 virtual machine and succeeded.
> >>
> >> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks,
> > Namhyung
> > 
> 
> Hi Namhyung,
> 
> is there something which needs to be done on my side to get this patch picked?
> It still fails on s390.
> 
> Please adviseon how to proceed.

Arnaldo will take care of 7.2 development cycle.

Thanks,
Namhyung

> 
> While at looking at my backlog, what about this patch
> [PATCH] perf test: probe_vfs_getname add do_getname() probing fallback 
> 
> Thanks a lot for your help
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
