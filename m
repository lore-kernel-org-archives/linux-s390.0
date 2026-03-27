Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96B202F65;
	Fri, 27 Mar 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625080; cv=none; b=FEOjHGCcjM+5jaBklqTd1w7WQjyHkOEeHkAkXemv65h26dmc2369Thi0OV8oiBVDp1FIZG8D7V6uf6BRCStI9Dytr4jUNMeipBDeuOFh9zAJ7tUNdnw/WHmPAgk1Dx36s1HlbHgYYpqTrqSexBLAqPMRSZ3kvEWK3Wrk6Pak+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625080; c=relaxed/simple;
	bh=pxKEKwxLg6/Ar5vfuMuF+Dy7IqinuncFJs/e9lpnHbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TnnI6/BVSgSbhfNfFIuveGFHYQRAtHkpFZx4KfcHmzu/ygceUy7BZYUUyJz1gwo+fFPNH+zHAZg6PnH//p95M60sCi50glubLVV3u5oqTFQZnRqOK3yAo1oYXl9KYBq4rWP/Ro5aMe/3LXkHlRYaUlYGJppdWvvU7r5wCnGMb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WD4h5DKs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WD4h5DKs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RAKCSY3275715;
	Fri, 27 Mar 2026 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KUge4l
	PzC40aRys0/iuE92l0c3TTv9y9zLa1eThuWow=; b=WD4h5DKs7rlUMQr+Eig3cp
	ZP8RKh4P13ouKR5FiqdHJS0k04upOk5fo8WLhp5h0LbfVTGVM2dWprNbpOZlV4eq
	I1ZUhHnZ0jVfQc/L7D3QV6MyG1V2hBqsr6wZT7ovmwPLLJDImzYB1EjHdXIAVKzf
	v9K75rCRhH0MVlPtyM1aTRYBicbvJ/9LJSr+6PKxbmhGi8FmS7BqWZHCltEXb57A
	MehZbBvfQrf6FQHXiNicAOPsE6ykKKLo6MtCl48NnEkw5EXvgfK2DIduBzVWKuPJ
	7+F6w5hX9n+DnDxa7UvFp4Qn97pWSzGTy9N6rxdMbR1AlOCn451OkWshRvhFIwzw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtw3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RF4pcx008749;
	Fri, 27 Mar 2026 15:24:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np01c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFOXvG21430848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19F258058;
	Fri, 27 Mar 2026 15:24:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C762658057;
	Fri, 27 Mar 2026 15:24:32 +0000 (GMT)
Received: from [9.61.87.139] (unknown [9.61.87.139])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:32 +0000 (GMT)
Message-ID: <f1555566-8e9a-477c-8459-f3323676b243@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:24:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 52INgxSxtNyOh8TTeeggIdY_O1EYAbgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX73D8E9TPbFWK
 nM7Qxe8v8msq9JVujMh2Bkj4Yacv1hyf1iu3rqrULA4gJNNW1UoAXVh0CiPG6ZvuSL1Ij+IhpkK
 C+Ic4OX+lSPuMre/7/WxhRAfacOwp9NWwr3G01RNbsNtZf2t3I1YWB+gQSxHFck1yH3x8hMGWRC
 F+SKGzWRxF3nxZnp7fHSyA6iQkAib7h+vSCGcRMxBXzCe3LDASunDj+0EB+/WgmxO96QFi6vIum
 nB1nzVyBVYL+2o0zfPYjJ9Y4B9qppELVFYIY4O8vR+Ax7ZStWKqv5YCwlhEr+EBASaNRZLOq/xg
 dFSItsuevPH5yw0TWBn+TITwkIvazCYWoOs5Id002s25pPCUiOkopBE8iFxnxVXHf3OrX/tNf8h
 gCL3e1CkMbulg3WqTqWSlCAYUCiNXHtBTkb+TufTq8LbHJ3YtNtB48PEknCAK1Gyww3+bZu3eHr
 ZmWvSS8YIdXINrTqh1Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a134 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=9X27iumAzmmkbSIuC0kA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 52INgxSxtNyOh8TTeeggIdY_O1EYAbgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270105

On 3/25/26 9:42 PM, Douglas Freimuth wrote:
> S390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> 
> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
> in Secure Execution environments. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> will not be incremented as the adapter indicator pages are not mapped.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>

FYI, in addition to my own review I looked thru what Sashiko found to
see if anything was valid:
https://sashiko.dev/#/patchset/20260326014247.2085-1-freimuth%40linux.ibm.com

> ---
>  arch/s390/include/asm/kvm_host.h |   5 ++
>  arch/s390/kvm/interrupt.c        | 145 +++++++++++++++++++++++++------
>  arch/s390/kvm/kvm-s390.c         |  20 +++++
>  3 files changed, 144 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 3039c88daa63..a078420751a1 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -448,6 +448,8 @@ struct kvm_vcpu_arch {
>  struct kvm_vm_stat {
>  	struct kvm_vm_stat_generic generic;
>  	u64 inject_io;
> +	u64 io_390_adapter_map;
> +	u64 io_390_adapter_unmap;
>  	u64 inject_float_mchk;
>  	u64 inject_pfault_done;
>  	u64 inject_service_signal;
> @@ -479,6 +481,9 @@ struct s390_io_adapter {
>  	bool masked;
>  	bool swap;
>  	bool suppressible;
> +	spinlock_t maps_lock;
> +	struct list_head maps;
> +	unsigned int nr_maps;
>  };
>  
>  #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 7cb8ce833b62..fce170693ff3 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2426,6 +2426,9 @@ static int register_io_adapter(struct kvm_device *dev,
>  	if (!adapter)
>  		return -ENOMEM;
>  
> +	INIT_LIST_HEAD(&adapter->maps);
> +	spin_lock_init(&adapter->maps_lock);
> +	adapter->nr_maps = 0;
>  	adapter->id = adapter_info.id;
>  	adapter->isc = adapter_info.isc;
>  	adapter->maskable = adapter_info.maskable;
> @@ -2450,12 +2453,104 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
>  	return ret;
>  }
>  
> +static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
> +{
> +	struct mm_struct *mm = kvm->mm;
> +	struct page *page = NULL;
> +	int locked = 1;
> +
> +	if (mmget_not_zero(mm)) {
> +		mmap_read_lock(mm);
> +		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
> +				      &page, &locked);
> +		if (locked)
> +			mmap_read_unlock(mm);
> +		mmput(mm);
> +	}
> +
> +	return page;
> +}
> +
> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
> +{
> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> +	struct s390_map_info *map;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	map = kzalloc_obj(*map, GFP_KERNEL);
> +	if (!map)
> +		return -ENOMEM;
> +
> +	map->page = get_map_page(kvm, addr);
> +	if (!map->page) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&map->list);
> +	map->guest_addr = addr;
> +	map->addr = addr;
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	if (adapter->nr_maps++ < MAX_S390_ADAPTER_MAPS) {

Sashiko output correctly points out that here we keep incrementing
nr_maps even once we hit MAX_S390_ADAPTER_MAPS for subsequent calls to
this ioctl.

What it missed is that, besides an overflow you might also cause an
underflow during unmap due to nr_maps exceeding the actual number of
entries in the list.

You should check the current value FIRST and only increment nr_maps if
we add to the list.

> +		list_add_tail(&map->list, &adapter->maps);
> +		ret = 0;
> +	} else {
> +		put_page(map->page);
> +		ret = -EINVAL;
> +	}
> +	spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +out:
> +	if (ret)
> +		kfree(map);
> +	return ret;
> +}
> +
> +static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
> +{
> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> +	struct s390_map_info *map, *tmp;
> +	unsigned long flags;
> +	int found = 0;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> +		if (map->guest_addr == addr) {
> +			found = 1;
> +			adapter->nr_maps--;
> +			list_del(&map->list);

Before we unpin this via put_page you need to mark_page_dirty() and
set_page_dirty_lock().
Because we are not doing this inline like the 'slow path' it is possible
that we end up marking a page dirty that was mapped but never actually
had bits indicated.  That's better than not dirtying pages that did change.

BTW this should also be done as part of kvm_s390_unmap_all_adapters_pv.

> +			put_page(map->page);
> +			kfree(map);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +
> +	return found ? 0 : -ENOENT;
> +}
> +
>  void kvm_s390_destroy_adapters(struct kvm *kvm)
>  {
>  	int i;
> +	struct s390_map_info *map, *tmp;
>  
> -	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++)
> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		if (!kvm->arch.adapters[i])
> +			continue;
> +		list_for_each_entry_safe(map, tmp,
> +					 &kvm->arch.adapters[i]->maps, list) {
> +			list_del(&map->list);
> +			put_page(map->page);
> +			kfree(map);
> +		}
>  		kfree(kvm->arch.adapters[i]);
> +	}
>  }
>  
>  static int modify_io_adapter(struct kvm_device *dev,
> @@ -2463,7 +2558,8 @@ static int modify_io_adapter(struct kvm_device *dev,
>  {
>  	struct kvm_s390_io_adapter_req req;
>  	struct s390_io_adapter *adapter;
> -	int ret;
> +	__u64 host_addr;
> +	int ret, idx;
>  
>  	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
>  		return -EFAULT;
> @@ -2477,14 +2573,29 @@ static int modify_io_adapter(struct kvm_device *dev,
>  		if (ret > 0)
>  			ret = 0;
>  		break;
> -	/*
> -	 * The following operations are no longer needed and therefore no-ops.
> -	 * The gpa to hva translation is done when an IRQ route is set up. The
> -	 * set_irq code uses get_user_pages_remote() to do the actual write.
> -	 */
>  	case KVM_S390_IO_ADAPTER_MAP:
>  	case KVM_S390_IO_ADAPTER_UNMAP:
> -		ret = 0;
> +		/* If in Secure Execution mode do not long term pin. */
> +		mutex_lock(&dev->kvm->lock);
> +		if (kvm_s390_pv_is_protected(dev->kvm)) {
> +			mutex_unlock(&dev->kvm->lock);
> +			return 0;
> +		}

I believe sashiko has a point here as well.

You rely on the fact that once the VM goes into protected mode all
previously-pinned mappings will be released.  While the list itself is
protected by a spinlock the Secure Exeuction mode indicator is not and
can change once you drop the kvm lock here.

So what could happen here is you drop the kvm lock and proceed to create
this last mapping but a separate thread of execution acquires the KVM
lock and calls kvm_s390_unmap_all_adapters_pv, releasing all old adapter
mappings.  And then finally the first thread of execution gets around to
performing the contents of kvm_s390_adapter_map() and now you are left
with a long-term mapping for a VM in SE mode.

To resolve I believe you need to hold the kvm lock over the actual
mapping operation / addition to the list to ensure that the mode change
does not happen until after that point -- then your code in
kvm_s390_unmap_all_adapters_pv will be guaranteed to pick up that last
adapter mapping that just got added.

You don't strictly have to do that for unmap (since we also do a
wholesale unmap when going into SE mode), but it's probably just safer
to do so in order to avoid unexpected error returns on the ioctl.


> +		mutex_unlock(&dev->kvm->lock);
> +		idx = srcu_read_lock(&dev->kvm->srcu);
> +		host_addr = gpa_to_hva(dev->kvm, req.addr);
> +		if (kvm_is_error_hva(host_addr)) {
> +			srcu_read_unlock(&dev->kvm->srcu, idx);
> +			return -EFAULT;
> +			}
> +		srcu_read_unlock(&dev->kvm->srcu, idx);
> +		if (req.type == KVM_S390_IO_ADAPTER_MAP) {
> +			dev->kvm->stat.io_390_adapter_map++;
> +			ret = kvm_s390_adapter_map(dev->kvm, req.id, host_addr);
> +		} else {
> +			dev->kvm->stat.io_390_adapter_unmap++;
> +			ret = kvm_s390_adapter_unmap(dev->kvm, req.id, host_addr);
> +		}
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -2730,24 +2841,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>  }
>  
> -static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
> -{
> -	struct mm_struct *mm = kvm->mm;
> -	struct page *page = NULL;
> -	int locked = 1;
> -
> -	if (mmget_not_zero(mm)) {
> -		mmap_read_lock(mm);
> -		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
> -				      &page, &locked);
> -		if (locked)
> -			mmap_read_unlock(mm);
> -		mmput(mm);
> -	}
> -
> -	return page;
> -}
> -
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index b2c01fa7b852..4b1820bcead1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -68,6 +68,8 @@
>  const struct kvm_stats_desc kvm_vm_stats_desc[] = {
>  	KVM_GENERIC_VM_STATS(),
>  	STATS_DESC_COUNTER(VM, inject_io),
> +	STATS_DESC_COUNTER(VM, io_390_adapter_map),
> +	STATS_DESC_COUNTER(VM, io_390_adapter_unmap),
>  	STATS_DESC_COUNTER(VM, inject_float_mchk),
>  	STATS_DESC_COUNTER(VM, inject_pfault_done),
>  	STATS_DESC_COUNTER(VM, inject_service_signal),
> @@ -2491,6 +2493,23 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
>  	return r;
>  }
>  
> +static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
> +{
> +	int i;
> +	struct s390_map_info *map, *tmp;
> +

Sashiko also correctly points out that you are not acquiring the
adapter->maps_lock to protect the list here.  Please add.

> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		if (!kvm->arch.adapters[i])
> +			continue;
> +		list_for_each_entry_safe(map, tmp,
> +					 &kvm->arch.adapters[i]->maps, list) {
> +			list_del(&map->list);

As mentioned above, mark_page_dirty() and set_page_dirty_lock() before put.

> +			put_page(map->page);
> +			kfree(map);
> +		}
> +	}
> +}
> +
>  static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>  {
>  	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
> @@ -2503,6 +2522,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>  
>  	switch (cmd->cmd) {
>  	case KVM_PV_ENABLE: {
> +		kvm_s390_unmap_all_adapters_pv(kvm);
>  		r = -EINVAL;
>  		if (kvm_s390_pv_is_protected(kvm))
>  			break;

