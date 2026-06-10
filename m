Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF45331EA4;
	Wed, 10 Jun 2026 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121922; cv=none; b=QlFEbEwRU1gf6O1Mfz+DjqxM44Mxx7W5LzhP9Ulrw75XdrSb3zWj/+3MLqL2UEXsBUcj85NvSRZwb06zfxxAaK+8Ggvzqwlb7VqJiSj859P2sydZ3mv6nDT0uFY4pvbHaSI2vu93jc8+4QWj8EYhEN67cpf7Q1qEnlg+Hlqk3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121922; c=relaxed/simple;
	bh=0qffO1zeu2Z9/a9U08SC9vhlvpitayQOghPrLhC3RsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq7eirkO6xdzfKR53QLyQdk+s0nUS3FXm3ta7myCWA+a5HULk5IJp0NY1hxFu43wRGcz1iXHZMKSQ3OpxKdyex28Wr4JVbHV4MSInmMj8Vm6F7xkH+a2BbMoBSPa/e39kO3EICTHTeByHkQYKjmSUzK9FSSS1xNTz88GuAi0I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbLkmAAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbLkmAAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F11F00893;
	Wed, 10 Jun 2026 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121917;
	bh=7rT/ne9euQ4wOGv70UqHVlvjkpEYBAEsUF0ZfhZ9MKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FbLkmAAQmr/99HzdzKV9wQmVC+rryW7qzAIxJYpi0D3faZSDq4x7EqBjjkG3c/56G
	 JUde8Tcs/cQdiN1bzwtVVPfCdI69HYmew7hqyFJ9xuKpnDRyXjB2jdDwYRacPL7F6q
	 4L9Mz4HwVpzvaC0v7sjfbCey/RftHjPqPRFKXUgs+VJ8VsUU9bbRsBV3/8BkYB2EnN
	 TiHNvNb8DfAUiO6BleY1qXBGDbDeAsDpMdgWjVysjlUadNKWXedY0CuIIptOdXjADx
	 9DyfK2xHcF1/nOWR6WV28sSkW7ZfE9sRfCCaFuTCrW70aPzLoIkI/gmDUedXJUNXLS
	 mB0cRQob0hjKQ==
Date: Wed, 10 Jun 2026 17:05:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
Message-ID: <ainDeXsfPw0mwXe4@x1>
References: <20260610112451.1553054-1-jremus@linux.ibm.com>
 <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>

On Wed, Jun 10, 2026 at 02:39:10PM +0100, James Clark wrote:
> On 10/06/2026 12:24 pm, Jens Remus wrote:
> > +++ b/tools/perf/Makefile.config
> > @@ -109,6 +109,7 @@ endif
> >   ifeq ($(ARCH),s390)
> >     CFLAGS += -fPIC
> > +  CXXFLAGS += -fPIC
> >   endif
> >   ifeq ($(ARCH),mips)
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
