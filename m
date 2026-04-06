Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43B2248B9;
	Mon,  6 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482796; cv=none; b=OaH7payF+nwvkIG3BQyJ0wNN1fVEZDPpfZ8DztGR4FjAno0x8DCCx29oPxVcoA5tvsvIxuvbrVR2tNTFduMEvh5DbKfmcOJrfWYBF0IInowbK1AoanaDrJE831UMa8pjK+Xua+J/jvwI/aIR9vDPS7743MI31qPxq1HNbQmdmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482796; c=relaxed/simple;
	bh=FC1BbWazLS9hg1HFjVWA3d/X9Wjw5dFcv92s8YgiSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DlpYu/jm+4EfFUP4WUJCTN2m6vCpReASV3Qh+lD3AQN6I2ZJTNWc1HvEIid96WAP/5/F7OUZVzh0FM/vK7MxJx9DRPm+PE4TL/Yub0qYFPFwscWHGggOXol2akyUiUwmE5/HJ2VOh8opRu3ip9xqQ0My7QRAoMyd1y+u0TDs3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UBJs3621; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UBJs3621"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635MPA8G3726924;
	Mon, 6 Apr 2026 13:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tepw79
	9UkYExDdTa5bI9Q8SSg6bmiW51NjjhcAaXSGo=; b=UBJs3621PXJXOZA3Oa97B1
	eHVq00bo75kscz4XfDrBBrk77ahkt733weXfnCwnzYFY4G4zPMhcj5hMMmzIUpPG
	VzmpsWx+HcO1Vb41JPck7o26G4dNPG/I9qeU0luE+0fj0HQAtWLZ/s2rfQ7VyU2K
	VZaH1cQxiUjtfIqSIqKA2GiQP/DQ+7XrZZYa7ff2EP+bIKS/KtGkmL+qp/D48n3d
	87N3a9rHBm6XGEDcOJq5p3n67PbUi68vAyEO8+TF2R7/7bjx9U4nCbqdeLs5ZVr5
	/tRwNwtZvppJHGS1SWekZBrlRdiKIeUw6yNqFQiGg16x2uE4cVoMuCQJyS52RYyA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2pva1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 13:39:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636A15iN018529;
	Mon, 6 Apr 2026 13:39:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcysw0hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 13:39:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636Ddb3R26215154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 13:39:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30BEB58057;
	Mon,  6 Apr 2026 13:39:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3624158058;
	Mon,  6 Apr 2026 13:39:36 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 13:39:36 +0000 (GMT)
Message-ID: <e2c813a0-0ac0-4a1e-b980-fa2dce33eca7@linux.ibm.com>
Date: Mon, 6 Apr 2026 09:39:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-2-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260406064419.14384-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEzMSBTYWx0ZWRfX9Dn/caooQ7QC
 xr/iSisrYm6Zo3rFmMZUsRwr20TqXp6axlFsObqHegWiUZkgsR6hhcPCbAjzD5JSfx9BNUo/As6
 1Y+TIo86zVzlNDzOdk2pgG39xjCmtTT5aUzfq4ODTw/HB0yQ4a2a7rOKdCw0jvr7ptKfsc3mudO
 yvkh100aAwPiPD949vgvbD0AW2bRPX5pIebn90ihewxsDvBMk4BflUQeeXi5yz0dfO5eCM3gYEW
 7tIsoI6RTxWCD1/6eZjIFQSmMV3fd4foiSOr7tVf8gKC2/P78eFeZNMTOYgJJSqmmEIAs8+uKlA
 eH63fl8p7VQZgVC6b1TTrOlF9gBE8fWqYK5D49dHKHoWDpJQIXi4AUzXNgsPY3PWxNMuAxZHnM9
 ggzJ7GVKqWH6LsliMTBlT4FMuR5V86+Zz6PfugwffW+CCM2HKFppGf0z0cnnBhZnFqUt+9BQGOb
 3MVh9iaJvDI0dLJE3VQ==
X-Proofpoint-GUID: fVU_w3aYr0hj7edpyjmIc9ULyAj1ArhY
X-Proofpoint-ORIG-GUID: fVU_w3aYr0hj7edpyjmIc9ULyAj1ArhY
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d3b79c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=btLd6DknfgKiYBGOQYYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060131

On 4/6/26 2:44 AM, Douglas Freimuth wrote:
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

[...]

> +static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
> +{
> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> +	struct s390_map_info *map, *tmp;
> +	unsigned long flags;
> +	int found = 0, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> +		if (map->guest_addr == addr) {
> +			spin_lock_irqsave(&adapter->maps_lock, flags);

This lock needs to be acquired before the list_for_each_entry_safe call,
that way it protects the list from changing until after you delete the
specified entry.

> +			found = 1;
> +			adapter->nr_maps--;
> +			list_del(&map->list);
> +			spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +			idx = srcu_read_lock(&kvm->srcu);
> +			mark_page_dirty(kvm, map->addr >> PAGE_SHIFT);

This isn't the right address to mark dirty.  Per

898885477e0f KVM: s390: Use guest address to mark guest page dirty

You need to keep track of the gaddr and use that to mark the page dirty.


> +			set_page_dirty_lock(map->page);
> +			srcu_read_unlock(&kvm->srcu, idx);
> +			put_page(map->page);
> +			kfree(map);
> +			break;
> +		}
> +	}
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

Should also be holding the maps_lock over this until the list is emptied
(e.g. right until the kfree(kvm->arch.adapters[i] call)

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
> @@ -2463,7 +2563,8 @@ static int modify_io_adapter(struct kvm_device *dev,
>  {
>  	struct kvm_s390_io_adapter_req req;
>  	struct s390_io_adapter *adapter;
> -	int ret;
> +	__u64 host_addr;
> +	int ret, idx;
>  
>  	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
>  		return -EFAULT;
> @@ -2477,14 +2578,30 @@ static int modify_io_adapter(struct kvm_device *dev,
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
> +		idx = srcu_read_lock(&dev->kvm->srcu);
> +		host_addr = gpa_to_hva(dev->kvm, req.addr);
> +		if (kvm_is_error_hva(host_addr)) {
> +			srcu_read_unlock(&dev->kvm->srcu, idx);

dev->kvm->lock also needs to be dropped here.

> +			return -EFAULT;
> +		}
> +		srcu_read_unlock(&dev->kvm->srcu, idx);
> +		if (req.type == KVM_S390_IO_ADAPTER_MAP) {
> +			dev->kvm->stat.io_390_adapter_map++;
> +			ret = kvm_s390_adapter_map(dev->kvm, req.id, host_addr);
> +			mutex_unlock(&dev->kvm->lock);

This unlock...

> +		} else {
> +			dev->kvm->stat.io_390_adapter_unmap++;
> +			ret = kvm_s390_adapter_unmap(dev->kvm, req.id, host_addr);
> +			mutex_unlock(&dev->kvm->lock);

and this unlock...

> +		}

Could be combined and moved here

>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -2730,24 +2847,6 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
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
> index d7838334a338..4eada48c6e27 100644
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
> @@ -2491,6 +2493,30 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
>  	return r;
>  }
>  
> +static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
> +{
> +	unsigned long flags;
> +	struct s390_map_info *map, *tmp;
> +	int i, idx;
> +
> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		if (!kvm->arch.adapters[i])
> +			continue;
> +		list_for_each_entry_safe(map, tmp,
> +					 &kvm->arch.adapters[i]->maps, list) {
> +			spin_lock_irqsave(&kvm->arch.adapters[i]->maps_lock, flags);

Same comment as kvm_s390_adapter_unmap, need to aquire this before the
list_for_each_entry_safe call.

Actually this one will need to be a bit more creative since you need to
drop the spinlock before each call to set_page_dirty_lock(), but you'll
need to re-acquire it again each time you go back to the list.  That
makes list_for_each_entry_safe a bad choice.

Maybe using list_first_entry_or_null() each time you re-acquire the
spinlock, until you get a null (meaning the list is empty)?

> +			list_del(&map->list);

You need to be decrementing nr_maps here before droppping the lock;
unlike kvm_s390_destroy_adapters we are not freeing the structure and if
we leave SE mode we could get more mappings later so the nr_maps value
has to be kept up-to-date.

> +			spin_unlock_irqrestore(&kvm->arch.adapters[i]->maps_lock, flags);
> +			idx = srcu_read_lock(&kvm->srcu);
> +			mark_page_dirty(kvm, map->addr >> PAGE_SHIFT);

Same comment as above, need to use the gaddr

> +			set_page_dirty_lock(map->page);
> +			srcu_read_unlock(&kvm->srcu, idx);
> +			put_page(map->page);
> +			kfree(map);
> +		}
> +	}
> +}
> +
>  static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>  {
>  	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
> @@ -2507,6 +2533,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>  		if (kvm_s390_pv_is_protected(kvm))
>  			break;
>  
> +		kvm_s390_unmap_all_adapters_pv(kvm);
>  		mmap_write_lock(kvm->mm);
>  		/*
>  		 * Disable creation of new THPs. Existing THPs can stay, they

