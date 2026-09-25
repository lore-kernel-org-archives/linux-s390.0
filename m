Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663254A49A2;
	Fri, 25 Sep 2026 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343940; cv=none; b=AdJD4ACxrMdY7k5zKQeGBiuJH8k7Ha5jJt/rl9kBeU3mHw4uDC2C3QnasyA4lb6erCNIH9cwQUqqHLzAyYS8+KR2EhFLda0NqjRg1UjLW/q4bnpoBoyKZm19hAAjtvhINLPaReIUa1jjhjkpHS2FFJKxBgbQd5XSxcOYafyNZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343940; c=relaxed/simple;
	bh=CKAPGLwDXTFMrK2MdPXgIY04/dK/XFfHEseXqoJsN60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MABqm/O7Ut3Zv5NARghtmeNNg6mOx22QgquUSJXkT6W/OhfZcnQh4+252ml883RvmWHX2KAoGzJnMjJX4X4LKPNCrLX2lMFZHdw4ydONn4KPTgYciXQDB0d+pUrSjObgoj5g++ziLbh8cclOsJ9NmNXL3TLgJRk02HhXPlopkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LhQj1jbx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LhQj1jbx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4b9HG2394816;
	Fri, 25 Sep 2026 13:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bL9oim
	l8P/QV2lvvF4Gl37etlWtKIx0FdaKQYlV9CHg=; b=LhQj1jbxiv3KjYzUbfKRef
	w6SkTUKi+hnQajXbl4y6nVniRJBCE2bqOjHKs9BEVSS+EjKnBowkn9AtQ+mvUYxR
	SKu65tNWX2LZzoT+KfMiAl5yU4CtXDg3Yfm96rv8crK8hFqJJAsrT/M153l287XF
	wZ/Wt+BWawc6nQmQ9Yc/P9yAokOK1VTxZP87nPtu+S54nm7YGbzWOKlWkaYhIAPv
	l9+o3LEru/s9L1UIzxjoHeSsjX+Pb/GaezrgE0wfBSR6aMfdrCfJrd4OVd7TpQiY
	cYXBrEWGtLtdiM6XqZttRaYaCTSZ9HhSJXX1QgOmNfZ+qQqjf1lipkjw9VujQvUQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske27bfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 13:45:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9h8dI3298370;
	Fri, 25 Sep 2026 13:45:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2mmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 13:45:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PDjVvt39649642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 13:45:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3172220043;
	Fri, 25 Sep 2026 13:45:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 064D120040;
	Fri, 25 Sep 2026 13:45:31 +0000 (GMT)
Received: from [9.111.23.152] (unknown [9.111.23.152])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 13:45:30 +0000 (GMT)
Message-ID: <6ed30827-e79f-4fdb-8e26-dd14860f1d4f@linux.ibm.com>
Date: Fri, 25 Sep 2026 15:45:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: s390: Improve floating IRQ injection behavior
To: Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-2-frankja@linux.ibm.com>
 <b7707a7e-26bc-4b0b-ad58-9cd7f8f820fa@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <b7707a7e-26bc-4b0b-ad58-9cd7f8f820fa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q801NceOMG-cPQx7Bey1Jcz4wiCGMpfc
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab67aff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=atEMzyAhulN_aJCjzi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX+gtuJoAg9z/h
 tgkQj9NSX2mVdi+ORlAbEJ5opJBkolt5qrJt/TWzjPx4zTjJOYBSSLOkRyTrScEHQtZKf1v4gyj
 3jzvs29AhChK92+fdX6+K2eQRVaCnRU=
X-Proofpoint-GUID: Q801NceOMG-cPQx7Bey1Jcz4wiCGMpfc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXwhjAnaGpXDWX
 /d+Ox1dfevSOvCXfltZiKgYoteot7jwgCNLZXEgB0OgargjwA4nB04WG81UUmuGY84+AoHY2fR6
 /GRNcm8pqh/fCJf1ZbEa4ioPoBrKs/z2JXSbPRdNm2Afj1So+UPwEHd278OZJ7MOuncDv8SqPqV
 ZHxtwK0J1GQnQcTsY1xyyf5uKmTTDSGFR6EsS7AlD5ZP7mytGIduOdJk6EEz4jofawvuU56lv3L
 zEkB5c/LAr2sMyOgVH3e+5040NqTgQi55rXEsb8KTRvd617S9jjXl7Ec3SNRMgkAEHQ5pCtwM3H
 EcHrYGM93Zz+y9pt8nbEYTCzcphW6gVYwdwhtvrrLwUsmS2kseGY61DFgvU1uExr0+8oTAWin2y
 lbAbqjxinvT9ZBuUuHENo5vgPHbT1FfnZngCDJo959DQICnYoiA+0YYO5rR2gG6tXX/wuX5sr/5
 H/9QnHG+VINBZZj/t7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054

On 9/25/26 11:26 AM, Christian Borntraeger wrote:
> 
> 
> Am 20.08.26 um 14:12 schrieb Janosch Frank:
>> Floating IRQs can be handled by any VCPU that opened its masks. The
>> current design does not check if the mask is open when a floating IRQ
>> is injected via the FLIC. It will wakeup the last VCPU that went
>> sleeping hoping it's the correct one.
>>
>> Improve this by checking if the VCPU has pending IRQs and if not try
>                                          can deliver that particular IRQ> to find another VCPU which can take the IRQ.
>>

Ok

>> This is not the final fix around this topic but we'll eventually
>> inject a pending IRQ. The current code can easily deadlock a VM and
>> with this fix we work around that.
> 
> 
> One question below.
> 
> 
> probably not the last version of that code ara but certainly a necessary
> fix in the right direction.
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> We should apply this and add it to kvms390. We will get some
> performance regression testing via the next kernel then and wait
> for the results before sending out a pull request.

Sure
Knowing our own CI timeouts a change in either direction should be 
pretty obvious as well.

> 
> 
>> [...]
>>    /*
>>     * Find a destination VCPU for a floating irq and kick it.
>>     */
>> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
>> +static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
>>    {
>>    	struct kvm_vcpu *dst_vcpu;
>>    	int sigcpu, online_vcpus, nr_tries = 0;
>> +	u64 irq_pend_mask;
>> +	unsigned long i;
>>    
>>    	online_vcpus = atomic_read(&kvm->online_vcpus);
>>    	if (!online_vcpus)
>>    		return;
>>    
>> +	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
>>    	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>>    		sigcpu %= online_vcpus;
>>    		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
>> -		if (!is_vcpu_stopped(dst_vcpu))
>> +		if (!is_vcpu_stopped(dst_vcpu) &&
>> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>>    			break;
>>    		/* avoid endless loops if all vcpus are stopped */
>> -		if (nr_tries++ >= online_vcpus)
>> -			return;
>> +		if (nr_tries++ >= online_vcpus * 2) {
> 
> why 2 rounds?

I honestly can't recall why
I can remove that change if you want.
