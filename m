Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600333EC
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900981; cv=none; b=ioaAZitaz7rkxlmNCZBBnCZ4RCc2dxTDsnUDX40zABg3/Pywu2gP/L6uR4F5zv7ZoiiMkUgPjgEObtPMLocZjJk/lM9FQmH9WenkOAQBdMQiXSHdjmNlomkyV+EDNU+tEcKZmR91PyEC327wAl5i7TnqLT1uCNsLpsapWRmGXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900981; c=relaxed/simple;
	bh=0Dq01w1TJ7m9SV3stDQ5U2H+AhmlCn/CJHibDsCscYw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A9DTWYREuMCw17Q/M7oJ7dpwCC84VblK53ddusbcFj2zzJ4GOw4zWi0mKtBOkO88LxCb+Ihzwr4cWjNvjPaQsKyu2+MsXdrpk+FDJG+02+sob5l8PAl40HbrL4GrTXcB28z3oTWXw4x0Rdosb+BKY5mDMAgnu64luk2pNf8wxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZZQflOY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZZQflOY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P3juIi025356;
	Tue, 25 Mar 2025 11:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=UP9aNI0gSTnVkYond3k1RlRjNGE6UzGaEBwronzBBVU=; b=OZZQflOYkhGk
	oF0QwIPm7bVWabiiKmtIs4wi3r1LB8hCRvw+2SRxFtQR5/oELlb/Hszr27SbrDkp
	oS+YuaI4s7/fY5JNMYZXSaPlhB4WTsg+J640ImQI5q49lFpJ3OEvFKiuw5Z7FjXM
	FiorG3Y4l/c0njeeLEAi/AaTSQZlT3VqCFtppyHH/JTWYQtqoolJWJWKZne1DdW+
	GjuTxv4bUFoHMn1yJzuAScjd9wvbAKEAaDil21W5NVh7q/06bdDjqQy7ZbFBTQ5F
	woKOy/lryUdeBcGKxMD9pCz/RfKeulH0fbNZXRrTeN9cw/su+W6bC5w9DfBF1Wwv
	0P6lXWO08w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva1w3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:09:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9ENnb012250;
	Tue, 25 Mar 2025 11:09:36 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m308g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:09:36 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PB9UVG25494026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 11:09:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FC65805A;
	Tue, 25 Mar 2025 11:09:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B235958052;
	Tue, 25 Mar 2025 11:09:31 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 11:09:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 12:09:31 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 09/20] s390/zcrypt: Introduce pre-allocated device
 status array for ep11 misc
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <6a88fd00-3997-4930-a6dc-11ece42a6c72@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-10-freude@linux.ibm.com>
 <6a88fd00-3997-4930-a6dc-11ece42a6c72@linux.ibm.com>
Message-ID: <c4008d916e8506fb9961f049ecc301d9@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EkDwPmD5JI1GAVFXRrsEOjwwV3hDA5Fj
X-Proofpoint-GUID: EkDwPmD5JI1GAVFXRrsEOjwwV3hDA5Fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=971 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250076

On 2025-03-19 19:02, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Introduce a pre-allocated device status array memory together with
>> a mutex controlling the occupation to be used by the findcard()
>> function. Limit the device status array to max 128 cards and max
>> 128 domains to reduce the size of this pre-allocated memory to 64 KB.
> 
> I have the same concerns as for patch 8/20. Please think about an
> alternative to the dev_status_mem sharing, because it synchronizes all
> findcard() calls.
> 

There are not so many findcard() calls in parallel. And the lock is only
during running the findcard itself. Ok, the function may need a couple
of milliseconds and during this time block other callers but as I wrote,
I do not expect this to have impact on any load.

I could think of giving this function a ptr to memory from the caller.
So then all ioctl calls could alloc some work mem and pass it down
to findcard(). On the other side exactly these callers have time and
a short delay because of the mutex does no harm. The real issue is
with a pkey request coming via in-kernel pkey API. The pkey_cca handler
could hold some memory for this purpose - but with that I am only
moving the mem + mutex one level up. I have no other idea.

Btw. the exit() function now locks the mutex before freeing the memory.
-> v3

>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 46 
>> +++++++++++++++++++++------
>>  1 file changed, 36 insertions(+), 10 deletions(-)
