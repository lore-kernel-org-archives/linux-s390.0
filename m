Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7B25D52E
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908351; cv=none; b=e0aadYC99h/SfIDRnvmcY63sgrTKmqv0jvhPdN7kEA+QoeYIq/6apdYXzFnwxwIaLvzOWdTUORH6UpyAYruVc3KhBI7+q/xeE0d8KZZHTCO4q27VirNtdkXo+fiB7LiZditsiNT2W7pyI4EU7Yg/gv1qFW1JxtCGVon8O41DdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908351; c=relaxed/simple;
	bh=glwMwdettVeZuTulhEwMe4xdgibnZNcXLdn+5eyuemY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B2CbMFYPL9c5AVqTeAzs2l8J/ZT9ybNAqjdnxl9SNfTRNCRzskLFPuJo5RGBTmr/d7N1W/BFmzjY5VVXblb7nKJG4KEuFxxkfkLtW8l1rA00Q7KdqBKPnXcMOZW1Ib+rLe/50pkwJmwZ5Q2s1XkFLWjEZVm3yUYGJ9p/EJf8hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NL6GjTPJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NL6GjTPJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCSRHd013345;
	Tue, 25 Mar 2025 13:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=VHi88WZWtCvaxFPls85yfRj5bBIaymVPNhymVUjTyPE=; b=NL6GjTPJ968D
	Db298UOlEakIkO+ozWDoGPNIyFvENleJ9MqgEEx459Mnip5Dfj/SpUv9pdv1IPwL
	hcENKyAoJ8JhJV5BIT4GtdSQLu4kfEBTvWc9/rb/X3Nwyegmqg/9YhBwl1zGjtVf
	o6uBIJZyFRx760KY7zhMtXQzrVcQ/V1K4bNkpUERROLsDT4c+bg6aZH5dTlREUzI
	9YDMqIvHJy2SLskzftxdW7pYL8ldls1wX+ooJGtLJn6yMa/4eTTVi8xw+B4HMALC
	I8BUQ++b9rgC5g+5RTjxLU6imdCxvGV19bx1HG69VRieeVBtcixpms6SStfHXojU
	US3vAoGkiA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh306r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:12:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBvQrR030325;
	Tue, 25 Mar 2025 13:12:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htbq1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:12:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PDCPsf20972044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:12:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12ED85805A;
	Tue, 25 Mar 2025 13:12:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A621F5805E;
	Tue, 25 Mar 2025 13:12:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 13:12:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 14:12:24 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 11/20] s390/zcrypt/pkey: Rework ep11 findcard()
 implementation and callers
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <22578a6a-6abb-422b-b9b5-d87b0d1390f2@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-12-freude@linux.ibm.com>
 <22578a6a-6abb-422b-b9b5-d87b0d1390f2@linux.ibm.com>
Message-ID: <a9e5ce7d1e4776f92e99024b21517e71@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avDszOIAWH1fRsFpVET-vgWrGR8ciGRb
X-Proofpoint-GUID: avDszOIAWH1fRsFpVET-vgWrGR8ciGRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=623 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250091

On 2025-03-20 09:30, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Rework the memory usage of the ep11 findcard() implementation:
>> - findcard does not allocate memory for the list of apqns
>>   any more.
>> - the callers are now responsible to provide an array of
>>   apqns to store the matching apqns into.
> 
> See my comments below.
> 
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/pkey_ep11.c       | 19 ++++++++-----------
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 18 ++++--------------
>>  drivers/s390/crypto/zcrypt_ep11misc.h | 12 +++++-------
>>  3 files changed, 17 insertions(+), 32 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index 04153b476168..6005ef79c001 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> [...]
>> @@ -1678,17 +1671,14 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, 
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
>>  	} else {
>> -		/* no re-allocation, simple return the _apqns array */
>> -		*apqns = _apqns;
> 
> Please update *apqns unconditionally.
> 
>>  		*nr_apqns = _nr_apqns;
>>  		rc = 0;
>>  	}
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h 
>> b/drivers/s390/crypto/zcrypt_ep11misc.h
>> index a4b98eca8431..cbd615547bc2 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.h
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.h
>> @@ -136,14 +136,12 @@ int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 
>> keybitsize, u32 keygenflags,
>>   *   key for this domain. When a wkvp is given there will always be a 
>> re-fetch
>>   *   of the domain info for the potential apqn - so this triggers an 
>> request
>>   *   reply to each apqn eligible.
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
> As mentioned in my comment to patch 10/20: please update nr_apqns in
> any case. If -ENODEV should be dropped for cca, than also drop it
> here.
> 
>>   */
>> -int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 
>> domain,
>> +int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>>  		   int minhwtype, int minapi, const u8 *wkvp);
>> 
>>  /*

The *nr_apqns is now unconditional updated. But I keep the behavior with
the -ENODEV as there is code relaying on that.
-> v3
