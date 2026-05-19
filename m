Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5E33A6EB
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159403; cv=none; b=uLHJylkdTi6NGbGVMiYwdD3ZTJWTtDn6VfC0ljESwETlLopxXrcg0En/tk0wXgeKHfmJ1uEYUns9Atsf/AUqCbbeWnqKsjjnbz8/qQSzj/I3h/edAbQkhnvk6q5gAMlDqdZH2DvHy8SDtvuggnYBChl/ZOyF/0zFk9jr1IQ90M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159403; c=relaxed/simple;
	bh=pAQJOymE4QtaAjpB3yTuOSqpExdQTfaMieljZhZ90QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8rZ67pEYOIDeEKILG76Ww/kewnTA2aPuPS+huFDI0skFFF21NtgQEZii2idRG+bgI5mQj88JRf0CZWVhSpUOKbeVn9rDICVixBN7o02Zcw/Fj4i0lEy/VuE7X4J53aCYrkRilomZle6FwXMNotkdbLIugeUawKKExI8WqE873k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nchkEYj8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nchkEYj8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779159399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZEPDE0JhFiHBzsJZnEnOmNR0XlNNMR93C5REwadzXo=;
	b=nchkEYj83AaVfsUXxCl0AvZUaid1ISLjmEkYTd42iifdpzigk+RxNSzNQL1fmc2Ovg+CLs
	YCNmlMQHYag98UVdCm749EKUrnTkj4xmfprGZEpQ0YK2u4pxGj2UrZMgCdcEuVc9k/mZak
	7n1ZXHcwCLSVdvfIS5AVfaO+KMbAozc=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 3/8] mm/bootmem_info: stop using PG_private
Date: Tue, 19 May 2026 10:56:31 +0800
Message-Id: <20260519025631.71942-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:31PM +0200, David Hildenbrand (Arm) wrote:
>Nobody checks PG_private for these pages, and we can happily use
>set_page_private() without setting PG_private. So let's just stop
>setting/clearing PG_private.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index a0a1ecdec8d0..6e2aaab3dca9 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
> {
> 	BUG_ON(type > 0xf);
> 	BUG_ON(info > (ULONG_MAX >> 4));
>-	SetPagePrivate(page);

Right, the users classify these pages via PageReserved()/bootmem_type(),
not PagePrivate().

So makes sense to not set PG_private in the first place.

> 	set_page_private(page, info << 4 | type);
> 	page_ref_inc(page);
> }
>@@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
> 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
> 
> 	if (page_ref_dec_return(page) == 1) {
>-		ClearPagePrivate(page);

Nothing sets it anymore, so there is nothing to clear here.

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		set_page_private(page, 0);
> 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 		free_reserved_page(page);
>
>-- 
>2.43.0
>
>
