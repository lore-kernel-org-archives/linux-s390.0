Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96C47607F;
	Fri,  7 Aug 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107443; cv=none; b=n/RbopuDKZaWn245nOFGz15Ak+hLnGcCDklLCxk0Pp2CtiqfqySqJxU1vcYxxIjXUY2mH87Qq95UiSEJ8dudtahoTgSg7yL84iJyTHdD+ubQvb1cB/ShYJ5AG0nC5ssuH832o91c5XATcuhdPF0l3ckzcYGN1N141A6QhK6Xet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107443; c=relaxed/simple;
	bh=RqNrnrfSrh4JGqVqqnuJS4ZrvC2g64alleAL3373SJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9T7T/Q8Wbi8tk0uTba2WCWQBCEnn484xzxakWu5FzKPND1XldV0wpUTRzePp0PE/e1OwQMztk1vlq6e+6MyGO9jodioGalwSSF4W2sNm0vTBbvDeyrLOLGWH61mGWv/tkNaiddElcTE79AP/8UAa4BsT+aY2KnQ+pJgT4NaU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI/xW4b6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI/xW4b6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE321F000E9;
	Fri,  7 Aug 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107436;
	bh=bfeT8Oe0hGP6zH0zazdc6PEZoroy4KpwJjKGjfF2ayA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZI/xW4b6wrmM2Mp2BrqbeavdEN8NnBJ9uODK97LhzrfB3IU2OmtFyN5prTcpLJhg8
	 8lrqCfC81aS+nWvHyfbvpCCb67hz4ZY4ZOA4xf5uTod6/1YpDDmjSl37jZzvOKdU3v
	 s9+kkxACDnSJ/0RUjlsSL2JAaMugu2EPOm2A1jg35XpFVyjFMRwDSKOemYj/L4LcYG
	 AYQK0hhqj5TgWGvYR8dkvyOYsLg0emmSDpscJrvywdNfmWHr1VD2epjlmKpBn9qHFx
	 Jxb571w0ZRzMoRn+qizl2IWc/kWM6hpm9b1pEET2rC21EGgONKOXIZjN2JOQ8zJgLj
	 6pvpZ6pQX/akg==
Date: Fri, 7 Aug 2026 13:57:12 +0100
From: Simon Horman <horms@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
Message-ID: <20260807125712.GK51943@horms.kernel.org>
References: <20260805145032.1409325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805145032.1409325-1-hca@linux.ibm.com>

On Wed, Aug 05, 2026 at 04:50:30PM +0200, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for drivers/s390/net.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> Do that for drivers/s390/net. In order to avoid false positives due to
> conditional locking, disable context analysis for specific functions of
> the ctcm driver. All comments in ctcm indicate that the code should stay
> as it is, and that such warnings should be ignored.
> 
> Disabling context analysis for specific functions keeps analysis enabled
> for the rest of a file.
> 
> [1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
> [2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")
> 
> Heiko Carstens (2):
>   s390/ctcm: Add __context_unsafe() attribute to various functions
>   drivers/s390/net: Enable CONTEXT_ANALYSIS

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

