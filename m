Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922F44236A;
	Tue,  6 Oct 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296337; cv=none; b=d0uGvZZqo/YDBpI4h8YJf/xEHHDt6LMvFWd8N+y3jX5r1PlBIKgMmc0kEA2FmHA3d3RPdSjSXkf4P5Sw4dksyuMTJ3DjyJnqjcNTahZBD/XE6FE/4RyJ2q0gQPl+sxK52A/l9kPA//D8lAKXQ0z+o9ufLW55NUIdIBXNJjakeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296337; c=relaxed/simple;
	bh=MVL43bQqMlnDsdzB6w2pi7ukEIVAnEvrV1x+eQpsezM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YNUXsVm1+Sb+gJz8FCR9SKld6YZKpoQ5YvEdfKNgj+dpinrYhsi6CmzAPIqPWtg3wv8DBD2Bs+EXwqZf39mHj+a0pMTrVfxOqhH6AazUSlBSvHU6s+gjYRVm9QO4mMSjXxxKgizrka2O1usuE+wgq2GtYkI1D+xycqe2+RDXGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVSuBi68; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVSuBi68"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Da0cG3726236;
	Tue, 6 Oct 2026 14:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=81DpjX7Q18BJD6p8IxwkfHyDveC6lCi9F+whlen2894=; b=CVSuBi68ZzhR
	pN5iOpMcmRBk1D8xOHrmIPzzL9wGSf8MgH5/P50pF4GJKpTav9pLly0/93yo/Jwc
	4vn3pBi4j62LPsYbYvAqB/fsLrWk2Gh95eY/UzCskMJ3Ffs83uFmrv0pzmCIHeeh
	G0u6AvG34Wio3sbPmvLh66uw1F2mCHtBnytPHs4JBOL+va+22q9DMWpzLaoMz2HT
	OUg0V58SEV0DOG17boUkK2JC8RNMMC7ixCRmkz/MCeJ26NucSqoN95Ked3HI7VsY
	QovLP39arYAnEodOLPKf1hXYMu0ahvEZ3ReN2FFkK5DPV4XAvzEb7tNQcuE53vDf
	TNLxRk3OCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jqvv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:18:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHU49424975;
	Tue, 6 Oct 2026 14:18:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqya0up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:18:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696EIrbS30147310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:18:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0845805A;
	Tue,  6 Oct 2026 14:18:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39585805E;
	Tue,  6 Oct 2026 14:18:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:18:52 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 16:18:51 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261006133329.EDBA81F000FF@smtp.kernel.org>
References: <20261006132127.6251-1-freude@linux.ibm.com>
 <20261006133329.EDBA81F000FF@smtp.kernel.org>
Message-ID: <cc4fedb4841e10c272db10b3e2ea97dd@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yu4YThjGTJlhoVxyUJjcVbxMFfyCrIMI
X-Proofpoint-GUID: Yu4YThjGTJlhoVxyUJjcVbxMFfyCrIMI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX4FK5PabQBnH8
 5iEjGoFw42OW5NZ/tuM88tu62YMjRZybVUdtrQEBLdkk//Z5BXYq7YaeIvPQzqEmBRuuViJ0v1C
 pwHGD7iZ7OAP/7vP8iWnBr06nk/sNWg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX08o0QRQyEn4m
 IMfb9QSc7kpYSDEosTJrucs/7PUnbt9Z3IeK6ixA+/XNwxD0pxdIQMhbtyqHDz4qcIKJnB0sank
 WkgX3vYOGwTn9MbRuTzAety+xa/e9j2QdOO17j1BO9A8fB9I14RvWUAvr7WbshxLd9t18oweawF
 t/Qp0ZuFXzyGWleRlp8/YykVfGIcumAAvEX6la7Mnx3gntZ+qA6okx/R7HT6Ty9Ratto/vFN7Uw
 nB1qqP8djA2QRhWKJAsq9a3C90UXs1abOfbHRlfk3dmXYTQg4JmEMU+iNMyCf66E366pvfu0RME
 9vEFLVBefWjltqSugFv4C60PmkfgZ4SYZts0j2z1SfAr0jaHlNlDXJKbKCdefIno4nUlIGmxATl
 E+tQlH+8qA3z8nntZMgHd51dX48k9duxBE0y7lX3YYMksiGNxZhGXB6hj59ksV/X6jMTOp73raw
 0dqjmsAbZv8FOg480Fg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac5034e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6bZyiVwYS4zChwlI3kwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060056

On 2026-10-06 15:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] s390/ap: APMLM field is zeroed out by TAPQ_CARD_HWINFO_MASK
> --
> 
> commit a92b6e193aedcdab18cc73823dae8ff72c9b6ca0
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/ap: Support new APMLM field with PQAP/TAPQ instruction
> 
> This commit introduces support for the new AP message limit multiplier 
> (APMLM)
> field defined within the GR2 register on successful invocation of the 
> TAPQ
> subfunction. The formula to calculate the AP max message limit is 
> updated
> to incorporate this new multiplier.
> 
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index c91b6ace199d7..01d575c358875 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
>>  			unsigned int	   : 14;
>>  			unsigned int at	   :  8; /* ap type */
>>  			unsigned int nd	   :  8; /* nr of domains */
>> -			unsigned int	   :  4;
>> -			unsigned int ml	   :  4; /* apxl ml */
>> +			unsigned int mlm   :  4; /* AP msg limit multiplier */
>> +			unsigned int ml	   :  4; /* AP msg limit */
>>  			unsigned int	   :  3;
>>  			unsigned int qd	   :  5; /* queue depth */
>>  		};
> 
> [ ... ]
> 
>> diff --git a/drivers/s390/crypto/ap_card.c 
>> b/drivers/s390/crypto/ap_card.c
>> index c86397f4ddcd9..e9a8180f08c24 100644
>> --- a/drivers/s390/crypto/ap_card.c
>> +++ b/drivers/s390/crypto/ap_card.c
>> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct 
>> ap_tapq_hwinfo hwinfo,
>>  	ac->hwinfo = hwinfo;
>>  	ac->id = id;
>>  	ac->maxmsgsize = hwinfo.ml > 3 ?
>> -		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
>> +		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
>> +		AP_DEFAULT_MAX_MSG_SIZE;
> 
> [Severity: Medium]
> Will the new hwinfo.mlm value read here always evaluate to 0?
> 
> Looking at ap_scan_adapter() in drivers/s390/crypto/ap_bus.c, 
> hwinfo.value
> is masked with TAPQ_CARD_HWINFO_MASK (0xFFFF0000FFFF0F1FUL) before 
> being
> passed to ap_card_create():
> 
> drivers/s390/crypto/ap_bus.c:ap_scan_adapter() {
> 	...
> 	hwinfo.value &= TAPQ_CARD_HWINFO_MASK; /* filter card specific hwinfo 
> */
> 	...
> }
> 
> The 0x0F1F portion of the mask applies to bits 48-63. The leading 0 
> nibble
> clears bits 48-51, effectively forcing hwinfo.mlm to always be 0. As a
> result, the new max message size calculation hwinfo.ml * (hwinfo.mlm + 
> 1)
> seems to always evaluate to hwinfo.ml * 1, nullifying the intended
> functionality.
> 
> Does TAPQ_CARD_HWINFO_MASK also need to be updated to preserve the 
> newly
> defined 4-bit mlm field?
> 
> Note: This masking behavior might actually be preventing a severe 
> memory
> exhaustion vulnerability. If the multiplier were not forced to 0,
> unconditionally allocating up to ~960KB via kmalloc for hundreds of 
> queues
> in zcrypt_queue_alloc could cause frequent order-8 allocation failures.
> 
>> 
>>  	return ac;
>>  }

Oh well. Sashiko is right. This mask needs adaptions as well -> see v2 
then.
