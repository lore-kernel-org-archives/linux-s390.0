Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F82750E1
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641579; cv=none; b=MQ+dvGNedW00uqWZeSh+StXUcASg6k3qVMZjsSh61FxlDJIC21ra15yl2OutrVVpMDP0KPJr4Uz2Yiuoip8gR12oYdjj9RqU8piLPgYAXMbV4BmboEiLEBICRTvyIBjcQRuW/VlaVrsdSl2F6bjsGidUoUSnVrmhT1JLHPObD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641579; c=relaxed/simple;
	bh=0o+MpfrU+aS28g3TwbY0LBFuUrdy1Fz4Fo3+nEUQ5Ds=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aiE2D9DBUKHgeh1zYEnaKjBB+DfguezrfxxFZ8SG9soRcCLPo+9Uou0Irmc3fXfkv8NTSeKpSOC6+BdTh3GPN+10hlU4xUvHl0ttWuSGWzarpcOHqtFb48UYTv4Lk8/pgOtdbLTxSISlx3PwI1NWrmgCtcHJTGCmdYNmkVv8B04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYECCoom; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYECCoom"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAmfgu009012;
	Mon, 14 Apr 2025 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=bGV+3q+hJVzxulyZTRrFj+l0Xz9cnK3kflfB8tf6Jhs=; b=UYECCoomz3/N
	rejJRXggjbsQ2eEDjn+vWGYlejlb5B/ZZE1+ywW+ih7MlSowKSxi9K2u2/J3J3PE
	kzbdefA1nLZY+okhnfmxslgz8UHhuxtfh6IgKp92wtMhf2n1e8b7nhO1+6+J8xlX
	SHtfuFUanWebIdYCpGuyIMIPBC8se3OY4G0asY0pXK+AQvHEkc/mduRSetznR7P2
	CAo7UNNgN7GRsrQMvmIMLMdo8eTLPihalH2nVDLzldn9T/0cGlCrCLjTNOOKInQw
	6Cm+isu1R4sce6kKPgXxdBgIb7Xq85+a4wYf/kjIGJ6k/zbpE4WE+iluNNscLOIH
	b6tzLhMElw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460mufv0s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:39:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDoUEP010392;
	Mon, 14 Apr 2025 14:39:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjxcac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:39:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEdXD630605846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:39:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEB2B5804B;
	Mon, 14 Apr 2025 14:39:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259BC58055;
	Mon, 14 Apr 2025 14:39:32 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:39:32 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:39:31 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 12/24] s390/zcrypt: Remove CCA and EP11 card and domain
 info caches
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <3d545497-da67-4e03-8495-d5bf5a763d33@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-13-freude@linux.ibm.com>
 <3d545497-da67-4e03-8495-d5bf5a763d33@linux.ibm.com>
Message-ID: <f0ff0b6453aa337957c24d3c71d3a3bd@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D7SJ44bUKZrmDzxLzYUyc-kHxNsJXqgP
X-Proofpoint-ORIG-GUID: D7SJ44bUKZrmDzxLzYUyc-kHxNsJXqgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140105

On 2025-04-11 15:25, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Remove the caching of the CCA and EP11 card and domain info.
>> In nearly all places where the card or domain info is fetched
>> the verify param was enabled and thus the cache was bypassed.
>> The only real place where info from the cache was used was
>> in the sysfs pseudo files in cases where the card/queue was
>> switched to "offline". All other callers insisted on getting
>> fresh info and thus a communication to the card was enforced.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> See my comment below. With that
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/pkey_cca.c        |  16 ++--
>>  drivers/s390/crypto/zcrypt_ccamisc.c  |  89 +------------------
>>  drivers/s390/crypto/zcrypt_ccamisc.h  |   8 +-
>>  drivers/s390/crypto/zcrypt_cex4.c     |  35 ++++----
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 120 
>> ++++----------------------
>>  drivers/s390/crypto/zcrypt_ep11misc.h |   2 +-
>>  6 files changed, 46 insertions(+), 224 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 3a6a5b785a0d..7e24b78d4e56 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
>> @@ -1771,24 +1701,14 @@ static int fetch_cca_info(u16 cardnr, u16 
>> domain, struct cca_info *ci)
>>  /*
>>   * Fetch cca information about a CCA queue.
>>   */
>> -int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
>> +int cca_get_info(u16 card, u16 dom, struct cca_info *ci)
>>  {
>> -	int rc;
>> -
>> -	rc = cca_info_cache_fetch(card, dom, ci);
>> -	if (rc || verify) {
>> -		rc = fetch_cca_info(card, dom, ci);
>> -		if (rc == 0)
>> -			cca_info_cache_update(card, dom, ci);
>> -	}
>> -
>> -	return rc;
>> +	return fetch_cca_info(card, dom, ci);
> 
> Why not remove this function completely and rename fetch_cca_info()?

Done

> 
>>  }
>>  EXPORT_SYMBOL(cca_get_info);
>> 
>>  int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>> -		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
>> -		  int verify)
>> +		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp)
>>  {
>>  	struct zcrypt_device_status_ext *device_status;
>>  	u32 *_apqns = NULL, _nr_apqns = 0;
> [...]
