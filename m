Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072157;
	b=BsrSPB+kf/6USRTaAAo+/OIIfEhwfqQLPS0VT8sQkMyOJ+AFVwdqqwMED5fHc+0ZLglb
	 Y8oszC3zwfLs1pYmFRq+jznEKymZTP8q293/bVJ4/8R7594+AbB4NfkZqUhv+069boIy3
	 k0E08n+0VEZ0kQ/0CKwtg0uxf6MWjcpvIpRaWc3fp/kLvzWulBGDQGbohLdFUvUQac4hW
	 g5R7kFNPPUphlNYY06kRnad5MKdkf2nHCqPTd3Ke9YJDUpMHCblTwFT/j3Q6QymvR7/Iu
	 156eR139YHa2z1AzHKKqykRedLkcToTA865GjcArXfvh9+fI7YCWfPah8NE9JfhXQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072157;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XmI8rWYPQf/Yk3+VD2zo2YslLq5vKVW6l7UCq9+Iu4s=;
	b=mcIfkIWK8vLOx0ie0KVbPcbB6ONY/c3I6pA/is2Ovd/J4xecvaZcKYzP6bhrXB6ijgMD
	 6SmHzZsDGxBHSu14suJlYg2JODuywV3VUmD44osAayHHfp8Z0c37YVpUdyafHbhV6ffKl
	 A5o+34YhHW9Zlck/YQlOFpaLQ/krWVsLNSfuQO7iIZpXHWQJE783HK9isFB4eBI5JXnuv
	 UZ/gz3Wz6nlJ3at+R3mhgNDbizctLd3DmPR8Z6Wrv+8ihsSxs7z0ofD6W9ace6Orewm39
	 D4POP0YFVrMPEQZdwSm1krx1YeYwGkKy/fVKdntkeUfe2ji6t1LFwxhO/+cgFNQUsnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KolnCTI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2B606A326;
	Sat,  7 Nov 2026 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KolnCTI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBA21F0089F;
	Sat,  7 Nov 2026 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794072156;
	bh=XmI8rWYPQf/Yk3+VD2zo2YslLq5vKVW6l7UCq9+Iu4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KolnCTI7SaK31zca7v7wy2Mycrmz3EJfGWSoHQT+xw4wMvA5veAkZQyAzR0RHLf53
	 7z0w2Y1hoaKGxi6XRZfkLKShmaUF9YXKLnTCvVHVorxctr/2riWCRhVYDHO6JUDsb+
	 /txQnwAPITgzg67QQgZLuuhvC4TDhau41rQl1Dtom+Utzu4v7VHiNwoZu0/cn0y8/P
	 PLwkFVCeoUea5WmCr0NKAudWsjpf99WGVzC3JmNDIMMiNqWVwtxCRaxhwoowmDT/Lj
	 FsIWGLvtajb3oBbBnZA/TWCD+SHD/vs+w/hy5dKGnepbpDYnrmj8WXDbUyZV3nfOeW
	 odC6ug+HnuAgA==
Date: Sat, 7 Nov 2026 18:22:28 +0100
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
Subject: Re: [PATCH v3 1/5] powerpc/mm: make
 vmemmap_populate_compound_pages() static
Message-ID: <au9eVOrRrnRNLUZb@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-2-songmuchun@bytedance.com>
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
In-Reply-To: <20261107043122.25650-2-songmuchun@bytedance.com>

On Sat, Nov 07, 2026 at 12:31:18PM +0800, Muchun Song wrote:
> vmemmap_populate_compound_pages() is no longer used outside
> radix_pgtable.c.
> 
> Make it static and drop the unused dev_pagemap argument from
> its only remaining caller to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
