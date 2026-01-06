Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60069194C96;
	Tue,  6 Jan 2026 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735819; cv=none; b=EXmmpaCX9bPma+h5p2LM5VWccDNjNXtbW6k56Wxm/gWXwpIDhMO3vM32upZqbM5yCGLPXgh8lq4kYf3KCxlHR788kyZGJYrOvS2W4iArfl369Bs7KyVhddjYZPIRWATBL7fdxQi8eArmSIxx0ZyBKS73ZBr2E6Ai9Wf0emeiOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735819; c=relaxed/simple;
	bh=hUHsHh3FbOTEb3Y9hs5Fw2NpxjDFWmCSLXCPJmeq4FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV6bea+LGRdgd91UtaCc6rVg//lS9CZ7B642eVkljAZ8eKFh9uEOkR7YzrNQBWrwayaSLVdZrcgsflWXO5hHfODN5ukpvJB1lJ2RrSYJ1LWeuCSXejFlNt72XZjegl7EQk527luUB6GBRgUtCUgF91AH9u+9VaDqmgNYaWwq94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlWubsDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlWubsDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C792C116C6;
	Tue,  6 Jan 2026 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767735819;
	bh=hUHsHh3FbOTEb3Y9hs5Fw2NpxjDFWmCSLXCPJmeq4FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlWubsDj4lQBSprNxvhsNImCqdrbDMVJTRmXDXcfeIOGfmJ3WpQ/0na+7ObpWwgp9
	 nnatXlhNTCBda1TOItyJML5HGAW2KDR7+fetzJO5JIooQWg3yScRk7dgoudMG0J6ge
	 lZkMORaoW/XDnzs3YduJoRv3okldL0oTBz+n2NqBesnI1hD07okS0HN/dAuQefMfHi
	 iU+BqAMLLqHTc5mRCiDhZTHLZk/1fCFpE3UutIxVIoIDD8X2yiWy1LNw8rpvi9frp5
	 91x4UiPUOzmy1jjbVAvwpF+HSJ13TZdzdGdhvo/hmqjobT8kbZOgIzoON4y7dFMjGe
	 lP19m88H10gzA==
Date: Tue, 6 Jan 2026 18:43:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2] perf test: Fix test case perf evlist tests for s390x
Message-ID: <aV2CBqwc94wbPCsQ@x1>
References: <20251210071752.4160369-1-tmricht@linux.ibm.com>
 <CAP-5=fXZw9NA7bK6bH+hxPYG0nHGPYKqtYt3pg7iNmsQPWHRig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXZw9NA7bK6bH+hxPYG0nHGPYKqtYt3pg7iNmsQPWHRig@mail.gmail.com>

On Wed, Dec 10, 2025 at 10:35:01AM -0800, Ian Rogers wrote:
> On Tue, Dec 9, 2025 at 11:18 PM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Perf test case 78: perf evlist tests fails on s390. The failure
> > is causes by grouping events cycles and instructions because
> > sampling does only support event cycles.
> > Change the group to software events to fix this.
> >
> > Output before:
> >   # ./perf test 78
> >   78: perf evlist tests              : FAILED!
> >   #
> >
> > Output after:
> >   # ./perf test 78
> >   78: perf evlist tests              : Ok
> >   #
> >
> > Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
