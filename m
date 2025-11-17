Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F279309DDC;
	Mon, 17 Nov 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391217; cv=none; b=j8aPo+kXQoAn7u9PRShyG9gd+jflIj99VWMWN0PR+3OT5kVRrEppQuUK/yayEpsT+Kh57nzc98sd6W8ENEcLNMofZFG5ulG2sA+fULz+G1ZS9Qcyv+WCHmcH/cZoY3wQ7tcntRN2309Orgew/s+4RzmnRGIqf6c+Jycf5swu+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391217; c=relaxed/simple;
	bh=CHi0nZZGkEKprMC9PR3vEJeM8myBm8l4zKjYk7NDfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTCs+wP2DORDBzuX/yBOokWSG7KN1+Jb39Yr8E5lySPCiD8uD39+zKislfkBDAsD4z0U7C3cS0Z5sQ7eWkUO5fQHIKCgMz732rO349ncj3RSQBMf5hr0CTLDu28QNYcijufV3cBcbiDt/CGUJEW2dPm/93j7wa+eJfBmEHFKod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMarKb/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMarKb/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF043C116B1;
	Mon, 17 Nov 2025 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763391216;
	bh=CHi0nZZGkEKprMC9PR3vEJeM8myBm8l4zKjYk7NDfDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMarKb/Z5rBknb0rKMyIkFUcJJ5v9u/EYFS5nGXSS2MpoexBCe61hPwmb0D4wm/ZZ
	 aSjhdkPSXBoXXBgXuSYpe1+zJlJAHBaX5tObj2hQdHkDY3hMbgbV1hedc5elweNJ9Q
	 QSIUvhXes/XZCBEJi1mm3Wesf9AcXr4sSEwMbRqOCY9dKkMEAhnAHKyjjybfMVXq0V
	 82rOUgd6wrzD1C9N/QxYhgCIPL+z1pXoOiYRIblOaxv19D1hIO/RjYcbOubxyHtXA0
	 woON4FTFQ2irFmFh9M6C7CDxgUoekO7bDlDL+2SsnWDV5OPKswdszqmcB+vkrsM2sO
	 iKaNDeNz2KyGg==
Date: Mon, 17 Nov 2025 14:53:31 +0000
From: Simon Horman <horms@kernel.org>
To: Aswin Karuvally <aswin@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: Re: [PATCH net-next] s390/ctcm: Fix double-kfree
Message-ID: <aRs26yy7xkr3Ln54@horms.kernel.org>
References: <20251112182724.1109474-1-aswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182724.1109474-1-aswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 07:27:24PM +0100, Aswin Karuvally wrote:
> From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> 
> The function 'mpc_rcvd_sweep_req(mpcginfo)' is called conditionally
> from function 'ctcmpc_unpack_skb'. It frees passed mpcginfo.
> After that a call to function 'kfree' in function 'ctcmpc_unpack_skb'
> frees it again.
> 
> Remove 'kfree' call in function 'mpc_rcvd_sweep_req(mpcginfo)'.
> 
> Bug detected by the clang static analyzer.
> 
> Fixes: 0c0b20587b9f25a2 ("s390/ctcm: fix potential memory leak")
> Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>

Thanks,

I agree with this analysis.
And this change brings mpc_rcvd_sweep_req()
into line with other functions that ctcmpc_unpack_skb()
passes mpcginfo - they don't free it either.

Reviewed-by: Simon Horman <horms@kernel.org>

...
