Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CD15B10D;
	Mon, 27 Jan 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012183; cv=none; b=JkANkeoxFcQEf9WdmejoX/lRSYPYXNQGtHUtm1DgywRJ/Ey71N+9Txb/YxRY1/FhHJwxCuI5nLa0t8nWC1vaKnBiQAZufZY7FJFt4Ohg3G9QOF0JaUNFbBhx/L6IJKcBtk/giuJpRUXzWKyOXuiXrrdUaP5Jo84lsW+rijVEg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012183; c=relaxed/simple;
	bh=IjwjlGOx8bummuat1vXBnvyxNwe6Bu27nfCPtb66fCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t02Ps0PERuZn0QeBpFQRCdPJ9QhsA1q6mn9V4dWej39oI1GvBAWfAyoLm/RSwd8YCTb2S+760Xgbtd60duQq4tih6z9YsaZJyVE/DFRHT2UTU5t5/hU3OYLq5oJ/Wiya5xpKBX2JMmmaGS7yuPLHJD8koxB0qboMEzkfoN1bQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBiQgRvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBiQgRvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F137C4CED2;
	Mon, 27 Jan 2025 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738012181;
	bh=IjwjlGOx8bummuat1vXBnvyxNwe6Bu27nfCPtb66fCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBiQgRvU5qvNJRqE3UvuIcKhFZYfuzVe8fsJjAyNJq6l9IzYh/b4vIqrQ+N41eT67
	 uNG5hIyy4hx2uKScvayVYJj4qpYf+qRkynN531kzb3sZBFnQEKkYsM0uXPCUVsRb5A
	 jL4HgL4hAg5lGfgF9OC4jiUUkTUAdJ+Oivy7ayZro4LxhLUSXU+jDlE3VEN6mo97Nm
	 Qk+xOXbPSgKtpaMpmPr4WapIHdRHmsmM9ztMAb9CkQCXqwyRPc+nFdirR+ACK3HiHL
	 rdl2/0HKZwooTBsZQdNCvA5KttuxDclMKjeAm2kPeoumMwW3HsNH6X1Ria8kL0nVU9
	 HvCZF4btkZd6Q==
Date: Mon, 27 Jan 2025 14:09:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <20250127210936.GA3733@ax162>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
 <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Thu, Jan 23, 2025 at 11:40:40AM +0100, Alexander Gordeev wrote:
> On Wed, Jan 22, 2025 at 07:54:27PM -0700, Nathan Chancellor wrote:
> > GCC changed the default C standard dialect from gnu17 to gnu23,
> > which should not have impacted the kernel because it explicitly requests
> > the gnu11 standard in the main Makefile. However, there are certain
> > places in the s390 code that use their own CFLAGS without a '-std='
> > value, which break with this dialect change because of the kernel's own
> > definitions of bool, false, and true conflicting with the C23 reserved
> > keywords.
> > 
> >   include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
> >      11 |         false   = 0,
> >         |         ^~~~~
> >   include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
> >   include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
> >      35 | typedef _Bool                   bool;
> >         |                                 ^~~~
> >   include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards
> > 
> > Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
> > these errors and make the C standard version of these areas match the
> > rest of the kernel.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ...
> > ---
> >  arch/s390/Makefile           | 2 +-
> >  arch/s390/purgatory/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Applied, thanks!

I noticed that a Fixes tag got added to this change in the s390 tree but
I do not think it is correct, as I would expect this issue to be visible
prior to that change. I think this will need to go back to all supported
stable versions to allow building with GCC 15. It seems like maybe the
tags from the parent commit (0a89123deec3) made it into my change?

Cheers,
Nathan
