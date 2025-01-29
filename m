Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FE1494DD;
	Wed, 29 Jan 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109787; cv=none; b=uZQiaV4yj3TFyqI3EKuFVdjBKkSTcWVJtm1oea+fisXvPK/Eryc/ygi+5t75dXZ9lucx6434FfM0Ch8yli7thuolWyi1+9T7uvOtblsL+iT3na4BeOYFOmOBOb/X4aH4FJGDWCDN/XSONjpPED6gW9WiSMi9B0ErxVQHHAdwRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109787; c=relaxed/simple;
	bh=VR06ZjENg1V2BwoQ53XkUOjhAMbIFkJYpe8xLPC17hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv/Y8jUuzbI5hG6DiAeaIwA6J8i0aEGB63pRaVzkseIe4vdZYi9Gx6v7JIyObwLTA/HenhG3+xhMHPSW2BsbhwV/b0eGp9h4GC6ugtAiJQFse5oL4+FmTFfKAdYYV7oXVKTe9fvXMbGJlC+fmIR28z+XwijvbopaZNOyn8ubELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALSBw2xN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALSBw2xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BB6C4CED3;
	Wed, 29 Jan 2025 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738109785;
	bh=VR06ZjENg1V2BwoQ53XkUOjhAMbIFkJYpe8xLPC17hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALSBw2xNcCEtK88yeonRXUtia+n+5LcPeGykIVcOPLfBzx81S49TQBgkjTSXeUBFC
	 e6WsS9YocovHf5cTwdWseF74Q8o7LHqlXcBRFsV0jFiOIq/ZE+ty/7b9L8VQ2T5NE8
	 UMjhHDzOlPRhgPhGu662xwwws2T1bBTPKiYi5ZvPfRfB3SyaEeynwc2gng/ZxB3EaL
	 zqhOexBXErZYRC9pWieP7bFhPR+86EBZTXn2t0iEE+S/oENmGtlhHGHFfrbKKgHV34
	 GiyZWPbpTFAt2Nxe66fwXGwkIAak143+BTB5gnLUixvMgrMClN5Yx5AyLQ+BoNk6zg
	 pXzWdl7XcccOw==
Date: Tue, 28 Jan 2025 17:16:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <20250129001621.GA149925@ax162>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
 <Z5IcqJbvLhMGQmUw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20250127210936.GA3733@ax162>
 <20250128075319.7058-A-hca@linux.ibm.com>
 <Z5iUi9EdsPPMqlRB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5iUi9EdsPPMqlRB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Tue, Jan 28, 2025 at 09:25:47AM +0100, Alexander Gordeev wrote:
> > > I noticed that a Fixes tag got added to this change in the s390 tree but
> > > I do not think it is correct, as I would expect this issue to be visible
> > > prior to that change. I think this will need to go back to all supported
> > > stable versions to allow building with GCC 15. It seems like maybe the
> > > tags from the parent commit (0a89123deec3) made it into my change?
> > 
> > Yes, looks like b4 picked up the tags from my inline patch I sent as
> > reply to your patch. The following tags shouldn't have been added:
> > 
> >     + Closes: https://lore.kernel.org/r/20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org
> >     + Fixes: b2bc1b1a77c0 ("s390/bitops: Provide optimized arch_test_bit()")
> >     + Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Alexander?
> 
> Yes, I think that is exactly what happened.
> 
> @Nathan, thanks a lot for pointing this out!

Aha, that definitely makes sense. The result looks good to me now,
thanks for the quick fix!

Cheers,
Nathan
