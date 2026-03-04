Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9C611E;
	Wed,  4 Mar 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636907; cv=none; b=dmHA5S9ArFUyeEGaUgY7NMI5IPOdjz6DWuutGklV42GA0X7c1S3jmT43cLk2jbXqmYgsaAuxXrER+sZK96z8EPXVdttSe35l5M3dXL5bDi19l5jPMdQAxQwVlX69hMuy69sQkWvkB+Hk1JOXgFU6TgqXBc9YNPGi6SAGJrQFJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636907; c=relaxed/simple;
	bh=2TGls5NMglPJf2mT0nC0v7dhXbN0gFTp1s3E9TBvs/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0I3b0GnEZM80ZBGzhPx/HUd2HJop57xx3k+9s/Bb6N8kkvEf6H9w74Aw6zCLJr5a8iNGcgXDHHYEmxlEvl4yvL1NnRz8Vtkr8wjaYvlxc9Hz3PW/n3M+7s+4NfrOhf3CClVUshaUfqenmMBRog06/b1N0bud5DmfQIPy+bjXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdaiLF2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdaiLF2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47DEC4CEF7;
	Wed,  4 Mar 2026 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636907;
	bh=2TGls5NMglPJf2mT0nC0v7dhXbN0gFTp1s3E9TBvs/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdaiLF2o1n0vlO6m3lPMwNOZphF80XGIYFDKeAxw1+JMFcJA6XnXrRWxPayyuRLVF
	 xY5DnzmDjm7DJGsEtxMJiajrbRZ8l21MKX00T7YHbM6n8jfjh4FdgBGofDHYF43yQW
	 sjlMNZpR2PpIYO7EILIiJ3f8tnA6eq0jYohYG//E8sZ1rVPs1IlYUC+Nue1NJGJX83
	 /ZvRJzk/wjM00Qe7Vcu3J8Jc4qfENJbNHlSspYp4FB1OEeUPLk4QSci6C2dm8Cx0BE
	 L0XunLQULaFgDFy8lncpzgsnDMgD/f0YMM1QxW8sDSvg0Xyj4iDp+J7fu1u2WjiXy9
	 YbUSswlGFU1Qw==
Date: Wed, 4 Mar 2026 16:08:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 8/9] s390/vtime: Use lockdep_assert_irqs_disabled()
 instead of BUG_ON()
Message-ID: <aahK6FgW47BulQJ-@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-9-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-9-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:11PM +0100, Heiko Carstens a écrit :
> Use lockdep_assert_irqs_disabled() instead of BUG_ON(). This avoids
> crashing the kernel, and generates better code if CONFIG_PROVE_LOCKING
> is disabled.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
