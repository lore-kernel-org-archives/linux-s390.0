Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9D2BD034;
	Wed,  3 Sep 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916240; cv=none; b=t1/UtEjPGsDMYnru9x7C/tiW9oJem0QiTFAuatgw6NBao/pZsh/Vpd/bUZryWu73k2tpP4YBEkEFZNv+znNSNSW8gM0Niv3xnscovFUCrH9nd+p/3hzZbXk8PJzUew6dNG+RHYwvH4MX7cIUmiEC9dqrdDilgv6qya/4pI/wTKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916240; c=relaxed/simple;
	bh=o+WvopKUkDO5D+QjLVhF9kUeHK4AramhRlHQ5c8Yiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moKGQaMnPgA/10jmukcxRsBv3SYlLVI3inHd8aUIpCJdxZPG6lyJo7rC00Kd/zObSeMnKG0GWF8Y3xYB33Lj06aEIeYEskye7jSyX505/d8MebaXCcokis0tXccOrBWqE4embcx9sqbNkJ6gwoVZIP8QV9J6kGdyfqsEmiDROLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWKkp6A5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWKkp6A5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1F6C4CEE7;
	Wed,  3 Sep 2025 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916240;
	bh=o+WvopKUkDO5D+QjLVhF9kUeHK4AramhRlHQ5c8Yiv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWKkp6A5vgddDRQlniZKC6pI70tMJoOPjQuWVRH5ajLvR0xLSNablNQXRSXv1oUxD
	 6WCH4L626uu2LneArQHjBsV9aI1l9swjLvjgycrb8Gp2vXtLlbvK6oi89NOhqtZelt
	 8SgDlj5aEn5m5RQ2m1hI9Sde6phKz5Ogkih5AbMriaizRIgqLsASGppyPVWC2qmROO
	 VA4/U1kO8RhCtzUkatSKrxRc94K3k2G0II360tA81zVgc8WAq35wBnb67mTVkQ5wXz
	 F9u/OkJIZ3adnL+jxkEwUIwQYjJk+asftLDI0rq7bhMw6bh22NNKcIWI79gcnv84gP
	 hh2YixVMyQqnA==
Date: Wed, 3 Sep 2025 13:17:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	blakejones@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v6.17-rc] perf test: Checking BPF metadata collection
 fails on version string
Message-ID: <aLhqDDnG4Nu9-h7C@x1>
References: <20250822122540.4104658-1-tmricht@linux.ibm.com>
 <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>

On Fri, Aug 22, 2025 at 11:02:27AM -0700, Ian Rogers wrote:
> On Fri, Aug 22, 2025 at 5:26 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")

> > fails consistently on the version string check. The perf version
> > string on some of the constant integration test machines contains
> > characters with special meaning in grep's extended regular expression
> > matching algorithm. The output of perf version is:

> >  # perf version
> >  perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git

> > and the '+' character has special meaning in egrep command.
> > Also the use of egrep is deprecated.

> > Change the perf version string check to fixed character matching
> > and get rid of egrep's warning being deprecated. Use grep -F instead.

<SNIP>

> > Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Cc: Blake Jones <blakejones@google.com>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Namhyung, I think this should go into v6.17-rc.

Thanks,

- Arnaldo
