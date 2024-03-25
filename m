Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1311EAEB
	for <linux-s390@vger.kernel.org>; Mon, 25 Mar 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361384; cv=none; b=PR7IyslbSKm5goBCoupknEHgbAjPe3MtYRny6i6LxsA9cJ4dSXJdVmW1dKBmvf97CToxcdKymDSkiqadthhkPhmrOdFcDoFd8ic87TmFIOPHhOWN62tQwTIe6zrRusKZ3Fvukq6n8F6KBGnLBa1yTUMwsZL8a9uQ7SzcQE2r/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361384; c=relaxed/simple;
	bh=jPYKp7iZgYGf2meAt5xTuu0Q1OfUlW2CVg0/SseAhps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hmlt3ptsTYdHFkYMhWG2KT5fgVEqJTKpfeZMqMf+FJnd3xShXidM4ClX728ZQzonvHQ2UWup8I94N8hDWyxOc5pTLc5NyCIDsyiFKMEEtSJ9N52ntX3kRBKvuyxd1JR1V5mLGeHzrD3thK9eu0ZWft/p0LwDO4FT8CJG6LfKbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFw43iyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFw43iyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711361381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9S05SCRpMYvA+toy0tHe1naxURHrZ58qKUQ3/5tsGzc=;
	b=EFw43iyyralttXeMCB0ulEDk5VRagMjlgfcgpvsy1YH0iz7wzq5xUn59ZZFXlr7UOcY3iF
	czidScnnMvaCRyZdRkvFZdrgUMDkRImE+GFhrLMkLHAZsLA90gjFenHCLPaXFsWfZll8VJ
	+Zf5m6b+ANelqJWOqwUrXQf/tvT/ekE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-sEcjEcK4NAmQNj1b5hd2_Q-1; Mon, 25 Mar 2024 06:09:36 -0400
X-MC-Unique: sEcjEcK4NAmQNj1b5hd2_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBC25891E68;
	Mon, 25 Mar 2024 10:09:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98561492D17;
	Mon, 25 Mar 2024 10:09:34 +0000 (UTC)
Date: Mon, 25 Mar 2024 18:09:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <ZgFNVtp3EsJRaSN0@MiWiFi-R3L-srv>
References: <20240323141544.4150-1-urezki@gmail.com>
 <ZgC38GfEZYpYGUU9@infradead.org>
 <20240325093959.9453-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325093959.9453-B-hca@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 03/25/24 at 10:39am, Heiko Carstens wrote:
> On Sun, Mar 24, 2024 at 04:32:00PM -0700, Christoph Hellwig wrote:
> > On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
......snip
> > I guess this is ok as an urgend bandaid to get s390 booting again,
> > but calling find_vmap_area before the vmap area is initialized
> > seems an actual issue in the s390 mm init code.
> > 
> > Adding the s390 maintainers to see if they have and idea how this could
> > get fixed in a better way.
> 
> I'm going to push the patch below to the s390 git tree later. This is not a
> piece of art, but I wanted to avoid to externalize vmalloc's vmap_initialized,
> or come up with some s390 specific change_page_attr_alias_early() variant where
> sooner or later nobody remembers what "early" means.
> 
> So this seems to be "good enough".
> 
> From 0308cd304fa3b01904c6060e2115234101811e48 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Thu, 21 Mar 2024 09:41:20 +0100
> Subject: [PATCH] s390/mm,pageattr: avoid early calls into vmalloc code
> 
> The vmalloc code got changed and doesn't have the global statically
> initialized vmap_area_lock spinlock anymore. This leads to the following
> lockdep splat when find_vm_area() is called before the vmalloc code is
> initialized:
> 
> BUG: spinlock bad magic on CPU#0, swapper/0
>  lock: single+0x1868/0x1978, .magic: 00000000, .owner: swapper/0, .owner_cpu: 0
> 
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-11767-g23956900041d #1
> Hardware name: IBM 3931 A01 701 (KVM/Linux)
> Call Trace:
>  [<00000000010d840a>] dump_stack_lvl+0xba/0x148
>  [<00000000001fdf5c>] do_raw_spin_unlock+0x7c/0xd0
>  [<000000000111d848>] _raw_spin_unlock+0x38/0x68
>  [<0000000000485830>] find_vmap_area+0xb0/0x108
>  [<0000000000485ada>] find_vm_area+0x22/0x40
>  [<0000000000132bbc>] __set_memory+0xbc/0x140
>  [<0000000001a7f048>] vmem_map_init+0x40/0x158
>  [<0000000001a7edc8>] paging_init+0x28/0x80
>  [<0000000001a7a6e2>] setup_arch+0x4b2/0x6d8
>  [<0000000001a74438>] start_kernel+0x98/0x4b0
>  [<0000000000100036>] startup_continue+0x36/0x40
> INFO: lockdep is turned off.
> 
> Add a slab_is_available() check to change_page_attr_alias() in order to
> avoid early calls into vmalloc code. slab_is_available() is not exactly
> what is needed, but there is currently no other way to tell if the vmalloc
> code is initialized or not, and there is no reason to expose
> e.g. vmap_initialized from vmalloc to achieve the same.

If so, I would rather add a vmalloc_is_available() to achieve the same.
The added code and the code comment definitely will confuse people and
make people to dig why.

> 
> The fixes tag does not mean that the referenced commit is broken, but that
> there is a dependency to this commit if the vmalloc commit should be
> backported.
> 
> Fixes: d093602919ad ("mm: vmalloc: remove global vmap_area_root rb-tree")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/pageattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 01bc8fad64d6..b6c6453d66e2 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -344,6 +344,9 @@ static int change_page_attr_alias(unsigned long addr, unsigned long end,
>  	struct vm_struct *area;
>  	int rc = 0;
>  
> +	/* Avoid early calls into not initialized vmalloc code. */
> +	if (!slab_is_available())
> +		return 0;
>  	/*
>  	 * Changes to read-only permissions on kernel VA mappings are also
>  	 * applied to the kernel direct mapping. Execute permissions are
> -- 
> 2.40.1
> 

