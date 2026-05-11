Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6DF3F1669;
	Mon, 11 May 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507319; cv=none; b=hNMaCmRfjJHObbJSrRIMvGOrJ0wwxfZJTdvuUeYFcB/6IDUFigjZD65uFRlfvWaQWC0eCc+Ujk2qEGT/1VDXlMVoqAC1p9KvuJRnLlDWq/LwvipB3XbZySgCpebNc2LoDwb/zLRf2im0aBYa09RtWVbC5Xgcv0ZkYOUFNElTr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507319; c=relaxed/simple;
	bh=d0gEBlfWzbz9BHGffbxwOOgJHYpaIU0b8X94oAVz7gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut8TNfhdC7DOEKBsFigx26n8sGuAkbShMoFccfdAVEsKW7KuyIO2yWgx9A2LbXpiZ4uJZF1a8YNKCLeOmgE9t1MgcE3pyk2Ej6XZ6HWi+iCr8CP/UfhzEsMwgP5uBdSL1b+ED+3TSlUTsFa/8WKCvS/uONaPJDDzNgiO56Pfnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0Sv6I9Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0Sv6I9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C818DC2BCC9;
	Mon, 11 May 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507319;
	bh=d0gEBlfWzbz9BHGffbxwOOgJHYpaIU0b8X94oAVz7gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0Sv6I9YxBRsyk69pIVXMWaGe8Ywrol1qyjGbVvkAtOIuZVLbqg/jpcnTAJJs52/l
	 uCSlK4dwpfZtkz3F+RuZutqF7QRzo0gaSTFXqKMIX/nAZr+Ar9qqXiIYN5hFWioVKV
	 jMYxPNLezmkpqRJi/i0wFvksoebqME3P9XxuHuFXS/bXGrgXAdZBZWagp8uWcE2poz
	 sFi7Nd3dhWXRvOZ9a/Ke3NNY828SE1Q5yBfSExmqq/bOxSI3VXkvXiy7Y/4bW43hn2
	 KAg8DmV6i7VhIjz44u51xfT1GzFpqjtkSM7P99gOJ1TBVYAiwpOw/7MPKSf8mXlWLK
	 wsQtu8kwN6dkQ==
Date: Mon, 11 May 2026 14:48:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	muchun.song@linux.dev
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
Message-ID: <agHX3zQ261XZBfLb@lucifer>
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511111800.2181785-1-songmuchun@bytedance.com>

On Mon, May 11, 2026 at 07:18:00PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), and collapse the
> redundant section-number wrapper into a single block-id based lookup
> interface.
>
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.

As David said, let's reference more of what you've done in the various
refactorings.

>
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM overall, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>  drivers/base/memory.c                         | 38 +++++++------------
>  drivers/base/node.c                           |  4 +-
>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>  include/linux/memory.h                        |  7 +++-
>  mm/memory_hotplug.c                           |  5 +--
>  6 files changed, 35 insertions(+), 50 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 75f85a5da981..94f3b57054b6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>
>  static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>  {
> -	unsigned long section_nr;
> -	struct memory_block *mem_block;
> -
> -	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> -
> -	mem_block = find_memory_block(section_nr);
> -	return mem_block;
> +	return memory_block_get(phys_to_block_id(lmb->base_addr));

Ah nice I see this does the equivalent via phys_to_block_id() and
pfn_to_block_id() so that's a nice cleanup.

>  }
>
>  static int get_lmb_range(u32 drc_index, int n_lmbs,
> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
>  	else
>  		rc = 0;
>
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>
>  	return rc;
>  }
> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>
>  	rc = dlpar_offline_lmb(lmb);
>  	if (rc) {
> -		put_device(&mem_block->dev);
> +		memory_block_put(mem_block);
>  		return rc;
>  	}
>
>  	__remove_memory(lmb->base_addr, memory_block_size);
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>
>  	/* Update memory regions for memory remove */
>  	memblock_remove(lmb->base_addr, memory_block_size);
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 11d57cfa8d72..5b5d41089e81 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>   *
>   * Called under device_hotplug_lock.
>   */
> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
> +struct memory_block *memory_block_get(unsigned long block_id)
>  {
>  	struct memory_block *mem;
>
> @@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  	return mem;
>  }
>
> -/*
> - * Called under device_hotplug_lock.
> - */
> -struct memory_block *find_memory_block(unsigned long section_nr)
> -{
> -	unsigned long block_id = memory_block_id(section_nr);
> -
> -	return find_memory_block_by_id(block_id);
> -}
> -
>  static struct attribute *memory_memblk_attrs[] = {
>  	&dev_attr_phys_index.attr,
>  	&dev_attr_state.attr,
> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
>
>  	ret = device_register(&memory->dev);
>  	if (ret) {
> -		put_device(&memory->dev);
> +		memory_block_put(memory);
>  		return ret;
>  	}
>  	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
>  	struct memory_block *mem;
>  	int ret = 0;
>
> -	mem = find_memory_block_by_id(block_id);
> +	mem = memory_block_get(block_id);
>  	if (mem) {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		return -EEXIST;
>  	}
>  	mem = kzalloc_obj(*mem);
> @@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
>  		memory->group = NULL;
>  	}
>
> -	/* drop the ref. we got via find_memory_block() */
> -	put_device(&memory->dev);
> +	/* drop the ref. we got via memory_block_get() */
> +	memory_block_put(memory);
>  	device_unregister(&memory->dev);
>  }
>
> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  		end_block_id = block_id;
>  		for (block_id = start_block_id; block_id != end_block_id;
>  		     block_id++) {
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (WARN_ON_ONCE(!mem))
>  				continue;
>  			remove_memory_block(mem);
> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		return;
>
>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>  		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
>  		return 0;
>
>  	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (!mem)
>  			continue;
>
>  		ret = func(mem, arg);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		if (ret)
>  			break;
>  	}
> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  void memblk_nr_poison_inc(unsigned long pfn)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>
>  	if (mem) {
>  		atomic_long_inc(&mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>
>  void memblk_nr_poison_sub(unsigned long pfn, long i)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>
>  	if (mem) {
>  		atomic_long_sub(i, &mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 126f66aa2c3e..b3333ca92090 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
>  		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
>  			struct memory_block *mem;
>
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (!mem)
>  				continue;
>
>  			memory_block_add_nid_early(mem, nid);
>  			do_register_memory_block_under_node(nid, mem);
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  		}
>
>  	}
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 78c054e26d17..6df1926d4c62 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  	addr = sclp_mem->id * block_size;
>  	/*
>  	 * Hold device_hotplug_lock when adding/removing memory blocks.
> -	 * Additionally, also protect calls to find_memory_block() and
> +	 * Additionally, also protect calls to memory_block_get() and
>  	 * sclp_attach_storage().
>  	 */
>  	rc = lock_device_hotplug_sysfs();
> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  			sclp_mem_change_state(addr, block_size, 0);
>  			goto out_unlock;
>  		}
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> -		put_device(&mem->dev);
> +		mem = memory_block_get(phys_to_block_id(addr));
> +		memory_block_put(mem);
>  		WRITE_ONCE(sclp_mem->config, 1);
>  	} else {
>  		if (!sclp_mem->config)
>  			goto out_unlock;
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> +		mem = memory_block_get(phys_to_block_id(addr));
>  		if (mem->state != MEM_OFFLINE) {
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  			rc = -EBUSY;
>  			goto out_unlock;
>  		}
> -		/* drop the ref just got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		sclp_mem_change_state(addr, block_size, 0);
>  		__remove_memory(addr, block_size);
>  #ifdef CONFIG_KASAN
> @@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
>  		return rc;
>  	block_size = memory_block_size_bytes();
>  	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
> -	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
> +	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
>  	if (!mem) {
>  		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
>  	} else {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		rc = -EBUSY;
>  	}
>  	unlock_device_hotplug();
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 5bb5599c6b2b..29edef1f975c 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(enum memory_block_state state, void *v);
> -extern struct memory_block *find_memory_block(unsigned long section_nr);
> +extern struct memory_block *memory_block_get(unsigned long block_id);
> +static inline void memory_block_put(struct memory_block *mem)

Yeah as David says, we remove extern's now as and when we touch that code :)

> +{
> +	put_device(&mem->dev);
> +}
>  typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>  extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  			      void *arg, walk_memory_blocks_func_t func);
> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
>  typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>  int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  			       struct memory_group *excluded, void *arg);
> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
>  #define hotplug_memory_notifier(fn, pri) ({		\
>  	static __meminitdata struct notifier_block fn##_mem_nb =\
>  		{ .notifier_call = fn, .priority = pri };\
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 462d8dcd636d..890c6453e887 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>  		struct vmem_altmap *altmap = NULL;
>  		struct memory_block *mem;
>
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		mem = memory_block_get(phys_to_block_id(cur_start));
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>
>  		altmap = mem->altmap;
>  		mem->altmap = NULL;
> -		/* drop the ref. we got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>
>  		remove_memory_block_devices(cur_start, memblock_size);
>
>
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> --
> 2.54.0
>
