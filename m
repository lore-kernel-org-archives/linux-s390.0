Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C41DF982;
	Mon, 16 Jun 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064112; cv=none; b=Nl+1y6cdAJyLGrfXsNuKc6Qt6uwn+MSuaWN0w7x0S0VCSIokgzk2wEEbzB10rWGrb/SMDGcLIZZHfoVh5s4HYG4iiCgjjgWQ9stTp/cUw9wsumEVyiT55TsxBySdvPYrharv0BVxoMVSeiKh3h895Tr3jJPtiode5kLA93W5ALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064112; c=relaxed/simple;
	bh=yVMK7o6TEsrw4Q3fvl9FM+ShlUKqWavW41gkW+rpmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brD65an6JaFnGe2/5ewGBPbwxAmyGJTP9ywIYEsQLCQ9C9rI10SA9/KwwM+HmgjSfYOA5wL3Wj3FuPe9c0TSe5EyE5Vp8ics4o5lAncCHdP/oX5TpqLNHQCsOnlihUSB73jHvwfGGFekIMB93r+T6GEdoFnA6y7m8mAwr/15yHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7/BL2qY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7/BL2qY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54239C4CEEA;
	Mon, 16 Jun 2025 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750064112;
	bh=yVMK7o6TEsrw4Q3fvl9FM+ShlUKqWavW41gkW+rpmNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7/BL2qYK+YG+ojniL/KBt0nWQXdG4qf3Jm32w2X6tFbOXvb1tTKbeR+BtGuiQppV
	 tjqqf+YZH9c074Q2KfLZEu1ZqD2dicn1wPI8RLYgsub4TH71CZBENIpnMTel64DXay
	 M+w9DO9z7qJbRAnyhuuUYDrmz56xKMfL+adRPVGCGIAmxauEWqAM4RltL5/3sOYQBF
	 vqkTzHZ2CwTqPndh0KHWRxboh0cAEXLwuhahMJWTZ+THuRCxzyUqpW59mlrctnSAi6
	 OMcY3gZvmbhF078IkIIklL8hK9VcN0F22qTV2YxTSO47EjYrBty289K/VkoYzuNBeR
	 x/tPq4dEv6ISA==
Date: Mon, 16 Jun 2025 11:55:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3 1/2] mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic
 for s390/alpha architectures
Message-ID: <aE_b5X7NmOd5-SC5@kernel.org>
References: <cover.1750040317.git.gehao@kylinos.cn>
 <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
 <afcdc872-680e-40c6-98d0-6b6a43daedbf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcdc872-680e-40c6-98d0-6b6a43daedbf@redhat.com>

On Mon, Jun 16, 2025 at 09:59:09AM +0200, David Hildenbrand wrote:
> On 16.06.25 04:29, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> 
> subject is misleading: we are not optimizing anything in this patch, do we?
> 
> It should probably be called
> 
> "mm/percpu: rename ARCH_NEEDS_WEAK_PER_CPU to MODULE_NEED_WEAK_PER_CPU" or
> sth. like that.
> 
> 
> > Add the ARCH_NEEDS_WEAK_PER_CPU option to the mm Kconfig file
> > and enable it for the s390 and alpha architectures.
> > And replace all instances of ARCH_NEEDS_WEAK_PER_CPU
> > in the kernel code with MODULE_NEEDS_WEAK_PER_CPU.
> 
> Most of the description here should likely go to patch #2. See below.

...

> So what you could do is move the actual introduction of
> CONFIG_ARCH_NEEDS_WEAK_PER_CPU to patch #2, where it is actually used, and
> limit this patch to the rename.
> 
> Similarly, teak the patch description to reflect only that.

Right, if the patch only renames ARCH_NEEDS_WEAK_PER_CPU to
MODULE_NEEDS_WEAK_PER_CPU the description can be as simple as 

mm/percpu: rename ARCH_NEEDS_WEAK_PER_CPU to MODULE_NEEDS_WEAK_PER_CPU

as a preparation for introduction of CONFIG_ARCH_NEEDS_WEAK_PER_CPU.
No functional changes.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
