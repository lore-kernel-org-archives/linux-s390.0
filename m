Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216050;
	b=ACN6wMgTRUqaZgMD0DIju9LZgVScOQq8cYOguTMF6js1i7jm3whP7X6RQZBYb59yH0y+
	 kunbSnfu/WnG6qmt2HTSy+55IulQZnmCn52R2xClAE3898HJtnRnN6pVNJh+PrpT9ji/n
	 g0uFKmIaeVPAjOICineDgfaPazzbj24s9N6iHwnsFn7yGiHEdvfcG4GMZeb1iyiLk2iA5
	 z+WXEFhMnYorce2Hzy8ldltpHtxgmVpngHj2wb0VnE77ccKFavwkPMuGLA5fQGwdaDCaL
	 Pb/YpqUP2ibI3jm3gCmrtRwARoid/wREStyNL2JDK/Fw9mt3aCWugchp53al26DoW/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8h0PI3x5L84bxHJWgvhwyPcSqbxezc6i6wUfYwT0/gw=;
	b=i7zICc73IzVshNmjwpyvSfCysv4BnfgdypM+QuMRpDNUJwV+ZxnTWl4m3ucs6cMscRDu
	 5zMCt19nkbMlnoSb+4nkYWV+hmV5DBt3PcznKga8OKK/DvTnexHRY8N/8IJykpFXi42Oo
	 MkUcOzEH96LKs65C6sKKgVvGBzHtDHXmHb0XAo4KujwlIDywMqKeZEOsedMy9nM6Tic/n
	 5nZ/kjCQ09HHzQrpeRrhIUvaClGoh5AyHxdgyXcydpF2/716c9i6BNjXQ10GWtoi29x5b
	 do9dbHWAtCtE1tCs+u36KGRHnun+oIrG2T1A3Y3vDigC4vvV6Oo8JullHJg6d8KvGiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWMKq2ci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4E606A337;
	Mon,  9 Nov 2026 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWMKq2ci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8531F008A2;
	Mon,  9 Nov 2026 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216049;
	bh=8h0PI3x5L84bxHJWgvhwyPcSqbxezc6i6wUfYwT0/gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWMKq2cik7On9nLBWZZo+q2yFr8sWXi/dqsHfAOWf5G8lTU47xEhSOhDJMI8XikaX
	 5m07d7IVQvL4OmfmjXbpZC1xKhl0bnPIHFCc1+GnK9lePH1J9OXffOSC3rolXJf+DP
	 k4ocKY24KRkrPS6q7WNJrkW/H6guwGWdd1Qlf00BWCHthyiEskC+lVYU1caVCSxDJ4
	 8mr+TmUNdQsWrTcx+JFHlqbf5vM/T8amfu0IckZaVZKSK+i+YeSGHR/TccZjqYXArb
	 yGxJbGTMk29VHdRtuVjfBsvlx9exyhCVwGps8u3eDDtXsofy9sTxR1LmMTyHZmh202
	 /IyFsFh/XTSVw==
Date: Mon, 9 Nov 2026 10:20:41 +0100
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
Subject: Re: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Message-ID: <avGQadeXQU0ayFYv@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-5-songmuchun@bytedance.com>
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
In-Reply-To: <20261107043122.25650-5-songmuchun@bytedance.com>

On Sat, Nov 07, 2026 at 12:31:21PM +0800, Muchun Song wrote:
> section_vmemmap_optimizable() can already decide whether a section uses
> vmemmap optimization based on the section compound order. The DAX-specific
> vmemmap_can_optimize() helper duplicates that policy, so remove it to
> simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
