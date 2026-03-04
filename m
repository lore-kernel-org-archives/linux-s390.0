Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD393074A1;
	Wed,  4 Mar 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634879; cv=none; b=oWapT9rY9VKde5aFrBlBUq4RzzllWRzOrVR+k2Kwt4TEjOkaHSojZ5TQOIVyRuX34wB7wz9j7KlkWD0mUNmlHfKMgDZfD6lPEbI9K3LlLeszoT7f3L7Vfp3AtYlZ5m94o1WcGgm7TiyMzTPvXjPSie7uPnruzc8fqDp5mJ4lH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634879; c=relaxed/simple;
	bh=VYjfd90z/T/hT7lKXvnRTkt7wyLpbBb620pFx1oQ7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRaJYSO5fWaYCgcRQXMa+G6s+wXLl7wCIpHiTNNagtE0Dav0KDTGsKccCuuwM3wvYpxZa3O/G72b/Grek0DRyUmomOXYc6jote3euDz6P6NJEFlntoY9uYKVMjx3afDqhK2Kzzq0i3exEyyfr4tMT5Bkr0mREm6rolcS25Wub4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT0oorqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT0oorqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF35C4CEF7;
	Wed,  4 Mar 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634878;
	bh=VYjfd90z/T/hT7lKXvnRTkt7wyLpbBb620pFx1oQ7kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WT0oorqdI2GMDRnMODTl02YsKk4/Xw3K7BNAkvt0hoOcVkYLdzS/r+L5m20F1aN/z
	 S2InAuIbkZDwT21/V7gROFNhkl9t97qpdOnMwn4dgthucRl7ZEZfwL/qArGf65Om08
	 7sPOniFAvz6jdpb+KWglcHMwQPpir2zgDE/GaK+/DYuMpQ23kY+YqaUNSs6B8EM0Wz
	 Xblz+d+CQgH4THTuXPv+qIXUOYbQ29qWZEu5z6WOOLO5orjs/YKfVRXH785C/qUfW+
	 leGyZnDQfG/QtJa1dEspJqwKOtE0xye71hCPSvm9ihkyrPY8HBOHW2tBzeXdRWIDsx
	 2LIXh3NY8Co3Q==
Date: Wed, 4 Mar 2026 11:34:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com
Subject: Re: [PATCH v2] perf symbol: Remove psw_idle() from list of idle
 symbols
Message-ID: <aahC-zp56irr5e2k@x1>
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
 <aZzKrRB0__RahFJV@google.com>
 <aaXaX676sTLCX_LG@x1>
 <CAP-5=fUjyOUi9J6WfXf0HkbiD6Y=vAfT2gSMo0e-L7LOOtPW=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUjyOUi9J6WfXf0HkbiD6Y=vAfT2gSMo0e-L7LOOtPW=A@mail.gmail.com>

On Mon, Mar 02, 2026 at 11:44:19AM -0800, Ian Rogers wrote:
> On Mon, Mar 2, 2026 at 10:43 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Feb 23, 2026 at 01:46:21PM -0800, Namhyung Kim wrote:
> > > On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
> > > > Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
> > > >
> > > > removes symbols psw_idle() and psw_idle_exit() from the linux
> > > > kernel for s390. Remove them in perf tool's list of idle
> > > > functions. They can not be detected anymore.
> > >
> > > But I think old kernels may still run somewhere.  It seems the above
> > > commit was merged to v6.10.  Maybe we should wait some more time before
> > > removing it in the tool.
> >
> > Agreed, using a new perf tool, say built from the tarballs made
> > available at:
> >
> > https://www.kernel.org/pub/linux/kernel/tools/perf/v7.0.0/perf-7.0.0-rc1.tar.xz
> >
> > (I will not make a rc2 available since there are no changes to the
> > tools/perf codebase in this rc).
> >
> > On older kernels should still ignore those functions.
> >
> > A suggestion for work in this area instead is to get those samples into
> > a special bucket, the "idle" one, and show it at some place in the
> > screen.
> 
> Would it also be sensible to pass the perf_env:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/env.h?h=perf-tools-next#n74
> into symbol__is_idle? The contents of the perf_env are shown by `perf
> report --header`:
> ```
> # ========
> # captured on    : Mon Mar  2 11:34:47 2026
> # header version : 1
> # data offset    : 904
> # data size      : 4268216
> # feat offset    : 4269120
> # hostname : google.com
> # os release : 6.17.13-1rodete1-amd64
> # perf version : 7.0.rc1.g982b63f6380b
> # arch : x86_64
> # nrcpus online : 28
> # nrcpus avail : 28
> # cpudesc : Intel(R) Core(TM) i7-14700
> # cpuid : GenuineIntel,6,183,1
> ...
> # e_machine : 62
> #   e_flags : 0
> ...
> ```
> The kernel version is in the release and the e_machine/arch captures
> the CPU type.

Yeah, I think it is a good improvement, I think you mean that we should
have per-arch idle symbol lists? 

- Arnaldo
