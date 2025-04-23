Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F82701A6
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400087; cv=none; b=QBmEhvBXK23ID1ZqQvHbU1S8/necD4h6YTei/qr5Yhm92ONpSGDvl7ouRYQ4mE6S+z6dFnBWWwJowZmW3T4WgN3l6kOW+zstl2tMOPfU64ExuFzzK0GicwWChaq8sY3araTba5kR4KrCLdOswVudlW69/3esSU/ex5TY5+z+u6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400087; c=relaxed/simple;
	bh=HejitWKgwWIj/qqSTMu42AhsR1l+NYL/+QNAP/2iURQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Duh3e+waKuyJHs+6tTPExhq9fz07LZ4apG7TYXHsU9Ap4ZataM8Y36MKXLzLTJzlOhfF7/TMjlHyP+dBqnOn4nuE6TOHTtd8iQcs6qf6oosQck4G94YrkAuFBQKfREV+dsI6w9gzyL9prDaC82LaRFJtRF8D7RuA55Tt2fYv5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WCcQSNit; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCcQSNit"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fiZY002092;
	Wed, 23 Apr 2025 09:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=9uA9cMWHJsttGFaMx4/dLzlxebhiDWO/OepWMoMDUac=; b=WCcQSNitSQjD
	JpTPBxM0eiSXyUdeUI9Iaf+EaAX0RkXFzgl5XwjFYAeMgaSHMJ8fteM4bJuTg6+X
	9zM43y9bj/4Dv4SoW5tXgf7GaSnvvT9eaOTv4vxC49MGPIQjhM1pDdNPpJaAozfk
	d7iuSMCk8ZX2YoiyB6Kewaps3zgTptMH1kEvsPGUa2sfxuGFdK75g6znUWnk/V2D
	AA3icij/8LrwX1+L5ySrBKBa8yneIPafN6tyiDN8qjbnI3eBNrxVqkqi4vBu9iEg
	aUfxCzelBHR7z5cxPdAPUxOP/E6eswwuN29yTuFcOp+AxRyyISBZIbAvyP+smOwz
	iLimEE8/0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpt2g7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 09:21:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6YFiO028443;
	Wed, 23 Apr 2025 09:21:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvjbbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 09:21:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53N9LIbg25756160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 09:21:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FBA75805E;
	Wed, 23 Apr 2025 09:21:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96EE85805B;
	Wed, 23 Apr 2025 09:21:19 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 09:21:19 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 11:21:19 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
Subject: Re: [PATCH v6 04/25] s390/zcrypt: Avoid alloc and copy of ep11
 targets if kernelspace cprb
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <ad59b9e8-4d53-43b0-a9de-4af6ed4b9f99@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
 <20250416135801.133909-5-freude@linux.ibm.com>
 <ad59b9e8-4d53-43b0-a9de-4af6ed4b9f99@linux.ibm.com>
Message-ID: <af1862b803a58a6d78595725e4eb3740@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FhXA5nlILHooIIQNzer0Ii4MHI3Vui62
X-Proofpoint-ORIG-GUID: FhXA5nlILHooIIQNzer0Ii4MHI3Vui62
X-Authority-Analysis: v=2.4 cv=a/Qw9VSF c=1 sm=1 tr=0 ts=6808b112 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=sSBaeIrVoWQDrLzOg8sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2MSBTYWx0ZWRfXw9WmbHBM7T72 0PKht76/V3d8qHgsB4seEncDMIBrwNYblYN4YslzChdFm6SsYWUDTKdfttXry8z3MbWuHqKXjoZ vqwv128SsJQt712O6ND31bwMHOW4FBPaf5+tyhSNX24mwy4Z7v5KlajgFgaFkd++EXeJgdE6oN1
 5beGH016eQVStuaR654cby2SNNCUyHZLuBOGJXzUnk7J+2WxaOiW6j7y4qJltc8bIJXATsUUGT+ GkiHgOf+Y4DtWDox/+q3S/BbsHqgg5eA/YUPDHtEh0JT3RsgpqNs46zzM9UmMZe0PLvbH3jvOcH QK22voSediYoRNhkphRNcyxYJuvZbtD2VWV54dxLAf/uHg0Rz6LNIipVA63VjEnjdNNxV69+Qn7
 3XFJGafBWuSp9VoA/2QIR0bgFv49RgZaCIuv7jvLcrse3iOfDJhR2nHmH+bIpEXntMiUNPJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=797
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230061

On 2025-04-18 09:57, Holger Dengler wrote:
> On 16/04/2025 15:57, Harald Freudenberger wrote:
>> If there is a target list of APQNs given when an CPRB is
>> to be send via zcrypt_send_ep11_cprb() there is always a
>> kmalloc() done and the targets are copied via z_copy_from_user.
>> 
>> As there are callers from kernel space (zcrypt_ep11misc.c)
>> which signal this via the userspace parameter improve this
>> code to directly use the given target list in case of
>> kernelspace thus removing the unnecessary memory alloc
>> and mem copy.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the change below
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c | 41 
>> ++++++++++++++++----------------
>>  1 file changed, 20 insertions(+), 21 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>> b/drivers/s390/crypto/zcrypt_api.c
>> index ad09c5306e28..f96f596e578f 100644
>> --- a/drivers/s390/crypto/zcrypt_api.c
>> +++ b/drivers/s390/crypto/zcrypt_api.c
> [...]
>> @@ -1052,29 +1052,28 @@ static long _zcrypt_send_ep11_cprb(bool 
>> userspace, struct ap_perms *perms,
>>  	target_num = (unsigned short)xcrb->targets_num;
>> 
>>  	/* empty list indicates autoselect (all available targets) */
>> -	targets = NULL;
>> +	rc = -ENOMEM;
>>  	if (target_num != 0) {
>>  		struct ep11_target_dev __user *uptr;
>> 
>> -		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>> -		if (!targets) {
>> -			func_code = 0;
>> -			rc = -ENOMEM;
>> -			goto out;
>> -		}
>> -
>> -		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
>> -		if (z_copy_from_user(userspace, targets, uptr,
>> -				     target_num * sizeof(*targets))) {
>> -			func_code = 0;
>> -			rc = -EFAULT;
>> -			goto out_free;
>> +		if (userspace) {
>> +			targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>> +			if (!targets)
>> +				goto out;
>> +			uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
> 
> I mentioned this earlier already, the cast is not required here,
> because xcrb->targets is always a user pointer in this if clause.
> 
>> +			if (copy_from_user(targets, uptr,
>> +					   target_num * sizeof(*targets))) {
> 
> You can use xcrb->targets directly without any cast (and also drop 
> uptr).
> 
> if (copy_from_user(targets, xcrb->targets,
>     target_num * sizeof(*targets))) {
> 
> [...]

All these requested changes are included in v6. So only
Holger's signed-off was missing. Should I re-send a v7 with Holger's
signed-off on patch #4 ?
