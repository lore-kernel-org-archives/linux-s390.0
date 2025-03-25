Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBD77104
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891222; cv=none; b=jblMZ2TZ6JZsn+eNJRoUG9rTGL1X5SqOGlFk58CtKqtJuvXw/Xem0aNXRCYgH1W59WzamZEMPNy8UmDyC4XuoTjI0Bf2QKQOcWu8YyVBAKD7K60KpvMmT5dq4EnnNAhaIStnKiEQ6Ozm9vZSbdwOwaSW4oOImVHn86KI+Z5KZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891222; c=relaxed/simple;
	bh=mlWIPiQIkmW1aX3JymRxz38ZjR2VE0e3R6S++zsiSHA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Dtqcqb5CmM+Lzp/dRlHSF9QK3jCGdxWkdP78TkXmXb0dTozbNTyI+BCzQJe4h23DsUYCoPFS6bzmHCLiuF8qtyxqzMcMk0/N69sN6yTBycUOvUalfe8xjUK4mEROt7Bx7RiBhnu/rXwbkS32oQvWAWCUzk9Qo3/D2r+3H/QQLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYDPXaNj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fYDPXaNj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OLWn1f027692;
	Tue, 25 Mar 2025 08:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZnXA9U810NvtAGfl+uD4LOU3zpIDGQojMHfdz3sySlU=; b=fYDPXaNj37YE
	HwTYpEsThvOf1veaJXC7qm7WUK9iX3YKV0mlP93SfuWW0QZwkOuULSP03YAR0INf
	VD8eOHouvoseiqqG2W5kmzPPdDe91QKWX3+AfCPIVK1niOI+/IBuXx3pkMmYa4EA
	03qTRdhb3qeHTQX6cOou2yIHYqUTAQMQXt5j+ahfifsOgbrRqw3LAfm5KdlyfwDI
	qV0no/Vl6lD9Xvh2Op9QXygO0zY8Nnb5QYgOYmw9keAtmKuWlZABxi1xldrrKHDs
	xDM9zyLPXdDWqV6CoqyfbXySGVpO4c1k23dBp0dG+j4PWNUQi2yrITLyeOE+Mb6T
	lA5WBGzEzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e3d2vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:26:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5GAvN020109;
	Tue, 25 Mar 2025 08:26:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnte4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:26:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52P8QqHx25297572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 08:26:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68CBA58052;
	Tue, 25 Mar 2025 08:26:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04B575805D;
	Tue, 25 Mar 2025 08:26:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 08:26:51 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 09:26:51 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 05/20] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a9e5cebe-7d68-46df-a194-d6ef393322fb@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-6-freude@linux.ibm.com>
 <a9e5cebe-7d68-46df-a194-d6ef393322fb@linux.ibm.com>
Message-ID: <3325245358b26e84cbbcd4b80ecaba9c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k_O-VTrAEsV29sRTba9ZSyoDzraFFqge
X-Proofpoint-GUID: k_O-VTrAEsV29sRTba9ZSyoDzraFFqge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250058

On 2025-03-18 15:16, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Introduce a cprb mempool for the zcrypt cca misc functions
>> (zcrypt_ccamisc.*) do some preparation rework to support
>> a do-not-allocate path through some zcrypt cca misc functions.
>> 
>> The mempool is by default space for 4 cprbs with each 16KB.
>> For CCA a CPRB needs to hold the request and the reply, so
>> the pool items only support requests/replies with a limit of
>> about 8KB. The minimal number of items in the mempool can get
>> adjusted via module parameter zcrypt.cca_cprbpool_min_items
>> on module load.
>> 
>> This is only part of an rework to support a new xflag
>> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> One minor comment below. Beside that
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c     |  13 ++-
>>  drivers/s390/crypto/zcrypt_api.h     |   2 +
>>  drivers/s390/crypto/zcrypt_ccamisc.c | 116 
>> ++++++++++++++++++++-------
>>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>>  4 files changed, 101 insertions(+), 31 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 521baaea06ff..2c2ca2d67e2d 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
>> @@ -229,7 +241,15 @@ static int alloc_and_prep_cprbmem(size_t 
>> paramblen,
>>  	 * allocate consecutive memory for request CPRB, request param
>>  	 * block, reply CPRB and reply param block
>>  	 */
>> -	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
>> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>> +		if (cprb_mempool &&
>> +		    2 * cprbplusparamblen <= CPRB_MEMPOOL_ITEM_SIZE) {
>> +			cprbmem = mempool_alloc_preallocated(cprb_mempool);
>> +			memset(cprbmem, 0, 2 * cprbplusparamblen);
>> +		}
>> +	} else {
> 
> Just a nit: let the compiler decide, if code should be duplicated or 
> not.
> 
> if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> 	size_t len = 2 * cprbplusparamblen;
> 
> 	if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
> 		cprbmem = mempool_alloc_preallocated(cprb_mempool);
> 		memset(cprbmem, 0, len);
> 	}
> } else {
> 
>> +		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
>> +	}
>>  	if (!cprbmem)
>>  		return -ENOMEM;
>> 
> [...]

It was not my intention to outsmart the compier when writing this code.
However, changed to your suggestion -> v3
