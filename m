Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A413D61A;
	Wed,  7 Aug 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054368; cv=none; b=fre8DKbr6WzETtYMvoLwnpluuWN2ayVe9IpLxwqJ/6SUyVpO5/t8aA8QtwynfO0NT69v3wFi6TzwoElgVr0x7pDca60jqAYqZ35Ku1J4qZ1kIu28rFF9gzqvQX3iBOTwRNKT65HcLiEVkTL4Ph/RjC221hnxZ9kzDWx7Rh/GkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054368; c=relaxed/simple;
	bh=ISPP/Y0DYUabn/g+gm+IohCoQEotWJ5A5dTGdvhtvq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k23aZSJjYM5kTF2yvMGz79X+UX2m45OvtmqxqZwRll568gVyC0F3lJdtjcWAKud1u/eouxePolhneVAHUSeHSlWIeIDVJ6fBoFQrtSrzcRXSAod1HeAjOrNonqc677+pAXaVt5gnMOcyUHvZVvcsczWuA8z5a7J36cDW+jmIz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDkeZhMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDkeZhMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EB6C32781;
	Wed,  7 Aug 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723054367;
	bh=ISPP/Y0DYUabn/g+gm+IohCoQEotWJ5A5dTGdvhtvq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDkeZhMv+5Y731BeDVZK+3kSkdceaAQQrABiNMuSDB66BV//Tu/PyPXIvABMEopRg
	 Km8QsvqIvMXW7+CxiJ0BaCoZJQm+LZguhuXnn6D6jov2XTl5R6MZGgewoI0LBfAD11
	 PsyLl5/hHvoIN/LBQtukUUE6PJn85TLRAukcDy9rH4XoHcQkqQ+KVzPuHAUJqOOjMR
	 XNUkBK8IDAk5Ba5hW6WwaI8S3RrwGAQ0EOCeA7i8XCHaaV2gRNXd5afSll7ARSTw7H
	 kl3dC35FojRLr4ZeezVZc1iXtoaJeCGmL3ADxwag4IpUTDjpwLG4MgxIoQm2pXCDzG
	 eC+6EjBpsCUuQ==
Date: Wed, 7 Aug 2024 11:12:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for
 v6.11
Message-ID: <ZrO5HR9x2xyPKttx@google.com>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>

Hello folks,

On Tue, Aug 06, 2024 at 03:50:03PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is the usual sync up in header files we keep in tools directory.
> I put a file to give the reason of this work and not to repeat it in
> every commit message.  The changes will be carried in the perf-tools
> tree.
 
Could you please double check what's in the tmp.perf-tools branch at the
perf-tools tree so I don't break build and perf trace for arm64, powerpc
and s390?  It has this patchset + arm64 unistd header revert (according
to the discussion on patch 6/10) on top of v6.11-rc2.

Thanks,
Namhyung

> 
> Namhyung Kim (10):
>   perf tools: Add tools/include/uapi/README
>   tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
>   tools/include: Sync uapi/linux/kvm.h with the kernel sources
>   tools/include: Sync uapi/linux/perf.h with the kernel sources
>   tools/include: Sync uapi/sound/asound.h with the kernel sources
>   tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
>   tools/include: Sync network socket headers with the kernel sources
>   tools/include: Sync filesystem headers with the kernel sources
>   tools/include: Sync x86 headers with the kernel sources
>   tools/include: Sync arm64 headers with the kernel sources
> 
>  tools/arch/arm64/include/asm/cputype.h        |  10 +
>  tools/arch/arm64/include/uapi/asm/unistd.h    |  24 +-
>  tools/arch/powerpc/include/uapi/asm/kvm.h     |   3 +
>  tools/arch/x86/include/asm/cpufeatures.h      | 803 +++++++++---------
>  tools/arch/x86/include/asm/msr-index.h        |  11 +
>  tools/arch/x86/include/uapi/asm/kvm.h         |  49 ++
>  tools/arch/x86/include/uapi/asm/svm.h         |   1 +
>  tools/include/uapi/README                     |  73 ++
>  tools/include/uapi/asm-generic/unistd.h       |   2 +-
>  tools/include/uapi/drm/i915_drm.h             |  27 +
>  tools/include/uapi/linux/in.h                 |   2 +
>  tools/include/uapi/linux/kvm.h                |  17 +-
>  tools/include/uapi/linux/perf_event.h         |   6 +-
>  tools/include/uapi/linux/stat.h               |  12 +-
>  .../arch/powerpc/entry/syscalls/syscall.tbl   |   6 +-
>  .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |   8 +-
>  .../perf/trace/beauty/include/linux/socket.h  |   5 +-
>  .../perf/trace/beauty/include/uapi/linux/fs.h | 163 +++-
>  .../trace/beauty/include/uapi/linux/mount.h   |  10 +-
>  .../trace/beauty/include/uapi/linux/stat.h    |  12 +-
>  .../trace/beauty/include/uapi/sound/asound.h  |   9 +-
>  22 files changed, 810 insertions(+), 445 deletions(-)
>  create mode 100644 tools/include/uapi/README
> 
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 
