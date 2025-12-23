Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4802BEC27;
	Tue, 23 Dec 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509913; cv=none; b=Bh5gLjBhqzzPcSEdlCB8PBMMDLSRxD+zSVSQF+xAb+MUQEFJeVNHE6/t8Tie7cdaOUD/3fQIewztewf9GWC+WS2lHMMP/hLJuIGL9ZaB0N+ldubeXgNGJxYDDFJAEZWGHU8oTBkAhrs+A2iI8OY1vBsyVtGhrrQSkV63XluSbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509913; c=relaxed/simple;
	bh=3um8NkjnKfQWblw0ttBXC1gQUUqnZlPZFVjmKn1p7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asK0iGOfjtLVdIwjd0IpHnLdKl+QmMIh7/B+sY/H5gVvo1JUlIn1T1drn5i/9io6kkBa3dC+WXeNUtNee+e96YIW5+OEhgPhu9ioUZSG2pfcFikX7zSaqm4K0xU1kFz7oRELQqtYLiYvByh+FV5yJ23om8IlSHAsL5K3f5RflaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa+0Ubgf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa+0Ubgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59005C113D0;
	Tue, 23 Dec 2025 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766509912;
	bh=3um8NkjnKfQWblw0ttBXC1gQUUqnZlPZFVjmKn1p7PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa+0UbgfGH0MW7oBnwI79BEfDFeL2kz26p3mGx0sCirQiG+ODvVSzIvze2Y4eZ39e
	 WIzrCovlU7u1ZaXeiidmAy+OfcAiEQyWBxBq8TEgBFblUeLzUl71pnP8IwQYxRxZtl
	 JU7DoafiH8mxnn2LoNc4c4dJAdE2oBfmG5UhDjQJJJ432y4bbFEKAVbwNtMFpz/VKJ
	 6AlMqdnjsTFz7IjJg58q5KShlRT8jwNW+ZHfTHRSECk5n7n3KNXCVAxif2wK9xXXXT
	 E+/IjLB2oCGTQ1JX1lHXV5bbVjgxm5fyavrfeDQFfoQJYkrnbzjVcvXusb6YT55ENG
	 LaGk5PAMnNqlg==
Date: Tue, 23 Dec 2025 12:11:51 -0500
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-ID: <aUrNVyuSaQrQLGZP@laps>
References: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
 <20251223013045.4579-1-sj@kernel.org>
 <20251222183055.88c3cc1f0705c1dc29c7f011@linux-foundation.org>
 <aUqAcf2405H0pRW1@laps>
 <20251223085434.a6d6ae08c3aedf420908f404@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251223085434.a6d6ae08c3aedf420908f404@linux-foundation.org>

On Tue, Dec 23, 2025 at 08:54:34AM -0800, Andrew Morton wrote:
>On Tue, 23 Dec 2025 06:43:45 -0500 Sasha Levin <sashal@kernel.org> wrote:
>
>> >> > Yes, -stable maintainers have been asked to only backport patches where
>> >> > the MM developers asked for that, with cc:stable.  There may be
>> >> > slipups, but as far as I know this is working.
>> >> >
>> >> > I don't actually know how they determine which patches need this
>> >> > special treatment.  Pathname?  Signed-off-by:akpm?
>> >>
>> >> I guess it is pathname, based on ignore_list file [1] of stable-queue repo.
>> >>
>> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16
>> >>
>> >
>> >Oh, that's a bit sad.
>> >
>> >- other trees sometimes mess with mm/ and they probably aren't aware
>> >  that they need an explicit cc:stable.
>> >
>> >- misses drivers/block/zram and probably various other things that
>> >  the MM team maintains.
>> >
>> >Oh well, I guess simple mm/* coverage is good enough.  But I do worry a
>> >little that useful fixes coming into mm/ via other trees without
>> >cc:stable will get missed.
>>
>> How should we improve the filter? mm/ AND signed off by akpm?
>
>I think just signed-off-by:akpm please.  That way, mm fixes which come
>in via other trees without cc:stable get backported.

Ack

>Obviously we'd prefer that such patches get appropriate consideration
>by the MM developers but sometimes other-tree people aren't that
>cooperative.  In this case it's better to backport the thing rather
>than missing a fix?

I tend to err on the side of taking one extra thing rather than missing
something :)

Would you be interested in trying out AUTOSEL for mm/ again? In the current
workflow I give about 2-3 weeks for review, and all it takes to have a patch
dropped is to just reply with a "no".

I can generate a series with mm/ patches from v6.18..v6.19-rc2 that don't have
a Fixes/stable tag but the LLM thinks that it should be backported as a way for
you and other mm/ folk to gauge the current state of AUTOSEL, if that helps?

-- 
Thanks,
Sasha
