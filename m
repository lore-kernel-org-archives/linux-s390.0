Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307227;
	b=1eLVuyTR07KGbH7g/6ui7szd0KRfiTM6+FZ1euRYUfjYcYEDqcQQ51vwaFOoHbnz0f1a
	 xvkBgFMb5vDbNfhI0J54A7ST8ELcyzafOBx+yQsA+98XA4Q95lHYNi6OVNd81aLtYYPHk
	 EN8P3d9KYtoa/maR/ZwqUn8Cuw5Po42/SjQVpKfeNieeSoU2GgmdQJJhjNHbeIgXkMxbP
	 QPSE70uwnRdMh8TlpPanCQBeU+QrW7m7fugv8o01aohXcrZOV3EjcUogxGmCu7SbkhXw/
	 ZSo/lgU+ja5HOy+TrOmtEhQyUwqatUzLmKu2SzHg5iWcwtumzp7CWLos+2fY7uPL5RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
	b=avHEgxGsP1TZ9AKFFQkihL0L7r+SrVvyO69rYIA5DItoQ/GuUQm+iEZ328ApU+uPvh4s
	 BVIJtt8Dj/l05RkX6SOIOuhD+CsTir8lstdwG94SEmI5krnIxwjB4sIAbfkEWv2PVJqMt
	 gSmZYOdMeGdjzdyfFZ9GA7v7OmD+EZvka54+W0m9kqfsiW4ACYVDmpR/iSW4d7K+9Ol9n
	 Wv6dfbs6nsAsZqkwXdKcHIBE1DE6uzpiKHOz3ZYvh+H+QPH8bfKUN6cJoYoOnmvAGHpnI
	 Zqj8UtDXKl7oRb/yamDF0TszRyywivQ++hviw4Y/e/JR8hOkRYPnKRUtNwgri3G5DJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X4ncqWDH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08827606A322
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08827606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X4ncqWDH
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso23917eec.0
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 13:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793307226; cv=none;
        d=google.com; s=arc-20260327;
        b=MIEHeyipXiqgqIZjJBdICiBx0pe5o2ji7vw3asPIv34AKrRLvDBaZI74t4h/VLvr2k
         GrT9MuPXqc4JN9VRkdM7f06DSKyHdsYfFmGyOD+MG9UaYKAvb4OUgkyEfbHBIkUwAfdF
         uUsPQNOCKYRoKkOTm8txTqlFovhxhiEwiuqtLbL+VFw1f0qMoSKAs+pVNGUs3R7omh/E
         7ss75xIoD34fNPYp8OekjDYlgYxWhHmfJXpOhJIPWzbm9LBBtJn/kOy4wpsZXc0xouM0
         gHnWBZLTv6krVYZgEAGx2XNsomcdUnPYKtEVn7qOctpC+ONB+npXwpXrHcgrgzoggvDi
         plfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        fh=EpTye0UbVldE1o4/w8G5Ui3uPYcDueM3QOFchPuDO30=;
        b=RgzZ1ucddG+XvSV68cp2QVtkFVrGH+pClXgOfAhcx4JV9uAW4Davk/8x4sK3U+uOwD
         l7FeA06ackh6YjclNl5OGNBiO05I+K9+mvKXiOGv3qsXJJN/bj2yUY8PJ9qZP8dc0rY4
         cDj413sM2d4L7ZF4W7x/n5cYkxsSDPEP8zhDRvREeuk7AUVXvwH8e1aaXGICImVUL5PZ
         Dae+HnV7HMtqjCg2YMKcBkxWixRZApSH/xEfRlQsu7W+25GFMNJjn5LqQt0v7UqF1AQb
         6iBNrEGh+6gy1E7+9NYC4/cG7lj51OKJJCiSby1KyKEd1VQs3/L0sdJe4At053xjJCWf
         IJwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793307226; x=1793912026; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        b=X4ncqWDHObARExJNzFicTAgGNShnnQyxHKRK/cw0fjeWbrVpO9dqNdFUtJLaHpfPe3
         3pQCYs5wPDyyeDRmHh6ZqxApAZowXImXkA1IiV80Wa+vN63OrMv6zHZ38w2Artqhj0kC
         TU5uAZwV8krucDNHMSBMsftqEv1zyLHEc4T7kkfonRf1QyhSc0K9tIEDxDosPnvHYJtU
         xrApcK1DGEJ0jC9G46yDslykO/UkCOdwNhIENzzsS6m5+HzjfiU4CekIHstdVmcDr6+w
         qoB3o1FiEmAOoeBr6eS4J+v8S4/RWAMAqqL+riJw8IsTfV7R0fo/ywFH88iTB5PhjqF0
         soEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307226; x=1793912026;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        b=HFoLUpub7B/CJIJlVutCEYSWWMpewP/E4cGFDwfXyKEbyQokoOA7/ACnGk1aAsvneL
         5bIsFBO9X6V01iCw3Rinon+TH0RIETuW1tk8p00oI0TyXyQJGBOnDj9t1TpK+IGZ5lcG
         lvPzg5+JHWoy+eK5DY11bqK5qSQfVth/kuCgT0k7dxJgwUggmbf/ENmZ7swrAjAkbImh
         5Zuz3ocTMtWH88pyE6q7GqGWc5XQqaCDXvF1jJelWwokFsdoOtfu0qyngG+fmrcH0AsO
         3ZHCsPNh89E8XJwKEVBCRyf/beUiICZtzS1ozZLpvcoKAKKdEIVvs/GGwfuwX3ZKhK92
         4L5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUIZgN1V3esI94jOs74/09JReen24DYxrz6TI3xg6co+WNa7hXfZ8inL81yWs0rsUOcs1r+yyhCczo@vger.kernel.org
X-Gm-Message-State: AFq9FYJhzbixmtrFoYqE/WA/phH2dkkmSnqByTJUSSlwEwOZWFTVjsnr
	7L0hmmSaeff/5Yc5BzpdyMuOtHhO+KiYKoNM0wYAzqHjrnu2yqkIxJEwdgNrOzYYdKhjQCheHtj
	kPRH6yV/aSsKVjS6OFTinCXTE1aTSwpRoiy8wAVxv
X-Gm-Gg: AYBFou1kkpmBPqYrF9V2i+sB2RI15F89uRvqEUmI0q3cr4ViXxKfMoOogpkHoewQuf6
	DJzltcNneD20WCnoqWjJ0Lq7QdmpMroluFdiV1lwHTNg+feBRQenTdor9dY8jS3bJ41+XlieGqb
	roX4Ge/zyZLJbWqExGN6/hiGParumcHFD1S8/2M+GSxrXaF8VdjPUuMRXOm/EzgcD/6irktsRU/
	Lhn9o06RDdw5UK7fX9uStDqlbQz/yH9duuF7prD3qaOXe0Fx62NUjO3FeqeX2FmEuHOwNL7EsPM
	55Sbi4qh2/uhLaN5UUmB+CT4Zd578qVc4htM6dA4orCkC/FuM6lJ1+7tn3CkIMUUFCUV4lgDFR4
	Rul/orLnaU4mp3PqtPRwf9rEEqTUeUwv4pyGonGj/8zeapRXfEBldCI2LDZ7gOISwOf8/FleDi+
	NOzpqp2hrf7oBoZRpzQI0AGPU=
X-Received: by 2002:a05:7022:2522:b0:1a9:c9fe:12c7 with SMTP id
 a92af1059eb24-1ac5bbb4b85mr358477c88.9.1793307224406; Thu, 29 Oct 2026
 13:53:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 13:53:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org> <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 13:53:42 -0700
X-Gm-Features: AclHuK_vfygndkmig7dtJT75402KjRWCrBeo-qQvow0jlIneeAJCjzWqgPCqOeQ
Message-ID: <CAEvNRgEY1uNs7F+ZPpcbx4Tgg=9r+f6nYpPsnm7em0+2YMq6cQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
To: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-s390@vger.kernel.org, luojiajun <luojiajun3@huawei.com>, 
	Josef Bacik <josef@toxicpanda.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

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

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
>  	inode_lock(inode);
>
>
> --
> 2.43.0
