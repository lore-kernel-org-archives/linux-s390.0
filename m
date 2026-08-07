Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD442BEB5;
	Fri,  7 Aug 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099149; cv=none; b=R05ws9ky/U0ZmeD7mI1lHFQFkDpnD/mkK0NCqpWizqPdHrp7lUuN+/p9NQDLSJNPsaEZvuYpwWLpR7BdmRJys5TJRqmxt4ETnVumItRwSxL4ZjN4479r+kwu64ZIouL878FFFwrk/ozJY+9jjSq1KZgGjfF91Wav/ERE720nbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099149; c=relaxed/simple;
	bh=PPDfUcUSMfTzzLhM0CFsSzs5YwpUFRWGeyivxWIFEoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUuhW8Hxdv//P4nwPOPPrGSZMDPIddnzq9RmLwsPaOfEwIPqGLOvfPpUU4hIfvf5qgOgTe8p2L3hgoOn3ewSprZV49K+GsbUzOvwgqYNOlyTTcRK6Jvee8b3213rmaH6Fw9t0c1E6V+Leggjc8+jYwPXZiLtIs5K56BfT369N2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MeoCXD0c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MeoCXD0c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HogX4134299;
	Fri, 7 Aug 2026 10:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JNaUrc
	8po9XZwvaACn+jnoBzES4LT7Ke7qo392YQ8NQ=; b=MeoCXD0cXhbmIrrPL/Unii
	KHC36PJ6TLgGhUVZzLl4t4ZPqy9jSMIMeTENE+zKxs10n5Z01S9iAtk/XFZ9icdb
	a2zzW0N5QR/KDKXle8AEI2mldcdR6zgyC/niT8rNBFpU3AM8gsYed4QYn63kH3IN
	XT9wcenNiMizDU+diVxhyLDms4RjRWHqmWK9P2wUia+1S3eyVk0tliJRtg7lDstZ
	Vebr29C6i6lrbhU+6HpapOkVv3DrpwXd4+55Zj/ktqtnkXQXhPtlDB9gxCcuAAzV
	o2V4P/EjqPyoD0LsZL2FfIHWhJdsupmrtIj1R/oC7WclAh7Eo9Ymqh+iL8MOhLzQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043eyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:39:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQHLY030400;
	Fri, 7 Aug 2026 10:39:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwfdsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 10:39:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AcwH344892526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:38:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C382004B;
	Fri,  7 Aug 2026 10:38:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7341520040;
	Fri,  7 Aug 2026 10:38:58 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:38:58 +0000 (GMT)
Message-ID: <55edcc8d-44fb-49c4-8e74-106023818009@linux.ibm.com>
Date: Fri, 7 Aug 2026 12:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] KVM: s390: vsie: Assert crycb alignment in vsie_page
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-5-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX2elzjCrLsl9U
 i7I+prLgqEjvu6bLGAWM9IEiaQzXgu05ajjS9lkkgA6z5A6T0uNETrvjerzJOK5qrxdbAQJvSwC
 VqBH4Vk3AaUEDr/7ZZGXCgt9RQ/qTb0S9j4rpxpDha2Vh0TCvTntHNX0dfx6v/T63wGq1UaPqz5
 fPKv+X9II8+6OJ2V4kkGvM9QRVPUm+dIszz0yM/pLbp7atPZikxDlBiE/jYqnffWh38dCmoYZNQ
 8HxnzEeu5VeZGvBpPJnGNbkWAo8QbCv36UzyCisEHPBRB8XYBMlYoWr/pxipOM2awUJtZA2ELbi
 1NZIdjNuxRqxMfYiZ5TXaULWUmy3QwFuPFxfOm57cMEu4fx8hBgFPx4dIVWlePZxE/Zkf3zr6+y
 SEQft6bYewPRb5Up6HvRHgdbzMiIJ3uXzK5hldzHcrjWD7bE1JKUNrspqPuFmRUrpc8A+EgSKqk
 nKH20C36debMxOwHfaw==
X-Proofpoint-ORIG-GUID: NLeVEQKAb7C9M4E9xm1r5r6cC2svWSg1
X-Proofpoint-GUID: NLeVEQKAb7C9M4E9xm1r5r6cC2svWSg1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX8L9bjcJWosKF
 aO7qcHuLgZVYcUaGsgV2hTsxTZJxtwLmoB6PdhuvnCPvJvl3P2mmJIGdIBliiWf3Dy2crHEjpkb
 s6oQ4wrmswCEuKyx/23Hpm0JvAYeuXY=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75b5c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=kYesBGs7L6EJELLaMM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070078



Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
> The crypto control block address is required to have double word
> alignment.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/vsie.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 7c3b5e11b301..c9392460edca 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -69,6 +69,7 @@ struct vsie_page {
>   
>   static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
>   static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
> +static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
>   
>   /* trigger a validity icpt for the given scb */
>   static int set_validity_icpt(struct kvm_s390_sie_block *scb,
> 

