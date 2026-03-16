Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED12E7179;
	Mon, 16 Mar 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686065; cv=none; b=f5HN5s275sqXhCviJjQOvvFwZTzIb+dcTxbbDJdBN0+GeNUlnstZ8LSi/YOzmQsPmyooUtpifu961O3ghhCJv/rmci31cvkrGKJ3hZyIG/8WQClOPiZWmW3Y6cFHRTOrgKFtcEJONLhcVt9gWNolYnlh1etV3tvTibxxDZPJ0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686065; c=relaxed/simple;
	bh=aNiN6xEWUSr7r1iT7OKjVXEnVC/XrIOxt3XWgqNnDkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmxRod1NDy6xteA0PYCuUPgJRHXI0hz0ZpGjJYMcOhLoEaKY+6tMGGR7heoceSYC59gSRtBi8Bg1Z6Yw4almqpPxjSUJhMfTbZy4cvo5X74XJ6lud1hMgFnGNGvY9oJ0dw1n/iVwGLQS9Ldmo7/iNCWFRLNVf70t22Vmis0sk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9wpTHOW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9wpTHOW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFVb4H853168;
	Mon, 16 Mar 2026 18:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tHdSrT
	+fbPM5ttMV3YEugatTEeZ69TSyOXH5A/B2dD0=; b=U9wpTHOWxOsp1tOKRKrtoF
	fcA8a1ahrnTUfvcs4SOHj5RZLWMn4ApU5GV6TKXIkPBFKsCZNVeO0EsFynZpSusF
	cbgi0FSnsNQS/ZGqYgfM8rmi7JuRAFYJ0aLHAtN/QmgvvMKpGZV9yGTQxfln8Ol8
	1/8W4GwCEhF0XpS0fN9usTbBhm5Cbf9l3G3VHvlXX83kLCKPtMid2R9IEubOdtWc
	eR7mkN7shQAnlx5WHTs8td+LHXVl617psXs+GFp0M1ILEkFKckt65SG4y4Fe1h4i
	PDuwcgAcfAvm1x/+K2DvpVejcodUIux+RH4dh5SZFJ0mXPWgRMVw2UvP+V1lTHiQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8u6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:34:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEcrG2013997;
	Mon, 16 Mar 2026 18:34:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxx047-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:34:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GIYIgl46465310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:34:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5BF20043;
	Mon, 16 Mar 2026 18:34:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F7FE20040;
	Mon, 16 Mar 2026 18:34:18 +0000 (GMT)
Received: from [9.87.135.243] (unknown [9.87.135.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:34:18 +0000 (GMT)
Message-ID: <1cb094c5-fe90-4ea6-bf3e-bf26fa2d300d@linux.ibm.com>
Date: Mon, 16 Mar 2026 19:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] KVM: s390: diag258: Pass absolute address to
 kvm_is_gpa_in_memslot()
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, akrowiak@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316180310.17765-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0MyBTYWx0ZWRfX0D1rjvHzO8MJ
 +2Rs5+EJt9HMfANkhap/eitVNr/SAlc5jXdV6ZyMRA9nLoqrhP9u6QQB1XITfXY4bYFwr+5ftSD
 yAAN+nJLJPxde3YmqV6YyfFZhTpHDCjO+qsanRrN9x2jJ6vstkMeGJmCr04Z6K5uH/1KJCkPLPU
 1yBYrcLNoTZad4Ghb4frsefYxT4gPf4SV5fPSdSJ48Tizoui+jJYhvf/j088845wRXiqnN1R25y
 yEkAUdwstvey7FhGuPljHxGfGoQ1Ae7NdV5BInZPRx5XVSHfvIeOvpOUMxSPbz4POeoghVQX1E8
 yzfY50UGxixuyuR30NIVC7WhrxacB85aRbLI5tI7bnBs7+0rPi4K9oxfzsxSk+4iLLGs1OIwr52
 Iz1RJD1z3q15bwiQvbadk2dlkIYVicZ+vwhhAercOwfMJaQ6lnDJaSkL6ttUosefRMUrm4PCR7U
 7qsE5Q+k7HTX4BDPcWA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b84d2f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hmbiDVwH1lKaQpimJPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QoB0KMophuYGrPlkcTxRtpuk72GIqsaK
X-Proofpoint-GUID: QoB0KMophuYGrPlkcTxRtpuk72GIqsaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160143

Am 16.03.26 um 17:23 schrieb Janosch Frank:
> The token address is a real address and as such we need to translate
> it before it's a true gpa.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 3c038e6be0e29 ("KVM: async_pf: Async page fault support on s390")

Makes sense, but I guess we would have other issues if the prefix register
points outside a memslot.
Anyway

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/diag.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index d89d1c381522..51ba4dcc3905 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -122,7 +122,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
>   		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
>   			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>   
> -		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
> +		if (!kvm_is_gpa_in_memslot(vcpu->kvm, kvm_s390_real_to_abs(vcpu, parm.token_addr)))
>   			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   
>   		vcpu->arch.pfault_token = parm.token_addr;

