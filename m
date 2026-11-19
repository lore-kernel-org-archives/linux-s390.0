Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079996;
	b=dcaNz1SKYCIqDRfua7062YB9+7ddj5yiC1IzQ4AOvS1YMcZPjpqiBkXBrYzl/fSKzoDx
	 dwNPgi99RwhZHTLib+ueR/USIRo/tvo6CsASVR5V916ZEItrbPo8EkXSkzh0TAKsMGuK3
	 KDBcjd2P8/+p4gdHeJwKo8fwhiWKSdGcYnqY+d5685LDzZtvos9XxaUIQIdjekhaPDsLJ
	 miTGxIhOo0JENB2IRlpfsd2d18pWkfq7wgTQQDs9iUswRYyfHK5SLZaZRxZp+HYeBV+Ag
	 HoWwiHnToy8VnE7NwZ8ut2nYp0PVxtakspSnSMzABx+sHu37vXtjqBqCa/jkkq4q8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079996;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9F+PqeTKayL2InwlVERF9AhfXlGn4mSe033kr4lKz1o=;
	b=yKqNOueAzKIPasuQLWsEmWU1ZY1YYFpOoF+LcGSIjDlGaSf9mP3z7ZRg536lZhd3wgJH
	 /9Ap9gte2pCZnqQJIYDu5eg04YQdbbF9GQdTSOmDM0wupP5fiRuNAr4QJwky75HWXs4Rz
	 bVmefDD0SpG9/vbeKzVk+bzGIBTnp4Sblm0QBytAt7Sjj35lipQsatziHmJrSpLfbsQ6F
	 2ewUwVNrNrmcBnz2jzPJ+ZznJv+9HB2KcqiJMwmayuP6D+kUzEaUBd7ZQ2ygstbzbhlpx
	 eY3c2skbq7mu8Vq0BfU1hdTElfMD8zeUpXm8B12uWY49qz27inuKm9siAYiZo5SDSBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BwGgpGq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C36606A325;
	Thu, 19 Nov 2026 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwGgpGq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404C31F000CC;
	Thu, 19 Nov 2026 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079995;
	bh=9F+PqeTKayL2InwlVERF9AhfXlGn4mSe033kr4lKz1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BwGgpGq/s8LdaixY6UA2dpl6cyOlv1U26xLUHK3qsAmF6KXzFhdJnAytG8CXWrQBM
	 XVeINsUMo6TefJjonhgO+dU2JDcGut71ZynTXwmmsacy26fqvKspQwAEe3pW9YxRYb
	 SRVUpuAwBCNykQtoTyrgySODnUAnTtj+r6Z7KtbXyKiUSyXpa3s+UnhtCFOL6mULIv
	 zw1B6CY2f91QpZTQOHg4aiwKYj5x1Ad1onk/4u3eM/C9w5Up2vCqXyTIjYc9NeP5b3
	 YxNFrYfFFPs6Iajczpo3yenRQC+cX3+gHptB5mKZSBkRA8zyHVly+82sPqdzFKldFy
	 gy+890bIbmpJA==
Date: Thu, 19 Nov 2026 10:19:43 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>, Andy Whitcroft <apw@canonical.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
	Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v2 11/15] hugetlbfs: do not grow a sealed file in mmap()
Message-ID: <av6_L080RpmFYham@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-11-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-11-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:32PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> hugetlbfs_file_mmap() grows a file when a writable mapping extends beyond
> EOF. We are missing seal checks similar to hugetlbfs_setattr() and
> hugetlbfs_fallocate(), allowing a user to grow a file that has F_SEAL_GROW
> set.
> 
> To fix it, skip the resize when F_SEAL_GROW is set; mmap() still succeeds
> without growing the file.
> 
> We currently also allow CoW mappings to grow a file. Disallowing this,
> maybe even only for read-only file descriptors, could break existing
> userspace, so we have to be more careful. QEMU's file backend is an
> example user that might rely on such things, and would suddenly start
> getting SIGBUS when faulting in memory outside EOF.
> 
> So be careful and focus on F_SEAL_GROW for now.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: ff62a3421044 ("hugetlb: implement memfd sealing")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: drop comment; simplify+extend description ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

> ---
>  fs/hugetlbfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7f64bdc07aa80..68761e1ed4d2e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -157,7 +157,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		goto out;
>  
>  	ret = 0;
> -	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len)
> +	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len &&
> +	    !(HUGETLBFS_I(inode)->seals & F_SEAL_GROW))
>  		i_size_write(inode, len);
>  out:
>  	inode_unlock(inode);
> 
> -- 
> 2.56.1
> 

-- 
Oscar Salvador
SUSE Labs
