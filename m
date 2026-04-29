Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A713D539;
	Wed, 29 Apr 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473899; cv=none; b=L/iSfpgkSYpyK7zHUTh2pDycELd5W61vTTReBGH/VqU7z0adNqvfjbYLWu+lGVpDW9Hde59R3LsqYc00vpSEy1AHP3WYPNpG5R7cuRf1q5jcNA/SFrmB9XLPUVXUXSxEAt4syTR13O99JLLn3a5qvGAo+2UHB2tbwln07DNTVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473899; c=relaxed/simple;
	bh=FqSvAgtJuvb9f5xvuUWZP8tCr5URrgofaeuoJwA93UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VrzNa9uNnQCEJX/iDPf9yjB/d56w6U1Tw3lGmq50Cf5W7UFx44zP/F/orps0ViIkLQoK33+cIsmyJgpW5WWBUPoaHaNpNpZSaLVLzG4mJW7v+1E4B7e7rk2ccWh63PJlHF+fVDDJiGJdEr3DF3oaA3yEH1XBe7nJ5ZN2bn8zTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RTuHI0E8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RTuHI0E8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T82Hbl2525992;
	Wed, 29 Apr 2026 14:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=evjQ+M
	t6wejhn1F4pKmvjMHmyl/O4rElYaBzMzcekQQ=; b=RTuHI0E8fhlxI8tA0JkDke
	1mkkpf+09w+vEHCIn5+1zVszkcqLLVDIoAyFcHnRmpA7gEi+VPOE4lJCm+naBc9z
	C2WlbTxkK/JsKZ317GRtC057mMBQiDTaJsPR8gP9jceOCblm331z+5dI6HXtvmLv
	B1LRiP3CnQWjX1a+WbchK/KkRDAxTJNpCQYigtt8xU/3rCC2qAjwX71zPntNcEKt
	MZ8EKE2bzMDjjrFUo1LLZ6Cu9rIBdoyA0ywhepKOKSgxzcc/iUzQsubYTUnYAGlz
	ygUNQ0ByLyTzeoL77HMVDmzcLBvDI5r/AnX/C8nh8MiFSqbdaYBvflf8pYYkGjSQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5b0xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:44:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TENqg4005391;
	Wed, 29 Apr 2026 14:44:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gejwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 14:44:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TEiQUh25362954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 14:44:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F12B558062;
	Wed, 29 Apr 2026 14:44:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B4A658063;
	Wed, 29 Apr 2026 14:44:52 +0000 (GMT)
Received: from [9.61.22.161] (unknown [9.61.22.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 14:44:52 +0000 (GMT)
Message-ID: <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Date: Wed, 29 Apr 2026 10:44:51 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-2-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260423235316.3665-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f21967 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=nWr_SGdks0rttQIoimkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0NSBTYWx0ZWRfX8IqEDdNy1XSs
 8UZmsDgSRyrRqJATw0JrlTe9Bo2U8CuKtUsYVvsVn2No+DcL+S9JontJg1Nzp3PQAAH+huBI0Tb
 2qM9LejWAIYgni3cvIC0ULXkauT73Z4iQQ+A/0T2Sn7PXNzdsWxh2hoCEmkh+oPweHq7TEhM2CI
 1ZiJ9PH+9DaJ6GBDBb3WbfTtSRvgvtd0RscXmYPrnkeuLzuGq+RzhmUL9loJIrBb4PRXHoca+GZ
 000YwRGArsaaYMVafqtmFyNccTwxRHWrlLqwM2jtgz/wPJHJSZ9xaMKKQuulBLieToGdpLLjcKd
 myyKg0qb5ATVqIHhb20SQvvibufBnVaGtz6V6qU7I3HqEP4Ut+maWOvC8sFVc89AHrsrFjgTawT
 p7lgfuYcjXwlNzt/aAvwtSiWoc4NGn4moyo4WQlEF2j4eHLFDiJeGZv8AeLhsOAaRjzmts1wDaD
 JDRt1L4RAZbCfWFlFVw==
X-Proofpoint-GUID: VmdMOMN1XVfSAfoEC5DcytcrQVvvYq13
X-Proofpoint-ORIG-GUID: VmdMOMN1XVfSAfoEC5DcytcrQVvvYq13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290145


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

I have wondered this before, and Sashiko mentions it now:  Would it make
sense to also FOLL_LONGTERM here?

I recognize that the old ioctl code that you are resurrecting here did
not use FOLL_LONGTERM, but I can't think of a reason why.

The mapping may indeed be held long-term (life of the guest or at least
the associated adapter in the guest), and it's effectively under
userspace control, waiting for a corresponding unmap ioctl or for the
guest to go away or enter pv mode.

Can you please test?

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
> +	__u64 host_addr;
> +	int ret, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
> +	if (!map)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&map->list);
> +	idx = srcu_read_lock(&kvm->srcu);
> +	host_addr = gpa_to_hva(kvm, addr);
> +	if (kvm_is_error_hva(host_addr)) {
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		kfree(map);

Drop this kfree(), you already do this when you goto out

> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	srcu_read_unlock(&kvm->srcu, idx);
> +	map->guest_addr = addr;
> +	map->addr = host_addr;
> +	map->page = get_map_page(kvm, host_addr);
> +	if (!map->page) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> +	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
> +		list_add_tail(&map->list, &adapter->maps);
> +		adapter->nr_maps++;
> +		ret = 0;
> +	} else {
> +		put_page(map->page);
> +		ret = -EINVAL;
> +	}
> +	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);

Sashiko is concerned about put_page() potentially sleeping under
PREEMPT_RT; drilling down to functions like free_one_page() indeed I see
regular spinlocks employed.

RT aside, it might be worth doing this anyway to reduce the critical
section you are holding this lock over, like so:

	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
		list_add_tail(&map->list, &adapter->maps);
		adapter->nr_maps++;
		ret = 0;
	} else {
		ret = -EINVAL;
	}
	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
	if (ret)
		put_page(map->page);


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
> +	struct page *map_page_to_put = NULL;
> +	u64 map_addr_to_mark = 0;
> +	unsigned long flags;
> +	int found = 0, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;
> +
> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> +	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> +		if (map->guest_addr == addr) {
> +			found = 1;
> +			adapter->nr_maps--;
> +			list_del(&map->list);
> +			map_page_to_put = map->page;
> +			map_addr_to_mark = map->guest_addr;
> +			kfree(map);

Move the kfree() outside of the raw spinlock and instead call it...

> +			break;
> +		}
> +	}
> +	raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +
> +	if (found) {

... right here.

> +		idx = srcu_read_lock(&kvm->srcu);
> +		mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
> +		set_page_dirty_lock(map_page_to_put);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		put_page(map_page_to_put);
> +	}
> +
> +	return found ? 0 : -ENOENT;
> +}
> +
>  void kvm_s390_destroy_adapters(struct kvm *kvm)
>  {
>  	int i;
> +	struct s390_map_info *map, *tmp;
> +	unsigned long flags;
>  
> -	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++)
> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		if (!kvm->arch.adapters[i])
> +			continue;
> +		raw_spin_lock_irqsave(&kvm->arch.adapters[i]->maps_lock, flags);
> +		list_for_each_entry_safe(map, tmp,
> +					 &kvm->arch.adapters[i]->maps, list) {
> +			list_del(&map->list);
> +			put_page(map->page);
> +			kfree(map);
> +		}
> +		raw_spin_unlock_irqrestore(&kvm->arch.adapters[i]->maps_lock, flags);

Moving put_page/kfree out of the spinlock is a bit more work here.
Handle this the same way you did in kvm_s390_unmap_all_adapters_pv()?

Actually wait -- besides the dirty page logic (which should be fine to
do here too) this is the same code as kvm_s390_unmap_all_adapters_pv().
Can you make the code in kvm_s390_unmap_all_adapters_pv() a single
routine with a different name (e.g. kvm_s390_unmap_all_adapters()?) that
is called both from here as well as from kvm_s390_handle_pv()?


