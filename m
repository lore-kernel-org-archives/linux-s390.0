Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FB3043DC;
	Wed, 11 Mar 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260692; cv=none; b=bbdERLCcAGxixXuxoLGEwuo6gwXDqtuWib3Y2klzRy9oW8UBOIbLZjkJIOEqjd7nIuaiTYF+xLxZXuPx3Vk/+LS4pyUL22DjROi/FIC8hGt7dJ2NeMUkdRGtA/CwixMKJWUgeSTskiRrlgoAvBPxlPFSIvFoAMBfIHgWhyFahVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260692; c=relaxed/simple;
	bh=OZDjC1uCYwquj6LEjogkQwQlw/1E1JEum6n52cX/nxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hhSBGAbXpMT6f+QD6UD85hx0thmDH0oBVcZn1b950LYNTXNOtA5hzMU0go1p8ZTy5p7AoRbYLqKsrkPuaI8Z8iIm3CXtVAt7prYhwseBxk97rBPvo+jQWPh3QT7hq/zN+ZgDuMHp1xAP9ux0u/V0TG9Y2KoUlOhLOnkk/UWJiKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LUQkwkY9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LUQkwkY9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9Wowd336696;
	Wed, 11 Mar 2026 20:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g7VgYe
	JOt2tn3RxIgHi7avmGM75cDnoT06A+kgIWG2U=; b=LUQkwkY9OQELoe3MKXCFKL
	dTe0wncuGCg1TMu3VV/zCH//4N95VS2XMCzUJehlQwcRgE+wla2K3DJyxUQRoGZc
	xJDZDlxRK0rHD6j8kEmTqWovbKCeZXxKT3mFFpYrxyTkZTjvhQvPFoEtj93g22ya
	MHWldFe9NBehHT0A6Hk08jCHtGjLTAHM/rQ7epaPkM18aFo04LqQensBSHCe8/Xi
	zIOIvqQ5h+WfS/A8uUz9maFNk6vRRAXnt67oYoL6kl9CSb82OfwQSZmB3jfXTlk9
	mBLj8WGyqBe+Yoi8Q/ed+B7s36Z7/lKECxOH8UMAygyrpIgkJZOOYxdsCHQCNxVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywhu3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BGWN15023022;
	Wed, 11 Mar 2026 20:24:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng7ya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:24:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BKOkdm33358484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 20:24:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9D35804B;
	Wed, 11 Mar 2026 20:24:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB97D58059;
	Wed, 11 Mar 2026 20:24:44 +0000 (GMT)
Received: from [9.61.81.79] (unknown [9.61.81.79])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 20:24:44 +0000 (GMT)
Message-ID: <e0f9d530-c691-4d1f-ab82-33b5456fca9f@linux.ibm.com>
Date: Wed, 11 Mar 2026 16:24:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Introducing kvm_arch_set_irq_inatomic fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-4-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260308030438.88580-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3MCBTYWx0ZWRfX9vNCs1T6yJza
 i8suX73psxm3iOgekZ1eFfU4fSUw9WOXGS/BRGJOB1qgNU/BaA//B8LyIwR156Zcj+RBVqEV2I5
 noQMkJaaRMiW4fxuWJWnIOOh9p3ElUCxdGQMPawYD9FgujhuaxRDR67lpaCc7EpSrCP8q7wIqU4
 AgWwDj9HcAI3CmAaWkiqeulBli61HauhUFP0aoq/DXaJmr6sYox1weGp4C6xgXb/HG0o8f0syma
 SN95CeI98lXaK/xz9GFm1s+w9YwWMdBx/00CR8ASwJuMJShgVH0GRb5Rd7COssQ5Jxfinnd7iwR
 N22A3zNpy8bkQzX5EXyHpCwUodsDwBgQN3vHO8kcz5bDBMt2x1DU91JBjI6WM2lQEdjlLqjy7yF
 UxZ7Ac2mNhy8qR4tM93EmACMDIUa4C5Ux6xwRdvQeYyGA6up1aF81mUv7CqvCLCwvAJ7OSqxQwm
 Ykb5hI5Pj5w+oLhcK2g==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b1cf90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=uSkj2Dn4VTC6QYEr51sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Mpfu2zw87_matOxSNXo3AxquUo-FvMKp
X-Proofpoint-ORIG-GUID: Mpfu2zw87_matOxSNXo3AxquUo-FvMKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110170

On 3/7/26 10:04 PM, Douglas Freimuth wrote:
> Patch 3: This patch introduces kvm_arch_set_irq_inatomic, a fast path

See comments from patch 1 of this series.

> for irq injection. Instead of placing all interrupts on the global work
> queue as it does today, this patch provides a fast path for irq

Maybe add a bit that this depends on creating a path that cannot lose control, namely by pre-pinning the associated indicator pages, conditionally attempting allocations via GFP_ATOMIC and switching a mutex to a spinlock.

This would also be a good point to work in the fact that this is fenced for Secure Execution guests rather than patch 1 beacuse the indicator pages will not be pre-pinned.


> injection. Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic,
> io_flic_inject_airq, io_set_adapter_int and io_390_inatomic_adapter_masked.
> > In order to use this kernel series with virtio-pci, a QEMU that includes
> the 's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.
> Additionally, the guest xml needs a thread pool and threads explicitly
> assigned per disk device using the common way of defining threads for
> disks.

This last paragraph, while relevant to testing you were doing, delves a bit too much into the specifics of when QEMU will/won't drive this code and doesn't need to be in kernel git history.  I'd suggest either removing it or moving it to the cover-letter.

> 
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |   8 +-
>  arch/s390/kvm/interrupt.c        | 169 ++++++++++++++++++++++++++-----
>  arch/s390/kvm/kvm-s390.c         |  24 ++++-
>  arch/s390/kvm/kvm-s390.h         |   3 +-
>  4 files changed, 170 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 616be8ca4614..a194e9808ae3 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -359,7 +359,7 @@ struct kvm_s390_float_interrupt {
>  	struct kvm_s390_mchk_info mchk;
>  	struct kvm_s390_ext_info srv_signal;
>  	int last_sleep_cpu;
> -	struct mutex ais_lock;
> +	spinlock_t ais_lock;
>  	u8 simm;
>  	u8 nimm;
>  };
> @@ -450,6 +450,10 @@ struct kvm_vm_stat {
>  	u64 inject_io;
>  	u64 io_390_adapter_map;
>  	u64 io_390_adapter_unmap;
> +	u64 io_390_inatomic;
> +	u64 io_flic_inject_airq;
> +	u64 io_set_adapter_int;
> +	u64 io_390_inatomic_adapter_masked;
>  	u64 inject_float_mchk;
>  	u64 inject_pfault_done;
>  	u64 inject_service_signal;
> @@ -481,7 +485,7 @@ struct s390_io_adapter {
>  	bool masked;
>  	bool swap;
>  	bool suppressible;
> -	struct rw_semaphore maps_lock;
> +	spinlock_t maps_lock;

Patch 1 (re-)introduced the maps_lock, now you are converting it to a spinlock 2 patches later.

I realize that you were bringing back code that was previously removed by

f65470661f36 KVM: s390/interrupt: do not pin adapter interrupt pages

but for this series wouldn't it make sense to just start by introducing maps_lock as a spinlock from patch 1 vs re-introducing the semaphore for the span of 2 commits?



> @@ -2700,6 +2706,8 @@ static int flic_inject_airq(struct kvm *kvm, struct kvm_device_attr *attr)
>  	unsigned int id = attr->attr;
>  	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
>  
> +	kvm->stat.io_flic_inject_airq++;
> +

This just tracks how often the function is called, and includes instances where the adapter is NULL or the call to kvm_s390_inject_airq failed.

Do you want to actually track the number of successful injects only vs every time we call this routine?



> @@ -2919,15 +2968,15 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>  	int ret;
>  	struct s390_io_adapter *adapter;
>  
> +	kvm->stat.io_set_adapter_int++;
> +

Same comment, would we rather track only the successful cases or only count times we enter the function including things like the 0->1 transition below?

Actually, the addition of this counter as well as io_flic_inject_airq seems like it should be a separate patch.

>  	/* We're only interested in the 0->1 transition. */
>  	if (!level)
>  		return 0;

...

> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
> +			      struct kvm *kvm, int irq_source_id, int level,
> +			      bool line_status)
> +{
> +	int ret;
> +	struct s390_io_adapter *adapter;
> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> +	struct kvm_s390_interrupt_info *inti;
> +	struct kvm_s390_interrupt s390int = {
> +			.type = KVM_S390_INT_IO(1, 0, 0, 0),
> +			.parm = 0,
> +	};
> +
> +	kvm->stat.io_390_inatomic++;

Is this the right time to increment this value?  There are plenty of reasons we could -EWOULDBLOCK after this point and fall back to scheduling it.

So this will only count how often we call here from irqfd_wakeup() and not how often we actually successfully make it thru the inatomic operation.

> +
> +	/* We're only interested in the 0->1 transition. */
> +	if (!level)
> +		return -EWOULDBLOCK;
> +	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
> +		return -EWOULDBLOCK;
> +
> +	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
> +	if (!adapter)
> +		return -EWOULDBLOCK;
> +
> +	s390int.parm64 = isc_to_int_word(adapter->isc);
> +	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter);
> +	if (ret < 0)
> +		return -EWOULDBLOCK;

We know for sure that a guest that is running in SE will always hit this because no mappings will be available. 
Did you test if it would be more efficient to check the kvm for SE at the start of kvm_arch_set_irq_inatomic() and immediately return -EWOULDBLOCK there?

> +	if (!ret || adapter->masked) {
> +		kvm->stat.io_390_inatomic_adapter_masked++;
> +		return 0;
> +	}
> +
> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
> +	if (!inti)
> +		return -EWOULDBLOCK;
> +
> +	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
> +		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
> +			if (ret == 0)

This to me seems like the right spot to kvm->stat.io_390_inatomic++ unless I misunderstand the intent of the counter.



