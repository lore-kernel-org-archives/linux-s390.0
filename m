Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56767317173;
	Thu, 12 Mar 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349079; cv=none; b=WgCjvHViKC2dvzAAth7uQDgueYISmNGxdvvij6cIWxSNw1f8Py1UGSpSVBekiQlytj/1qBGHjK3pjzZXn5q3i0E1cNsUJuRRsStGPSgf7RFmicHSbxvFfmlVLi3r2y3/4zHZqtlKvSAnsZq3CaQRX1WKxHi0zuTEkAJSiDat/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349079; c=relaxed/simple;
	bh=K9BkTSEP4DAO1oqXkTRgIUsMciXJXXN0g3ET3zAlngE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qvVJCMh7ZE7gYkhgLeg5o4wzGtd/6nAQY8blRA2XBh5zna1YLJSLThtzQRhCUt1B4X7PUOBjBCcKqMyEiVFvAsMhARyI8PnxPT/+r97UOiOA68iUOsYM0+fmRxs3IGqjqcbrq6YwYZmjnE6dogGDCIzSPFnfRFFv/gZZJogsLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FLiV1etm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FLiV1etm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D739C4CEF7;
	Thu, 12 Mar 2026 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773349079;
	bh=K9BkTSEP4DAO1oqXkTRgIUsMciXJXXN0g3ET3zAlngE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FLiV1etmYVcSGbbdm/XWzQaxQrtcu+DjcXjI6bdWYsu841NM3z6Xw64cXI54+iaIn
	 L2BrHY9lnVUqIJ6938urwDNEtRFz9ffekCMe3lr4UZIlR45/w5t14m5ix5+hCEMOxM
	 z/hIOPZIY6kgBHdLKvnC8iu8NrktiaWhHWtId3+Y=
Date: Thu, 12 Mar 2026 13:57:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
Message-Id: <20260312135757.d65e8145d9d39e1ca5bc9666@linux-foundation.org>
In-Reply-To: <ttbskgg@ub.hpns>
References: <cover.1772812343.git.agordeev@linux.ibm.com>
	<ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
	<ttbskgg@ub.hpns>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 16:02:40 +0100 Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Mar 06, 2026 at 05:16:30PM +0100, Alexander Gordeev wrote:
> > From: Tobias Huschle <huschle@linux.ibm.com>
> > 
> > Unlike other architectures, s390 does not have means to
> > distinguish kernel vs user page table entries - neither
> > an entry itself, nor the address could be used for that.
> > It is only the mm_struct that indicates whether an entry
> > in question is mapped to a user space. So pass mm_struct
> > to pxx_user_accessible_page() callbacks.
> > 
> > [agordeev@linux.ibm.com: rephrased commit message, removed braces]
> > 
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h             |  6 +++---
> >  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
> >  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
> >  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
> >  arch/powerpc/include/asm/pgtable.h           |  4 ++--
> >  arch/riscv/include/asm/pgtable.h             |  6 +++---
> >  arch/x86/include/asm/pgtable.h               |  6 +++---
> >  mm/page_table_check.c                        | 15 ++++++---------
> >  8 files changed, 24 insertions(+), 27 deletions(-)
> 
> Andrew, may I get your Reviewed-by or Ack-by for v2 so I can take it
> via the s390 tree as well?

	Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

It doesn't look like [1/4] changed significanty since v1?

