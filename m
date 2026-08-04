Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549F332907;
	Tue,  4 Aug 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855141; cv=none; b=UgE7MAY24gyioa8ZzP0oGQT08mqU261uQPMRwL4gCfI/gfOfpbumoy4wNVYEFPhLCaC7w1dWu0nFNfFYwFhsO25LCTTDUlWlpw5eHaaj28jwavkWFvVS3QBRwiZuDRwPL1Uje5+wTbei9pfA/X/j8UQYrurHDXloCQ32m9IhmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855141; c=relaxed/simple;
	bh=r9eUxwC2Y2tU2TryqdtvLSezfLtspXkRp+Qyq74U7sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmYkY+nKQzQk2YOXUucnOgaWiFSboPKy2KA7eRMg2zpsz0WX6jbdYJHRHpPe4/7oxuePzJ1CDWwT2djsLESLu0LwaYaw3JC4VFolF8HIt+QwE+mtz/PFsVDHlcuWWqQdxCJbA4tFUNt+hP1hAKicurRx3R3/bFv22UOxMc7yhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qRib1pfr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qRib1pfr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CmVU7804682;
	Tue, 4 Aug 2026 14:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XGBjXM
	89xOYF2Rpnke2hKuV9lCDZulbuTTmdJ/JboBo=; b=qRib1pfrWuCKtyjaxF9nw/
	v7bxag/wXCiIMy1YYRAzcIl2zKMuOq6L9xBMqHxZYESLfThCi0wOBKmozdBoKQZs
	U5KlcG90BspTrq9svnxq1HQfNxYtxO1RZDLUJfhhAvzKyMv8Eu7QUZdo0BSaxGuo
	VCjT6IdSo9PaADmp3yZSqelweEUduU2YMoB+L7gJFNa//vj6RWJxFtTBDslhuZqN
	xqvC10hCwzlpoT8iZbAnSNJ5QZI680Vf+iMHJscqpnqDIlmGOV0jbccj4LPtNmkE
	jI/xxlk4KF+Ur/LLjgHHELr2VgvfMW3yvNTrBbiT9ZREW4zPBlWR1G4u9aNmVVgA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g63eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:52:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EfG6D029419;
	Tue, 4 Aug 2026 14:52:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qjhka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:52:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674EqErZ65405342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:52:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3317F58060;
	Tue,  4 Aug 2026 14:52:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17E9D5805C;
	Tue,  4 Aug 2026 14:52:13 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:52:12 +0000 (GMT)
Message-ID: <75d47b2b-9a47-407c-a02c-01fb9a58fabb@linux.ibm.com>
Date: Tue, 4 Aug 2026 10:52:12 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: s390: memory leak in guest debug handling
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-4-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260804120631.736919-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX69X1/BVOc/YI
 Il9jLNYdYyX2+gb+S80W8BUce6kxeLZEs/zhHy6xEFM968j49AjPyi+gfjsGZ5WtmCR8byeIxbK
 Xhwq/20b+u9g6l/RzpPSnNNkAnvbvzHqUVnLF99Sa3Lu/g3p9KinmjeTJZBqj0S034SsXPLlwC8
 JH9gjwSQ+6NdDuZM20wRaEW/t6SCXwimtEH3Y5DzU/7eQDErRMwj9f3CDv5QkgllcAtyjLcMoUU
 pUVtJkJYSfqtaGhDJO/tnY68Lgpq7H98UCvXLaaTHLJeS+kQNklgjcZPhGmys0yURzMGs3ajM4F
 2x/7KOZ1ATK2ZY8727BrDMcxBOJK/8bludZGcaA7wEFCU/v6ZJdVpncdJddZoNbtGPwVsZne1If
 ADrrSsGpFwZ9Zn9faPey/BFXxVAnoNkHaN2JCo73727oEKcUTRxOPA4CJOMZAiD6pvLzRf64VJt
 Bj2iNRpABxZqnqnxWqw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71fca0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=SojaDyzEsxftZGC-1DoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BuSMatYEgsaEzcT1sxyHjEYwV05HPUnI
X-Proofpoint-ORIG-GUID: BuSMatYEgsaEzcT1sxyHjEYwV05HPUnI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX+ZXA/wyICTkT
 GZbz2kUwOlz98RdjiRhB1JBw48KoRLL4xlQH8QPO34ZfU5up3hLiY4G+sxxe9Jwm6EQOR18D9f0
 tj0/ErbPy8/mdNXLSThhp/N+9EbPMEE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040120

On 8/4/26 8:06 AM, Christian Borntraeger wrote:
> bp_data is freed only for the error case by kfree(bp_data).
> Every successful KVM_SET_GUEST_DEBUG will leak bp_data.
> 
> Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Maybe worth re-visiting for potential __free() usage as a follow on and
replace the goto logic.

But as a fix this LGTM.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


> ---
>  arch/s390/kvm/guestdbg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 69835e1d4f20..4c02dbebb2eb 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.hw_bp_info = bp_info;
>  	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
> +	kfree(bp_data);
>  	return 0;
>  error:
>  	kfree(bp_data);

