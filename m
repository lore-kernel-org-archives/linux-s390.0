Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9293E9F8D;
	Fri,  7 Aug 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099074; cv=none; b=abCNBUxiRhWVoBx3jL3FbZFXXekjeKoFkZyIArghvOI9jpWgui9j0pdLq0LuPVbveKMk0MGekObfPBtW3cyJdtKx9YgqUv5m8VCyeaI+yA4/cL1jiOK8p6netlsUQtdEugJipEyhKZjZEtQAMr5vJV5FSzd/reUwzL2Bl2HFYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099074; c=relaxed/simple;
	bh=pJFYL9AajxQ+0v6F4H+PA6YYhK3jDFHLy9pkcYaSaUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7v42d89Cnz2TRrLepL0X41ZFNt+N31/6rs4VtJvUR6ryZaCKIiTLR8jL9aYfMoFr9MDpbC6XAEi3MRF/PPgaFPONu1fksBXUHLJE/7NEg89XAXsg/tKkipNQpdUpO/YvCRZPneZgP5+q7R9cd6HBhMlAu0xEsiTDBrCRD/3xpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1t/J9zP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1t/J9zP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IMsD2277771;
	Fri, 7 Aug 2026 10:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qgRnvi
	lRDLXsX8nS26BApRVe02goZtgCHY2lFeFlWFk=; b=M1t/J9zP2WYO3GfuK2JWv4
	D9JkhJSLhpfgaJi9VOQIpfjpcb6g1oHWrQMdXmZDTB/wzPKNK1z9HJnPi0FIHCW+
	N3kBhS3wWLjgS5Mx364drUOeU/QWuVbcnxC+GPGIiEaaZsEGXpwAYZczG6eUhAiR
	qorp5/NqhhiphXlG7lTQvTggSkkWYFp54otVr6W5L2vCducweMXpI8mt5imtkra5
	V+7+ee/zX8a6k+8nOJlzcI3d4neq302lVgdkdXb8jYGPC8pPxe94UUhggT4RsNyT
	LtOGVdCCNeT0hHMmlUghM1xsj9RH/nVTGe9n4EOXaLkUcEKAhjPSMd6iGl0P01+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01kehv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:37:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQFGo016593;
	Fri, 7 Aug 2026 10:37:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qye94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:37:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AbkDS47841540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:37:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C642004B;
	Fri,  7 Aug 2026 10:37:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F46220043;
	Fri,  7 Aug 2026 10:37:46 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:37:46 +0000 (GMT)
Message-ID: <c7e4c6e2-b594-46db-9355-f4ddc718e7d6@linux.ibm.com>
Date: Fri, 7 Aug 2026 12:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] KVM: s390: vsie: Assert mcck_info offset in vsie_page
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-4-b18659b55e3d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-4-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d2S9LYMkOg4z1ps8p5wf915z_Oprwd3b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX0KIFzsBOR8P0
 nQLp5cpe2+jW+V7Taby7XY3ON/zokgZy9F1r1B7tNdOYbMOILCSMi7TlwvLc6iHog91PILf+Exy
 B5YJN+f1clGdq56KTL1e862d4L1hp4o=
X-Proofpoint-ORIG-GUID: d2S9LYMkOg4z1ps8p5wf915z_Oprwd3b
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75b57f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=GQvCdBjmt8U6gY7Y-kUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX8VGwrDfkuoDA
 Ajg4wwxotzL9mm2jbzK6AcUGPLuRD6v1mUosKAZbhx1imLnOSh8KetOe474D/XdqeqpwNlfUMJE
 Fgh9vTlVAebq6dcgCxVvXobynU4KcGdvTF69TGgOAlTd69m7XtmAMM06nrtD8OsgGm936KjuHDY
 RLvpRGiNoIvKmFzc5ce/SdB1pbmOCNdPg7U4z/Kf5z87WMv4G7miW1IhAr1xrvtk/5QIZw+1dGU
 j7QAQnxrg/+8sNH2OGZs8HGjklYgNjmxLbmGosUpmy2Zq1SBNsWld50zIrVdZSTWBJ1TMq94TVK
 z7YhFNQPh0wRMYWLcSRBzZJ+LElZzy403KBvUIvP9xr+DX2TnUjKxaLnVCCYBSDFnTvvbLHOnBj
 89MUGA7CCXGxEGs6XtPvoBpGtHU5SrfI7Q0iothiQov3zwJDIqEr5XkLP99/heIr+oCXkww6prv
 06l7I7mqLr4hVQtXA7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070078



Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
> Ensure that the backup info for machine check is the same offset as that
> in struct sie_page!
> 
> With the assertion in place we do not need the comment anymore.

Nice and useful.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/kvm/vsie.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 937f9c99bc00..7c3b5e11b301 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -33,10 +33,7 @@ enum vsie_page_flags {
>   
>   struct vsie_page {
>   	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
> -	/*
> -	 * the backup info for machine check. ensure it's at
> -	 * the same offset as that in struct sie_page!
> -	 */
> +	/* backup info for machine check */
>   	struct mcck_volatile_info mcck_info;    /* 0x0200 */
>   	/*
>   	 * The pinned original scb. Be aware that other VCPUs can modify
> @@ -71,6 +68,7 @@ struct vsie_page {
>   };
>   
>   static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
> +static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
>   
>   /* trigger a validity icpt for the given scb */
>   static int set_validity_icpt(struct kvm_s390_sie_block *scb,
> 

