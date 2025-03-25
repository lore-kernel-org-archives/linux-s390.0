Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC9BA36
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899910; cv=none; b=aQxvhYW3siLZpLy5iBbX7H/mFK8mBW5gZb1Wg+C4K/3S2Tah0GdBTrl5bZOdfA0/Kz38KlzJ6teOOyPsoAxDztSSygZiFHzwqpdHl0UGEUzxQiAEgxic9FFrX3/gZ+GSY/Sb4uNOG2GxNWO6XY4TKj2/nA8xvEwPVIIdI65MJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899910; c=relaxed/simple;
	bh=mGqcqJaZplQpNWr77aXlLnLzSDRqhMJRTncIRj3yHX4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CY07n1NJIT6hrwLqCEokz9jBCgZF3+gFZQhBNGI5gp9S7zDP5rJYlqVGO9zYU1sNkGMij/wAe743ThHe1N9Ul7hWk+2l4xqZC3wKlDZVusmDK516dALhP4nixiFIzsyzdsyf7lvUMaoDCRBj1LRhKvRYiVbPQt7HMU75pE9yyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P14twlbW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P14twlbW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P46u2J027796;
	Tue, 25 Mar 2025 10:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=WB3FKCZvetO0lOaXn+jB+xc8+tfZFVQyp8H3LfEUKHU=; b=P14twlbWly1t
	ch0Qk/0spAArZG3FaPBV+vCUK5Bv8haqGmIql4C7tF96qXgFaiYw9Xw1vXoE+EqA
	sA9DH+Gs3VN+9uGGpaY9DF2D35YxdKPgtdysBywI2c//bRt++KRp1EcK78zmRHg0
	dzNRmkVi8KeuvvCtluOLNt9OARbL/jfRwaaEHnZq+JcXbanqHdlx3PJ+TJdMBAxw
	sTNjZJM7MeIkhuhA9gc2BjzqzsbwuCGXxAmHg8Fj3uCvU4Ses2dcnlu2PnmfBq4y
	X7JoeU33osV6qkNqr1xfdfxBLZEsE+XxAEwstT9aWMsCT32FTM60gCZmlp6+p7Dd
	47LogTAYuw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwv2xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:51:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PA95Re009694;
	Tue, 25 Mar 2025 10:51:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkjscy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 10:51:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PApisA27787880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 10:51:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB5C5805D;
	Tue, 25 Mar 2025 10:51:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F69458043;
	Tue, 25 Mar 2025 10:51:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 10:51:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 11:51:43 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 08/20] s390/zcrypt: Introduce pre-allocated device
 status array for cca misc
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <887dc169-e62e-4f52-ab29-20e9aa5a31c9@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-9-freude@linux.ibm.com>
 <887dc169-e62e-4f52-ab29-20e9aa5a31c9@linux.ibm.com>
Message-ID: <0f82b989b08cf656c563005978028d07@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Krij5Mm8m3obgGdCn0bQCdkp41WjTqrM
X-Proofpoint-ORIG-GUID: Krij5Mm8m3obgGdCn0bQCdkp41WjTqrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250072

On 2025-03-19 15:31, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Introduce a pre-allocated device status array memory together with
>> a mutex controlling the occupation to be used by the two findcard()
>> functions. Limit the device status array to max 128 cards and max
> 
> As far as I can see, cca_findcard() (and also the static findcard())
> are no longer used. If this is the case, I would prefer to remove this
> unused variant, either in this patch (with a hint in the commit
> message) or in a separate one (in the order prior to this patch).
> 
>> 128 domains to reduce the size of this pre-allocated memory to 64 KB.
> 
> I'm a bit unhappy about introducing a synchronization with this single
> piece of memory.
> 

Any other ideas ?

>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/zcrypt_ccamisc.c | 78 
>> +++++++++++++++++++---------
>>  1 file changed, 53 insertions(+), 25 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 420895df70f0..65b4cdb9b478 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
>> @@ -1801,21 +1817,20 @@ static int findcard(u64 mkvp, u16 *pcardnr, 
>> u16 *pdomain,
> 
> As mentioned above, please check for users of findcard() and
> cca_findcard(). If there are no users anymore, please remove the
> obsolete code.
> 

Seems you are right - findcard() and cca_findcard() are no longer used.
So I'll introduce another patch before this one which removes the unused
functions. -> v3

> [...]
>> @@ -2023,11 +2041,21 @@ int __init zcrypt_ccamisc_init(void)
>>  		cprb_mempool = NULL;
>>  		return -ENOMEM;
>>  	}
>> +
>> +	/* Pre-allocate one crypto status card struct used in findcard() */
>> +	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
> 
> The alloc of dev_status_mem should be protected by the mutex as well.
> 

No, init() is supposed to be executed exactly once and there is nothing
running which may somehow occupy this memory already.

>> +	if (!dev_status_mem) {
>> +		ZCRYPT_DBF_ERR("%s allocation of dev_status_mem failed\n", 
>> __func__);
>> +		mempool_destroy(cprb_mempool);
>> +		return -ENOMEM;
>> +	}
>> +
>>  	return 0;
>>  }
>> 
>>  void zcrypt_ccamisc_exit(void)
>>  {
>>  	mkvp_cache_free();
>> +	kvfree(dev_status_mem);
> 
> Same here: please lock the mutex before releasing dev_status_mem.
> 

Agreed - the free call should be delayed in cases where the memory
is currently occupied by a caller. So I'll lock the mutex before
calling free() -> v3

>>  	mempool_destroy(cprb_mempool);
>>  }
