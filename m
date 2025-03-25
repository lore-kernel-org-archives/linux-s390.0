Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42625A62E
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907747; cv=none; b=bSP6bZb972xlf8g1lC2FWxozSc0LdH4IChJwOsuf9RsfbORm2yua/1+lZ0jgNClqEiEd9VOnm/kHhUzFy8Ja+GJV6eRf5Sh8EIv6J4sBnRvK9513qGf8NMYOtM/qvqPc0hXdaf0qtJbZW/9H5fj8JInA9e86fZ8uIBAaeLLMsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907747; c=relaxed/simple;
	bh=7WwvuLxp77LrONr034Q9Bt75+4YJW9d8Jq7DXT6l3FM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=br4sSrV+cu8EPUCPiHx7fQUiClAAyk3aAxgyzaAHV9Z3t9JY95zwN2sK/cQInbYBtFxEv75B/57NyH2vnCe30RNLrQQfkWRw/Ul4MaiOZpglf+hPwqFE00BGZQdde3rp+cL8w+Z29zACbctwORrWgwlBUnCuysYWDIgANMUuEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jn5svJ4O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jn5svJ4O"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P3joRp025323;
	Tue, 25 Mar 2025 13:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=PTiGvspnGydCPcBunBX8cTv8SKB6P3MbqiZHwDebXdI=; b=jn5svJ4OgbGx
	TXPz/x6mO3vNJ9Vo3foS90DQrW2a2acdHpqwMCs9EFU22H7aagGwEN9kJhVoBnWt
	vXb3q7spN/jXjerVA6n4nKbrtrwrcwwyJEHl3t1an2vobyEPyQwPoe29uFeuLCYC
	Lo2buatDTpTG3qu1aIsneUOB0ys5pVcAR3VantKRdW71t8Mgtuae3mspJog2WD3T
	NtNhDGzaOJKB0oL9wRrlQ20HAa/42JboGluHoUHuX0oULYXCHkBmEpmqzh3v4K8Q
	zS38Ooz/rputMguljxTWFUk3i7i/XOJWtOOiuQ5H0lYJOdVP3amwJXV+xN6TfgnE
	b5RfEDBTQA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva2f7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:02:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBwYW8030352;
	Tue, 25 Mar 2025 13:02:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htbnvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:02:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PD2Kmr35455526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:02:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F14058061;
	Tue, 25 Mar 2025 13:02:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C75558056;
	Tue, 25 Mar 2025 13:02:20 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 13:02:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 14:02:20 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 10/20] s390/zcrypt/pkey: Rework cca findcard()
 implementation and callers
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <2fb000bd-1764-4fef-9d6b-fa1ee705da6b@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-11-freude@linux.ibm.com>
 <2fb000bd-1764-4fef-9d6b-fa1ee705da6b@linux.ibm.com>
Message-ID: <2d4d5cb7097995907fd862bad86e4e10@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dxgTeR8KvFhWVeaueSN2GTdhIJwg8x9S
X-Proofpoint-GUID: dxgTeR8KvFhWVeaueSN2GTdhIJwg8x9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=737 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250091

On 2025-03-19 18:58, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Rework the memory usage of the cca findcard() implementation:
>> - findcard does not allocate memory for the list of apqns
>>   any more.
>> - the callers are now responsible to provide an array of
>>   apqns to store the matching apqns into.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> See my comments below.
> 
>> ---
>>  drivers/s390/crypto/pkey_cca.c       | 25 +++++++++++--------------
>>  drivers/s390/crypto/zcrypt_ccamisc.c | 18 ++++--------------
>>  drivers/s390/crypto/zcrypt_ccamisc.h | 12 +++++-------
>>  3 files changed, 20 insertions(+), 35 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 65b4cdb9b478..d3b093dcdf30 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
>> @@ -2006,17 +1999,14 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, 
>> u16 cardnr, u16 domain,
>>  				continue;
>>  		}
>>  		/* apqn passed all filtering criterons, add to the array */
>> -		if (_nr_apqns < 256)
>> -			_apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
>> +		if (_nr_apqns < *nr_apqns)
>> +			apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
>>  	}
>> 
>>  	/* nothing found ? */
>>  	if (!_nr_apqns) {
>> -		kfree(_apqns);
>>  		rc = -ENODEV;
> 
> In my opinion, the -ENODEV return value can be completely dropped. For
> the caller it should be sufficient to check for nr_apqns == 0.
> 
>>  	} else {
>> -		/* no re-allocation, simple return the _apqns array */
>> -		*apqns = _apqns;
>>  		*nr_apqns = _nr_apqns;
> 
> Please update *nr_apqns unconditionally.
> 
>>  		rc = 0;
>>  	}
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h 
>> b/drivers/s390/crypto/zcrypt_ccamisc.h
>> index 273edf2bb036..bed647a42eb2 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.h
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.h
>> @@ -229,14 +229,12 @@ int cca_findcard(const u8 *key, u16 *pcardnr, 
>> u16 *pdomain, int verify);
>>   *   cur_mkvp or old_mkvp values of the apqn are used.
>>   * The mktype determines which set of master keys to use:
>>   *   0 = AES_MK_SET - AES MK set, 1 = APKA MK_SET - APKA MK set
>> - * The array of apqn entries is allocated with kmalloc and returned 
>> in *apqns;
>> - * the number of apqns stored into the list is returned in *nr_apqns. 
>> One apqn
>> - * entry is simple a 32 bit value with 16 bit cardnr and 16 bit 
>> domain nr and
>> - * may be casted to struct pkey_apqn. The return value is either 0 
>> for success
>> - * or a negative errno value. If no apqn meeting the criteria is 
>> found,
>> - * -ENODEV is returned.
>> + * The caller should set *nr_apqns to the nr of elements available in 
>> *apqns.
>> + * On return *nr_apqns is then updated with the nr of apqns filled 
>> into *apqns.
>> + * The return value is either 0 for success or a negative errno 
>> value.
>> + * If no apqn meeting the criteria is found, -ENODEV is returned.
> 
> Why not just return nr_apqns == 0 to indicate, that no matching device
> has been found? Anyhow, even if you would stay with the -ENODEV return
> value, *nr_apqns should be updated in any case.
> 
>>   */
>> -int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>> +int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>>  		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
>>  		  int verify);
>> 

I changed this to unconditionally always update *nr_apqns.
But I'd like to stay with the -ENODEV in case 0 apqns have been found.
There is code using this returncode (which then also would need 
reworked).

