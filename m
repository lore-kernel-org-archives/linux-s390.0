Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C8349B0D;
	Wed, 29 Apr 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479100; cv=none; b=WasfeXRg7X1VGCF0soZcWPqEX6FAaHFoCrUlk8IHZSZxttXeOLrs2B0ki+es/xx5s5DoYMXjfO4Qe8eueA/XIS04iDClUb4vFyi56W1FtIWG4wca5K38kPJ8lU5DF7uWtXeyPGXi0npLiYbsvWzJidYP3ZBC7dvCjfVhb9Y1M1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479100; c=relaxed/simple;
	bh=k++l3WtLFBko4f56l2wRpN2TjenMI0cWBCrk3PWqaYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hKunpsg4bsZU2EHoFyKfGOHtKL5X88TM0ge28M8idvuTUOoDo5xI77LkQjBvZ1g9dClce+FGoX6Cnmlelig+PlVyg0Pcd2+1cp4b/AWNnG2E5Xr/YYqV2gsbr7Q5vtnk6BAjUFXtjMBYi/zingVkcvJCY8cHQjXaLKDBnOX4zEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tb/V+b45; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tb/V+b45"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TAk1dI2888876;
	Wed, 29 Apr 2026 16:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fTqOyx
	iaJok5OwQ/9OwcV0+As566moPHGf+m7xxSUxg=; b=tb/V+b455H7GL3THSdmrYU
	ui42yBMWW91QJjejeGBkMSh34DDPGfMgRCAXCDo8zYlkOsTCGo5mUZeOZKV/Rcl1
	MkFHsKm9yVQZY+v1ZtLzuL/OkvBFMpAm54KZNpVnMyoEI3vjtOvzy7p2P3AT3YYy
	Cojqr+K7sRqIPWWZO5NN/t38MSOy0V92m1EvcMyp8d7MCa5YswfaZrIF4jqf3A1O
	GI3vF9dBt1mj6COlH7t9vJkFw5lTUV+aP78uqvdr61Glly4+sxI3rIsZ8eBr0bQt
	YM24crKsGOLL+1IZh0zIOfm2w6vR8cDDqcMsK47552zBVnLmMm66MhW7VeODJGNw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5bdjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:11:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TG8mkd030925;
	Wed, 29 Apr 2026 16:11:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avy3xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:11:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TGBRdd27918920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 16:11:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B734258058;
	Wed, 29 Apr 2026 16:11:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F3A58057;
	Wed, 29 Apr 2026 16:11:26 +0000 (GMT)
Received: from [9.61.22.161] (unknown [9.61.22.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 16:11:26 +0000 (GMT)
Message-ID: <cff05849-c937-4611-8776-d654e225e5cc@linux.ibm.com>
Date: Wed, 29 Apr 2026 12:11:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-4-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260423235316.3665-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f22db2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=rgTvcgvkiA0iA1z48PgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1OSBTYWx0ZWRfXysm9mzuzQRMh
 J0lv2s1i6Js2i20F5v+3/vJSplERpofOxFHXXl3Ksq+zOA3Hk4v8OVMfLKlOLb8zDg8bYvfBe1h
 m4AuLLcEfjRl27jqH8kpT9H4X9GkVmBDS2H1mKinn5Uv1rPfcCYslw1WFb13ZOv9XTchrPfCLxT
 9fLAZY44qKIcJE20W39pY5gVgxuvhhe9oiqxFm+auNxkRY1nOjnO06CwafVTSxCCyJhmeR4NqGk
 QRmK2JloWelkuaZD2yQGW6IrUz8AnirtaCtFyc1SEbU1AsNZIRu7I7jY3QzwS4FrKnb6BhYupPm
 pvQSJ3HTxKNtzpLE+MNu/NHLJkJVAUTKu9nB4LfWiV4kikgAUjkK1QK0L1gMuWNuuUrqje2oJfj
 z0R/5eDhyV7Q8k9cgbkw6AIOeFWSvylgkb92I5PxDbYmoQpRKKSrSg897bn0Tbm4PYGhgtQuue1
 QVOAIcOoFrCt+DVdlDw==
X-Proofpoint-GUID: 3YZrjGJhd0CNv_5puPZxiw2zESPCLgb-
X-Proofpoint-ORIG-GUID: 3YZrjGJhd0CNv_5puPZxiw2zESPCLgb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290159


> +static int adapter_indicators_set_fast(struct kvm *kvm,
> +				       struct s390_io_adapter *adapter,
> +				       struct kvm_s390_adapter_int *adapter_int,
> +				       int setbit)
> +{
> +	unsigned long bit;
> +	int summary_set;
> +	struct s390_map_info *ind_info, *summary_info;
> +	void *map;
> +
> +	raw_spin_lock(&adapter->maps_lock);
> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		raw_spin_unlock(&adapter->maps_lock);
> +		return -EWOULDBLOCK;
> +	}
> +	map = page_address(ind_info->page);
> +	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> +	if (setbit)
> +		set_bit(bit, map);
> +	else
> +		clear_bit(bit, map);

Hmm, I don't know about this.  In my comment on v2 I was only concerned
about undoing the setting of the summary indicator as that will be used
on the slow path to decide whether or not we need to inject an interrupt
in addition to setting the indicator bits.

I think we should drop the else clear_bit() here.  If _fast already set
it and we are now backing out to the slow path, then it will stay on all
the way through the slow path and that should be OK.

> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		raw_spin_unlock(&adapter->maps_lock);
> +		return -EWOULDBLOCK;
> +	}
> +	map = page_address(summary_info->page);
> +	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +			  adapter->swap);
> +	if (setbit)
> +		summary_set = test_and_set_bit(bit, map);
> +	else
> +		summary_set = test_and_clear_bit(bit, map);

I had to go back and refresh myself about WHY we needed to 'undo' our
prior setting of the summary bit specifically.

The reason is that, if we need to fall back to the slow path, that code
will see the summary bit already on and therefore not inject an
interrupt believing that the thread that initially set the summary bit
did that.  But, if we fell back from the _fast path via -EWOULDBLOCK
after setting the summary indicator, no interrupt was ever injected at
that time.

So my point: this _really_ deserves some comment blocks describing the
purpose of setbit + a specific statement that it's OK to clear this
summary bit now when setbit=0 but then the caller must re-drive this
summary indication again via adapter_indicators_set().

[...]

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
> +		kvm->stat.io_390_inatomic_adapter_masked++;
> +		return 0;
> +	}
> +
> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
> +	if (!inti)

You need to undo the summary bit indication on this path as well.

[...]

> -static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> -				      unsigned long token)
> +static int __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> +				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;
>  	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt_info *inti_mem = NULL;
>  
>  	if (start_token) {
>  		irq.u.ext.ext_params2 = token;
>  		irq.type = KVM_S390_INT_PFAULT_INIT;
>  		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
>  	} else {
> +		inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
> +		if (!inti_mem)
> +			return -ENOMEM;

To match the other nonzero cases here, rather than making
__kvm_inject_pfault_token() return a value can you leave it a void
return and then just do something like:

if (WARN_ON_ONCE(!inti_mem))
	return;


