Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D1483BF1;
	Thu, 17 Sep 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638621; cv=none; b=V2Mq+jFnMrI7TWTedhEag+i/6etSvOlNKoaYNKUqzT1okTiJYfo16XT3/giLOkDH03A+8rUGVdjzhGrm05tUEBUU2M9roIogwTb3jC/HNrd1mCnxw7e+c1mGBxD/r3PalF5SdZgQG9w+lDAV0yYvjnVdCiPL1XPUA7hAv1pm8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638621; c=relaxed/simple;
	bh=+Vq7VyY8jt+tyPHeeMu3dsn/m0TEJ+EqWN/3OQo09TA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BolekXaVyHeI8LNdsIsgjijwBJHnG2ZhU87lUdNnkme8mZIHZuakYwkei/e0e+Irmg3UXoYKC9X7HFJO0fdfirEyPrYCWtWTniE4r6IbBNvBfGL6d6Ev03B+XO9cB8BiRPeRyMArTh8X4sk44GzizeJzzLboDb0QcbbPWGRZLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p/dUKsTX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p/dUKsTX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62LLE1743422;
	Thu, 17 Sep 2026 09:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1um41C29ZBKqPqzYPgGQU991pVYC2B
	HMKlk+Am+86g8=; b=p/dUKsTXPDK8STI5rsxrRfO7DXtfCVAF84BxqVyIVM9Be2
	+GCWvJ6Zudtva4OWFJi4cLPfVus3pHbfzdiC6q3SPXeEMJrDd3uqPZ/D2xuCpBYJ
	iKg5dDLyzF3AYUSKeGq6k/Aicmhe9s50B1lKIsCAjPvHyutUiTS62HTqz7/BCbwI
	rAEKzrNji+NrvP7RpfgX8NMQZDhiaYBTiddxgX3JfTiASh8qGPlfrFleb4mOmiEU
	wXeanq2EQwYzI+4TVdPwlOR3X2YeLzd18fncmRGX3FfPmFVpQQovM9W4N+wPX86D
	B62bNZLrjKGnsR925E3XM+EqJzs35Wp00BpP+rNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv93rj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:50:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aQgv2917878;
	Thu, 17 Sep 2026 09:50:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa1pmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:50:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H9nxNY53084442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 09:49:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90A2B20043;
	Thu, 17 Sep 2026 09:49:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E68120040;
	Thu, 17 Sep 2026 09:49:59 +0000 (GMT)
Received: from localhost (unknown [9.224.74.101])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 09:49:59 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v5 1/4] s390/sclp: Introduce macro sclp_gds_for_each()
In-Reply-To: <20260917070850.B5E171F000FF@smtp.kernel.org>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-2-egorenar@linux.ibm.com>
 <20260917070850.B5E171F000FF@smtp.kernel.org>
Date: Thu, 17 Sep 2026 11:49:59 +0200
Message-ID: <874ifodx6g.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzMCBTYWx0ZWRfX4ttOaPSl/Ss0
 GVDWjdRX6uD+rAfkfEWwdbvJUCAVDscTwVDUAa+nzNY2ariXMokCNp3vLgiAxS/W/DOboX0usH5
 h3rs2g3h2VTgG2cMh7DMtbcIhZF1mLk=
X-Proofpoint-ORIG-GUID: 8f_Cx2QJNsgBiOIsfxGu19-C-NgSqNrJ
X-Proofpoint-GUID: 8f_Cx2QJNsgBiOIsfxGu19-C-NgSqNrJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzMCBTYWx0ZWRfX+2oS+yFzAdAt
 oQXuQVkTau8kH8wy/2HARUPPJX1jZjS8We5GPhFvKj5kM50/qn2v20WUkHQbgXOqaqcRhAQo6n+
 P7Z8GZgZ1zdAOXyK4BRQ8oT3an65j+MILLcfBFJtP5K0AO60aGp4XTpBCySsEihBkJxr8VxUsXe
 IwaTrDedzEY8ajpoC0kdDmOnOCzhD8+41lWBCflqxMvliPb0o93fg1NuRwCCMcTF+CovDqdUc68
 oyheChNPs3UAen1PrxetfoIVp6yMmYkvg6zdzWAjawQ+l6MS74PKGTEwqR7ep/zrzXrFNHgyyP3
 IBwNw4JB4LdOtFJ7tC75FdjSHHmeMFnFqdsaTF/JJbD47G/derUEAylXtLgmVPgVeoQwXMP+DSW
 k6yvv47ebAFDfhecW2E9uHraxNHWE7nofM7uFL4npf4cHKOj2cPOdH93M0iCuISeId5sUZYVwDg
 dIshulVKcgAFd9YhcdA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aabb7cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FAke6POGxsZ3gMvDDg4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170130

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] sclp: out-of-bounds read in sclp_gds_for_each() due to integer promotion
> --
>
> commit f292c3c2b28abf9088d99e5a8af81f738a00c9ee
> Author: Alexander Egorenkov <egorenar@linux.ibm.com>
>
> s390/sclp: Introduce macro sclp_gds_for_each()
>
> This commit introduces a macro to iterate safely over GDS {sub}vectors. It
> adds bounds checks to avoid infinite loops and out-of-bounds memory accesses
> when parsing malformed event buffers.
>
>> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
>> index b31a680e08714..d22003b769f14 100644
>> --- a/drivers/s390/char/sclp.h
>> +++ b/drivers/s390/char/sclp.h
>> @@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
>>  	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
>>  }
>>  
>> -static inline struct gds_vector *
>> -sclp_find_gds_vector(void *start, void *end, u16 id)
>> +/* Loop over all GDS {sub}vectors in a safe manner. */
>> +#define sclp_gds_for_each(v, n, start, end)	\
>> +	for ((n) = (end) - (start), (v) = (start);	\
>> +	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
>
> [Severity: High]
> Does this code introduce an out-of-bounds read due to integer promotion?
>
> If a malformed SCLP event buffer is provided by the hardware with an
> evbuf->length smaller than the header size, start will be greater than end.
> This happens in callers like sclp_ocf_handler() and sclp_tty_receiver():
>
> drivers/s390/char/sclp_ocf.c:sclp_ocf_handler() {
>     ...
>     v = sclp_find_gds_vector(evbuf + 1, (void *) evbuf + evbuf->length,
>                              0x9f00);
>     ...
> }
>

This is true but the length of an SCLP event buffer should be larger than its
header.

To properly fix it i will make the parsing of event buffers in
sclp_dispatch_evbufs() more robust.
