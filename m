Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B01215F47;
	Tue, 12 Nov 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435743; cv=none; b=j1l4KBEQzYA/3oBzYgcknsuGwKy+HgawjOYMe30peg9sJuhL3LQvpDUkekbgHue5xGRwOTi+wtmCHAs0ifS1E9znrzl9845ENOMJyDwJZXKRthKHAeRunk1FOdfenTMfALHoQa5aNQm5QU2pGEDwCv3n0pwRGrGFDO8xVxKqe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435743; c=relaxed/simple;
	bh=v9ADCGAr6cULZfeazrrOEhkTHbvDQvHJ16GL+7IJLaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAZ6NfxYZI4Dvukc7AHil0zPhl6p/XqYjaDTRrHPfLwnA/aSGLkU9XwnZbRjtYy4oBkeX3rz61Aj1mem6a/d3rKZscO4i1B4hfd9Vy3ziovsJW7EOgGExzY18jfJx+/mFN3c6TQ9d7QwJY7oe8RyESSeAkiLWuux5wFWdxxl4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiNaVJGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiNaVJGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BBBC4CECD;
	Tue, 12 Nov 2024 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435743;
	bh=v9ADCGAr6cULZfeazrrOEhkTHbvDQvHJ16GL+7IJLaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiNaVJGfNjmBjGU2PD3Yq9l1mzQROTpgCvAO4x/sWYsEQx4txYISHdNvUd8SUxfR3
	 5ET1BWWSRZz6tqjP0+E8F4L52K7f00JRRxvgfae5DT7m+TIkHgMyWMJioxKixrhHjQ
	 69kyp3WAowD9BKKiFuDzRDRiTk49oFWm1yvkwo8/ELlQUKvb9jZuV6bUBVSXp9mZDa
	 B4QIg0Xq48jUnYxojYTd/Kbyy1ZiPQl580ie294ke2jKxwckyORK9c4HYdmCAtqvmW
	 NMkvQtguagSXBP5exdPaZ849D/QLQ3xu4f4vunURjTY78h0HNqs8RUBJu/Yir52oHy
	 XLSd0CWU9rx+g==
Date: Tue, 12 Nov 2024 18:22:18 +0000
From: Simon Horman <horms@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Manas <manas18244@iiitd.ac.in>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
Message-ID: <20241112182218.GV4507@kernel.org>
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
 <ae8e61c6-e407-4303-aece-b7ce4060d73e@linux.ibm.com>
 <niqf7e6xbvkloosm7auwb4wlulkfr66dagdfnbigsn3fedclui@qoag5bzbd3ys>
 <538b7781-0d57-45e6-a00a-fb03c0c30a52@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538b7781-0d57-45e6-a00a-fb03c0c30a52@linux.ibm.com>

On Tue, Nov 12, 2024 at 08:36:13AM +0100, Wenjia Zhang wrote:
> 
> 
> On 11.11.24 16:10, Manas wrote:
> > On 11.11.2024 15:11, Wenjia Zhang wrote:

...

> > Thank you Wenjia for reviewing this.
> > 
> > Should I make any changes to the commit message if we are going forward
> > with it
> > being as a cleanup patch? The commit message itself (barring the cover
> > letter)
> > should be enough, I reckon.
> > 
> I think it is ok as it is.

Yes, agreed.

The commit message should be truncated at first scissors ("---").
Which leaves us with a commit message only describing the removal
of an unused function parameter. Which, given the discussion in
this thread, is what we want.

Reviewed-by: Simon Horman <horms@kernel.org>

> 
> Thanks,
> Wenjia
> 
