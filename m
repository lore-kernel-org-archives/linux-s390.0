Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D931547E7;
	Thu, 15 May 2025 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333095; cv=none; b=q+7faIgekM6erdwXRigT5h1K63N+Vr+veYfq1lxlXhb5Wqx9uV6AFO1jT90ie/8jhLfO3JEjZ9j/2v0y0qi3ScL7nkeUiGc0GJ2tJygEYcuhyVV4OqghgEMi0IokcACpRaGVE/Lv3IJPDysdXKQfoybSFvW4vwIbKRzmwkI2dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333095; c=relaxed/simple;
	bh=89cSYRfw5ySTf8D/ZfQiQlDBpPvwHutsxZSH9b1IQQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvt8XRdMnNF43DdhpmFMTrzCkh22ZxFMqcwvQPZYsQVjbXNtejISXq5vn+aZPXxT2Y/pnKdF8j4KOolv47ynXsDTeVwUxnhdHK55tau+H/0MaqgjR8HjvpqVIJ6OH3YLi2iTjdAj+9e9sGwHVjO+rfWyGoAv41B8tcjmT3hsjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM4rTUA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM4rTUA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC265C4CEE7;
	Thu, 15 May 2025 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333095;
	bh=89cSYRfw5ySTf8D/ZfQiQlDBpPvwHutsxZSH9b1IQQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YM4rTUA5ec86as02K62yOSkmV+6W3rM0Xkxq/xscF5qx+GtU3q9Q17RBDCYhLbNGa
	 FKLYx1rN/e7Jkesm4KB1bG8YJUatlt6OpEco+194AcVNINBenu3Ut6Y58FAgBU4iPu
	 CluBDjoZLAzVNIAvqc7nkH/OY8xl4/cRUUw5OauKomlf9n7bCDsPsvggk22p/ySbIU
	 rbaJ9eBIJZo45smMdCzDZP/LUfMY3XnRzXqGRcFtCMPzSw88O7dowLB984R0u2vLPR
	 iW2Q9rWJGFTGG2QzPQPdxyW4WMY+gdM/aSvuO8UqS2f45TIoVwb2kQRlDNJW2qApcA
	 CGi4uM0V15RqA==
Date: Thu, 15 May 2025 11:18:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH] perf ftrace: Restore to original trace settings on exit
Message-ID: <aCYv5U5u238pH1uq@google.com>
References: <20250515063407.3025338-1-tmricht@linux.ibm.com>
 <aCYSEMrXIwptT0d6@x1>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCYSEMrXIwptT0d6@x1>

Hello,

On Thu, May 15, 2025 at 01:10:56PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 15, 2025 at 08:34:07AM +0200, Thomas Richter wrote:
> > Executing perf ftrace commands ftrace, profile and latency
> > leave tracing disabled as can seen in this output:
> > 
> >  # echo 1 > /sys/kernel/debug/tracing/tracing_on
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  1
> >  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
> >  # cat /sys/kernel/debug/tracing/tracing_on
> >  0
> >  #
>  
> > The tracing_on file is not restored to its value before the command.
> > Fix this behavior and restore the trace setting to what
> > is was before the invocation of the command.
> > On Fedora 41 and 42 tracing is turned on by default.
> 
> This looks fragile as it takes a snapshot in time of what are the files
> in some particular directory to save them and then restore it at the
> end.
> 
> The tool may at some point in the future go and touch other (added in
> the future) files in that directory, etc.
> 
> I _think_ that instead we should move to use some "session mode" ftrace,
> which I _think_ is already available for quite some time, i.e. instead
> of touching the global ftrace files (which probably are there for
> historical reasons), we should use, lemme find the reference...
> 
> I think the keyword to lookup is /sys/kernel/debug/tracing/instances/
> 
> Ian did a lot of work on having 'perf test' run shell tests in parallel,
> so we need to think about ways of allowing for that by not touching
> global state.
> 
> tldr; great idea, avoid global state.

Right, by using an tracing instance, you don't need to worry about the
original states.

Thanks,
Namhyung

