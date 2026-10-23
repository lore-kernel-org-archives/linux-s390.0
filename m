Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758866;
	b=q7nkBaT3f9eF+dzqmFyIktukxV+MWo43Or473Na9a9st0xRaTf04gTYrvWkzv1ChJuhk
	 qhfcKGeRpjPJVOBOh5Y59BIjQeB2Zcv5mhQedDz37FO7Z3B1dfZNOacTm+FQ9ttPPWSBD
	 IJn93uMMT4Wpj4X0H2sbQWVaLv/i6IBS0oz//xAXhI340yplv3IwcakyJlolsO+QoNYwT
	 yPrL3D6HR8L2BBbL/NYDYZNe+rSyNUCokfgWbnnixnXOQZ615Lge+DLsM5BaVdeXIQ22e
	 wzkE20F2y7d6ZARtXnS7N9pj33Bqy5MPEgbUrtxgwJT4OKrQOWZGTnSdXnoVEvrEd0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SEnKZRG3NQWQDgPPDTektGULtiqs+sSwWNbWI9hnAis=;
	b=rZ48lTLci2mk1wPLoKvzYxkqsX9G2F0EVFJQ7ZWXPTujdjMD5hrpD/6MreI9Qz1t4YQc
	 ggmN3by86YOyE+bct2LTvjlmtWqXMpmwNjtkO0T5+nAZWZ01Ono9nxrsiylA4lCCPhnPG
	 7mZuBMLK31k8GvakwIvkOsIKveedWnh0OK3qugWFZgiPdeQmlmyBW+XK2ceBi9bieT2j5
	 02U1ymXQsHi8guMjr4nn6aeQt37xFW7NOM33WzBrS1+ixu/7IgYeFa1qjozC6g5DGs9M4
	 C1f84HE+dBLIea3vGAiqY/+EdQn6Qs4KUG0kC0HXpXU8zzkTORJoeo8bglgl2o7sUFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEP9wtat;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CC606A31A;
	Fri, 23 Oct 2026 12:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NEP9wtat
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAEdmI2721319;
	Fri, 23 Oct 2026 12:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SEnKZR
	G3NQWQDgPPDTektGULtiqs+sSwWNbWI9hnAis=; b=NEP9wtato995KGWDI2CQbA
	uR1ShfrJn5PLyXhX1s6aPQI4SxdQWq2Je1qpWX4llzOIync+EIz3oiLCXOENFdnf
	lSym46ksDKw5Tsnlolb1tm7NVFel+2npFnHoaS93pHgp36wrSwjKQbLKwATux+VY
	7B1T5lk1J/ZscOokIA1cyRqwEQty9DUSbNqjAxZjabkPTxhNvesB6/9Li37Mv2rf
	ZXMvOfrFwn6YbXAd/NxZ//HH2huMGvd4sCx+HYgjUlTwpdlGxNjAxckCG/pLvakm
	KEfhFTojQ37ggBAd/KlMcZ0TBMwLMMRuGKXxZvP2EzejboJMUlBacgtDXSV6gchQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5954yb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 12:34:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAK2x3763796;
	Fri, 23 Oct 2026 12:34:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hg5exrgns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 12:34:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NCYH6a17826192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 12:34:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B544A20043;
	Fri, 23 Oct 2026 12:34:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 623FE20040;
	Fri, 23 Oct 2026 12:34:17 +0000 (GMT)
Received: from [9.111.18.82] (unknown [9.111.18.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 12:34:17 +0000 (GMT)
Message-ID: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com>
Date: Fri, 23 Oct 2026 14:35:27 +0200
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
Subject: Re: [PATCH v2 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
To: Sean Christopherson <seanjc@google.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
 <20261020175818.375700-3-borntraeger@linux.ibm.com>
 <atpTa2FMU19UGitv@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <atpTa2FMU19UGitv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8bdNFdV1i6SC5MOG_urFovcqbJlNvj93
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NyBTYWx0ZWRfX5H0sqR8LHK9d
 jaLSQEppl4Nj4QU3KcAEQUVn1dd6zOmJIOK2Ov8yFEiKppyi4eKogjjmFC9PsnRPNxNaWoo9lYI
 2xdUB/0Sza3lq/6p+iMVUPMBlryLDMM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NyBTYWx0ZWRfX5dGk3lCocyC2
 38EGmaABKnITzzg9dYgh2ayypRKZ2hGAE3/VseUVutrx33LdBU0bK3MxPosnfpbvXE8qxHU7uC4
 LjN04S9pSM6ff+6yYq3cLOL+a1tLLs3cif0BXHi1yVxrcxjoYIdq/l1a49flbzvM1z2U52P5Uad
 GBeUqSkYs52wl0VbH1g2KHxeX9/YGSx5U1pRPCwb34acxZz5yAJbMBVk8S3gVpFEqZciodPBlPg
 E5RgoqY49rCcR8yX73fdeKHroxx16cVkTeVlEE4ybkglNHeo5QzjZhrWrk81FRLQ9SUCVKK6qvm
 DPpTggnfAcMKFXL4//N2zVA8B0Dawc5zc+BV5ksA4fa/n9EyYHpuObuO34Xq3mqz/MQvNCjo6qc
 Qhh1rIdpXzRaCu+I+PjiTofe52BHxLNigxG8fuTPHlDDEJdsopb7Wb501yfFuErxue42lAyEV+b
 rg8jJ+aZYNEPHPrWk8g==
X-Proofpoint-ORIG-GUID: SCQfF4KCkvw6cr_VFquXdAgKamNeCE4q
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb544e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=qr_JO_wfw_wqWQrLoU8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230047



Am 22.10.26 um 20:18 schrieb Sean Christopherson:
> On Tue, Oct 20, 2026, Christian Borntraeger wrote:
>> Add a test in which the guest writes to a shmem-backed memslot beyond
>> the end of the file.  KVM_RUN must fail with -EFAULT.
>>
>> On x86 the guest enables interrupts, and on s390 the test sets up
>> pfault, so that KVM could handle the fault with an asynchronous page
>> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
>> retries the access forever, and the test fails after a timeout.
>>
>> The test is not built for LoongArch, which handles a failed mapping as
>> an MMIO access.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>>   .../selftests/kvm/faultin_sigbus_test.c       | 169 ++++++++++++++++++
> 
> The "sigbus" part of this is confusing, because there is never actually a sigbus.
> Kinda silly, but maybe faultin_efault_test?

Its Friday, so lets ask the British people and let them vote for Faulty_McFaultFace.c? ;-)
Just kidding, what about async_pf_error_test.c ?


> 
>> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>> +{
> 
> ...
> 
>> +}
>> +#else
>> +/* x86 needs guest interrupts on, see guest_code(); nothing to do elsewhere. */
>> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> 
> Nit, maybe arch_enable_host_async_pf()?  Because x86 has PV async #PFs, where

Can do, I will follow your guidance as you have the x86 view.

>> +
>> +	TEST_ASSERT(!(r == -1 && errno == EINTR),
>> +		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
>> +		    TIMEOUT_SECS);
> 
> Rather than assert on EINTR, what if we have sig_alarm() explicitly TEST_FAIL()?
> That way readers don't have to piece together that the EINTR is coming from the
> alarm, and there's less chance of the test somehow getting a false pass because
> KVM manages to morph the signal into EFAULT.  That would also allow using the

I will have a try. Thanks for the feedback.

