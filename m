Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507564;
	b=tfrW84sx6jzSfp1m8mLb5J9IlQtwVNOntqliBDloluBp5dDeP226BGZ8eHq/+vxZutEi
	 7rLmsdQ1VHalqGMEB0jqBPrF4XMg2jx2ud6PgEfdC635vj/97uZBoOL6GGYCy4/ABGvk9
	 HVKLHJY/oTeCuK+3lPtwvAncBiqbH5eCatLUS+PmFQlfRgpfl0JMUKDBQHasIqKlsNfNt
	 opJi8+NK0x70ohF9lTQc/YAUCSgpDGa+iL2U0TaKPXVTehygdmu+Wfp8ETuK59H/AE8bc
	 Cy4scvewa6/fEouZ715B1msCWTqPCem8mYcy3Z5hUegBly5Ut9Nm9E4CiyyT/iRlw6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507564;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xVaeWr6eC7nAd10myTM6jllmquGawebJ4Ac5mpjXGlQ=;
	b=Xm+Y1nIMEuNqu6c/QPgzHrWAC7Sux9Wz8lslH4ktpiW+t/lmyc5Jq23q0QL/iS1dGVTl
	 4d4wXRinCGfCVkVo7gRxN54dLXAB5ro2Ggfeq4+fSEULGuP7CkWA7oo2DBJs550l2aGq3
	 zojrWOhtP9gr1++JozWr1lBDUiXhGi2ZCrROdjnVx6ddZrbLJNYqrL2ogF57DyWqXJ4RR
	 h6S5NwFOy/bmlqQPQHTDM9hbjyi9s7DAuxmFaM5RzIHYu3HjvS1dA1kyXC8F79v79a0kd
	 z+imvlah4JivurCy6BdETsCfKLQOW7+5RglJrfTcdCAm7Gdif+I/CTrRqv+WeXUgj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BcmqemQx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC8606A329;
	Tue, 20 Oct 2026 14:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFBC8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BcmqemQx
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDEAkw1400439;
	Tue, 20 Oct 2026 14:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xVaeWr
	6eC7nAd10myTM6jllmquGawebJ4Ac5mpjXGlQ=; b=BcmqemQxx7R4oLm32yy+mc
	I1eUd5TERS7JnWZrHUJ4pwXGiNQT7CN1efZBaRpvEWsiVw8VZV70S6b8ahXdGk5S
	DCmIARr7UD75om6plWH9Vnq0gZhrpmFLO5Q8K6lzHz3MIYogC6IF1+MNZysvzVkK
	y2b0k5UQdn6c63+KC6yCf7/pEahjeLW3Egv8ZX4+RrU4b1QPupK6a2/k7VwEhFbo
	8nx5kbdPYesTj5ezZ8fbo7AheXSpBmzrgNpJ7o/gDAgaBD6lVPIqlohQsccDlOl3
	IPHVlvzwWUBaB6d8ZuF9IBCmbS/cBGtCxcA0WmJUp0BMS9xyUMrwhWAgla3HNiGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5839t7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:46:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDJsik1501031;
	Tue, 20 Oct 2026 14:46:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs0mp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:46:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KEjwoS49086752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 14:45:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2159A20043;
	Tue, 20 Oct 2026 14:45:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0253B20040;
	Tue, 20 Oct 2026 14:45:58 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 14:45:57 +0000 (GMT)
Message-ID: <82c43cbd-841c-4bac-aca7-ec79a5abb6a9@linux.ibm.com>
Date: Tue, 20 Oct 2026 16:45:57 +0200
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
To: sashiko-reviews@lists.linux.dev
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261020143308.228328-1-borntraeger@linux.ibm.com>
 <20261020143308.228328-3-borntraeger@linux.ibm.com>
 <sashiko-outbox-179179@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <sashiko-outbox-179179@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfX8I6h+sv6tJpo
 LzMjyYd6zKx4FIDnTrnrxK6lEaP8kBxRIMzUqRsNm1CZ0jF4v9Lj3n5CImJt9ZFlwKq+8nTadmw
 A9IbxZHrvX+F6lEphX/WwW7/IxoDQVc=
X-Proofpoint-GUID: 4RIHVI5H1Zg_IKyCEf-Jt8Nq7x14tCGz
X-Proofpoint-ORIG-GUID: 4RIHVI5H1Zg_IKyCEf-Jt8Nq7x14tCGz
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ad77eaa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iV_9lNH_Ea5QOsfRDesA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfX4tJde5ZyD/dP
 RmrijhWuFIjiqblX/UJhm1ZmlEu8Bp0+fCuO4ZQt8sHLyvVt6HVD6qjo4Jb6auEhH0cssq01dew
 I4u99svTu15EiJ5oT3DruyYHpzO2wSgSXwQd5XzCTZ1R9MlW2U8adq5A7eRt2vjsD9TNny7kTyn
 tbageg6J8hjjgTfISSbihJznUAWQ0gngzzuuw0gWcHLp+LxgPhM61TFOV/VR8k8JP92FetjpVDU
 Iy9oWX1olFBCVyf3Fxd+PBRO1InRy6WJQji9F0f+XR4nNRNuLkl6GZwXbOCRhtCvd4c9A1O6m7P
 NIq7kaEyNMbE26Un7BevINJjgNCxxe8nWrw6CXA8n/kI6HUdOp9vv4GnSNZHVdigmsMKlP0uU+s
 M+dv7iJeKqApzlgVEmS1GYQK7SMzKm7RL5dFqu27PFacdLshAyWpmszrXc484M0q5yoSl0rDyJA
 dNcmQ1ZwbTPuY3Tmd/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200058

Am 20.10.26 um 16:40 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM: selftests: missing gmem_flags argument to vm_mem_add() in main()
> --
> 
> commit 3a1c0f90404979b6638dbd3c2769d7b78633b104
> Author: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> KVM: selftests: Test that KVM_RUN fails for unresolvable host faults
> 
> This commit adds a selftest in which a guest writes to a shmem-backed
> memslot beyond the end of the file to verify that KVM_RUN fails with
> -EFAULT rather than retrying an asynchronous page fault indefinitely.
> 
>> diff --git a/tools/testing/selftests/kvm/faultin_sigbus_test.c b/tools/testing/selftests/kvm/faultin_sigbus_test.c
>> new file mode 100644
>> index 0000000000000..b9d673260ed5a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/faultin_sigbus_test.c
>> @@ -0,0 +1,168 @@
> 
> [ ... ]
> 
>> +int main(void)
>> +{
>> +	struct sigaction sa = { .sa_handler = sig_alarm };	/* no SA_RESTART */
>> +	struct userspace_mem_region *region;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	struct ucall uc;
>> +	gpa_t gpa;
>> +	gva_t gva;
>> +	u64 npages;
>> +	int r;
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +
>> +	/* After slot 0 and the page that some architectures use for ucalls. */
>> +	region = memslot2region(vm, 0);
>> +	gpa = align_up(region->region.guest_phys_addr +
>> +		       region->region.memory_size + vm->page_size, TEST_SIZE);
>> +	npages = TEST_SIZE / vm->page_size;
>> +
>> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, TEST_SLOT, npages, 0, -1, 0);
> 
> [Severity: Medium]
> Does this fail to build when compiling KVM selftests?
> 
> In tools/testing/selftests/kvm/include/kvm_util.h (and
> tools/testing/selftests/kvm/lib/kvm_util.c), vm_mem_add() takes 9
> arguments following commit ee455183c92be7:
> 
> void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
> 		gpa_t gpa, u32 slot, u64 npages, u32 flags,
> 		int gmem_fd, u64 gmem_offset, u64 gmem_flags);
> 
> Calling vm_mem_add() in main() with only 8 arguments omits the final
> gmem_flags parameter and fails compilation with too few arguments to
> function vm_mem_add. Should this pass the 9th argument (0), or use the
> 6-argument helper vm_userspace_mem_region_add(vm, VM_MEM_SRC_SHMEM, gpa,
> TEST_SLOT, npages, 0) instead?

Yes, this works on 7.3 but fails on next

