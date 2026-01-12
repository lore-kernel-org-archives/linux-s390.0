Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717B37E2FC;
	Mon, 12 Jan 2026 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243918; cv=none; b=HSeeKM5J9+HecWflu50jTwATlBsmI8n36SUEOICgffp3jVzxaWU9pX4dcpCauG1tQhEx82V4/ukLhkaMrWnUOYvDh0xh2UZq7wExsQ2RfA3tUWST/8nbIlDtnIk9bGDa3NC9cUTORDJJwm4Oo8mxVOzLCmbBc+2N7imzW7Sh/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243918; c=relaxed/simple;
	bh=lXH34tPpi9gC06FqoWff06TrHtRa1kynr19tm8tSGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv8TxYtSrYV/a4JZovREJMiuxgLXI+oIy//jI01J8mlzIFVnsqZVTo9XGHF8S3fzdVwvlCXWuFgac42EvOB5YqvlfaNegY/GOA7OXJtpnYej3dfVA30IJdbLFBpnCEV1jH+b6Bao+PECeqBHOhhjbSecQLsc7exziWR9EJVezZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYl+kMBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYl+kMBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8760C116D0;
	Mon, 12 Jan 2026 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768243916;
	bh=lXH34tPpi9gC06FqoWff06TrHtRa1kynr19tm8tSGH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYl+kMBuO+4NR/GAihg7u8ryF9XE/ab/21HT7ydThiIb+q/fTlmBzVpXbbURinPQY
	 LVIGZqnMcWWIVWk2HfTHRd7xWnlIMSbqOYlj1dzeGzG3I25qQqy2kLuUL7ei004ruB
	 EnK0tNaT1nhrfcmg0aE3QO4VtcrMhbZ1CSZvm7VGCbBQRr1BX58Nf4l4KdcIPdLIi7
	 Z4Gav1ZtdzIhmn1OqaUcYAQf4AgoFBC4bjJsO671iZzRNl2g1fXRtAa2vS6DXiW+v+
	 fS8MpFwzhxvZDRteIPeVEr0Z0RKgRlEeDx8gUnCQSJdoTqNRaxR2OFNlGIYxyWrCF4
	 05mUARebkVs1g==
Date: Mon, 12 Jan 2026 15:51:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org
Subject: Re: [PATCH V2] perf test: Fix test perf stat tests for virtualized
 machines
Message-ID: <aWVCyFX6UURztKXA@x1>
References: <20260107133216.2070400-1-tmricht@linux.ibm.com>
 <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
 <CAP-5=fUrqq5fH9DRtXM0KvYhG5LWzWMf0E4r+62=kAQgbzDHAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUrqq5fH9DRtXM0KvYhG5LWzWMf0E4r+62=kAQgbzDHAA@mail.gmail.com>

On Thu, Jan 08, 2026 at 10:03:49AM -0800, Ian Rogers wrote:
> On Wed, Jan 7, 2026 at 7:30 AM James Clark <james.clark@linaro.org> wrote:
> > On 07/01/2026 1:32 pm, Thomas Richter wrote:
> > >     # The expectation is that default output will have a cycles events on each
> > >     # hybrid PMU. In situations with no cycles PMU events, like virtualized, this

> > Reviewed-by: James Clark <james.clark@linaro.org>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
