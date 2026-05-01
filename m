Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63190308F1D;
	Fri,  1 May 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650741; cv=none; b=mQraM7vuSG7K3TN9OcGwpA4tz8d7jPN/69t81r/8x85Q35HYH02N2bIrw1Fza0t0lv6uLpu8aCJESHk9Q+k9wuHfObO8WBtDhr2qgQbpuwKExjB9UwEI5jxEO49i7xi1JCfaQblHaEmtS6UT1i6OXqAYAPWZB4ctt+q1mFK0whE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650741; c=relaxed/simple;
	bh=CmRbcbTi+OjVPZtnCXwufH2SPkRkS5oJkc2YfZ1djM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIusWcy9NJU95a2qkMMyrHKW17Zgp7PyW/CuaZtVL9KfZT4w6K6EOGXktoqWwPKrg0+aFeupbnWfvSC3opJ/7QnbrHhNaAX6Lv2cdFDh+xqgcXlYyZRnOOu2NcGGVwQl7T0btFLyTE+E098OS+qV6Z6qkZH53x24pd6SlP74Bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVDd9j10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVDd9j10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D9C2BCB4;
	Fri,  1 May 2026 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650741;
	bh=CmRbcbTi+OjVPZtnCXwufH2SPkRkS5oJkc2YfZ1djM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVDd9j10pzEBSdRC4+QeFj4BgrGtGegXqADT53FcQUjMhslsOR/0b8M/SeBRUjbiL
	 U2fYt86IaWaPqn4mV1onqa61I1SUk7HLNDW/omvLoBf0BH4n82Nt8SShUszHOEgWX+
	 Yg2s+/jyz3VDnqKEVso8YuKRhMIWmw5AZKuu313vA5DlmyJ/Rx3fmNczFEGG/bRD5C
	 eqUXB71O0/nCiiPJ8qZcNkawkQKohpdSSJ4uA0FZNvaLfCO6RUdrocyE/W1A7fSAIz
	 Hbt9kjA297YFDx/3kqUo5yAmQtYP02v7yShDf43ds+6qzWhvd82x48N7/jTN1fhgjc
	 65/sBiyDMsG6w==
Date: Fri, 1 May 2026 16:52:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTKsSj0i-ZkRZN5@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afNM-gIqxpyJ6ro7@casper.infradead.org>

On Thu, Apr 30, 2026 at 01:37:14PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > (1) If we need to wait for I/O completion, we still drop the per-VMA lock, as
> > current page fault handling already does. Holding it for too long may introduce
> > various priority inversion issues on mobile devices. After I/O completes, we
> > retry the page fault with the per-VMA lock, rather than falling back to
> > mmap_lock.
>
> You're going to have to do better than that.  You know I hate the
> additional complexity you're adding.  You need to explain why my idea of
> ripping out all the complexity now that we have per-VMA locks doesn't
> work.

After a brief eyeball I share Matthew's assessment, I really don't like this
series, it's piling on complexity for what seem like niche cases.

We already have enough weirdness in fault code honestly.

Let's maybe discuss at LSF if you're attending?

I will try to have a more thorough look through when I get a chance.

Thanks, Lorenzo
