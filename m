Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216268;
	b=gzH6zAl+qJ0ma9yrNJqtzXfGyjGlaRDhQyczxhPy3Ys0Uf0wEOUgouJTw6zF8xgGPp5k
	 S9VxLgBF5xGuDC9dKGSqFfgNRuldXISvnaO6Mxle+bzVF/iy/JJQcsNO25YvA4bnkdmXo
	 nbVLY/V7Bp7xeVyZIPoluqHqaQZA2XfqFMbrlHQuKjpGBL3DHAoVjZhoTCFcrJKa5FAoN
	 Gf8iUV1gcwx4eO1sMT5Pcqk8pOIDOchhgmTdIVpyqG2LrTKIbnTt9CO3zLH5Tk1NBk9oR
	 Pe6gXFRbdiecI4Aa8kZop0z+BwPNkNpJVX10cU5eRpoi/zpNiSwLlkLdF+Z+04xs1zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216268;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cNFD8zbRoLqcBaLpUrUz65qzQQyXXiRBbh/ZFm+g/0E=;
	b=RTmtyThdHsgfZKGCE+8bFRABWPhL1U7VJADZAd5LUt5s5TgmQzYeolDr6t/Mi9yerSSJ
	 mM7/CijWleHdfG9e7s/ngMOSlfwsJ2sa/srV1QhTMke6KdBgY7+Dj9jHaO6ExlJedKpE9
	 Gn9FRy/u8Fc9YVKZWWUqoZcQO/YuZswr/52GHNnxQNXhcnB0Mjp+/sBaUUb+FKOFB19Av
	 Ebfmk/EclNqN3AtxrUY7diOVZdcw3ESl0J1j9sPkAxXq13lZYaMhaJ6yK7y98ODW1Amj9
	 UfZ+gBSBH3NB7pphGKrkl0Y2yo02w9lhN0k+JnB+zhQzZa0uja5M0A6KhiEW3CpRkDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV6f4qcJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF6606A31C;
	Mon,  9 Nov 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV6f4qcJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E841F00921;
	Mon,  9 Nov 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216267;
	bh=cNFD8zbRoLqcBaLpUrUz65qzQQyXXiRBbh/ZFm+g/0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RV6f4qcJIjlbsx8FxA1gxmtGOYGrqDAqHaEFkjDmVEvh9lKtryFCfIVBh2Syv+Nm5
	 3pWfPBY0jOJrkRMONpLfK9G4EHDraDOfXd+MhXzuTpE2P9tsEthfMKFGmOQLCDYlzs
	 SrJGyjebs3ZRk2dtFEh1jcZAgMmA+UzzkSel7YKXk43VbE4n0QFjoaKPOUMpS0lDnO
	 15H2VQcUneTXTIQ+aMXnT45PaTd+sHwAGhegff5F4dk8O3hpM+u4GKIrR7OGwG4/2J
	 uogUUW4aLsfTJs2ixdi0HB3c3kaLECdnu2Awi3Rgj9GQOwpEjUI4amOtG6CTKVQEMx
	 rIaJ9//B6Yzjg==
Date: Mon, 9 Nov 2026 10:24:19 +0100
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
Subject: Re: [PATCH v3 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap
 population APIs
Message-ID: <avGRQxsRFT6Ax_zy@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-6-songmuchun@bytedance.com>
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
In-Reply-To: <20261107043122.25650-6-songmuchun@bytedance.com>

On Sat, Nov 07, 2026 at 12:31:22PM +0800, Muchun Song wrote:
> The vmemmap population and memory hotplug paths no longer need @pgmap
> to decide whether a mapping can be optimized. That state is now carried
> in mem_section, and the architecture-specific population code can make
> the remaining decisions internally.
> 
> Drop the @pgmap parameter from the vmemmap population helpers and the
> related memory hotplug interfaces, and remove the remaining
> dev_pagemap-specific coupling from those call chains.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
