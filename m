Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1734A0EF6;
	Tue,  6 Oct 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301698; cv=none; b=Yr0AAURZpPZBtBYCxHAbU3FITiUfKK6douhqMYLZWwfHwtEEu+RazINnfED5vCK0izzMKXAmBM8y11n+pUTwLa+drikOtkSGORk0tEgUvufhvUX1l5pUY8SXDyylKLKVZ5hoqAl8bpnrVBJm0j1wZVNQjA53fYBqRrCJo8wiPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301698; c=relaxed/simple;
	bh=/S4n+ZtDyQHQJrEX2Vc88E6pGvSnVb7tXLjCagBg0Fo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qkVqeGhLY1QD2IV81B1XsnUzQYQOOGKFLRwJWhwvH2DiGd83yg7M+1QbTn0kevkmh8B4JcZjUdNkh/3mcS8zAAePlWemxWsEQA56IpfGuKnsfHQJaPZEM9rQ1a9uKpttM8eJsOmSN6nZpzdW+ST/+8ZjpFhQZC5zQJQtfy642wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dPgkyKw0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dPgkyKw0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZTej4059033;
	Tue, 6 Oct 2026 15:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=+Kok9YvA9/ml0vr0F26j5JAMHpLdtuLNR7W3YctTk1k=; b=dPgkyKw0+c5w
	3frGcZa0qFoERGvAbhbC4y8+NoZbZO53QmeoAQdOm2hXqRq78TcIat+XAJSxHLsL
	ATScMm9aRUpFJk4vnKPCPun/VBIlv4WS6w3xNiVuiNYOLwf/dXrOIMJdM7djz4pV
	THE9Ce8diGI5A64lAIGcPKpw0v6FJEATuqoX3d17QPyLUZ5+3T3gT95TsWtJN+N8
	AlCJTIrjXItbvkCJ2fPn0u1/JdTvV4HMgGf3dH+hmv6s5CD/5HTShu1mazmh8U+J
	L3TItJWV9lLV/UqqruUhCQOwIUH7Mw9yWFwsKTHyI4Pid0vVyF57gmKhoEEyLsK+
	Qc3GZVwiuQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74rxwy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:47:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHg3O453434;
	Tue, 6 Oct 2026 15:47:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgtg21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:47:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696FlmRP64291150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:47:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B99258043;
	Tue,  6 Oct 2026 15:47:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD4458061;
	Tue,  6 Oct 2026 15:47:47 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:47:47 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 17:47:47 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in
 cca_query_crypto_facility()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20261006142233.538C31F00893@smtp.kernel.org>
References: <20261006141245.7558-1-freude@linux.ibm.com>
 <20261006141245.7558-3-freude@linux.ibm.com>
 <20261006142233.538C31F00893@smtp.kernel.org>
Message-ID: <8c198689f01e8671948e6ba099b9784d@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _eyQcqshazDBw_CadMqqG_nQsG1SeDMq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX3erls2jDVFdy
 JWxgpw4gTqkM0VwFNzvfa274hAdVxWgGlt2YkkZz8m804yGqpds9bmNce642qgg5xOlZEZVzb44
 eW6bcPdnGXqMOemrtIHaKMsL3Xa1Tvk=
X-Proofpoint-GUID: _eyQcqshazDBw_CadMqqG_nQsG1SeDMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX8/IFKQNVFMn3
 LDfgIZiKp5xU46sCtShVek4Ec+QHirvOgJXunDf4SXZdgHh6eGxqRRzM43orQhjQujuobXxSsU/
 1uwOG44Vco6oiLHi3vilvrCafV/xcyu6O90TFF3mJ8AUldLSLv+qklhDOH43VsKLp59Dz5KoXYI
 ue5Eo8Svfrp8TVjALQnBCh4qGf4zd8vtXBy5HBKfrSa2AUQwI1qmYj/BtG2yWiAUqpxtM4Dykiw
 VGfrK/abZ+NLPjK6Gd1j8jG0ezq9hohtQ/kZ2UZlheewofwJcbnOutyrzxPdWfqERpxN14ZE9ak
 +H1ttX26aAb+ZH5LEVBQTl9+U0EHJfEyBHQlQxa1SNPUud58cp3Cb1tUAUhSNv7Wmg7v0S5613/
 podO0jNrDlvOSFCaLCS8RQorT1GLbEq2sAN54HsVXqF2uNs6DoS28EaodKjtIaCxtRrCSnllKTs
 6TsUEhsqNOVRkW5sXbQ==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac51826 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_9M-GxliydPItMSevCgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

On 2026-10-06 16:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] crypto: zcrypt: OOB read and underflow in 
> cca_query_crypto_facility()
> --
> 
> commit 5de45449fe732b12f3310f3ce76a2abecc04ed97
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix out-of-bounds ptr advance in 
> cca_query_crypto_facility()
> 
> The FQ reply parser code blindly advanced the walk pointer by a length
> value read directly from the hardware reply payload without checking
> that the advance stayed within the allocated reply buffer.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 19909bf43dc91..862947431164f 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [ ... ]
>> @@ -1673,27 +1674,44 @@ int cca_query_crypto_facility(u16 cardnr, u16 
>> domain,
>>  	prepcblk->rpl_parmb = (u8 __user *)ptr;
>>  	prepparm = (struct fqrepparm *)ptr;
>>  	ptr = prepparm->lvdata;
>> +	datalen = parmbsize - 2 * sizeof(u8);
>> 
>>  	/* check and possibly copy reply rule array */
>>  	len = *((u16 *)ptr);
>> +	if (len > datalen) {
>> +		ZCRYPT_DBF_ERR("%s reply rule array len %u exceeds datalen %zu\n",
>> +			       __func__, len, datalen);
>> +		rc = -EIO;
>> +		goto out;
>> +	}
>> +	datalen -= sizeof(u16);
>> +	ptr += sizeof(u16);
>>  	if (len > sizeof(u16)) {
>> -		ptr += sizeof(u16);
>>  		len -= sizeof(u16);
>>  		if (rarray && rarraylen && *rarraylen > 0) {
>>  			*rarraylen = (len > *rarraylen ? *rarraylen : len);
>>  			memcpy(rarray, ptr, *rarraylen);
>>  		}
>> +		datalen -= len;
>>  		ptr += len;
>>  	}
>>  	/* check and possible copy reply var array */
>>  	len = *((u16 *)ptr);
> 
> [Severity: High]
> Does this code introduce an out-of-bounds read and subsequent integer
> underflow?
> 
> If a corrupt or malicious device response sets the first array length 
> (len) to
> exactly or almost exactly the remaining reply buffer space (datalen), 
> the
> first array parsing will advance ptr to the end of the buffer and 
> reduce
> datalen to 0 or 1.
> 
> When we reach the second array parsing here, a 16-bit length field is
> unconditionally read from ptr before checking if there are at least 2 
> bytes
> remaining in the buffer (datalen >= sizeof(u16)). This could read 2 
> bytes past
> the end of the allocated buffer.
> 
>> +	if (len > datalen) {
>> +		ZCRYPT_DBF_ERR("%s reply var array len %u exceeds datalen %zu\n",
>> +			       __func__, len, datalen);
>> +		rc = -EIO;
>> +		goto out;
>> +	}
>> +	datalen -= sizeof(u16);
> 
> [Severity: High]
> If the out-of-bounds read above results in a value smaller than or 
> equal to
> datalen (e.g., 0), the check (len > datalen) is bypassed, and the 
> subtraction
> here will blindly consume 2 bytes. This would cause an integer 
> underflow if
> datalen was 0 or 1, wrapping the tracking variable to a huge value.
> 
>> +	ptr += sizeof(u16);
>>  	if (len > sizeof(u16)) {
>> -		ptr += sizeof(u16);
>>  		len -= sizeof(u16);
>>  		if (varray && varraylen && *varraylen > 0) {
>>  			*varraylen = (len > *varraylen ? *varraylen : len);
>>  			memcpy(varray, ptr, *varraylen);
>>  		}
>> +		datalen -= len;
>>  		ptr += len;
>>  	}
>> 

Ok i see ... this needs further investigation as well.
