Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE132ED39
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291097; cv=none; b=OgB971IhcKpRz7giVvMcgLlRFypb76VyNr2vTSu7TEoO7nYKRdp067ZJo1jl6gn9pqvSZQ0oANGmk1x4D7spyptigIVL60bC9OYm85UKct+qjqTTRmbjPk5zzGHlXehSPGxOIXVJI7JJQsoDK7LbDYv7e4xmB9Opwhfwlz22b7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291097; c=relaxed/simple;
	bh=u8WjjRIrjIi+YYl0V7pzG2yc3criivYx2JxFgRlvXg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UplSDIFKXWv45g9KKtSHdExvk4WP0XU85nD0OX+xGjDwxPDNWgIotryxOx41cea9OmqFjLiBKpt2wS8JhZU3QnFjPu1bXbCtamIBlxYebdhtmkYvdijgr0tj/ZiYwLUGOZ3hob29xl7D9HbFpIlAnwcf2wdQdK6fmsw8Bebob80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UrD4QznM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UrD4QznM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779291083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxePXEMQDWwNnRA4fuUAEJ8toZ4JkLQ6obW+0ibr2gg=;
	b=UrD4QznMUDmQ0luAlbLeSSiws6nZUUkmtwBztn8k6zeWl1F6tpAnuJzA7kqzv5F400/CJu
	tsnsT0njTgvs2egS7NWnQZ3sFoLN2sNldH6aweT3nAwMm/SUsrALg/hSZ40qnAurfGkQIy
	7NDdgJx0NZYt+FVg9eFvyCYbotjwbEw=
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
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Date: Wed, 20 May 2026 23:30:55 +0800
Message-Id: <20260520153055.61173-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:33PM +0200, David Hildenbrand (Arm) wrote:
>We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
>remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
>
>But it really was never used it besides for safety-checks ever since it was
>introduced in commit 04753278769f ("memory hotplug: register section/node
>id to free"), where we had the comment:
>
>	5) The node information like pgdat has similar issues. But, this
>	   will be able to be solved too by this.
>	   (Not implemented yet, but, remembering node id in the pages.)
>
>Of course, that never happened, and we are not planning on freeing the
>node data (pgdat/pglist_data), during memory hotunplug.
>
>So let's just stop marking the pgdat as NODE_INFO.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index 74c1116626c8..cce1d560f094 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
> 
> void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> {
>-	unsigned long i, pfn, end_pfn, nr_pages;
>+	unsigned long pfn, end_pfn;
> 	int node = pgdat->node_id;
>-	struct page *page;
>-
>-	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
>-	page = virt_to_page(pgdat);
>-
>-	for (i = 0; i < nr_pages; i++, page++)
>-		get_page_bootmem(node, page, NODE_INFO);

Cool. IIUC, pgdat isn't freed during memory hotremove. Offline nodes
stick around and can get reinitialized on hotadd, so NODE_INFO doesn't
buy us anything here :D

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
