Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241921494C2;
	Tue, 23 Dec 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508876; cv=none; b=hmJX2Eo+o+HFnRmzx1GJM4Frt0aHCYgLmH/cLqHPjYMhUgOdkZ8+fBCoMxDTuMfCiVYeQmYtyvsyHr0P9AdBB33ozeZoMC7U5H1nKCsHT7czQnU4d1XaVTbxcJvh/AyBr/yK2/Lr2pGOCDCoX2DFnMhCJkUvb5PjoXuaI6JLHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508876; c=relaxed/simple;
	bh=YSvTCQaekcYuL9cT3nyDik7utEEmbDcrz5nvozNxXXU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uwdOsFPtQbgp+P02Bk7OQi9hnKnNHxuhzbHgQKF6335K4VL9mCPDR01Uu3P4jMdC4sGbZv2AiZOhr06OItjp6vqwwQr3AzFQVySNtFmAX/eEbAHIRbnLzjznbUJS/FfHGEwGAcJSFZe2ij0FMyZZ3H8iBCR1KEuJCIlBiW8RT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y2uhOtTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y2uhOtTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1558EC113D0;
	Tue, 23 Dec 2025 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766508875;
	bh=YSvTCQaekcYuL9cT3nyDik7utEEmbDcrz5nvozNxXXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y2uhOtTyCjTw1tPpgTeL42HMR7NDR8YOrZMmVeoReXhmp5EKVThfwCgm9ZMq2H10F
	 oIzbBqYLLx4dJjMprtUcezIIPaEprCv7+Ivvq8DySDY/SkRr8lJUxxnEjv0nTy3DK7
	 vdoFrPcKrSwzR1BtpDgv8TYXz/1pAkkyi1dpscy0=
Date: Tue, 23 Dec 2025 08:54:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, "David Hildenbrand (Red Hat)"
 <david@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Sourabh
 Jain <sourabhjain@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens
 <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Thomas
 Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-Id: <20251223085434.a6d6ae08c3aedf420908f404@linux-foundation.org>
In-Reply-To: <aUqAcf2405H0pRW1@laps>
References: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
	<20251223013045.4579-1-sj@kernel.org>
	<20251222183055.88c3cc1f0705c1dc29c7f011@linux-foundation.org>
	<aUqAcf2405H0pRW1@laps>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 06:43:45 -0500 Sasha Levin <sashal@kernel.org> wrote:

> >> > Yes, -stable maintainers have been asked to only backport patches where
> >> > the MM developers asked for that, with cc:stable.  There may be
> >> > slipups, but as far as I know this is working.
> >> >
> >> > I don't actually know how they determine which patches need this
> >> > special treatment.  Pathname?  Signed-off-by:akpm?
> >>
> >> I guess it is pathname, based on ignore_list file [1] of stable-queue repo.
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16
> >>
> >
> >Oh, that's a bit sad.
> >
> >- other trees sometimes mess with mm/ and they probably aren't aware
> >  that they need an explicit cc:stable.
> >
> >- misses drivers/block/zram and probably various other things that
> >  the MM team maintains.
> >
> >Oh well, I guess simple mm/* coverage is good enough.  But I do worry a
> >little that useful fixes coming into mm/ via other trees without
> >cc:stable will get missed.
> 
> How should we improve the filter? mm/ AND signed off by akpm?

I think just signed-off-by:akpm please.  That way, mm fixes which come
in via other trees without cc:stable get backported.

Obviously we'd prefer that such patches get appropriate consideration
by the MM developers but sometimes other-tree people aren't that
cooperative.  In this case it's better to backport the thing rather
than missing a fix?
