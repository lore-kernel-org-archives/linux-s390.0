Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304999;
	b=swmPTBcYuYoclbCmfQ3btenVHFYuF7Kz+ELjwFXEwfzCFTygTinEkGJsuFVRg9+Hn3w0
	 JeKacL4M7TgLnt5ckiBAx9iSqLInYwa9Rv/5jzA9QtGNfDX4G1VG1sdkB5AOkHe8dkGUN
	 oRQ15NKk1edEdgZXxGXWniZzklJYl3BDVJ7a85nwCBuwO2hu/G3yjJFt7BnAA3THuBO5D
	 ZuWgb/IhLAkx3bHaVgxuv/0dyuMfjLkxyYWbEyTtbPuwD2vm7HEI8dIeHfK2D4qsuAIOy
	 fo/7U5IAh0JpAwq4tgpnvm5Mxm3vOW0iQNik4E8LqPCLlzKHXn5uTc1f1/BAAS5LbXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KH5tlWQ/a/2Qjgu8uulzrQfDKvIAF8TNZYluLjZyVHQ=;
	b=WgtOFKv4rTemxGPOBYl/FgXFdWFl8gi1y/ZyVKOcEUdVBnUJlAQeEvk1qrWFJvRM4eX7
	 kyIWq3dRlnGhpzjPJHskyHei0JF02tKvc3JMtsrdOKxGxyOJo26+VrO31VhTMeNdQfC1D
	 Dm7MHCsqSY4A9ckZrjdpZsk45QYwPIuujhbuV4JKttdiPT29LtiXnl4bmazP02CCBB310
	 pC3CWzqrL/hK/mj5Bg21mllssXb1Du2a9ZyC03QGvND/eN5JbOCZ6f3r/acVRhq50UlCq
	 V/e7jqk0bqRhDwQ7fR/lnV1amqzQbSQlk3GJnMV0gz+j3hDAnfF90hf+dUrPPggo3iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+9sPb3f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699B606A31D
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+9sPb3f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EA31F01824;
	Thu, 29 Oct 2026 20:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304999;
	bh=KH5tlWQ/a/2Qjgu8uulzrQfDKvIAF8TNZYluLjZyVHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+9sPb3f7yAtRAyhhCNGswCMWiCYDVQL4n8UUKxe1WRm/wsE5VtYsSBFghyAadl8m
	 d+5FxKOS+U6sSVWx7EMPqSqLor99ZnqzQU6HU0s7e0nk2xFBgdv16Li+jUVZKyZitf
	 Tx3+QgDMuHHJ5q3rGwjVVfV24ACUwm2+XfTUu9xG2X2ZCmdq2Xyak42LYjat2y192n
	 tUuaCAlodVI2XdQbDMW+ekmLf8IguGSsh6il0wWHhyYwH0hPqqGfxQzZrGvQRKRL5T
	 5CoWb/6xfta/g48few6SxzPuPWD43jJfxh2berx/ezg/MAR9z5eeuwZh2y678lcqWz
	 6DELTiWg7tatA==
Message-ID: <sashiko-outbox-189914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] RFC: mm/hugetlb: account restored reservations
 before freeing folios
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Mel
 Gorman" <mgorman@suse.de>, "Andy Whitcroft" <apw@canonical.com>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Michal Hocko" <mhocko@suse.com>, "Rik van
 Riel" <riel@surriel.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>, "Dave Airlie" <airlied@redhat.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Peter Xu" <peterx@redhat.com>, "Breno
 Leitao" <leitao@debian.org>, "Will Deacon" <will@kernel.org>, "Aneesh Kumar
 K.V" <aneesh.kumar@kernel.org>, "Nick Piggin" <npiggin@gmail.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Arnd
 Bergmann" <arnd@arndb.de>
Cc: linux-mm@kvack.org, "Gerd Hoffmann" <kraxel@redhat.com>, linux-s390@vger.kernel.org, "Josef
 Bacik" <josef@toxicpanda.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/hugetlb: gather_surplus_pages() over-allocates and retains surp=
lus folios
--

commit d5256483029a06972dd519de19de57831de33af4
Author: David Hildenbrand (Arm) <david@kernel.org>

RFC: mm/hugetlb: account restored reservations before freeing folios

This commit updates anonymous hugetlb folio unmapping to increment
resv_huge_pages immediately when restoring the VMA reservation rather than
waiting for the folio to be freed. Because resv_huge_pages can now
temporarily exceed free_huge_pages while unmapped folios still have
elevated reference counts, available_huge_pages() is updated to clamp at
zero.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 69a5d2c73ee1d..06ef8ba41df7c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[ ... ]
> @@ -5313,6 +5309,45 @@ int move_hugetlb_page_tables(struct vm_area_struct=
 *vma,
>  	return len + old_addr - old_end;
>  }
> =20
> +/* Must be called after rmap removal. */
> +static void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vm=
a,
> +		struct folio *folio)
> +{
> +	struct hstate *h =3D hstate_vma(vma);
> +	unsigned long address;
> +	long rc;
> +
> +	/*
> +	 * Restore only on the last unmap, otherwise the owner could reuse
> +	 * the reservation while the folio is still mapped by a child.
> +	 *
> +	 * TODO: Handle migration temporarily dropping the mapcount to zero.
> +	 * TODO: Prevent reservation reuse before the folio is freed.
> +	 */
> +	if (!folio_test_anon(folio) || !__vma_private_lock(vma) ||
> +	    folio_mapped(folio))
> +		return;
> +
> +	address =3D vma_anon_address(vma, folio->index, 1);
> +	rc =3D vma_needs_reservation(h, vma, address);
> +	if (!rc)
> +		vma_end_reservation(h, vma, address);
> +	if (rc <=3D 0)
> +		return;
> +
> +	rc =3D vma_add_reservation(h, vma, address);
> +	if (rc < 0)
> +		return;
> +
> +	/* The restored reservation owns the subpool charge. */
> +	hugetlb_set_folio_subpool(folio, NULL);
> +
> +	/* Account before the VMA can close or fault again. */
> +	spin_lock_irq(&hugetlb_lock);
> +	h->resv_huge_pages++;
> +	spin_unlock_irq(&hugetlb_lock);
> +}

[Severity: High]
With h->resv_huge_pages now able to exceed h->free_huge_pages while an
unmapped folio is still referenced (for example, via vmsplice() or GUP),
can a concurrent hugetlb_acct_memory() -> gather_surplus_pages() over-alloc=
ate
surplus folios and retain them in the pool?

In surplus_pages_needed():

	static long surplus_pages_needed(struct hstate *h, long delta, long alloca=
ted)
	{
		long global_free =3D (long)h->free_huge_pages + allocated;
		long allowed_free =3D (long)allowed_mems_nr(h) + allocated;

		return max((long)h->resv_huge_pages + delta - global_free,
			   delta - allowed_free);
	}

When h->resv_huge_pages > h->free_huge_pages, (long)h->resv_huge_pages +
delta - global_free includes the deficit from the in-flight unmapped
folios on top of delta.

If gather_surplus_pages() succeeds, needed +=3D allocated equals delta +
(h->resv_huge_pages - h->free_huge_pages), so it allocates and enqueues
extra surplus folios beyond delta (or fails with -ENOMEM if
nr_overcommit_huge_pages only had room for delta).

Furthermore, when gather_surplus_pages() cleans up unused or aborted
folios at the free label:

	free:
		spin_unlock_irq(&hugetlb_lock);

		/*
		 * Free unnecessary surplus pages to the buddy allocator.
		 * Pages have no ref count, call free_huge_folio directly.
		 */
		list_for_each_entry_safe(folio, tmp, &surplus_list, lru)
			free_huge_folio(folio);

free_huge_folio() checks:

	} else if (h->surplus_huge_pages_node[nid] &&
		   h->free_huge_pages >=3D h->resv_huge_pages) {
		/* Free this surplus folio that is not required globally. */
		remove_hugetlb_folio(h, folio, true);
		spin_unlock_irqrestore(&hugetlb_lock, flags);
		update_and_free_hugetlb_folio(h, folio, true);
	} else {
		arch_clear_hugetlb_flags(folio);
		enqueue_hugetlb_folio(h, folio);
		spin_unlock_irqrestore(&hugetlb_lock, flags);
	}

While h->free_huge_pages < h->resv_huge_pages, free_huge_folio() will
enqueue the aborted surplus folios into the hugetlb pool instead of
returning them to the buddy allocator. If the in-flight unmapped folio is
a persistent folio on node A (where surplus_huge_pages_node[nid_A] =3D=3D 0)
and the surplus folio was allocated on node B, dropping the last reference
to the persistent folio on node A will not free the surplus folio on
node B either, leaving the surplus folio stranded in the pool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D14
