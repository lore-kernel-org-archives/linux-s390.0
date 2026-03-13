Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408031E820;
	Fri, 13 Mar 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410476; cv=none; b=UBl5oZ7I3q391D+xLnmiziEawerY/D/sQjLzLjJfEjAMo6UWaGxuJmpukz857VIH7ZCONWb2WAuoVcFWkK5jukthCIF+Z/ypHrkHfu0M78EZ6eowgrELaa482+EBkW8HfgZ4mlLEudsK7Pf7D4HuHWzmHwXEcBP7wnvKUuUmI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410476; c=relaxed/simple;
	bh=X/J2wrOcaMI/yebCXJsMRvgnvRptHiwqZcTlSCpJw6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GKXtZuZybbk5ewPgpHTBMVrOrDrzF13s6eHu4jMQYICILvQ10TlYpXmmYrz83d6lGkBC57FFBiXhAM6o+KoYu+XHqhWoX2AQ26zs+lN7r5GRYpd53JKmPfocTcdB3sdK9Vf1pPKGC0Sg7SuOhdD5vUyUM5y6YrEEUPJI2GUA6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7BsCLaQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7BsCLaQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4rE7H2306385;
	Fri, 13 Mar 2026 14:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dthJ5h
	yq2dIcnhNufEe8T9ANkUShPobDK+VjHvNuWdY=; b=N7BsCLaQdvB35ehUfwj4ng
	S0LvCoPLrkgwIXVKfIv5ir2b2/EowIQpZz2BJM6qX46J/O+XPVDXJWfJ6QD77ABj
	vP8KixjDiBeCC+onCTetDweOMGK9EAUezj+41+4nSHFYvquutJ19yd3u235zlb4y
	sVIRyGj+7hUltGFcEucaxmtcfrbVOJcDsDNulZNwfYsH0SSmiGY/8SE02Lc3PwA/
	yD0tcb58vVIKjKSAYBd3MJUT3gRHEAfYqsU2lvAIO7yRMw4dro3GetxeSzFBN2/6
	1ck7yml88t4y+++2p5RnfnBsiQtxYDUGpPMfQqcakJgC+uA0H/czpGRXTVY9575A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96fun7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:01:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAR5HU020811;
	Fri, 13 Mar 2026 14:01:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pw2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:01:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DE19Fh31654614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:01:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8E258059;
	Fri, 13 Mar 2026 14:01:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E9E58061;
	Fri, 13 Mar 2026 14:01:08 +0000 (GMT)
Received: from [9.61.247.193] (unknown [9.61.247.193])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:01:08 +0000 (GMT)
Message-ID: <2116b7d0-0cbf-4337-823d-986d0521982b@linux.ibm.com>
Date: Fri, 13 Mar 2026 10:01:07 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Introducing kvm_arch_set_irq_inatomic fast inject
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-4-freimuth@linux.ibm.com>
 <e0f9d530-c691-4d1f-ab82-33b5456fca9f@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <e0f9d530-c691-4d1f-ab82-33b5456fca9f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwNyBTYWx0ZWRfX1zhnqoChRsj7
 vHfLOhS//KlMbB/Kh4gyYax40i4eCiao+fyjv63OZx2NnU/5NqJpG8ReLjLxl/ooGz7yB8m1oaq
 8xTQLSEr9dcQsaeTtfjmtcuN/EjPFiwxNnYBIOG4uxohv0oCwTZTaCMcUngPk4Fn3qbMJ9doea0
 aUwMu7l+g/pMD014CdTac5KZIglSKp6ep6R80vpSvD5YwSoMzPR9l8WI8Ak4wRg6y5cKOzIyaVC
 3I1aS2ZUZzvdJzfXX4Z822RQ4iZKSYUxODuit/d0K3IQ6r+oV4uCS3R1cWHKA7+ju7U0R1fs79I
 C7G0EL8wWHu5Bi0kmfSa1wJs87llBmNb37hyfIPRiAdPdGdJHARiYmyLONcRE83wgJlAJkBhPlp
 ecnEXfxzjJpyVrABSMjaKzXyjJpdwvlHniguH+QW4LnMtBPa+cIKSM4IBUMzZCZzp6fPjHeQcsf
 bKdLYbMZvUaZFhLTe6g==
X-Proofpoint-ORIG-GUID: ykTQMAaC6QMgXfhjj8wdPNmvU4S9nHrm
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b418a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=dmKg382LtvCrSBsgsQ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ykTQMAaC6QMgXfhjj8wdPNmvU4S9nHrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130107



On 3/11/26 4:24 PM, Matthew Rosato wrote:
> On 3/7/26 10:04 PM, Douglas Freimuth wrote:
>> Patch 3: This patch introduces kvm_arch_set_irq_inatomic, a fast path
> 
> See comments from patch 1 of this series.
> 
>> for irq injection. Instead of placing all interrupts on the global work
>> queue as it does today, this patch provides a fast path for irq
> 
> Maybe add a bit that this depends on creating a path that cannot lose control, namely by pre-pinning the associated indicator pages, conditionally attempting allocations via GFP_ATOMIC and switching a mutex to a spinlock.
> 
> This would also be a good point to work in the fact that this is fenced for Secure Execution guests rather than patch 1 beacuse the indicator pages will not be pre-pinned.
> 
> 
>> injection. Statistical counters have been added to enable analysis of irq injection on
>> the fast path and slow path including io_390_inatomic,
>> io_flic_inject_airq, io_set_adapter_int and io_390_inatomic_adapter_masked.
>>> In order to use this kernel series with virtio-pci, a QEMU that includes
>> the 's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.
>> Additionally, the guest xml needs a thread pool and threads explicitly
>> assigned per disk device using the common way of defining threads for
>> disks.
> 
> This last paragraph, while relevant to testing you were doing, delves a bit too much into the specifics of when QEMU will/won't drive this code and doesn't need to be in kernel git history.  I'd suggest either removing it or moving it to the cover-letter.
> 
>>
>>
>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |   8 +-
>>   arch/s390/kvm/interrupt.c        | 169 ++++++++++++++++++++++++++-----
>>   arch/s390/kvm/kvm-s390.c         |  24 ++++-
>>   arch/s390/kvm/kvm-s390.h         |   3 +-
>>   4 files changed, 170 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 616be8ca4614..a194e9808ae3 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -359,7 +359,7 @@ struct kvm_s390_float_interrupt {
>>   	struct kvm_s390_mchk_info mchk;
>>   	struct kvm_s390_ext_info srv_signal;
>>   	int last_sleep_cpu;
>> -	struct mutex ais_lock;
>> +	spinlock_t ais_lock;
>>   	u8 simm;
>>   	u8 nimm;
>>   };
>> @@ -450,6 +450,10 @@ struct kvm_vm_stat {
>>   	u64 inject_io;
>>   	u64 io_390_adapter_map;
>>   	u64 io_390_adapter_unmap;
>> +	u64 io_390_inatomic;
>> +	u64 io_flic_inject_airq;
>> +	u64 io_set_adapter_int;
>> +	u64 io_390_inatomic_adapter_masked;
>>   	u64 inject_float_mchk;
>>   	u64 inject_pfault_done;
>>   	u64 inject_service_signal;
>> @@ -481,7 +485,7 @@ struct s390_io_adapter {
>>   	bool masked;
>>   	bool swap;
>>   	bool suppressible;
>> -	struct rw_semaphore maps_lock;
>> +	spinlock_t maps_lock;
> 
> Patch 1 (re-)introduced the maps_lock, now you are converting it to a spinlock 2 patches later.
> 
> I realize that you were bringing back code that was previously removed by
> 
> f65470661f36 KVM: s390/interrupt: do not pin adapter interrupt pages
> 
> but for this series wouldn't it make sense to just start by introducing maps_lock as a spinlock from patch 1 vs re-introducing the semaphore for the span of 2 commits?
> 

Matt, thank you for your input. The policy of individual patches not 
only compiling but having individual utility and standing on their own 
applies here. In patches 1 and 2 the maps_lock is more flexible as a 
semaphore providing utility for the patch. While in patch 3 the 
maps_lock has to be a spin_lock so inatomic can use it with interrupts 
disabled.
> 
> 
>> @@ -2700,6 +2706,8 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
>>   	unsigned int id = attr->attr;
>>   	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>>   
>> +	kvm->stat.io_flic_inject_airq++;
>> +
> 
> This just tracks how often the function is called, and includes instances where the adapter is NULL or the call to kvm_s390_inject_airq failed.
> 
> Do you want to actually track the number of successful injects only vs every time we call this routine?
> 

This response applies to all of the following comments about counters 
including this one. At this stage I do want to focus on the statistics 
for the number of times we enter the top of the relevant functions. For 
example, if we put the counter at the bottom of flic_inject_airq or 
kvm_arch_set_irq_inatomic, it will be silent in cases of a failed 
conditional. On failure of inatomic we would only see the flic counter 
going up which could be misleading. The current counter placement 
informs the correct path of execution is being taken, and the volume, 
which is valuable for initial deployments so we know the system is being 
configured correctly and provides performance insights. We expect to see 
a performance improvement with inatomic fast inject. If the system 
performance doesn't improve when it is deployed the first thing to check 
is the volume of each of these counters. As we observe steady state 
usage behavior in the field we could then consider a different focus of 
the counters.

> 
> 
>> @@ -2919,15 +2968,15 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>>   	int ret;
>>   	struct s390_io_adapter *adapter;
>>   
>> +	kvm->stat.io_set_adapter_int++;
>> +
> 
> Same comment, would we rather track only the successful cases or only count times we enter the function including things like the 0->1 transition below?
> 
> Actually, the addition of this counter as well as io_flic_inject_airq seems like it should be a separate patch.
> 
>>   	/* We're only interested in the 0->1 transition. */
>>   	if (!level)
>>   		return 0;
> 
> ...
> 
>> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
>> +			      struct kvm *kvm, int irq_source_id, int level,
>> +			      bool line_status)
>> +{
>> +	int ret;
>> +	struct s390_io_adapter *adapter;
>> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
>> +	struct kvm_s390_interrupt_info *inti;
>> +	struct kvm_s390_interrupt s390int = {
>> +			.type = KVM_S390_INT_IO(1, 0, 0, 0),
>> +			.parm = 0,
>> +	};
>> +
>> +	kvm->stat.io_390_inatomic++;
> 
> Is this the right time to increment this value?  There are plenty of reasons we could -EWOULDBLOCK after this point and fall back to scheduling it.
> 
> So this will only count how often we call here from irqfd_wakeup() and not how often we actually successfully make it thru the inatomic operation.
> 
>> +
>> +	/* We're only interested in the 0->1 transition. */
>> +	if (!level)
>> +		return -EWOULDBLOCK;
>> +	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
>> +		return -EWOULDBLOCK;
>> +
>> +	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
>> +	if (!adapter)
>> +		return -EWOULDBLOCK;
>> +
>> +	s390int.parm64 = isc_to_int_word(adapter->isc);
>> +	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter);
>> +	if (ret < 0)
>> +		return -EWOULDBLOCK;
> 
> We know for sure that a guest that is running in SE will always hit this because no mappings will be available.
> Did you test if it would be more efficient to check the kvm for SE at the start of kvm_arch_set_irq_inatomic() and immediately return -EWOULDBLOCK there?
> 

It might be slightly more efficient in SE environments to immediately 
return -EWOULDBLOCK at the start of kvm_arch_set_irq_inatomic. But the 
change would be fairly broad since it would require changing the mutex 
for kvm->lock to a spin_lock to allow checking if pv is present with 
interrupts disabled. I would recommend this for a follow-on if behavior 
in the field requires it.


>> +	if (!ret || adapter->masked) {
>> +		kvm->stat.io_390_inatomic_adapter_masked++;
>> +		return 0;
>> +	}
>> +
>> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
>> +	if (!inti)
>> +		return -EWOULDBLOCK;
>> +
>> +	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
>> +		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
>> +			if (ret == 0)
> 
> This to me seems like the right spot to kvm->stat.io_390_inatomic++ unless I misunderstand the intent of the counter.
> 
> 
> 

