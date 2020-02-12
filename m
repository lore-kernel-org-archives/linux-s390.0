Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgBLLwa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 06:52:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CBmvJN017393
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 06:52:29 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1ufn9u65-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 06:52:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 12 Feb 2020 11:52:26 -0000
Subject: Re: [PATCH v2 RFC] KVM: s390/interrupt: do not pin adapter interrupt
 pages
References: <567B980B-BDA5-4EF3-A96E-1542D11F2BD4@redhat.com>
 <20200211092341.3965-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Feb 2020 12:52:20 +0100
MIME-Version: 1.0
In-Reply-To: <20200211092341.3965-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5748d7ba-570e-9a45-7069-c42c6f725e09@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

I pushed that variant to my next branch. this should trigger several regression runs
in regard to function and performance for normal KVM guests.
Lets see if this has any impact at all. If not this could be the simplest solution that
also simplifies a lot of code.

On 11.02.20 10:23, Christian Borntraeger wrote:
> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> 
> The adapter interrupt page containing the indicator bits is currently
> pinned. That means that a guest with many devices can pin a lot of
> memory pages in the host. This also complicates the reference tracking
> which is needed for memory management handling of protected virtual
> machines.
> We can simply try to get the userspace page set the bits and free the
> page. By storing the userspace address in the irq routing entry instead
> of the guest address we can actually avoid many lookups and list walks
> so that this variant is very likely not slower.
> 
> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> [borntraeger@de.ibm.com: patch simplification]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> quick and dirty, how this could look like
> 
> 
>  arch/s390/include/asm/kvm_host.h |   3 -
>  arch/s390/kvm/interrupt.c        | 146 +++++++++++--------------------
>  2 files changed, 49 insertions(+), 100 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 0d398738ded9..88a218872fa0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -771,9 +771,6 @@ struct s390_io_adapter {
>  	bool masked;
>  	bool swap;
>  	bool suppressible;
> -	struct rw_semaphore maps_lock;
> -	struct list_head maps;
> -	atomic_t nr_maps;
>  };
>  
>  #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d4d35ec79e12..e6fe8b61ee9b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2459,9 +2459,6 @@ static int register_io_adapter(struct kvm_device *dev,
>  	if (!adapter)
>  		return -ENOMEM;
>  
> -	INIT_LIST_HEAD(&adapter->maps);
> -	init_rwsem(&adapter->maps_lock);
> -	atomic_set(&adapter->nr_maps, 0);
>  	adapter->id = adapter_info.id;
>  	adapter->isc = adapter_info.isc;
>  	adapter->maskable = adapter_info.maskable;
> @@ -2488,83 +2485,26 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
>  
>  static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>  {
> -	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> -	struct s390_map_info *map;
> -	int ret;
> -
> -	if (!adapter || !addr)
> -		return -EINVAL;
> -
> -	map = kzalloc(sizeof(*map), GFP_KERNEL);
> -	if (!map) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -	INIT_LIST_HEAD(&map->list);
> -	map->guest_addr = addr;
> -	map->addr = gmap_translate(kvm->arch.gmap, addr);
> -	if (map->addr == -EFAULT) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> -	ret = get_user_pages_fast(map->addr, 1, FOLL_WRITE, &map->page);
> -	if (ret < 0)
> -		goto out;
> -	BUG_ON(ret != 1);
> -	down_write(&adapter->maps_lock);
> -	if (atomic_inc_return(&adapter->nr_maps) < MAX_S390_ADAPTER_MAPS) {
> -		list_add_tail(&map->list, &adapter->maps);
> -		ret = 0;
> -	} else {
> -		put_page(map->page);
> -		ret = -EINVAL;
> +	/*
> +	 * We resolve the gpa to hva when setting the IRQ routing. If userspace
> +	 * decides to mess with the memslots it better also updates the irq
> +	 * routing. Otherwise we will write to the wrong userspace address.
> +	 */
> +	return 0;
>  	}
> -	up_write(&adapter->maps_lock);
> -out:
> -	if (ret)
> -		kfree(map);
> -	return ret;
> -}
>  
>  static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>  {
> -	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> -	struct s390_map_info *map, *tmp;
> -	int found = 0;
> -
> -	if (!adapter || !addr)
> -		return -EINVAL;
> -
> -	down_write(&adapter->maps_lock);
> -	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> -		if (map->guest_addr == addr) {
> -			found = 1;
> -			atomic_dec(&adapter->nr_maps);
> -			list_del(&map->list);
> -			put_page(map->page);
> -			kfree(map);
> -			break;
> -		}
> -	}
> -	up_write(&adapter->maps_lock);
> -
> -	return found ? 0 : -EINVAL;
> +	return 0;
>  }
>  
>  void kvm_s390_destroy_adapters(struct kvm *kvm)
>  {
>  	int i;
> -	struct s390_map_info *map, *tmp;
>  
>  	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
>  		if (!kvm->arch.adapters[i])
>  			continue;
> -		list_for_each_entry_safe(map, tmp,
> -					 &kvm->arch.adapters[i]->maps, list) {
> -			list_del(&map->list);
> -			put_page(map->page);
> -			kfree(map);
> -		}
>  		kfree(kvm->arch.adapters[i]);
>  	}
>  }
> @@ -2831,19 +2771,25 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>  }
>  
> -static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
> -					  u64 addr)
> +static struct page *get_map_page(struct kvm *kvm,
> +				 struct s390_io_adapter *adapter,
> +				 u64 uaddr)
>  {
> -	struct s390_map_info *map;
> +	struct page *page;
> +	int ret;
>  
>  	if (!adapter)
>  		return NULL;
> -
> -	list_for_each_entry(map, &adapter->maps, list) {
> -		if (map->guest_addr == addr)
> -			return map;
> -	}
> -	return NULL;
> +	page = NULL;
> +	if (!uaddr)
> +		return NULL;
> +	down_read(&kvm->mm->mmap_sem);
> +	ret = get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
> +				    &page, NULL, NULL);
> +	if (ret < 1)
> +		page = NULL;
> +	up_read(&kvm->mm->mmap_sem);
> +	return page;
>  }
>  
>  static int adapter_indicators_set(struct kvm *kvm,
> @@ -2852,30 +2798,35 @@ static int adapter_indicators_set(struct kvm *kvm,
>  {
>  	unsigned long bit;
>  	int summary_set, idx;
> -	struct s390_map_info *info;
> +	struct page *ind_page, *summary_page;
>  	void *map;
>  
> -	info = get_map_info(adapter, adapter_int->ind_addr);
> -	if (!info)
> +	ind_page = get_map_page(kvm, adapter, adapter_int->ind_addr);
> +	if (!ind_page)
>  		return -1;
> -	map = page_address(info->page);
> -	bit = get_ind_bit(info->addr, adapter_int->ind_offset, adapter->swap);
> -	set_bit(bit, map);
> -	idx = srcu_read_lock(&kvm->srcu);
> -	mark_page_dirty(kvm, info->guest_addr >> PAGE_SHIFT);
> -	set_page_dirty_lock(info->page);
> -	info = get_map_info(adapter, adapter_int->summary_addr);
> -	if (!info) {
> -		srcu_read_unlock(&kvm->srcu, idx);
> +	summary_page = get_map_page(kvm, adapter, adapter_int->summary_addr);
> +	if (!summary_page) {
> +		put_page(ind_page);
>  		return -1;
>  	}
> -	map = page_address(info->page);
> -	bit = get_ind_bit(info->addr, adapter_int->summary_offset,
> -			  adapter->swap);
> +
> +	idx = srcu_read_lock(&kvm->srcu);
> +	map = page_address(ind_page);
> +	bit = get_ind_bit(adapter_int->ind_addr,
> +			  adapter_int->ind_offset, adapter->swap);
> +	set_bit(bit, map);
> +	mark_page_dirty(kvm, adapter_int->ind_addr >> PAGE_SHIFT);
> +	set_page_dirty_lock(ind_page);
> +	map = page_address(summary_page);
> +	bit = get_ind_bit(adapter_int->summary_addr,
> +			  adapter_int->summary_offset, adapter->swap);
>  	summary_set = test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, info->guest_addr >> PAGE_SHIFT);
> -	set_page_dirty_lock(info->page);
> +	mark_page_dirty(kvm, adapter_int->summary_addr >> PAGE_SHIFT);
> +	set_page_dirty_lock(summary_page);
>  	srcu_read_unlock(&kvm->srcu, idx);
> +
> +	put_page(ind_page);
> +	put_page(summary_page);
>  	return summary_set ? 0 : 1;
>  }
>  
> @@ -2897,9 +2848,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>  	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
>  	if (!adapter)
>  		return -1;
> -	down_read(&adapter->maps_lock);
>  	ret = adapter_indicators_set(kvm, adapter, &e->adapter);
> -	up_read(&adapter->maps_lock);
>  	if ((ret > 0) && !adapter->masked) {
>  		ret = kvm_s390_inject_airq(kvm, adapter);
>  		if (ret == 0)
> @@ -2951,12 +2900,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
>  			  const struct kvm_irq_routing_entry *ue)
>  {
>  	int ret;
> +	u64 uaddr;
>  
>  	switch (ue->type) {
>  	case KVM_IRQ_ROUTING_S390_ADAPTER:
>  		e->set = set_adapter_int;
> -		e->adapter.summary_addr = ue->u.adapter.summary_addr;
> -		e->adapter.ind_addr = ue->u.adapter.ind_addr;
> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.summary_addr);
> +		e->adapter.summary_addr = uaddr;
> +		uaddr =  gmap_translate(kvm->arch.gmap, ue->u.adapter.ind_addr);
> +		e->adapter.ind_addr = uaddr;
>  		e->adapter.summary_offset = ue->u.adapter.summary_offset;
>  		e->adapter.ind_offset = ue->u.adapter.ind_offset;
>  		e->adapter.adapter_id = ue->u.adapter.adapter_id;
> 
