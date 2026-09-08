Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA03BBFD9;
	Tue,  8 Sep 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900920; cv=none; b=n22a+81WdNgnD0Khe3CPjofowsz7HXwJVowN/f/GYLJ71qT93PPopClvee1AaG/a/Nad59kPx2YRruknqggRTOQEATPlfGewKl/Raxp/fj4J8r++lWVar3f4lpSSCim1IPac8PzrHpqQfnVMLShZgGBY0EJPGEv8+lZW+pLmx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900920; c=relaxed/simple;
	bh=CiVHeu6RIPY8usSJ4PtuYb+4Uq+O/Fi8PdF5aQqViXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujhuzweIfRIMISSsqiedHjfIq4Cj0yDHfjzuqAG8lanNJFdcQRCeN7NJ8VFQNi9I3exHzfDbsMKmFfUrFXl5lWNEE4Mg80wnI2BFlEFe9lmGJAjguxMmjz5E+Ci0hBlvbaYGkAjQhhVvAuq63WsgBSb3y9Z9cLQE6uiwhUxVUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdmS1+iW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdmS1+iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EE01F00A3A;
	Tue,  8 Sep 2026 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900917;
	bh=IX1KW67zfncW7ENG/ph/am57RRkYoh41ri1wVVxuYdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdmS1+iW6xBy/80B7nrzj9Bi8ndZS5RkFKV+r2vMw0eKLge+zvViFN2AuZytaq8e0
	 Dth7aDnD5aEURjtkUxn645+ZYN2KK+TbHiVscagSwm/I1Vf4J8bXxTHmrKJrLMOyXI
	 +bqNA/oQyyGhUU2G0PfgBSEQo9ZG0br/g9w2lx4v3qW+8tvE95nXvw3HubLSc6a8kJ
	 90o3tfmNFgUHSraa5vof1WU6vNkpaGnFklzelp/G5COnJ+btcnAhrF/UZuTswcYkQQ
	 UUDn9rTlBFDM5GCK1WQZYuNOKQNi2xA23xxDqYg476q+Wj3OI7d93WnpWPY59D9zVC
	 QBb/MgVylpkPA==
Date: Tue, 8 Sep 2026 17:55:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, agordeev@linux.ibm.com, iii@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH v2] perf test: perf stat tests fails on s390
Message-ID: <aqB2MdzuAMAksHuL@x2>
References: <20260903073554.1300334-1-tmricht@linux.ibm.com>
 <CAP-5=fUtW=EfB5SOt8iCSsyt4pg_2NhoWvTr=Qf5vEKU5CwZRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUtW=EfB5SOt8iCSsyt4pg_2NhoWvTr=Qf5vEKU5CwZRA@mail.gmail.com>

On Thu, Sep 03, 2026 at 11:17:01AM -0700, Ian Rogers wrote:
> On Thu, Sep 3, 2026 at 12:36 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > The test case 'perf stat tests' fails on s390 z/VM machines. The
> > root cause is the unsupported CPU measurement facility on z/VM.
> > Therefore the events cycles and instructions do not exist and
> > are unsupported. This cause the subtest
> >   Hide zero events stat test
> > to fail.
> >
> > Output before:
> >  # perf test 116
> >  116: perf stat tests  : FAILED!
> >
> >  === Test Summary ===
> >  Passed main tests : 0
> >  Passed subtests   : 0
> >  Skipped tests     : 0
> >  Failed tests      : 1
> >  List of failed tests:
> >   116: perf stat tests
> >  #
> >
> > Output after:
> >  # ./perf test 116
> >  116: perf stat tests  : Ok
> >
> >  === Test Summary ===
> >  Passed main tests : 1
> >  Passed subtests   : 0
> >  Skipped tests     : 0
> >  Failed tests      : 0
> >  #
> >
> > Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppress zero-count events")
> > Cc: Aaron Tomlin <atomlin@atomlin.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
