Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65923976B8;
	Thu, 26 Mar 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520362; cv=none; b=FWJmgFkoeM5TZPFQURcw+12NK1PZcNa8E/RPs+uwQugNt3XfN3VQzB7T4PzYD9k7zbCblmVBMJOybu9r4bNwQSPfPecmYXrI6EF33+xbC1G3q0V8Mro6hacitEUcA0R9+lAHDwhSf07jjvBqqnzUV54ZdeqrpDsFs4J6mg0XfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520362; c=relaxed/simple;
	bh=8nlXIgLB2+L/cMlY8OxEeYbvYtIVZJMvx9VEbZoRDLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTgpeJUHCs4zPTJPX/mVf/33xX7NW5IE8H8uX9tVbmybNDrW3S4bgBXXCwwn47EY/zs0w2UaNoGLN25sPLAua2QhZX0KH30hU65olGRrAGEu33h5O3O8R4Z8XDPAtgRd5Zs0bSxQCIEvqvjOiqUd48kBRl2WTXSd9zvIHiKTm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o2+d3pCo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o2+d3pCo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q5dn0S666646;
	Thu, 26 Mar 2026 10:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fEp6/4
	SzrI5VfbwnKEoVIxybnutuKXrm+C/u9yO/csg=; b=o2+d3pCo0U2L59fILEhYQO
	64dZ3SntT9QsU5wzmWS4qiafQAhBUrvZT//ktSu9bbNbavogIaDp2cgFj2X+jkwS
	HHABGySuZBnbov2pjNo5pMxylNGbzCcWVmS7niejppKsXHjkGumJKTdb90d+JUaI
	8DBRDZVAbNETZ8HYpNVUxD+3qsuqWcgB/+bf6VtjpuIoZUFfZ2T0sR2m69BWf10Q
	/xZK7FjYphZDouSNhk054K5gieVPHj92/Au9LHOiLYCR+PLDR8cfFHWPVGpM6nT6
	gPnLYcB/BTZGEGF0PmpmBfnYyBjiF/ZsLqb4U8t+Sw0PqHq+BMTFfIkMLrOOUlmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty4kyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 10:19:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q6uEvu026797;
	Thu, 26 Mar 2026 10:19:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m2cqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 10:19:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QAJCcN590550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 10:19:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45CBF58055;
	Thu, 26 Mar 2026 10:19:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC8A58043;
	Thu, 26 Mar 2026 10:19:11 +0000 (GMT)
Received: from [9.61.136.69] (unknown [9.61.136.69])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 10:19:11 +0000 (GMT)
Message-ID: <00fa1811-97a7-4a71-8946-7eae73ce5b12@linux.ibm.com>
Date: Thu, 26 Mar 2026 06:19:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/24] fixup! KVM: s390: Remove non-atomic
 dat_crstep_xchg()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        imbrenda@linux.ibm.com
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
 <20260325210149.888028-2-akrowiak@linux.ibm.com>
 <c1deb93a-a2cd-4a5f-a8e2-9cc078f407c8@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <c1deb93a-a2cd-4a5f-a8e2-9cc078f407c8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c50823 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vxBSpDEMcLf9NR8dcUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3MSBTYWx0ZWRfX6bIsSPKjNF+h
 IPbFDI8EJSc6pvLSBkZdYJaDM2HMjxZ2HpV0LTz10j9+pLWicddkw4cRyKeBI1blRAx9La4VoRD
 ZhKHdBoJnxPxVWk/K+Iy98qgFRkJMe40hW1q1TIA665DE6dN9/N3A7Zql597zeasArT6OZvujUr
 bIyA/xJRcEUU+sZ4/Aa2AzecQ1cWSNCgioxrrWxO+Vk3GyIpF5bOgnEtii0xmuz7yvh7+JgsNTu
 5km/pdyPZn3Cu3AHk/uEp/nlroxzs7QJnHhfzvPpp1MK/B/1p7z+2F7+hEvXuIaD/aycjKdiW5n
 cBrVXXpAsvrOr0Rz54lSAYVH9uQHY3q9tb3MzxP1+QlO8ADWAxguFwQ6FOHVnT2wI+XsYxM9bE8
 tBFIby6bP/K4jZWOuOShz7Ob4IWeOrIXsO8ML09yYS7/yOhatoI1Z6xVNfnd0c0m8E/N6WaeWt4
 frftbuar/hDEGvBxdxQ==
X-Proofpoint-GUID: PDF0gmlfHNPnscKRZwjgajpRDwATdX7k
X-Proofpoint-ORIG-GUID: PDF0gmlfHNPnscKRZwjgajpRDwATdX7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260071



On 3/25/26 5:30 PM, Matthew Rosato wrote:
> On 3/25/26 5:00 PM, Anthony Krowiak wrote:
>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Tony/Claudio, I suspect this was included on accident and will be
> handled separately and dropped from this series?  I don't even see it
> mentioned in the cover letter.
>
> If intentional and intended to be part of this series, then please add a
> proper commit message.

This definitely does not belong in this series. I accidentally included it
when building the patch series.

>
>> ---
>>   arch/s390/kvm/gmap.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
>> index 967a280b3235..19379d162777 100644
>> --- a/arch/s390/kvm/gmap.h
>> +++ b/arch/s390/kvm/gmap.h
>> @@ -198,7 +198,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
>>   							 union crste oldcrste, union crste newcrste,
>>   							 gfn_t gfn, bool needs_lock)
>>   {
>> -	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
>> +	unsigned long align = is_pmd(*crstep) ? _PAGE_ENTRIES : _PAGE_ENTRIES * _CRST_ENTRIES;
>>   
>>   	lockdep_assert_held(&gmap->kvm->mmu_lock);
>>   	if (!needs_lock)

