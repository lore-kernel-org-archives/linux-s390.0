Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073315;
	b=xhwABrjPlJ5FtmVRQR4LaNcEWNqqU9CZhK0m0X+koKTIP5mA0ac+7gML6a/zUokifvqg
	 0z/F9LGGczYe156BCxgbsU/ZzgLXu6PGB/PRP7jrs05YO19DCmFOMWt6kX0dMGG2UT8uO
	 yggAU9EZalQzGge7xM2weLwOVMisdgqMq+Hn42xw6kI8phlD0G/DlN/cMouJUUyBDX6GL
	 myU3cOJY5LSD7KntSKl0cFC+qEriL0rAbw2mSKUWrVcmKsn/qxdPjTVnH5WfU1n6ZdPWQ
	 4WxZG5QVwE6lAZJZsdGwT/Or+xz1CoA7yUsXWmNxwADnnQuXgRG9Lxi9qNPG2OvOuuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2smR8h1VY8UC7VVz5oqEi+bHmSa6sUXSBdFSQ0jzot0=;
	b=ktmNa54rDSkpB1Jh7qpSe2FhoJWfViz4gjOKLz3VelkrZ+nzTMkxUVBeatnbRLo659Qn
	 DAFAHJy/r7O37zzRk4d1UyRqvlBSQ43jSFJhsJUn7lKZMMSMmLnO1gsPyD8/fWqxekMDB
	 nCLWXV3XNoWrx70hiUiZqDb2UQnAuHIEAND1oXhYsKqblJw8Hh7EHMnFM/9qD/EI2doqc
	 2M1Dnfty8+X4LqGdE46CyuGZiKxSRqyoCBmQonPx99v+VXjgyPduTMiJdT23W6/aFa6kl
	 dJrgojv3HrmauW63uYyNQrhKDKlVQWXB8uppIxxcSyo2OJ73s1U4Plkh0csc43MSxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRsQH68f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83808606A326;
	Sat,  7 Nov 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRsQH68f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19951F0089F;
	Sat,  7 Nov 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073315;
	bh=2smR8h1VY8UC7VVz5oqEi+bHmSa6sUXSBdFSQ0jzot0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRsQH68fYsmt/YqRKnGb7j9+ZUn/BT15BJaZIFXTUVXUP3ixFLBWVgTbJU6W8sJpS
	 b1fCpxzQFDVR2VJSr2R8zzA4uJoZdaIK0pmjvTM5lACaj4AJ7F874TXs2E62xNfRn9
	 L5SR2J84VJFqjLNK97AGzyBA0Ut29SeanbpUSwqtHzIqfGJ1wHFQCwrSmOOG0/hr64
	 1IfxE5CLwKht2cP+gI6KyqwZ4xjSA0Mx4E7dLsA3LP5pk3KX25TULgFopV3s/ukW5u
	 KabHjycL3hyF/UFtHzldk64LubWRNFGj7GoutJ/5UALUefJc+nTjsr7J1+bPnfoGCg
	 7ItmzA7G+8f3A==
Date: Sat, 7 Nov 2026 18:41:46 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Message-ID: <au9i2uHBRVP27pbp@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-3-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107043122.25650-3-songmuchun@bytedance.com>

On Sat, Nov 07, 2026 at 12:31:19PM +0800, Muchun Song wrote:
> Whether the optimized mapping can be used is now decided in the
> architecture-specific vmemmap_populate() path. When PowerPC has to fall
> back, such as on Hash MMU, it can disable optimization for the populated
> vmemmap range there.
> 
> Add section_vmemmap_optimization_disable() to centralize this fallback,
> use it in the Hash MMU path, and drop the radix-specific
> vmemmap_can_optimize() override.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

I was about to complain why you do not go ahead and drop vmemmap_can_optimize
but then I saw patch#4 :-)

 

-- 
Oscar Salvador
SUSE Labs
