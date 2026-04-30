Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA992DEA90;
	Thu, 30 Apr 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583148; cv=none; b=j86QoFXOXSQOtjEv4G3ljQymBh8E1Q9MAcrrpu6oQ4/Af+jkA0mt3rk1TBN53uE85JqGbjhQ7q8RJ+isz6P5vl+0bhz1iiRuvSpu+A6irAHQFEX7ivsXtWwNRBwEWcvzu4PmGoB3T1RzFDi4gxEDPF3dWFERsf5f1l69PExSNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583148; c=relaxed/simple;
	bh=BAj3Au5OUcjf/rsK3PvwVQA8gtKPhWs7wLF/rwYyVCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AADVmtBS3lzDVM+DdJsBja3Xq2QhIEC8/mv+Z5ekJXfPTAsM5KQNLAilT7vIHayScSiLO2hXS7YMZdqNljyz2cHV7KURnFYnuU4j+GcwKsRCJRpA0SF5WSB0MpQihzBXwYQ6tauYDdOGW7TVMQxP24nHlAksSlj21/3vAblVKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqDL6aV3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqDL6aV3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UEHB793239715;
	Thu, 30 Apr 2026 21:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gmfc4h
	1HDBFwIUL1WoZh0uKJgIB0pNROu7rRBvY+JrI=; b=rqDL6aV3SftPoB85Zc/J+r
	D3WOYy7mKMhk+j11mCWNtNp7wpbhAcAEzTnXWmCR/vz6yjzuF1tAKEIMCxY8sFB0
	yZvKZ2bnPcdqm2TpdnonrT1nhdQFru7JocUlPXJY+rTu2smdSeihi4FUZhFPD62s
	acWvw9pelSuS9P6SmoidvZyyhM7YZWTDQw4KsrP5bOSb0Drpy/3fuBhYBRe7Q9NC
	cvSMpKEUwEiQjKGc9Ug+v+BbtlO16yvHo+JCO00WhriThKW3plcRowrPu5x/jGJB
	4F6MRsZujNevzO/Ui+cr7p+x5+g9OHCxB44hJjgexOkQ+hOaEqyF8tW8A1adSChA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1k0a54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 21:05:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UKrmuC016102;
	Thu, 30 Apr 2026 21:05:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gmpj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 21:05:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UL5fOn29950516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 21:05:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D933458056;
	Thu, 30 Apr 2026 21:05:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2DB558052;
	Thu, 30 Apr 2026 21:05:40 +0000 (GMT)
Received: from [9.61.249.171] (unknown [9.61.249.171])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 21:05:40 +0000 (GMT)
Message-ID: <02554d0f-c90d-4467-9f12-7bea28322701@linux.ibm.com>
Date: Thu, 30 Apr 2026 17:05:40 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-2-freimuth@linux.ibm.com>
 <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxNSBTYWx0ZWRfX4UnFeBfB12d7
 z97STh9BWtvomG28e6/ZOK6o7pgD4IkaSRm5M3jEe+ggTRPbkMWuvq+wuddVcSNmRaWuq5+VwuG
 EAoKSGFBNwjtzf8Q/NqmeN7vPjo/NODac53d8lLbwgzqrdxJE0WeTmrrTi0V8s8AL7nldJpxkwA
 GC4DA6HD69Dt+NFKooXU8hTmHWdYfs2oC+ABblE3LwzINAoXSNPSTAPdAeJIJpPruYA5ll0ngn9
 aDronPW4MQ3hrpPavIxjx3O1E0+IVP6qb4fhhB6lDL6hxE+orRskE09x6lb1j1zihORRAMGz8cC
 0k9XI2L6S27LjcSIN2+lU4CMxp05AwhIjNjxJ4hp8YrdYjFHEkyHpk1KoW/Qn/o8Mit4yMOKbtl
 XDZ39AhrcCOc55yuC3DYZK79QSSORrfCc0srfm1znf6BXGKvMVGX1I/BWv6ZwJZnYFR0byGDTuZ
 +FSMMxb+q9q+8dHoEsQ==
X-Proofpoint-GUID: KT7XCcK8qZgqUNcy1dLzdLLwqHdZRW3L
X-Proofpoint-ORIG-GUID: KT7XCcK8qZgqUNcy1dLzdLLwqHdZRW3L
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f3c427 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GEdobD3kkTL1GvP2WKUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300215



On 4/29/26 10:44 AM, Matthew Rosato wrote:
> 
>> +static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
>> +{
>> +	struct mm_struct *mm = kvm->mm;
>> +	struct page *page = NULL;
>> +	int locked = 1;
>> +
>> +	if (mmget_not_zero(mm)) {
>> +		mmap_read_lock(mm);
>> +		get_user_pages_remote(mm, uaddr, 1, FOLL_WRITE,
>> +				      &page, &locked);
> 
> I have wondered this before, and Sashiko mentions it now:  Would it make
> sense to also FOLL_LONGTERM here?
> 
> I recognize that the old ioctl code that you are resurrecting here did
> not use FOLL_LONGTERM, but I can't think of a reason why.
> 
> The mapping may indeed be held long-term (life of the guest or at least
> the associated adapter in the guest), and it's effectively under
> userspace control, waiting for a corresponding unmap ioctl or for the
> guest to go away or enter pv mode.
> 
> Can you please test?

I tested this with get_user_pages_remote() and
FOLL_WRITE | FOLL_LONGTERM. I get null pages back. Thus the exploration 
into whether pin_user_pages_remote() with those flags is desirous in 
this case.

> 
>> +		if (locked)
>> +			mmap_read_unlock(mm);
>> +		mmput(mm);
>> +	}
>> +
>> +	return page;
>> +}
>> +
>> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>> +{
>> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>> +	struct s390_map_info *map;
>> +	unsigned long flags;
>> +	__u64 host_addr;
>> +	int ret, idx;
>> +
>> +	if (!adapter || !addr)
>> +		return -EINVAL;
>> +
>> +	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
>> +	if (!map)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&map->list);
>> +	idx = srcu_read_lock(&kvm->srcu);
>> +	host_addr = gpa_to_hva(kvm, addr);
>> +	if (kvm_is_error_hva(host_addr)) {
>> +		srcu_read_unlock(&kvm->srcu, idx);
>> +		kfree(map);
> 
> Drop this kfree(), you already do this when you goto out
> 
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +	srcu_read_unlock(&kvm->srcu, idx);
>> +	map->guest_addr = addr;
>> +	map->addr = host_addr;
>> +	map->page = get_map_page(kvm, host_addr);
>> +	if (!map->page) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
>> +	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
>> +		list_add_tail(&map->list, &adapter->maps);
>> +		adapter->nr_maps++;
>> +		ret = 0;
>> +	} else {
>> +		put_page(map->page);
>> +		ret = -EINVAL;
>> +	}
>> +	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> 
> Sashiko is concerned about put_page() potentially sleeping under
> PREEMPT_RT; drilling down to functions like free_one_page() indeed I see
> regular spinlocks employed.
> 
> RT aside, it might be worth doing this anyway to reduce the critical
> section you are holding this lock over, like so:
> 
> 	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> 	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
> 		list_add_tail(&map->list, &adapter->maps);
> 		adapter->nr_maps++;
> 		ret = 0;
> 	} else {
> 		ret = -EINVAL;
> 	}
> 	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> 	if (ret)
> 		put_page(map->page);
> 
> 
>> +out:
>> +	if (ret)
>> +		kfree(map);
>> +	return ret;
>> +}
>> +
>> +static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>> +{
>> +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>> +	struct s390_map_info *map, *tmp;
>> +	struct page *map_page_to_put = NULL;
>> +	u64 map_addr_to_mark = 0;
>> +	unsigned long flags;
>> +	int found = 0, idx;
>> +
>> +	if (!adapter || !addr)
>> +		return -EINVAL;
>> +
>> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
>> +	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
>> +		if (map->guest_addr == addr) {
>> +			found = 1;
>> +			adapter->nr_maps--;
>> +			list_del(&map->list);
>> +			map_page_to_put = map->page;
>> +			map_addr_to_mark = map->guest_addr;
>> +			kfree(map);
> 
> Move the kfree() outside of the raw spinlock and instead call it...
> 
>> +			break;
>> +		}
>> +	}
>> +	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
>> +
>> +	if (found) {
> 
> ... right here.
> 
>> +		idx = srcu_read_lock(&kvm->srcu);
>> +		mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
>> +		set_page_dirty_lock(map_page_to_put);
>> +		srcu_read_unlock(&kvm->srcu, idx);
>> +		put_page(map_page_to_put);
>> +	}
>> +
>> +	return found ? 0 : -ENOENT;
>> +}
>> +
>>   void kvm_s390_destroy_adapters(struct kvm *kvm)
>>   {
>>   	int i;
>> +	struct s390_map_info *map, *tmp;
>> +	unsigned long flags;
>>   
>> -	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++)
>> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
>> +		if (!kvm->arch.adapters[i])
>> +			continue;
>> +		raw_spin_lock_irqsave(&kvm->arch.adapters[i]->maps_lock, flags);
>> +		list_for_each_entry_safe(map, tmp,
>> +					 &kvm->arch.adapters[i]->maps, list) {
>> +			list_del(&map->list);
>> +			put_page(map->page);
>> +			kfree(map);
>> +		}
>> +		raw_spin_unlock_irqrestore(&kvm->arch.adapters[i]->maps_lock, flags);
> 
> Moving put_page/kfree out of the spinlock is a bit more work here.
> Handle this the same way you did in kvm_s390_unmap_all_adapters_pv()?
> 
> Actually wait -- besides the dirty page logic (which should be fine to
> do here too) this is the same code as kvm_s390_unmap_all_adapters_pv().
> Can you make the code in kvm_s390_unmap_all_adapters_pv() a single
> routine with a different name (e.g. kvm_s390_unmap_all_adapters()?) that
> is called both from here as well as from kvm_s390_handle_pv()?
> 
> 

