Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A72940B
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911458; cv=none; b=NvqKY/y0KhztVTDlBoAVrRM3mhGiY3EaR5C+WMZNm+/+prDH5MfTRMWIDNkA76bgjI/AGM9P2f2jH6A0BhAgLlF5BQ3t8LkMINkIkC3A/GNyJERUr+I69yGmwm4OmUBH6EPAOmlcfLoKhFYc5BIArOJ6WdVOWMVCGU8YkhOmblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911458; c=relaxed/simple;
	bh=T8RjMlU2uh3SX/g/uFqYpWNV+wVkzc8oCYYPzCJtGjk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q+ty+YEmqbtfZXQVq40jYndt0jPetY9cFYlEgF31R6tcX+7hqjenw2W8A6yYznAKsFQaPmHlD1aaSAs8o4nvo0+9HHAiguYot+z/Quk2yVUgPUJhY6ayEpza9Eg9VpkgrO3aINSULCcr+NcIr44zLn266rkC32byzciTTVTIgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WgNURUG6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WgNURUG6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCAEFs026985;
	Tue, 25 Mar 2025 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=kE3+sj4yTWZFrGNv10ee///YvhTqNIkN8HXr2sgPviE=; b=WgNURUG6R66G
	3FrkEfqkU9sigfHiFgqHNoOsJWgjBqKZ6x4ilbq1t+zVZPsbyW88Q56AvDlQEHS5
	Yl3CVJi/k+La9shXhMZbD5MA5kpsYfsPqoXVx37Bw/o9XQqNb3s1EN5AOgUiA+zv
	C6InxrYkU3nXn3Ph+gj3Nvowt2zvsozhhXuoxHN4XLL/c0dxZCGoabM7z62TwZXy
	ekqCvDdbjr3SjBS8zrmIYCPFmRYyKiXu7o+mCYLq70xIbP9gE5cqFt9uifX7/ywS
	2KE/DW9h+/jKQ/6fWSfhOSBhv3IIKm6lz5zy0ccCJyo6u1q3leS2Hc6KRwCJ4bnB
	thVs6Mks/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjww2cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 14:04:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDqgbM009693;
	Tue, 25 Mar 2025 14:04:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkkg3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 14:04:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PE4A6g64881098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 14:04:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4450A58054;
	Tue, 25 Mar 2025 14:04:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A41065805E;
	Tue, 25 Mar 2025 14:04:09 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 14:04:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 15:04:09 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 14/20] s390/zcrypt: Locate ep11_domain_query_info onto
 the stack instead of kmalloc
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <c64f1058-ec1c-47f3-bbb6-e1b64fc001d7@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-15-freude@linux.ibm.com>
 <c64f1058-ec1c-47f3-bbb6-e1b64fc001d7@linux.ibm.com>
Message-ID: <736e1e80f466535a47ce36655befae29@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UA-bocYQjeCSYpuVWn7l8SKA8VJhNhOq
X-Proofpoint-ORIG-GUID: UA-bocYQjeCSYpuVWn7l8SKA8VJhNhOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250098

On 2025-03-20 15:41, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Locate the relative small struct ep11_domain_query_info variable
>> onto the stack instead of kmalloc()/kfree().
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> One minor comment.
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index 6005ef79c001..7fb55be3e943 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
>> @@ -790,36 +790,31 @@ int ep11_get_domain_info(u16 card, u16 domain, 
>> struct ep11_domain_info *info)
>>  		u8  new_WK_VP[32];
>>  		u32 dom_flags;
>>  		u64 op_mode;
>> -	} __packed * p_dom_info;
>> -
>> -	p_dom_info = kmalloc(sizeof(*p_dom_info), GFP_KERNEL);
>> -	if (!p_dom_info)
>> -		return -ENOMEM;
>> +	} __packed dom_query_info;
> 
> Why is dom_query_info a typed struct? The struct type is not used and
> an untyped struct can be used as well.

You are right - this struct and the relevant struct for card info
are only function local and would not need a naming. However, I'll
keep these names - I think the idea was to easily copy this code
to file scope. The compiler removes it anyway.
