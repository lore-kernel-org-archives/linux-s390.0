Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D22D9795;
	Wed,  3 Sep 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921982; cv=none; b=SZfIDO2UIUws8B8VoT+SPkwLuExYL1OgrDQSentHu/9TXQVXmnm1tEmMEgxXlbU2vTx+bWqg/So5TWfRsFtAWnKnVsKd+nIz/FNVU8SkswU3R38jFRzQppMS3RQ12sGidipBAgpiSatM5yAeDBN/3O2gUyQ8volBlLG1UAYMFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921982; c=relaxed/simple;
	bh=K6zuvZBYxoN1PbngGb2nApov5U4Byc+4zm0S8NaTk6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQH8QTeCxt4BoF1pQsGLdXnQ6Dgpgy5FFI/7FamCSGNn7RLga7vAV38Y2tWQXGdPFJd7yYy3i2oi1p1pV3NxEixR2eHg1FV3WalVweXB1WI9ekU5cA+UnM94F8UC6XcayMpQIBlRssSUXnKF8ubF7O36TzetlNrDNMx5iCtv/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXGKWm47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXGKWm47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2393FC4CEE7;
	Wed,  3 Sep 2025 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756921982;
	bh=K6zuvZBYxoN1PbngGb2nApov5U4Byc+4zm0S8NaTk6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXGKWm47g3NfiexJyTHs4QRjix47kTc4OmnfhjbyVpD347vjCoHF2CxRKmYip8nZR
	 B27pBRDT4T8l101wBXtdUMTDahAT3sKmURn4MV72rG09nXRUaVUOBBBmZZsZNnb9cC
	 EzrhvPbWwXNOh82sAKkLO7ihg0HVVGQR3FzMuLFEkBi0T2lgClnRDdP9VIrEKqVLB4
	 /wv+4gVBcr/YxCiaVFfHPJuxr1GZizE8LY9wPwxq2XuTbWYwGQoqh7MvjQXThkGfry
	 tGMXej5HCwqKdHRnUpNv7MC/BDG38VwcYN0QhIRIgQLjWkN3uh/3sUW5BU8C2UxcZn
	 6X1WxAJAXUPDg==
Date: Wed, 3 Sep 2025 10:53:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, blakejones@google.com,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v6.17-rc] perf test: Checking BPF metadata collection
 fails on version string
Message-ID: <aLiAfPvqghcTF-te@google.com>
References: <20250822122540.4104658-1-tmricht@linux.ibm.com>
 <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>
 <aLhqDDnG4Nu9-h7C@x1>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLhqDDnG4Nu9-h7C@x1>

On Wed, Sep 03, 2025 at 01:17:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 22, 2025 at 11:02:27AM -0700, Ian Rogers wrote:
> > On Fri, Aug 22, 2025 at 5:26 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > > commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> 
> > > fails consistently on the version string check. The perf version
> > > string on some of the constant integration test machines contains
> > > characters with special meaning in grep's extended regular expression
> > > matching algorithm. The output of perf version is:
> 
> > >  # perf version
> > >  perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git
> 
> > > and the '+' character has special meaning in egrep command.
> > > Also the use of egrep is deprecated.
> 
> > > Change the perf version string check to fixed character matching
> > > and get rid of egrep's warning being deprecated. Use grep -F instead.
> 
> <SNIP>
> 
> > > Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > > Cc: Blake Jones <blakejones@google.com>
>  
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Namhyung, I think this should go into v6.17-rc.

Sorry for the delay, will add.

Thanks,
Namhyung

