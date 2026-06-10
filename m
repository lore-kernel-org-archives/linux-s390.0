Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B4380FD3;
	Wed, 10 Jun 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121758; cv=none; b=YqAFDpvUuzJyViEsYS9qBgN7g96xL5wG+fUqgDbAHupv0YwX4GZ+veYO4YCA7RLGo5wRSRLBcT45iHbt9qrcNM/nvXxqmtqel67iHCVYBHlr9pyHj72b4z7E15AceNsS/h64+bAPs9IiB2yLc996qqRC2womglxsU3xjfdkQK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121758; c=relaxed/simple;
	bh=T/p6HC9Q8a8aAajkOkGveF6+nf0tnC0RM+WxpJEYHz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTr8qWbO+6HDzFcqUypox1sMAiZSErWLYOjIbnqdZAytMKmzurhF9+H8RuPiIcYA6c1EKQyNZE3nyXi37PpTczDCnG/BHpIr+oVGpaWRB4ubNXQB66/f2jur6mz6CUaaSRsYlT8wLj8eNGOBN5FGKFbSHiOvY0Zq8BFd6+k4kY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPpki4Xm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPpki4Xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB0B1F00893;
	Wed, 10 Jun 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121756;
	bh=DGzsYpWYnSJv1ZTA52um4ym6YqhaLGbJSog82pKYXgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPpki4XmIs7Xk0tj5HrlUWuFrB8BddyBZmz35xzsBSyFG9dK2NwYK5W3pRZVIcOM3
	 mgKejYvYxq1f0s2Gi3/5b0R1EaN20GllkjYqXw3zPfIQsHIthecmNR5wP85oGtcHMZ
	 j62efuPH83VAy2GhGiD+ICSoBf5LChPKmVJuFpWEGwjNsTk2djrkOwj33yr84QgsCy
	 Bd30tevnbLif0C9yTWOsdAICIa85H6qWjKPGJhZLAWd6FMPs0mHxs2AOwQyV0XSpel
	 6a0E935yiQ4zVkYZgTr6j1gSrr6ok9kr2UriYhd9VXcIiFJX2k/fHvpyb3Eti9h5wn
	 /xQ796b8yq9fw==
Date: Wed, 10 Jun 2026 17:02:32 -0300
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
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Do not duplicate CFLAGS in Python extension
 builds
Message-ID: <ainC2J-eMxlcUSjC@x1>
References: <20260610112344.1550111-1-jremus@linux.ibm.com>
 <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>

On Wed, Jun 10, 2026 at 02:38:24PM +0100, James Clark wrote:
> 
> 
> On 10/06/2026 12:23 pm, Jens Remus wrote:
> > setuptools already uses CFLAGS.  Passing CFLAGS with additional flags as
> > extra compile arguments causes CFLAGS to effectively get passed twice:
> > 
> > $ make -C tools/perf V=1 JOBS=1
> > ...
> > building 'perf' extension
> > gcc [CFLAGS] -fPIC -Iutil/include -I/usr/include/python3.14 \
> >    -c /root/linux/tools/perf/util/python.c \
> >    -o python_ext_build/tmp/root/linux/tools/perf/util/python.o \
> >    [CFLAGS] \
> >    -fno-strict-aliasing -Wno-write-strings -Wno-unused-parameter \
> >    -Wno-redundant-decls -Wno-cast-function-type \
> >    -Wno-declaration-after-statement
> > 
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
