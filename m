Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB663DA5D0;
	Mon,  4 May 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900912; cv=none; b=H1OJsy8w4oveUHel527xGXrwvCpGP8UxQhCLpLSYG1+SDXr63JhtlhgeVkLnkZsxMtWka62dVKOsuJi85ubTm0JviFrwdWxDIbgJb7tgtcv8O99QMuilML9i3Dh98jo5d352ns1sDSmKNWtWa6ZirWeG9HQTkpd+McqDq+kGgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900912; c=relaxed/simple;
	bh=biMAPF9fOcMsiRcCnpPvLQVXNxKFkBM5cBJBdb8yLks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TwvXHbue8vaUAKJY3Zv/ePCadaUixMVK5j7zaIvtEJetdXEWc+y7+K1/BZ0qpM84KeW0XkP9SB98dzP0KSl4Wo2mEHVszKVWIyX6Z1ReSzr6ryHlZOZQtb3MAAyV+O8IdNq0qckzGdTrED70eYhYxAm8SNGR3b6cqig4tAUUSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tHVU3DYn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tHVU3DYn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6441OEBc3001038;
	Mon, 4 May 2026 13:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n6wWw/
	jT8ws/SY2mdFoFGFXcVbbITQEd09PZLAZnnWg=; b=tHVU3DYnx7QyLiDGCv3bLV
	orK2SeiZl7GcqJaHBIbptF4vgAp6nfXgUKmxjW3EXkeNIuv3LAUW8P5uOr0ABNwA
	OHFIb47B5sT5+5i9toqjljyrLDrTYRzx6I7sUdvV3fDEypUQiqDlw0aXCq3nMsWB
	bdq2+hWBNp2T34dxNKjI6Ef9MBi3M5bwBI8dIz2UV4e/RgJR/iXtaqktCEXgo/e/
	i1CZjlkpB/yDBfnTyuNrvG9FEZVp5Vng/HE70ellhTQavDqXlZuBZEdYq1BNlYOD
	7jGhOJkmqJSaLy5jPU4m3TrITwou0TrEYezUI8KETPbfXHeCC+0ljyoPP/dcn3XA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4expw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 13:21:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644D9Vas002580;
	Mon, 4 May 2026 13:21:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq5djs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 13:21:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644DLjUc64356712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 13:21:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7164458056;
	Mon,  4 May 2026 13:21:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD2E58052;
	Mon,  4 May 2026 13:21:44 +0000 (GMT)
Received: from [9.61.249.171] (unknown [9.61.249.171])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 13:21:44 +0000 (GMT)
Message-ID: <b81184c5-484b-4c69-a029-104ba37127fb@linux.ibm.com>
Date: Mon, 4 May 2026 09:21:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
 <20260423235316.3665-4-freimuth@linux.ibm.com>
 <cff05849-c937-4611-8776-d654e225e5cc@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <cff05849-c937-4611-8776-d654e225e5cc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzOSBTYWx0ZWRfXwl3Ja3E4JkJE
 ts/RyNaDYV65SuBNrtiy6V5eqqug+L4TIwbnuhG3CGoXht6rAwfgbiw9+1wpzbG20CbMVdsFf3v
 eeVvTzkCaXwGkUoZN/zP6px2l59WgbBGp+alz05H3Had8z4in+r+KlXzKR7R8nLZUMWfk4nuVtX
 UcgqX7SjJpUBWBaY/PA5XCn0fkNahi+Agz+iZewbgI72Yfj3VHk4Ac13aF4Iw2BPnNQLw2n/mcC
 WVYmjH0Qd9bzvZBhpMpPFT3jrVoLgRxtcN9WI35a8Z4NESECJ/JBO84X6R6HCYqfoHDtmoWK2Mp
 PGX8MvLIPwkIWoKwpfAXJ30OfHbWIg39HBMgzSVHbA9Os/yCiab2nMcjruvBBtnSVf0lLgI43Uv
 yv0oooOVUf32fNaKzGKbe3CdVDxSt73qn6mahaIYPplkaJvM35itUIKm3JHA3qh8ZaUs0owPyDf
 16P7lap4uP3+qqFk55Q==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f89d6b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=YQMYpVfbA9vLAZp5ZB8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gxy_u1QDmE6ReR8u-qG35bJ9Uc6ueSQr
X-Proofpoint-ORIG-GUID: gxy_u1QDmE6ReR8u-qG35bJ9Uc6ueSQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040139



On 4/29/26 12:11 PM, Matthew Rosato wrote:
> 
>> +static int adapter_indicators_set_fast(struct kvm *kvm,
>> +				       struct s390_io_adapter *adapter,
>> +				       struct kvm_s390_adapter_int *adapter_int,
>> +				       int setbit)
>> +{
>> +	unsigned long bit;
>> +	int summary_set;
>> +	struct s390_map_info *ind_info, *summary_info;
>> +	void *map;
>> +
>> +	raw_spin_lock(&adapter->maps_lock);
>> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
>> +	if (!ind_info) {
>> +		raw_spin_unlock(&adapter->maps_lock);
>> +		return -EWOULDBLOCK;
>> +	}
>> +	map = page_address(ind_info->page);
>> +	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
>> +	if (setbit)
>> +		set_bit(bit, map);
>> +	else
>> +		clear_bit(bit, map);
> 
> Hmm, I don't know about this.  In my comment on v2 I was only concerned
> about undoing the setting of the summary indicator as that will be used
> on the slow path to decide whether or not we need to inject an interrupt
> in addition to setting the indicator bits.
> 
> I think we should drop the else clear_bit() here.  If _fast already set
> it and we are now backing out to the slow path, then it will stay on all
> the way through the slow path and that should be OK.
> 
>> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
>> +	if (!summary_info) {
>> +		raw_spin_unlock(&adapter->maps_lock);
>> +		return -EWOULDBLOCK;
>> +	}
>> +	map = page_address(summary_info->page);
>> +	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
>> +			  adapter->swap);
>> +	if (setbit)
>> +		summary_set = test_and_set_bit(bit, map);
>> +	else
>> +		summary_set = test_and_clear_bit(bit, map);
> 
> I had to go back and refresh myself about WHY we needed to 'undo' our
> prior setting of the summary bit specifically.
> 
> The reason is that, if we need to fall back to the slow path, that code
> will see the summary bit already on and therefore not inject an
> interrupt believing that the thread that initially set the summary bit
> did that.  But, if we fell back from the _fast path via -EWOULDBLOCK
> after setting the summary indicator, no interrupt was ever injected at
> that time.
> 
> So my point: this _really_ deserves some comment blocks describing the
> purpose of setbit + a specific statement that it's OK to clear this
> summary bit now when setbit=0 but then the caller must re-drive this
> summary indication again via adapter_indicators_set().
> 
> [...]
> 
>> +int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
>> +			      struct kvm *kvm, int irq_source_id, int level,
>> +			      bool line_status)
>> +{
>> +	int ret, setbit;
>> +	struct s390_io_adapter *adapter;
>> +	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
>> +	struct kvm_s390_interrupt_info *inti;
>> +	struct kvm_s390_interrupt s390int = {
>> +			.type = KVM_S390_INT_IO(1, 0, 0, 0),
>> +			.parm = 0,
>> +	};
>> +
>> +	kvm->stat.io_390_inatomic++;
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
>> +	setbit = 1;
>> +	ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
>> +	if (ret < 0)
>> +		return -EWOULDBLOCK;
>> +	if (!ret || adapter->masked) {
>> +		kvm->stat.io_390_inatomic_adapter_masked++;
>> +		return 0;
>> +	}
>> +
>> +	inti = kzalloc_obj(*inti, GFP_ATOMIC);
>> +	if (!inti)
> 
> You need to undo the summary bit indication on this path as well.
> 
> [...]
> 
>> -static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
>> -				      unsigned long token)
>> +static int __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
>> +				     unsigned long token)
>>   {
>>   	struct kvm_s390_interrupt inti;
>>   	struct kvm_s390_irq irq;
>> +	struct kvm_s390_interrupt_info *inti_mem = NULL;
>>   
>>   	if (start_token) {
>>   		irq.u.ext.ext_params2 = token;
>>   		irq.type = KVM_S390_INT_PFAULT_INIT;
>>   		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
>>   	} else {
>> +		inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
>> +		if (!inti_mem)
>> +			return -ENOMEM;
> 
> To match the other nonzero cases here, rather than making
> __kvm_inject_pfault_token() return a value can you leave it a void
> return and then just do something like:
> 
> if (WARN_ON_ONCE(!inti_mem))
> 	return;
> 
> 

Thanks. This function was a bit of sideshow and kind of an after thought 
but that said I was determined to give the caller a return code. It 
really wanted a WARN_ON_ONCE. That works better here.
