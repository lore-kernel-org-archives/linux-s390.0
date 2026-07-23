Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A20361962;
	Thu, 23 Jul 2026 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842542; cv=none; b=aRm7F1/W2EHGQL5u+Su/7/aW5NztBt0/91+SEPPxD97lECq7ol4kjXLG/3C/tHqG4+3mU1z2cXGx5OuCKY4WHEWfws17tdNRcgt+WB5eQMzfNdi/U3hSjidQwDQ/HO2tBOYYCqfLS7O2d6Vcx10i1anPosqbojh+G/EOO6CkLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842542; c=relaxed/simple;
	bh=UwG4vdvIJBDFO6C5+06RCWOiTBdns1BKnyySdp3EHhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afHJp/ioxHnPqesL4lcneXyLyWTrGq3kkR8I49NzLlXqQYyrY+wDuOqJIp0URBB2Dlns1JdIpLCQjcjfxTdlYiBFsNcB1bixZx8d8yn9ebTeMCkBRMqORyxDRptjIEM5D3pUTK37HfS31ooZ99bqeidJf4SN8psosLn2eF1WFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nKFFEd51; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nKFFEd51"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NKGop13933594;
	Thu, 23 Jul 2026 21:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IK0rpX
	ljqBEYvPrVr8Y3mSxtG5ZxNL/kH0uPPwfnY+A=; b=nKFFEd51L2Xen8KjCkK9vZ
	UjDm4P53DgVZ6xWal6zrH0Cl3/h1dI8wlchMJlYxH6mISw6t+HjVvJgBTfXjsGzH
	fTaV+Mj1t2Zo1p9Ah2FziYTHZx+BJTPcwMENoRsv2Wp3Lnek9gM9UuwDIlAg46aK
	tIz4GyvPAS+J1l6o6kwDgbnDQwqLzX+ruHMW8UELyDH/IdUaNbVoMNyYbTWODVLs
	SJ4YDTNFJBMCnL7W5GZDXP4LPIb78gySgx9LI/tERj1UfR09DRb5Hiq02Ap1VcBX
	77R2fNUeI7FRliHuDyh2R1qnHVVS0mzI081WFcezs++3KusVZnhLWTm2MyqNvQVQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kh5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 21:35:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NLJu1w007888;
	Thu, 23 Jul 2026 21:35:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqeajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 21:35:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NLZZcR14680660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 21:35:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1534158056;
	Thu, 23 Jul 2026 21:35:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E3BC58052;
	Thu, 23 Jul 2026 21:35:34 +0000 (GMT)
Received: from [9.61.247.15] (unknown [9.61.247.15])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 21:35:34 +0000 (GMT)
Message-ID: <360e03e0-ae62-4c86-bda3-a728c36635eb@linux.ibm.com>
Date: Thu, 23 Jul 2026 16:35:32 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260723181017.1220552-1-jhkim@linux.ibm.com>
 <69c50fa5-66ca-4d09-8ba8-8918287d662b@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <69c50fa5-66ca-4d09-8ba8-8918287d662b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a628929 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=chuQhSM3YQ0uYKHvs6IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIwNiBTYWx0ZWRfX6GeAAH1gnGls
 AMy3lkJhVi7tE3eJ51kIqHjs0EsFopuNFGr2O2Z6rCBMU2HV3r6G9AR2+VelQMwjuiD4GUPWLp7
 Tymqj7o3FrptBVLeXUfplsbfj+VAMghOnzxOKuGPW6vzzekgXWfKDOuEre3TwrmUHDUA4NkY+JA
 BLf6Xk6SCvgDfDv02OcFnZOSsqIGu81HKV9fNNxUAsxykg9S/Y11FI71lzEIzLFhGUTLod7mK3z
 Pu/kgV1/aJ49SWz56+x76lMhYULT2v2GEepigF+57Ao+3Q/3vpYBkSfStz/Qgy1jjdWXjnHFYxB
 41uXTRZOBmxIQhMh7LEXa9MU34aN/Rv46pbXtN1/GO4L5Uq+EhtcyuWmfyTe9qIG6MWKI95ApT5
 YoTsGVoPgOsZLzPMheWRO/48CQo7rw11Dp38DiTmuWNrLFLumbe8SIHl0UT6z/LCxd6VUUGJBTD
 MudgdgYzC2e/lvl1E7A==
X-Proofpoint-ORIG-GUID: aBIaq0wvFXHKhaa_ll7vGRKMT7qxx-YJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIwNiBTYWx0ZWRfX5GgSwoziEsOm
 cjibeahTnP0Uw1msYKd0/cO4SajOPk5ciYPlwjoHcpujK7VNylprShNgJ/YLeaZCD/mf6acOhWp
 rBF8xVQZK+1H+8K2y2ZMBryzD3/DApo=
X-Proofpoint-GUID: aBIaq0wvFXHKhaa_ll7vGRKMT7qxx-YJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230206

On 7/23/2026 2:12 PM, Matthew Rosato wrote:
> On 7/23/26 2:10 PM, Jaehoon Kim wrote:
>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>> irqfd adapter registration fails even though interrupt delivery could
>> still work via the existing non-atomic path.
>>
>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>> using a short-term pin instead. If the short-term pin succeeds, unpin
>> the page and add a map entry with pinned=false to preserve MAP/UNMAP
>> symmetry. The non-atomic irqfd path already performs short-term pinning
>> for interrupt delivery, so this restores the previous behavior for
>> memory that cannot be pinned long-term.
>>
>> get_map_info() is updated to return NULL for unpinned entries so that
>> the atomic irqfd fast path falls back to the non-atomic path.
>> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
>> marking and unpin for unpinned entries.
>>
>> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
>> new MAP/UNMAP behavior.
>>
>> Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
> cc stable?

Thanks for your feedback.

Since the fixed commit first landed in v7.2-rc1, I don't think this needs to be
CC'd to stable.

The Fixes: tag should reference the mainline commit c9a5688380865b instead of
adcd5b3e758b, which is from the development branch.

I'll update it in the next version.

>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> ---
>>   Documentation/virt/kvm/devices/s390_flic.rst | 11 +++-
>>   arch/s390/include/asm/kvm_host.h             |  5 ++
>>   arch/s390/kvm/interrupt.c                    | 59 +++++++++++++++-----
>>   3 files changed, 58 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/s390_flic.rst b/Documentation/virt/kvm/devices/s390_flic.rst
>> index b784f8016748..ec9aaae04e22 100644
>> --- a/Documentation/virt/kvm/devices/s390_flic.rst
>> +++ b/Documentation/virt/kvm/devices/s390_flic.rst
>> @@ -112,9 +112,16 @@ Groups:
>>         mask or unmask the adapter, as specified in mask
>>   
>>       KVM_S390_IO_ADAPTER_MAP
>> -      This is now a no-op. The mapping is purely done by the irq route.
>> +      Map an adapter indicator or summary page for long-term pinning so that
>> +      interrupt injection can be performed in atomic context. If long-term
>> +      pinning is not possible (e.g. file-backed memory), the page is verified
>> +      via a short-term pin and the ioctl returns success; interrupt injection
>> +      will use the non-atomic irqfd path with short-term pinning on each
>> +      interrupt. In Secure Execution mode this is a no-op.
> Nit:
> ... this is a no-op and the ioctl returns success.

I will fix in the next version, thanks.

>
>>       KVM_S390_IO_ADAPTER_UNMAP
>> -      This is now a no-op. The mapping is purely done by the irq route.
>> +      Unmap a previously mapped adapter indicator or summary page and release
>> +      the long-term pin. If the page was not long-term pinned (e.g. file-backed
>> +      memory or Secure Execution mode), this is a no-op and returns success.
> Technically not a no-op in the file-backed case, you will still remove a
> list entry.
>
> How about a little re-wording:
>
> KVM_S390_IO_ADAPTER_UNMAP
>    Unmap a previously mapped adapter indicator or summary page and release
>    the long-term pin. If the page was not long-term pinned (e.g. file-backed
>    memory), the map entry is removed and success is returned; if no prior
>    map entry exists, -ENOENT is returned. In Secure Execution mode this is
>    a no-op and the ioctl returns success.

You're right. In the file-backed case, the map entry is still removed, so
describing it as a no-op is inaccurate. I'll update the documentation based
on your suggested in the next version.

Thanks for the review!

>
> Otherwise, code looks good to me.  Thanks Jaehoon!
>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
>>   
>>     KVM_DEV_FLIC_AISM
>>       modify the adapter-interruption-suppression mode for a given isc if the
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index eaa34c5bd3c1..c172f9b212d1 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -476,6 +476,11 @@ struct s390_map_info {
>>   	__u64 guest_addr;
>>   	__u64 addr;
>>   	struct page *page;
>> +	/*
>> +	 * True if the page is long-term pinned. False if long-term pinning
>> +	 * failed and this entry exists only to preserve MAP/UNMAP symmetry.
>> +	 */
>> +	bool pinned;
>>   };
>>   
>>   struct s390_io_adapter {
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 9e3e6b0d72ad..75eacd1578ef 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2520,8 +2520,22 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>>   	map->addr = host_addr;
>>   	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>>   	if (!map->page) {
>> -		ret = -EINVAL;
>> -		goto out;
>> +		/*
>> +		 * Long-term pinning may fail for memory types such as file-backed
>> +		 * memory. Verify that short-term pinning succeeds so that the
>> +		 * non-atomic irqfd path can handle interrupt injection.
>> +		 */
>> +		map->page = pin_map_page(kvm, host_addr, 0);
>> +		if (!map->page) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		unpin_user_page(map->page);
>> +		map->page = NULL;
>> +		map->pinned = false;
>> +		/* Add an entry to preserve MAP/UNMAP symmetry. */
>> +	} else {
>> +		map->pinned = true;
>>   	}
>>   	spin_lock_irqsave(&adapter->maps_lock, flags);
>>   	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
>> @@ -2532,7 +2546,7 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>>   		ret = -EINVAL;
>>   	}
>>   	spin_unlock_irqrestore(&adapter->maps_lock, flags);
>> -	if (ret)
>> +	if (ret && map->page)
>>   		unpin_user_page(map->page);
>>   out:
>>   	if (ret)
>> @@ -2546,6 +2560,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>>   	struct s390_map_info *map, *tmp, *map_to_free;
>>   	struct page *map_page_to_put = NULL;
>>   	u64 map_addr_to_mark = 0;
>> +	bool map_pinned = false;
>>   	unsigned long flags;
>>   	int found = 0, idx;
>>   
>> @@ -2560,6 +2575,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>>   			list_del(&map->list);
>>   			map_page_to_put = map->page;
>>   			map_addr_to_mark = map->guest_addr;
>> +			map_pinned = map->pinned;
>>   			map_to_free = map;
>>   			break;
>>   		}
>> @@ -2568,11 +2584,18 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
>>   
>>   	if (found) {
>>   		kfree(map_to_free);
>> -		idx = srcu_read_lock(&kvm->srcu);
>> -		mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
>> -		set_page_dirty_lock(map_page_to_put);
>> -		srcu_read_unlock(&kvm->srcu, idx);
>> -		unpin_user_page(map_page_to_put);
>> +		if (map_pinned) {
>> +			/*
>> +			 * Only long-term pinned pages need to be marked dirty
>> +			 * and released. Fallback entries exist only for
>> +			 * MAP/UNMAP symmetry.
>> +			 */
>> +			idx = srcu_read_lock(&kvm->srcu);
>> +			mark_page_dirty(kvm, map_addr_to_mark >> PAGE_SHIFT);
>> +			set_page_dirty_lock(map_page_to_put);
>> +			srcu_read_unlock(&kvm->srcu, idx);
>> +			unpin_user_page(map_page_to_put);
>> +		}
>>   	}
>>   
>>   	return found ? 0 : -ENOENT;
>> @@ -2598,11 +2621,13 @@ void kvm_s390_unmap_all_adapters(struct kvm *kvm)
>>   
>>   		list_for_each_entry_safe(map, tmp, &local_list, list) {
>>   			list_del(&map->list);
>> -			idx = srcu_read_lock(&kvm->srcu);
>> -			mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
>> -			set_page_dirty_lock(map->page);
>> -			srcu_read_unlock(&kvm->srcu, idx);
>> -			unpin_user_page(map->page);
>> +			if (map->pinned) {
>> +				idx = srcu_read_lock(&kvm->srcu);
>> +				mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
>> +				set_page_dirty_lock(map->page);
>> +				srcu_read_unlock(&kvm->srcu, idx);
>> +				unpin_user_page(map->page);
>> +			}
>>   			kfree(map);
>>   		}
>>   	}
>> @@ -2929,8 +2954,12 @@ static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
>>   		return NULL;
>>   
>>   	list_for_each_entry(map, &adapter->maps, list) {
>> -		if (map->addr == addr)
>> -			return map;
>> +		if (map->addr == addr) {
>> +			if (map->pinned)
>> +				return map;
>> +			else
>> +				return NULL;
>> +		}
>>   	}
>>   	return NULL;
>>   }


