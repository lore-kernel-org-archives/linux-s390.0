Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C723FB7F2;
	Tue,  2 Jun 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421313; cv=none; b=NA/walP4OA6HZH+1xgWu8IwErx4UiASofwkdNqVXynvpRihcJcZlxleAtQ+F6IT7zjjyLxm2qJoq+mCYYZxhaGt3eoREWomIVsTM+xTtxXmlBndRKmqatvfqTB0IcO4+YaD0mPVwaPQm7h/AYtMdmxy5hCmlozxd6o+/dFPuNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421313; c=relaxed/simple;
	bh=quTmk+yhgZDdP+VT7D9Ykx364Wfuxc3to/UYCtPawbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByQh1UCoafQXMYaCFECT+e7Dq5Bkc1dohkCkS32QD2Cs8CITGvloAQUmlOaqDEvR77iI+xKdFw4rm0NN6kSEBIMQ295Ew0Pzoz8R8WDAXmGmir+rVJBIPaWo55PBLrOKyqzlq38JkdIsppq8/2ovZ1sK3FMRmsWWyYbO6XeCVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsbh948j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsbh948j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652GCotu1958209;
	Tue, 2 Jun 2026 17:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mw/ffO
	vS18Jv183JyoXXjvFnCD03OjDxbWuvRHhCez8=; b=fsbh948jkeWKv8zdgqLkeC
	eyqsweqXE5SkLEnOtpBKmkD7Gu2SDce0CXXB31ohg3y99JRt2iiadDgvd6roYhMQ
	GO2Xb/h/j6weYo8yvha3ZlIIakNalegyRkhKtPAbDzHKymyjAb+CM62g3YlKjncE
	E4Srgnuzk1D6YBCQFBWdleTusyyNT7N7VCkPpsnI+3hBoscMBGrxsKY8b4RSb6x7
	zCNTbnQ6GMK5SDQxqziOW9wduNdzT0r7TgRlYRupEWLd7ZPVZjI05bmSi1drRvf2
	EotVTV/i1Z57E+w5C9y9LkWJJJN2/U8cywXlRM3xxOtL5ZpspxcCbq2YTVl1haUQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4y4qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:28:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HOHEx003442;
	Tue, 2 Jun 2026 17:28:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyc21y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:28:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HSL9c25625110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:28:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD2C5803F;
	Tue,  2 Jun 2026 17:28:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAF205804E;
	Tue,  2 Jun 2026 17:28:20 +0000 (GMT)
Received: from [9.61.245.94] (unknown [9.61.245.94])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:28:20 +0000 (GMT)
Message-ID: <c2b1e66c-49fe-485e-8a8f-a6c9767c7050@linux.ibm.com>
Date: Tue, 2 Jun 2026 13:28:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Janosch Frank <frankja@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260531190353.204317-1-freimuth@linux.ibm.com>
 <20260531190353.204317-2-freimuth@linux.ibm.com>
 <0b750cc2-ec15-43b3-a891-8499a7ed3a8d@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <0b750cc2-ec15-43b3-a891-8499a7ed3a8d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fg-94Dl30YgHn8fUEsMqlc28Sp31Sq1a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NSBTYWx0ZWRfX05/5nkX8smG7
 u4pbzHmQHbAMeuORSNfokIfqsfRJ2CI2Lv2FEO0T5YG2i+yxpeFvFubW2OI79+73bel6o8HVTue
 mbeASqcf42MEfwjiPcPrHC87O3aSHKk04tejS+dhRx3hPZLM4BarTWZR2Ox/d1eiuFkj+LUYNuU
 yOTjutfxYRJXle0cznEZDRTCJTsffQLAC+qH/t30mMAXsyK5bqzebmmLFanL5OTWcN1S5aL6hHX
 fRPm4p5Fw0m8/Zu5tASlaxu9k2alrGaayzBdgARLHay8plNkchJ3+XqXl7d/usODbqCINO31mji
 ZeF6brFxkVay9wV8cg8IOyHak9x/lcK5hnQJPx8iLlJadt5SSPzva6nnV+NI//ZG00mQQic4EmU
 8D/05yPRUHbbKxROa//uFXLcDP4vL/EX8gy8zO/hjNTYjsb26lsW0YTcSdz/NATbmS0fw+hEsdL
 458R+ODE2zVSLrJimOw==
X-Proofpoint-ORIG-GUID: Fg-94Dl30YgHn8fUEsMqlc28Sp31Sq1a
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1f12b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=MY7Ma9usa9UWor5y58cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020165



On 6/1/26 9:14 AM, Janosch Frank wrote:
> On 5/31/26 21:03, Douglas Freimuth wrote:
>> s390 needs map/unmap ioctls, which map the adapter set
>> indicator pages, so the pages can be accessed when interrupts are
>> disabled. The mappings are cleaned up when the guest is removed.
>> pin_user_pages_remote is used for both the ioctl as well
>> as the pin-on-demand logic in adapter_indicators_set().
>>
>> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
>> in Secure Execution environments. In Secure Execution
>> environments the path of execution available before this patch is 
>> followed.
>>
>> Statistical counters to count map/unmap functions for adapter indicator
>> pages are added. The counters can be used to analyze
>> map/unmap functions in non-Secure Execution environments and similarly
>> can be used to analyze Secure Execution environments where the counters
>> will not be incremented as the adapter indicator pages are not mapped.
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |   5 +
>>   arch/s390/kvm/interrupt.c        | 226 +++++++++++++++++++++++++------
>>   arch/s390/kvm/kvm-s390.c         |   3 +
>>   arch/s390/kvm/kvm-s390.h         |   2 +
>>   4 files changed, 195 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/ 
>> kvm_host.h
>> index 8a4f4a39f7a2..0056cc9414a0 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -448,6 +448,8 @@ struct kvm_vcpu_arch {
>>   struct kvm_vm_stat {
>>       struct kvm_vm_stat_generic generic;
>>       u64 inject_io;
>> +    u64 io_390_adapter_map;
>> +    u64 io_390_adapter_unmap;
>>       u64 inject_float_mchk;
>>       u64 inject_pfault_done;
>>       u64 inject_service_signal;
>> @@ -479,6 +481,9 @@ struct s390_io_adapter {
>>       bool masked;
>>       bool swap;
>>       bool suppressible;
>> +    spinlock_t maps_lock;
>> +    struct list_head maps;
>> +    unsigned int nr_maps;
>>   };
>>   #define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 3bcdbbbb6891..5ad0b29c8c1b 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2411,24 +2411,34 @@ static int register_io_adapter(struct 
>> kvm_device *dev,
>>   {
>>       struct s390_io_adapter *adapter;
>>       struct kvm_s390_io_adapter adapter_info;
>> +    int rc = 0;
> 
> Why do you even set it to 0 if you return 0 on the success case instead 
> of return rc?

Janosch, thanks for your input. Agreed, I intend to use rc.>
>> +    mutex_lock(&dev->kvm->lock);
>>       if (copy_from_user(&adapter_info,
>> -               (void __user *)attr->addr, sizeof(adapter_info)))
>> -        return -EFAULT;
>> -
>> -    if (adapter_info.id >= MAX_S390_IO_ADAPTERS)
>> -        return -EINVAL;
>> -
>> +               (void __user *)attr->addr, sizeof(adapter_info))) {
>> +        rc = -EFAULT;
>> +        goto out;
>> +    }
>> +    if (adapter_info.id >= MAX_S390_IO_ADAPTERS) {
>> +        rc = -EINVAL;
>> +        goto out;
>> +    }
>>       adapter_info.id = array_index_nospec(adapter_info.id,
>>                            MAX_S390_IO_ADAPTERS);
>> -    if (dev->kvm->arch.adapters[adapter_info.id] != NULL)
>> -        return -EINVAL;
>> -
>> +    if (dev->kvm->arch.adapters[adapter_info.id] != NULL) {
>> +        rc = -EINVAL;
> 
> You could move the rc assignment outside of the braces and have one less 
> assignment. But if you like it more this way then keep it, I'm still 
> able to read it :)

I will leave the assignments inside the braces which will rarely, if 
ever, execute. And leave rc assigned as 0.

> 
>> +        goto out;
>> +    }
>>       adapter = kzalloc_obj(*adapter, GFP_KERNEL_ACCOUNT);
>> -    if (!adapter)
>> -        return -ENOMEM;
>> +    if (!adapter) {
>> +        rc = -ENOMEM;
>> +        goto out;
>> +    }
>> +    INIT_LIST_HEAD(&adapter->maps);
>> +    spin_lock_init(&adapter->maps_lock);
>> +    adapter->nr_maps = 0;
>>       adapter->id = adapter_info.id;
>>       adapter->isc = adapter_info.isc;
>>       adapter->maskable = adapter_info.maskable;
>> @@ -2437,8 +2447,13 @@ static int register_io_adapter(struct 
>> kvm_device *dev,
>>       adapter->suppressible = (adapter_info.flags) &
> 
> Why the braces?

That was existing code and not my change. But as a courtesy I will 
remove the braces to set it free.

> 
>>                   KVM_S390_ADAPTER_SUPPRESSIBLE;
>>       dev->kvm->arch.adapters[adapter->id] = adapter;
>> +    mutex_unlock(&dev->kvm->lock);
>>       return 0;
>> +
>> +out:
>> +    mutex_unlock(&dev->kvm->lock);
>> +    return rc;
> 
> If you set rc to 0 you can actually have one return for all cases.

Agreed, I will remove two lines before the label and let it fall through 
for one return for all cases.

> 
>>   }
>>   int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool 
>> masked)
>> @@ -2453,12 +2468,151 @@ int kvm_s390_mask_adapter(struct kvm *kvm, 
>> unsigned int id, bool masked)
>>       return ret;
>>   }

