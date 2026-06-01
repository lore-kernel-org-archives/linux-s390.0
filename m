Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B41372063;
	Mon,  1 Jun 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319671; cv=none; b=HYYmEnEWCRQg/uZQFXSwhqCYjA6CwBfCG0M4MjGiTsn0Q2GtLS83athm2OrGdd0hdycG7b96vQdblsyl5My6IMc7sUKI4ywKhc/+G1idCtsh91hTfI0zUcKORw37e2g0fRhN50cGiw9VGfpIAPHLzO3O3bXzxpFXhZEDUe+QQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319671; c=relaxed/simple;
	bh=U7Wx4pQPbo7chs4LM7tpL/xVub5ZPnkHOqdEkYr3qo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJyyWjkluJ5l3pV5IUyBCZkgF4oK23RaCakR+uVNC9HD1+CTeEPYyJ4CZ78PWHDBFXeobJA/bmoxtwMpDlJ0FT5s3ujEFUC15FPBYeA/T1Vlbpi6LbrP/0s9xgGRl2KtyV0ibKklUTaaRUZtMGmiF7REsm71WzJOQF/dKOS6ljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WlgPX0IM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WlgPX0IM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65154H7u1890877;
	Mon, 1 Jun 2026 13:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v05JSl
	b4xU/ALd2h/9eXI3cU4UOSIQLXPpT3llYipjU=; b=WlgPX0IMxKPNQ4j3dIvnt3
	WdNDwb+nsgZsagVpShUqdG1GtkIqyIRU9eDKTqmMgMfd0qg6g5RJ6x2A4F7LaEU+
	bBE58HC1p3gC9+UrQXF1orH+8iJFKbTG4OaOKSMi5HQHfIs9IJOho3d9vt81hTJR
	Dc9mYqHdi6sKaGp5JXub9qb//2joGM2PkU0sqq494ton1rR4lqV0rvTDknOWFu75
	s/Z0WKeI/1iHwKfuStbZveZhmHWNSaPOtMUJAP2p/jzHpPLundyr0Z+qX5Cpy7WL
	5ynEOqrDQUczfUowHp7uV64AAtjqKt0tk65SRGsYU68q1/1Kl0++hElhrPu0Yzfg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd40v3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:14:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651D9AYe006147;
	Mon, 1 Jun 2026 13:14:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jx8jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:14:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DEIho45482476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:14:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13D512004E;
	Mon,  1 Jun 2026 13:14:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8778C20040;
	Mon,  1 Jun 2026 13:14:17 +0000 (GMT)
Received: from [9.87.135.205] (unknown [9.87.135.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 13:14:17 +0000 (GMT)
Message-ID: <0b750cc2-ec15-43b3-a891-8499a7ed3a8d@linux.ibm.com>
Date: Mon, 1 Jun 2026 15:14:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
 <20260531190353.204317-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260531190353.204317-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzMSBTYWx0ZWRfX9XvYbnvHVS94
 qYDMB6B+yPA8q4LjG8bLC1CGZLrik97E7HyoCWIB/sq1JrFlQgvC3BEH2g6KOnbVknLMwWsn9ld
 9mnIzkBg5LtYmtJifYl0/H6NSRejIfxhiFq/njTq1zyigKlXJ3fa6K1K8dc9K2cVtHEXd05chpB
 yHsAkSjYeQXGgprdwUYn5j4siz9hzJkwThJh3sDQO0iqrKKJCxk40RwWkU4kV1Sp8DZmuPf7F9s
 sObxAz6uLh1QMmQXkxXgTw8ic1djcIsYJ7jHNvV7jN6BNYGGCW41b4Q/8svgao7wooG9BG3N3yC
 1MxBxbWC3u7zxUA78M2E4j+ImhDE306WFPJVTRDI5e8orrjAunAUft03C3ibt3S4klGkvhXonMa
 ZfO/TljnJXT2H+92I7p6n5uqrBeIY3ZXfFVoXEFvTzoZwFSssmeq2K/WHnp4BIq7dWMHZflnFID
 7VuBME1+wHzU65lsRKQ==
X-Proofpoint-GUID: tz-FROh_OgJ_-1UYBTQCeZxkzPzvT6mi
X-Proofpoint-ORIG-GUID: tz-FROh_OgJ_-1UYBTQCeZxkzPzvT6mi
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1d85af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=YGDvbCiNrxpiZYwF9RsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010131

On 5/31/26 21:03, Douglas Freimuth wrote:
> s390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> pin_user_pages_remote is used for both the ioctl as well
> as the pin-on-demand logic in adapter_indicators_set().
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
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |   5 +
>   arch/s390/kvm/interrupt.c        | 226 +++++++++++++++++++++++++------
>   arch/s390/kvm/kvm-s390.c         |   3 +
>   arch/s390/kvm/kvm-s390.h         |   2 +
>   4 files changed, 195 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8a4f4a39f7a2..0056cc9414a0 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -448,6 +448,8 @@ struct kvm_vcpu_arch {
>   struct kvm_vm_stat {
>   	struct kvm_vm_stat_generic generic;
>   	u64 inject_io;
> +	u64 io_390_adapter_map;
> +	u64 io_390_adapter_unmap;
>   	u64 inject_float_mchk;
>   	u64 inject_pfault_done;
>   	u64 inject_service_signal;
> @@ -479,6 +481,9 @@ struct s390_io_adapter {
>   	bool masked;
>   	bool swap;
>   	bool suppressible;
> +	spinlock_t maps_lock;
> +	struct list_head maps;
> +	unsigned int nr_maps;
>   };
>   
>   #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3bcdbbbb6891..5ad0b29c8c1b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2411,24 +2411,34 @@ static int register_io_adapter(struct kvm_device *dev,
>   {
>   	struct s390_io_adapter *adapter;
>   	struct kvm_s390_io_adapter adapter_info;
> +	int rc = 0;

Why do you even set it to 0 if you return 0 on the success case instead 
of return rc?

>   
> +	mutex_lock(&dev->kvm->lock);
>   	if (copy_from_user(&adapter_info,
> -			   (void __user *)attr->addr, sizeof(adapter_info)))
> -		return -EFAULT;
> -
> -	if (adapter_info.id >= MAX_S390_IO_ADAPTERS)
> -		return -EINVAL;
> -
> +			   (void __user *)attr->addr, sizeof(adapter_info))) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +	if (adapter_info.id >= MAX_S390_IO_ADAPTERS) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
>   	adapter_info.id = array_index_nospec(adapter_info.id,
>   					     MAX_S390_IO_ADAPTERS);
>   
> -	if (dev->kvm->arch.adapters[adapter_info.id] != NULL)
> -		return -EINVAL;
> -
> +	if (dev->kvm->arch.adapters[adapter_info.id] != NULL) {
> +		rc = -EINVAL;

You could move the rc assignment outside of the braces and have one less 
assignment. But if you like it more this way then keep it, I'm still 
able to read it :)

> +		goto out;
> +	}
>   	adapter = kzalloc_obj(*adapter, GFP_KERNEL_ACCOUNT);
> -	if (!adapter)
> -		return -ENOMEM;
> +	if (!adapter) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>   
> +	INIT_LIST_HEAD(&adapter->maps);
> +	spin_lock_init(&adapter->maps_lock);
> +	adapter->nr_maps = 0;
>   	adapter->id = adapter_info.id;
>   	adapter->isc = adapter_info.isc;
>   	adapter->maskable = adapter_info.maskable;
> @@ -2437,8 +2447,13 @@ static int register_io_adapter(struct kvm_device *dev,
>   	adapter->suppressible = (adapter_info.flags) &

Why the braces?

>   				KVM_S390_ADAPTER_SUPPRESSIBLE;
>   	dev->kvm->arch.adapters[adapter->id] = adapter;
> +	mutex_unlock(&dev->kvm->lock);
>   
>   	return 0;
> +
> +out:
> +	mutex_unlock(&dev->kvm->lock);
> +	return rc;

If you set rc to 0 you can actually have one return for all cases.

>   }
>   
>   int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
> @@ -2453,12 +2468,151 @@ int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked)
>   	return ret;
>   }
>   
