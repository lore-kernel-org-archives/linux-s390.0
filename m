Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264738;
	b=ZkV9T4ZucfW9GaNH0IHdg2z3Wu+zesMwmkGjgPXIiFnyP8KS7DQp7d09zdYtqzlH/Urc
	 I9qA/pfduRtYBFP86zhiyxUMD6fMyXuiq09gfGud1RXZo0+kgKJY0gi4rH5nDi6CLeobg
	 hmqPLXMiifa15K57yXSVrRyDQqMO5CMyIdE8Gnp911+n9RhXRJef0/uAt/mywhLing80J
	 dcLFffM9BCXqKV6WmX0D+sRoSGenqgsaZZw0Zt+/ksPjur0KbbOiiQFg2R2nuH9Uj+n2P
	 rJU8POp3APdN8DTpy9eqcrinsgSYaYmok6TrD40IJwKTUTMfSHER24RoNAAAVgXwxvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264738;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DUwEU5VFVcm3BSvlIi+qnX1DNEYOOSjt0f4UAgjp/q0=;
	b=QzhJGxfuzYtwALHp2k4yc9YFoXwj8p86kIhkbZDQMNnZtw7UxRvpMk2a7cqWOQgqKIyM
	 4Buv78mwmkTaWRUjXfvmFGMrrXoP413/+uVkUPpr0dWK3ckvd5gxUtia47daAhdKpHRd5
	 I5UqNLJakMt5I/iRaiBpNQgAV49y4q0wZ7MVHd/ihpLqDxv11g2RHMeyfUAdXO3ZiWPIf
	 wKwXRXkZXyUQaha3NjZKPxBYfXAAjm9hE4uMhUhldVpkit2cPs69g0SUDSeWET0pLAVoI
	 1UE0sMVvQOflwcK3C6NjcIKW4NJEpEXjbB7OgfukFK2YOx8esi4G4sCJQgPlPX2FVaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE3pYWlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDE606A31A;
	Thu, 29 Oct 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE3pYWlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A921F01825;
	Thu, 29 Oct 2026 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264738;
	bh=DUwEU5VFVcm3BSvlIi+qnX1DNEYOOSjt0f4UAgjp/q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UE3pYWlMUN95Niu9Wtfdm3GxQH1knhbb/MKIkHh7IJ2bNicQLmFbrF5q1JQYXasKZ
	 z4wj8JOiEhU74QBIK5Z3ndUsaoUU7BgPFSWCBeuERZPO3ckPct4MAT1NQXxFWPotl5
	 3i4GCG3NFPUMorcuASu/L6ZAEoZhkGOXw/tsOQO/6H/H44u5pat8YWBJUuOu3ki+V2
	 KAKWF+F84fZVsfsKHbUWbgWYZEJmQi3SAEIGzUMfPCObb6n0XuCf1xftEBPCFS6xsP
	 Vc8DWMIvSEyRad1nF+CqBRxXHhLFv2v0K/4MEQgAEFYgnycFzyJiqU3PCodskvl2oV
	 Tq71mQ2U6LTyg==
Date: Thu, 29 Oct 2026 10:05:25 +0100
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
	luojiajun <luojiajun3@huawei.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@kernel.org
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
Message-ID: <auMMVcK_80irHLkP@localhost.localdomain>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
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
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>

On Wed, Oct 28, 2026 at 09:13:29PM +0100, David Hildenbrand (Arm) wrote:
> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
> 
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
> 
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in clear_inode().
> 
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.
> 
> Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
> hugetlb special casing in filemap.c"), remove_inode_hugepages() must
> include the final huge page during truncate and eviction.
> 
> Reported-by: luojiajun <luojiajun3@huawei.com>
> Closes: https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalavador@suse.de>

> ---
>  fs/hugetlbfs/inode.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44ebe..5592cfc6cc8b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -721,11 +721,13 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  	/*
>  	 * Default preallocate case.
> -	 * For this range, start is rounded down and end is rounded up
> -	 * as well as being converted to page offsets.
> +	 * vfs_fallocate() guarantees that offset + len is positive and does
> +	 * not overflow. Avoid overflows when calculating the end huge page
> +	 * index: set it to one past the index of the huge page containing the
> +	 * last byte.
>  	 */
>  	start = offset >> hpage_shift;
> -	end = (offset + len + hpage_size - 1) >> hpage_shift;
> +	end = ((offset + len - 1) >> hpage_shift) + 1;
>  
>  	inode_lock(inode);
>  
> 
> -- 
> 2.43.0
> 

-- 
Oscar Salvador
SUSE Labs
