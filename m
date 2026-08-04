Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF83385A1;
	Tue,  4 Aug 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850124; cv=none; b=hr4St4o1ykKTK2lpZ5UYPaUcQ2oIn07u0sByJnJv9yP+VlM/rI45Ph5m/1SE23emZeZIJ9CnyXeTZsXDYhdG3UwETBo9qd+8ImLXXIZIs84ErDv8wjUHsqt7eOf3aqbznSIhl+94wbF22ey0gefx2XbxzpmoXypwOrIxUZhw6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850124; c=relaxed/simple;
	bh=n7mxFjo941E8ndRkLtjDPHmnRS4zPb8dMB4cpRAOg3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3a94rD5XDf9ZOBMqvWcaHFekV0Zbv+7va9EQZf2QCdBQCoOlFHVFER8jUS+LWBgCH54oP/3ngFtMGuFfsZYKPnrBZluD21p7YPrdLJiJw9iKjfENgvlRn4O0KH/AOYSi8njuyTlcHXqPc/Gp2pKg2vGeDWcOJfgvEn5X5Icpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qECIdwAJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qECIdwAJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CpZfH808699;
	Tue, 4 Aug 2026 13:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KCgUJ8
	rUE9AN028aEpaY+3S7+kWBPaZhIViZLMQ6I0k=; b=qECIdwAJDbXGtmEj4+gUDa
	QujOLz8k+TkjIXwehhcvTTTMyuvJkwkDFzFjFUttEOAlQnTFMoTvud3zP+8J/K+R
	rPKeFRDvobPEm/GFOGK5fqbquA9UoBVvLQpRmHaQOnUNc7+oC9myxJj4NzEdq75N
	B0AqmNfQgE1l4cmzF9KvvUizhwW/byNzMosZKWwGQMz6prELoegYBhBlQs8862eS
	ZynI2E5jj09aq6P9mUFtlajYmNMYXgcpSMbY0jnc5k2HF2LiR7WCI7xX5MTZwN/2
	pQDzk+5BNtl0Pw5Q0+lW4JWtvDCknRDQPyf6v5erW8phfoZyPBTbd+Jt6ABeboOw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hnvu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:28:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674DQGeU029996;
	Tue, 4 Aug 2026 13:28:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg9w41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:28:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674DScj229622800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 13:28:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCC395805E;
	Tue,  4 Aug 2026 13:28:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92BD25805A;
	Tue,  4 Aug 2026 13:28:31 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 13:28:31 +0000 (GMT)
Message-ID: <936069c5-4783-41cf-8596-57677f542ac8@linux.ibm.com>
Date: Tue, 4 Aug 2026 09:28:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: s390: zero initialize irq for
 inject_pfault_token
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
        Douglas Freimuth <freimuth@linux.ibm.com>, stable@vger.kernel.org
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-3-borntraeger@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260804120631.736919-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfXxjmQYT55k+/z
 z1CUDaVrFeat5DpZSwBfEgRUiHdrUDulN/NthY3UPqseuBGTiFYpRq3mwh1ueP33F2LxLeV6Yfn
 ZdnN4RBTdQiCf+0YPOYCBRnFDvOoeWU=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71e908 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Wb58gRFZ4Bbfm71BjxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfX6jTT/XcAW+VL
 agdw7jjbuI+Lin+hxaThH3yWF3iXfThDR0qZpDHBJV+uhhQOpf86JEl6ER116y9eLzKamdkdJWu
 UMNBdNm2g7tv5VpfMLvGbaYjNCz175hRlAloTFRG3SO/dU6Sabu6dp2ACeh0CgL6GWs4EMtMTwV
 QDIVQtCH83ng6UAxb7mYEH/xZSP57RoXxYo3dndWOFmTTt2m/PF+IaRpXEzwJIDSnE/NYTVui1G
 chwGRI46fTKhssjdxYPLFjjZOghY1xZXM5ILNPBi0VjZfKST/CQT85EGv1a6qYkwSSvPC6ZdP4r
 25AVrLguqS0FBK+WyGJF1BI0oquIKQjpGyFb38ijw8YjoAaAnfO5v/5Q2DVIxtS4nPAvflfI8wc
 qd0KvjyUXRANv1BzSHisQj9jrVm2HmC+KkQ5JGtKTx4UQCjHSDctWCNbkF1LyhmtmJYTvMhsulg
 Srm/fCcMSwAcaSp856A==
X-Proofpoint-ORIG-GUID: cwxy-FoEsXCZ3PIdGS67nY7LqVcDOEdg
X-Proofpoint-GUID: cwxy-FoEsXCZ3PIdGS67nY7LqVcDOEdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040107

On 8/4/26 8:06 AM, Christian Borntraeger wrote:
> __kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
> the on-stack struct kvm_s390_irq but the full ext substructure is copied
> into the cpu local variable on inject. ext_params and pad contain stale
> stack values.
> 
> Interrupt delivery only uses ext_params2, so nothing leaks, but a host
> user can use the migration ioctls to get to the data.
> 
> Fix by zero-initializing the irq struct.
> 
> Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4a38de3d6758..447e6a61f886 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4474,7 +4474,7 @@ static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
>  				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;
> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_irq irq = {};
>  	struct kvm_s390_interrupt_info *inti_mem = NULL;
>  	int ret = 0;
>  

