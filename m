Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03447357D0B;
	Fri, 22 May 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471891; cv=none; b=uHFnUO5tLfDjwd2IrSBwnQgeFJ61p30vGEl1ptkwynRdgqDopw6H+VTZIftjQyqjcmZKQqpIwkbjsp5rpgBEwZd5cGAFyEn3fqkzDYbKoQn41ZywLUEWsOoQ7sIhCQS86iTZChxK4zrnJipBwi2KiBDluKESCo160taRzi8TQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471891; c=relaxed/simple;
	bh=7TUyfPrpp32uutuA5LoMpJSTWZJfXb6Z9pcKEovY8TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pZenk3VBGV6JItgcooQtlDce31S6da3DAPAyxiiQovdeM6Mxxr+Tj6q0puP7+KI+qZbl8w7ZtXuj/wqhZeclf/u3yaToaP5W/xS6bbU8sOTNdz9NeKePDiEDSbcTi5qeQjJEeRTdLOITyrvVl54fMeTQf2RQSwQnBcZP9owKj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGR61p98; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGR61p98"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8YlZP4037410;
	Fri, 22 May 2026 17:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qwML4z
	xSsWLDzmLkGPtHDKwj8k5qoLmLMRq7lEngIug=; b=RGR61p980AQv8ATcyYMHpP
	Z7sNzlSw08LeQhZsaP614tRnVSpxEMeiO3rYrQrNE8sTBAHLz9RgwFvARIZMbyji
	Pwsm4NsXMMbZgO++KygsimksuiZhzKr5TN4qDpgrHDkO4BaL7ljLLZjOpWyoVWjK
	e4vs47nnogcyaWeJ/UEOoZkRXtYvSPW0qf/gdMZvFp6bgAOeRgva2tThKUQGNpPY
	1H/6V/KTN9B4zcCsbBuuJ2+TEUm5h+ap6eeLH6hD45BE1la2Upiplwp4PpfXtsZJ
	QaZGK4kOpi/fakeHS4dldWtnIHdQWHoSb1oBxSrhsrbbXPp1ZL2xioSFQ7WVCy1A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75d5cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:44:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MHd9xo031698;
	Fri, 22 May 2026 17:44:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyhntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:44:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MHij8w35848724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 17:44:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71EB258043;
	Fri, 22 May 2026 17:44:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE3D58053;
	Fri, 22 May 2026 17:44:44 +0000 (GMT)
Received: from [9.61.48.218] (unknown [9.61.48.218])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 17:44:44 +0000 (GMT)
Message-ID: <8d270932-986b-4978-9615-6d5a614148d0@linux.ibm.com>
Date: Fri, 22 May 2026 13:44:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260520160442.1051999-1-freimuth@linux.ibm.com>
 <20260520160442.1051999-4-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260520160442.1051999-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a10960f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=22TEs9BJkDR8V0ZWFCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wTR_Tu23wCZ5dy1iEZ2-P7fyCHqHpw8M
X-Proofpoint-GUID: wTR_Tu23wCZ5dy1iEZ2-P7fyCHqHpw8M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NiBTYWx0ZWRfX/g/QqSxZ66XG
 NOJTCOgptWnqXuycVVvpHvw5VGOgvHlD0BR4FeV43BiztM98QSHvlFpKriYagXE/5EvDOKNDu/p
 n+ita0zpGcEq6eLKAhFNEu7DvpdnDnVQzLcmGULe4pgWHF3pJS5S+ZpnHOBXLG/9YnESQO6JxOC
 9hUfcqIfZvHYTkF6YjruXLnh8+aXVEchMDRBGnSc3LCizT4YgfNm6Dfec1YwBKaHhwbUeM49uns
 RcKXZtdRAv+AbK3OpJhpQBO43dNun5GgYvaLZfibFYCYQ7qem6mJsvwozLcwGh1ruN0ioe9kqvp
 Fkl166y0FkCnoK6WTNyQKa3/xoVcrBBlWF6kPMmb+f3p7LyXCftg04Q25HLd/2Qg7HGVz6AA2U3
 agV3/8MOMuUWz2Juf+DTXfzNC/4DTR3J3YJNs19VRJUYn7rtwASpZOZugLWKqi7hiXeSAuLJ02M
 w2cjxAhRlMdrHmbtc6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220176

On 5/20/26 12:04 PM, Douglas Freimuth wrote:
> s390 needs a fast path for irq injection, and along those lines we
> introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> the global work queue as it does today, this patch provides a fast path for
> irq injection.
> 
> The inatomic fast path cannot lose control since it is running with
> interrupts disabled. This meant making the following changes that exist on
> the slow path today. First, the adapter_indicators page needs to be mapped
> since it is accessed with interrupts disabled, so we added map/unmap
> functions. Second, access to shared resources between the fast and slow
> paths needed to be changed from mutex and semaphores to spin_lock's.
> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> these enhancements were required to prevent blocking on the fast inject
> path.
> 
> Fencing of Fast Inject in Secure Execution environments is enabled in the
> patch series by not mapping adapter indicator pages. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> io_set_adapter_int and io_390_inatomic_adapter_masked.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>

[...]

>  int kvm_s390_inject_vm(struct kvm *kvm,
> -		       struct kvm_s390_interrupt *s390int)
> +		       struct kvm_s390_interrupt *s390int, struct kvm_s390_interrupt_info *inti)
>  {
> -	struct kvm_s390_interrupt_info *inti;
>  	int rc;
>  
> -	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
> -	if (!inti)
> -		return -ENOMEM;
> -
>  	inti->type = s390int->type;
>  	switch (inti->type) {
>  	case KVM_S390_INT_VIRTIO:
> @@ -2010,8 +2005,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
>  				 2);
>  
>  	rc = __inject_vm(kvm, inti);
> -	if (rc)
> -		kfree(inti);

You removed this kfree, but there's still one in the default case
above.  Remove that as well so the caller is always responsible for
both allocating and freeing the kvm_s390_interrupt_info.  

This appears to match the Sashiko complaint about a double-free, but
you want to fix it here -- not at the individual caller(s).

> +
>  	return rc;
>  }
>  

[...]

> +
> +/*
> + * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
> + */
> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
> +			      struct kvm *kvm, int irq_source_id, int level,
> +			      bool line_status)
> +{
> +	int ret, setbit;
> +	struct s390_io_adapter *adapter;
> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> +	struct kvm_s390_interrupt_info *inti;
> +	struct kvm_s390_interrupt s390int = {
> +			.type = KVM_S390_INT_IO(1, 0, 0, 0),
> +			.parm = 0,
> +	};
> +
> +	kvm->stat.io_390_inatomic++;
> +
> +	/* We're only interested in the 0->1 transition. */
> +	if (!level)
> +		return -EWOULDBLOCK;

Sashiko makes a good point here; if we -EWOULDBLOCK, it's just going to
fall back to the irqfd_inject path which will drive set_adapter_int()
which will always return 0 due to the same !level check.

So while functionally it's not harmful, it would be an optimization to
simply return 0 here.  Please test it out.

> +	if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
> +		return -EWOULDBLOCK;
> +
> +	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
> +	if (!adapter)
> +		return -EWOULDBLOCK;
> +
> +	s390int.parm64 = isc_to_int_word(adapter->isc);
> +	setbit = 1;
> +	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +	if (ret < 0)
> +		return -EWOULDBLOCK;
> +	if (!ret || adapter->masked) {

Sashiko made me double-check your work here.  AFAICT this is correct:

Let's compare it to set_adapter_int(), where we inject only if

if ((ret > 0) && !adapter->masked) {
	ret = kvm_s390_inject_airq(kvm, adapter);

Here we are trying to decide whether to NOT inject, so invert it:
 
if (ret <= 0 || adapter->masked)

and you already checked ret < 0 above, so:

if (ret == 0 || adapter->masked)
or
if (!ret || adapter->masked)

I guess it's more a question of whether you want to consider masked
interrupts (adapter->masked) as a different counter than coalesced
interrupts (!ret).  I'm not sure we care that much to track this
distinction, but I think the sum counter is still valuable; it's how
many times times we delivered interrupts in atomic without actually
injecting the adapter interrupt.  (Actually, not quite true, see below)

All of this is a long-winded way of saying 'maybe you should rename
the counter to more-accurately describe what you're counting'.
And don't forget to update the commit message.

> +		kvm->stat.io_390_inatomic_adapter_masked++;
> +		return 0;
> +	}
> +
> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
> +	if (!inti) {
> +		setbit = 0;
> +		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +		return -EWOULDBLOCK;
> +	}
> +
> +	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {

Please look into the sashiko reports re: irqsave and the fi->lock.

> +		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
> +		if (ret == 0) {
> +			return ret;
> +		} else {
> +			setbit = 0;
> +			adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +			kfree(inti);
> +			return -EWOULDBLOCK;
> +		}
> +	}
> +
> +	spin_lock(&fi->ais_lock);
> +	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
> +		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
> +		spin_unlock(&fi->ais_lock);
> +		kfree(inti);

Actually, about that comment above re: io_390_inatomic_adapter_masked..
Here is another place where we set the indicators without injecting an
adapter interrupt.  Now due to adapter interrupt suppression.

If you want that counter to include all 3 (coalesced, masked, and
suppressed) then you should increment it here as well after you rename
it.

> +		return 0;
> +	}
