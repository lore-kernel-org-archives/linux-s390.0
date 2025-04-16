Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34923645D
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796362; cv=none; b=oZ4njvhc2YQnZ2quVAej36a7NbFVZCLUTj/BqnGNkOpBhC5ntLDJFP02qtNfj8OycVI/bywJQK8jAWuOYIR6HePeMRqhJoDPDdyAcdRnT0Q58zX8X05/GaNvyZtpLQQ1moGwFkaD+Um+cBGP8Y+P4aEiKylrT5QuRB26EZYWT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796362; c=relaxed/simple;
	bh=pFg8xEtKy+mgT6PpB/1egDJk07EnZ7TISRC3limQWMg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pMmo9paubeXdnPQ/dWP1WzcjsOrrpzBV69FupD3gE+YxLE4mcEnl8A2qsPdMbO35GSntmUKmfFndXskaEpuKgl9hhm2G7r+y0DK6iSKO5YEWjQPYuuFN93fyRGUY3v7hprY3gm2/6AuH5UYrKDDrQUg345bdHrHOo/+iHvRDOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D6tLJR41; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D6tLJR41"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8BE96021179;
	Wed, 16 Apr 2025 09:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=KMUeOpPf27C3fMAvd8SYrvzuRADp7gFcMftd+f8Z8KY=; b=D6tLJR41/XlJ
	cD3E/RFP+jBeuR/2fPShSwg0ZiMSOO/+sPauruS02Nh5NT92okKLlIHZQAoB1FIB
	HX3hWE75vol43IRi++sKK76oeGg/uywZl9LsYIWXqbDggzszg1XxxWaUqryQQ23R
	qsS7qlvhBEbllvjUaRenYk9yzcS3KMx5t4rrismoTXjmbwj+EKok5BfyPRq8YbS/
	YkRIvNCfZ1+pHXw1+K23l68HSimP4jiKrV2UQsEY4iLdPJQ96DuQzJv9NY3ZFzUL
	AjzqvW+RgqZBnenAFrMq1CfgFuEyCLGm2nKiSyoYv/TWm//EQmizFR2nFbbwSaz3
	qM3T/RuDMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq5nry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:39:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8aoCr016431;
	Wed, 16 Apr 2025 09:39:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46057278v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:39:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9dD2521299896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:39:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2A1958043;
	Wed, 16 Apr 2025 09:39:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76AE558055;
	Wed, 16 Apr 2025 09:39:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:39:13 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Apr 2025 11:39:13 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v5 06/25] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250415150737.12735Fad-hca@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-7-freude@linux.ibm.com>
 <20250415150737.12735Fad-hca@linux.ibm.com>
Message-ID: <c75ed1fd03d1ffd41341c8cac42389d7@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4R0aLgxq7Z5YIItV4kSP8K6ct-5maVCF
X-Proofpoint-GUID: 4R0aLgxq7Z5YIItV4kSP8K6ct-5maVCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160078

On 2025-04-15 17:07, Heiko Carstens wrote:
>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>> b/drivers/s390/crypto/zcrypt_api.c
>> index f753c0403a18..9ca78411737f 100644
>> --- a/drivers/s390/crypto/zcrypt_api.c
>> +++ b/drivers/s390/crypto/zcrypt_api.c
>> @@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor 
>> interface, " \
>>  		   "Copyright IBM Corp. 2001, 2012");
>>  MODULE_LICENSE("GPL");
>> 
>> +unsigned int zcrypt_mempool_threshold = 5;
>> +module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 
>> 0440);
>> +MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply 
>> mempool minimal items (min: 1).");
> 
> Please remove the "." from the module parameter description, here, and
> in all other patches which introduce new module parameters.

Done in all patches -> v6

> 
>> -void __exit zcrypt_ccamisc_exit(void)
>> +int __init zcrypt_ccamisc_init(void)
>> +{
>> +	/* Pre-allocate a small memory pool for cca cprbs. */
>> +	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_mempool_threshold,
>> +						   CPRB_MEMPOOL_ITEM_SIZE);
>> +	if (!cprb_mempool) {
>> +		ZCRYPT_DBF_WARN("%s mempool_create(%d,%d) failed: %ld\n",
>> +				__func__, zcrypt_mempool_threshold,
>> +				CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
>> +		return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
> 
> Please remove the ZCRYPT_DBF_WARN() for the !cprb_mempool case, and
> just keep the return code handling. This will never fail, except for
> the memory allocation error injection case, which is not relevant for
> production code. If this is forced to fail you will see a nice splat
> anyway; so no point in logging this in any case.
> 
> Please also remove all similar constructs in subsequent patches.

Done in all patches -> v6
