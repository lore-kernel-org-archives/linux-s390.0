Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CED1F4634
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401129; cv=none; b=twqi0fwi5T7aqRHjLPlMwr0BoYUHg3tR9cS3q1Lg+0uL2Om7rXmKALr8UKlGvafddeKqeJsy84IhdSo81k+XqzYnWmgNhY37+YUPC6GciuyzBJ2a9UReV3GDGhDGNXO2750YqHZsManwtt+18AFUw7PPTn8cXRUOJOvad3Wy2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401129; c=relaxed/simple;
	bh=c9yliqbBrSQheQIRDnqw6N9tVtuPZx1oBa1fX3GcZ5k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l2wmw+ZiVWOFxrb6SMa1LqXsCiRB1Ycux2ZbT+I5TO+DZiYDJalPjNcB96NnILxpNmPgIklvzzpJqFkXQHdjEJqD0XuKF5hiOa4zIgNG/pZhhUncXnaqOxzQtOPbsx706oN1V46EXAj2UDpb05SfxSDCtnUN0Ubjv0tniZec0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GD0zY7d4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GD0zY7d4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fifP012517;
	Wed, 23 Apr 2025 09:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=tc+MBuULtsKAWYlaJoULaGxuE4qgZplReXM+WK5jrUc=; b=GD0zY7d4dPFC
	Q19ioghKEvRR0XV+6pWUkkTSlKfsP6OnxmDSAHjzpsbZK9S00TTuQ3jHwAsYp8te
	XaNDNYlbu0cr5dWWCqqJPxKgdPZvgnr6P99M5dDOwFenQQpfFatml11uwuxqXjZr
	eNZOvdVqoM+Oxp3iq+NrsTJnnzn67YKZM2k093+yUoajKX4nbs3PAuIu+q+UF+mX
	3L8bbhWQ7PL0Yp/uCRv14algwvdfvteEK4hDKKoEFWOdQPMkikkBNClMmPXJ0XSB
	nF0R/gBzIDfClDto8SxA7YoSLoDAPoYQl86ctg2abZ8Lt4w+VIE9GJ5QztGbky/v
	pfPnWyohFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466n30a0u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 09:38:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6V4wD005844;
	Wed, 23 Apr 2025 09:38:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxad10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 09:38:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53N9cf5213894384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 09:38:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE05858052;
	Wed, 23 Apr 2025 09:38:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3255058056;
	Wed, 23 Apr 2025 09:38:41 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 09:38:41 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 11:38:40 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
Subject: Re: [PATCH v6 04/25] s390/zcrypt: Avoid alloc and copy of ep11
 targets if kernelspace cprb
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <af1862b803a58a6d78595725e4eb3740@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
 <20250416135801.133909-5-freude@linux.ibm.com>
 <ad59b9e8-4d53-43b0-a9de-4af6ed4b9f99@linux.ibm.com>
 <af1862b803a58a6d78595725e4eb3740@linux.ibm.com>
Message-ID: <cecbc6a6cd73aba754f9c4e9075e8938@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2NSBTYWx0ZWRfX1YZgH2EGCR4p sllGcdhRdSHA4bPetgFtU2ACzKmfpZsGk9+J+8PSuuwhkDbBvuNAd/XpiTVgvjC1f7eeWkEAFS9 0rNExszhA5NAgpgDstTf82WJAIxyKitOD4sTYQffOTmynykDn89uvZovTMVGw0P2jih33VuQ4CZ
 7upxqDVdogS8zWYmpar40qngY67T8gjbdMHNXYzMidJiRlHDJd4E0u4R2IP8WA5jBCDZ1NOPQcn 1DcewfgRWSFGCRMDK7ycoa0OgH7iAbU6JoQgffqa8AbNVV5Ai+ZKAdn1o/2h8wrMoIFyy7FzUVu PEknPaQQI/tU9peoBrQ69uhaotUyYj/mqVqz2WIvxabcoiq6cr+PoP+3YmGlPAR5hPtM9V+yhxi
 aDM82kvv5VCINGtTazYy5oacIUuwEwUVDGE1snfZ3+N+v/34wI6SATYBh9Mkr0Yd7EI9H9ig
X-Authority-Analysis: v=2.4 cv=aoiyCTZV c=1 sm=1 tr=0 ts=6808b523 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=sLxuRCDkvE3baNbqcHQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: s6CW0yv_g8-4xWgj2VLXTk2bPUXer4Ho
X-Proofpoint-ORIG-GUID: s6CW0yv_g8-4xWgj2VLXTk2bPUXer4Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=794 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230065

On 2025-04-23 11:21, Harald Freudenberger wrote:
> On 2025-04-18 09:57, Holger Dengler wrote:
>> On 16/04/2025 15:57, Harald Freudenberger wrote:
>>> If there is a target list of APQNs given when an CPRB is
>>> to be send via zcrypt_send_ep11_cprb() there is always a
>>> kmalloc() done and the targets are copied via z_copy_from_user.
>>> 
>>> As there are callers from kernel space (zcrypt_ep11misc.c)
>>> which signal this via the userspace parameter improve this
>>> code to directly use the given target list in case of
>>> kernelspace thus removing the unnecessary memory alloc
>>> and mem copy.
>>> 
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> 
>> With the change below
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
>> 
>>> ---
>>>  drivers/s390/crypto/zcrypt_api.c | 41 
>>> ++++++++++++++++----------------
>>>  1 file changed, 20 insertions(+), 21 deletions(-)
>>> 
>>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>>> b/drivers/s390/crypto/zcrypt_api.c
>>> index ad09c5306e28..f96f596e578f 100644
>>> --- a/drivers/s390/crypto/zcrypt_api.c
>>> +++ b/drivers/s390/crypto/zcrypt_api.c
>> [...]
>>> @@ -1052,29 +1052,28 @@ static long _zcrypt_send_ep11_cprb(bool 
>>> userspace, struct ap_perms *perms,
>>>  	target_num = (unsigned short)xcrb->targets_num;
>>> 
>>>  	/* empty list indicates autoselect (all available targets) */
>>> -	targets = NULL;
>>> +	rc = -ENOMEM;
>>>  	if (target_num != 0) {
>>>  		struct ep11_target_dev __user *uptr;
>>> 
>>> -		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>>> -		if (!targets) {
>>> -			func_code = 0;
>>> -			rc = -ENOMEM;
>>> -			goto out;
>>> -		}
>>> -
>>> -		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
>>> -		if (z_copy_from_user(userspace, targets, uptr,
>>> -				     target_num * sizeof(*targets))) {
>>> -			func_code = 0;
>>> -			rc = -EFAULT;
>>> -			goto out_free;
>>> +		if (userspace) {
>>> +			targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>>> +			if (!targets)
>>> +				goto out;
>>> +			uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
>> 
>> I mentioned this earlier already, the cast is not required here,
>> because xcrb->targets is always a user pointer in this if clause.
>> 
>>> +			if (copy_from_user(
targets, uptr,
>>> +					   target_num * sizeof(*targets))) {
>> 
>> You can use xcrb->targets directly without any cast (and also drop 
>> uptr).
>> 
>> if (copy_from_user(targets, xcrb->targets,
>>     target_num * sizeof(*targets))) {
>> 
>> [...]
> 
> All these requested changes are included in v6. So only
> Holger's signed-off was missing. Should I re-send a v7 with Holger's
> signed-off on patch #4 ?

Ok, my fault - Holger's suggestion is NOT fully included. Will send out 
a v7...
