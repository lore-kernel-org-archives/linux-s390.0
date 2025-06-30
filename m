Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98929117A;
	Mon, 30 Jun 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299786; cv=none; b=p+vbk4H0es7VFKAbRslYotkpYCiIzTXBjBnWQC2EFNKOGg+3TKsWoTbF70uCUaoTa7vwA0Vq/UvcsryzNC9X6zHl32D4IQxTMpUdvaHPGWKdytoG2XuLDRCHO2L2r18zIHDisngTC5qsuOx5RnO7gR/DV1kI26oaxVbfWa9HGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299786; c=relaxed/simple;
	bh=s43vrdBkB//7/xBOt9UWghrfxrjsGXZHPE7NijbiwcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe9tTozTUs3os4OjgfA1dScwUWDeGYuoShv/fvG/5DBhqNagML3p0p8GzKDW2tRG4ukr8i8tUuarxVlBhAEp3OxFVpNwvBUWWuRwew+13KBT7UwRXf3GOvNxoOCeIXrI5DCy4zq1qYwa3AWPDczi0Ed+TYkJugLjNmk1fOSshC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/+OnS8d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/+OnS8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1124FC4CEE3;
	Mon, 30 Jun 2025 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299786;
	bh=s43vrdBkB//7/xBOt9UWghrfxrjsGXZHPE7NijbiwcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/+OnS8dtPRKXQrplTbUDQmYHFCFp06TE+Zaq5dWdEQeCdRzIyvlBTYzBY44kfy9X
	 Gt0pWgS4K2fYJpZ5T8aQuxdqafsrINv4/HTxaZ/Try75t8K5cWi4f8cXCOvyZgHhkt
	 EQAOwb7OJ28rc6utillI3Vs5dopoI/wL8R/9oNkTqGh0HYlYpBzmc50dLevdIHTVaO
	 D/meXKCWm1GcLxH6HHRyt6QQnTunsatY2WbQ3+ZB2EDq08OK/u3C3lVuPARAmbTF+R
	 uTEfK9Ciaq5nx7qnxOO5SP8RHovBcKuD/W1F3g5daHj0YF5y1kQJFX84ykNGOb/XKt
	 E1zt48XIX8kDg==
Date: Mon, 30 Jun 2025 09:09:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf test: perf header test fails on s390
Message-ID: <aGK2xQNQOd1WoDVk@google.com>
References: <20250630091613.3061664-1-tmricht@linux.ibm.com>
 <CAP-5=fWGiitgromQRTxEsU3cY99gFAU6WPLnmiS7-Q8vQNGbYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWGiitgromQRTxEsU3cY99gFAU6WPLnmiS7-Q8vQNGbYw@mail.gmail.com>

On Mon, Jun 30, 2025 at 08:42:01AM -0700, Ian Rogers wrote:
> On Mon, Jun 30, 2025 at 2:16 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > commit 2d584688643fa ("perf test: Add header shell test")
> > introduced a new test case for perf header. It fails on s390
> > because call graph option -g is not supported on s390.
> > Also the option --call-graph dwarf is only supported for
> > the event cpu-clock.
> >
> > Remove this option and the test succeeds.
> >
> > Output after:
> >  # ./perf test 76
> >  76: perf header tests                           : Ok
> >
> > Fixes: 2d584688643fa ("perf test: Add header shell test")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> 
> Thanks Thomas! Given the s390 restriction to require dwarf, should we
> switch the default "-g" meaning on s390 to mean use dwarf? James Clark
> proposed this previously. It doesn't affect the change here so:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Unrelated but I found this test is failing on my machine.

  $ ./perf test -v header
  --- start ---
  test child forked, pid 42799
  Test perf header file
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.182 MB /tmp/__perf_test_header.perf.data.vvFUf (4114 samples) ]
  Test perf header file [Done]
  Test perf header pipe
  Failed to find expect hostname in output
  Failed to find expect os release in output
  Failed to find expect arch in output
  Failed to find expect cpuid in output
  Failed to find expect nrcpus in output
  Failed to find expect event in output
  Failed to find expect cmdline in output
  Failed to find expect perf version in output
  Failed to find expect sibling (cores|dies|threads) in output
  Failed to find expect sibling threads in output
  Failed to find expect total memory in output
  Test perf header pipe [Done]
  ---- end(-1) ----
   83: perf header tests                                               : FAILED!
  
The pipe mode doesn't have the headers.

  $ ./perf record -o- -g -- ./perf test -w noploop | ./perf report -i- -I --header-only
  # ========
  # captured on    : Mon Jun 30 09:02:09 2025
  # header version : 1
  # data offset    : 0
  # data size      : 0
  # feat offset    : 0
  # ========
  #

Thanks,
Namhyung

