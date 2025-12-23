Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FE70824;
	Tue, 23 Dec 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766490229; cv=none; b=KgB/dnVR+mmMd0khROpaSIbq6zs4P7ilGXOmQA4Ein1ky7HJxR2UVAWTv0GJvFBSQgaPo9Xlk4PvjB+dphsK3ee18e/Jq2Cc0KE4mK6gn9r+9y8Nhp5yKm558yj8hZHPP68NB+YgZvZWAtkusxkXFaO5i82dWfFmMsRLupNLUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766490229; c=relaxed/simple;
	bh=Y356nykrWSoOLSfh5YSTuQ7KEeAa3+p4YJplI7gtpt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEBGJWalv2iQ5AptF7eRQCB5mPRClnmKWr30opqq+90xgk+9MYHuWe2sKbFKdq43epnl31lNV8kj0/i4Bhh7sPLHnuJMin1ryFIXmcSc93U1+5HoeKYUgvR2a6/W3bZUEihslt7xAx818dvP9ncTOcHjqF30xAHCFJFW7rR3idI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp7+0Uj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp7+0Uj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37179C113D0;
	Tue, 23 Dec 2025 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766490227;
	bh=Y356nykrWSoOLSfh5YSTuQ7KEeAa3+p4YJplI7gtpt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bp7+0Uj5Z6VN2PwEXcmIQc2WbkxYG8kryhsefYIJmIYPnYY8o90w6UX2JAubtYhjj
	 fBSUj5KqEJpYw8kJ81qOZlCpQls5B1SHKmUG+cp9QRjlRtPS/GxilpnVO0oeJsFhh0
	 zpt35Rfs7wEpcjroz4hRRUAfPWdl4TmZ8biix0Eni2qLTjfyXRIbVKoacsc20ADOyt
	 KtOUj3Lc0LkCMZcWCBPQjQWIkBMyhkyl0Q2SI8TqIeWkTTBxIxFgeEXzoQqUMzJ0C7
	 lSF3JsFbuzMqS9nWP3rV8QXPHDJtLQFnf0UWcxlqVQ2wqbWDUNFSH78aHXUtTl1QZZ
	 KKfmU+sjJ/a9Q==
Date: Tue, 23 Dec 2025 06:43:45 -0500
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
Message-ID: <aUqAcf2405H0pRW1@laps>
References: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
 <20251223013045.4579-1-sj@kernel.org>
 <20251222183055.88c3cc1f0705c1dc29c7f011@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251222183055.88c3cc1f0705c1dc29c7f011@linux-foundation.org>

On Mon, Dec 22, 2025 at 06:30:55PM -0800, Andrew Morton wrote:
>On Mon, 22 Dec 2025 17:30:44 -0800 SeongJae Park <sj@kernel.org> wrote:
>
>> On Sun, 21 Dec 2025 10:49:07 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> > On Sun, 21 Dec 2025 10:22:44 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
>> >
>> > > >
>> > > > My main concern was -
>> > > > A fixes tag means it might get auto backported to stable kernels too,
>> > >
>> > > Not in the MM world -- IIRC. I think there is the agreement, that we
>> > > decide what should go into stable and what not.
>> > >
>> > > Andrew can correct me if my memory is wrong.
>> >
>> > Yes, -stable maintainers have been asked to only backport patches where
>> > the MM developers asked for that, with cc:stable.  There may be
>> > slipups, but as far as I know this is working.
>> >
>> > I don't actually know how they determine which patches need this
>> > special treatment.  Pathname?  Signed-off-by:akpm?
>>
>> I guess it is pathname, based on ignore_list file [1] of stable-queue repo.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16
>>
>
>Oh, that's a bit sad.
>
>- other trees sometimes mess with mm/ and they probably aren't aware
>  that they need an explicit cc:stable.
>
>- misses drivers/block/zram and probably various other things that
>  the MM team maintains.
>
>Oh well, I guess simple mm/* coverage is good enough.  But I do worry a
>little that useful fixes coming into mm/ via other trees without
>cc:stable will get missed.

How should we improve the filter? mm/ AND signed off by akpm?

-- 
Thanks,
Sasha
