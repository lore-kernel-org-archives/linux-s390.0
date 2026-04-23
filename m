Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574A311C01;
	Thu, 23 Apr 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953560; cv=none; b=URi+UlEn11iJ+qRCYyoFSrxgsZ3vzAWi/Kw/FXGu7Ie97n2ae0WnTFgiGBLY/mFTBa46El+qKzOa3NI6z6F+bjS9cNtSuxbnJbR991xvjIQEjiyxYV9k16AUjtWG2pXDsrkISHTbDAe5x7beJhZ3jJRBM8r2pLIp98IsqknuxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953560; c=relaxed/simple;
	bh=uI16ZwRsCMyqNFzngDZ6Y4aXU/BipIqjae2sn9Y0uzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDNQu83reXtu3NIGbd8xXKIMC2YmusvLpZXarkMPJPqLbgQW3v/5NKU9izuuap78vndSRePlhsMSuVL+rtCZdkO2tB6pNZaTfgYQpkY+mBa0Ltn4+dW2567phDKPohLW80Xmwav9FYEIer0cChXmIGgMQjhSAkFhTnTPWXgBE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuF/sW3v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuF/sW3v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8KXP23229023;
	Thu, 23 Apr 2026 14:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mauO9C
	1wCMlMM1t6nbhXRnwvearA6fDdJN06Eeznquw=; b=CuF/sW3vPUTUoSlP699NgT
	JkQmtJkAIqZ/Cb4sQ9A5wT18MbGrzSd9UCoIS4jUS2D4wPe80/T1/q7H1NM1riTf
	6uRwcp01tcDiDY/vgoKUv3yL/0xIjvrCumjKemZVDmeWxObnTeQrhE3jH5YQ9Yfo
	aMZLjKT0dTBjiopPFsjkWrZ5GOJi1pTUYBeoIvyH5NbBtXwZUzOM93zqLqSlBqD/
	TddXvRCKeolAhlPVSpg31YabYw8hH6oyMVRRAuXQ+ZjvfbBxhEiSKIKxkz7kIEHg
	FBnDwC7dO1yK3h8214o5Ymv0cYQ4fKF98nwfcyqrOnTi89s+XKFtXS+/ODRLhq/Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu291mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:12:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5SCF003016;
	Thu, 23 Apr 2026 14:12:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxwjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:12:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NECX3g43909626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:12:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8A3D20043;
	Thu, 23 Apr 2026 14:12:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89C1E20040;
	Thu, 23 Apr 2026 14:12:33 +0000 (GMT)
Received: from [9.111.73.67] (unknown [9.111.73.67])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:12:33 +0000 (GMT)
Message-ID: <7941e4ad-9b99-4cae-a590-22d94ee0baa8@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kvm: s390: Fix lpsw/e spec exception ilc reporting
To: Heiko Carstens <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
References: <20260423123902.14663-1-frankja@linux.ibm.com>
 <20260423123902.14663-4-frankja@linux.ibm.com>
 <20260423133602.10371F31-hca@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260423133602.10371F31-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L8BVORg6Z6gtXXSg73kAeogl0p71yfaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNyBTYWx0ZWRfX7tJo1LxxUYPr
 /WCHiHoaqWqTPDduuv0VU8OqCxZg8CMlUJ8Uov6TTXYdw3KhafOjB2Dj0MSQABHgezB5onjKDdo
 rNsfKIvBe9wrV3qXUxGEI1uXDJO2kAmk+W5yGrJehYJ0cVS1b/Dx0bbOmQx0h7/9gbXIM6E5njL
 UXlpU0RbNmnF3xOvii+PLtOr201uyOzhTniaZWz5u7ZovYz/VtrMh3/0r93lFPN/26FcID+sC0u
 0stjIVtLLmVc3J62Tm666fqZl9/F0FKSH62ojaeKZV6T/bEq/8AaBAKdqaJurhnhDuXCPJFdbFD
 1U2Ken6/yF3XRPx1XNOrtxm2PROJpmpUky6rgAwLrC5Yh8OdvSY1vo0dnMQlB8Be069SyPtmd9n
 UYmApvGNAh8EBjUDpZ/m+kXvKxjlvPF4fQ8TCLMpnTzY49eXztmF2nXGvp/0PZerEyo6FgKkvEL
 ocuXU3rIJsuXb69SSSw==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea28d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5I9kkwWeUB-T67iL5GsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L8BVORg6Z6gtXXSg73kAeogl0p71yfaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230137

On 4/23/26 15:36, Heiko Carstens wrote:
> On Thu, Apr 23, 2026 at 12:36:04PM +0000, Janosch Frank wrote:
>> On early PSW specification exception the ILC has to be 0 according to
>> architecture.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
>> ---
>>   arch/s390/kvm/priv.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 56e63679f9d1..9fd7d3f1d1e8 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -713,6 +713,7 @@ int is_valid_psw(psw_t *psw)
>>   int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>>   {
>>   	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
>> +	struct kvm_s390_pgm_info info = {};
>>   	psw32_t new_psw;
>>   	u64 addr, iaddr;
>>   	int rc;
>> @@ -738,14 +739,18 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>>   	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
>>   	vcpu->arch.sie_block->gbea = iaddr;
>>   
>> -	if (!is_valid_psw(gpsw))
>> -		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +	if (!is_valid_psw(gpsw)) {
>> +		info.code = PGM_SPECIFICATION;
>> +		info.flags = KVM_S390_PGM_FLAGS_ILC_VALID;
>> +		return kvm_s390_inject_prog_irq(vcpu, &info);
>> +	}
> 
> Hmm... looking at the architecture: an odd instruction address in the PSW
> does not result in an early specification exception, but a "normal"
> specification exception. is_valid_psw() however also checks for an odd
> instruction address. So I guess this is still not entirely correct.
> 
> I'm also wondering if the above implementation is correct if PER is enabled
> when the specification happens...

Well, we're hopefully slowly getting there one patch at a time.

> 
> Btw.: you may want to have consistent short descriptions for your two
> patches. That is consistently use upper or lower case for "LPSW/E".

Will fix
I'll also have to rename the bear test to lpsw since we're now testing 
way more things.
