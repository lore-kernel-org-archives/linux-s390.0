Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0981732
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909553; cv=none; b=tI1X7j77KwB2fe02IKGOvPO/686Xk+EiC4nba+7XBjE0tiygQU+i9btgZU4cpMO/GYQlYYCHq+ukB6Src7eyiEQA2hxxvmH62Xo1ULTlJ0+URnurZKUTa+3EV7pLuX9Ue2YMu9YXCuX/DYpZKuXK6bq1bBk5aaSYCvJ4R1jlHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909553; c=relaxed/simple;
	bh=mV9YdJkitpnSDbY6cJQOo238aLk6eRXb9TTZrjaejYo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gOWYxtDuZ3JJfh27ZQ4OtuZ+CBxSUd0OoshPqXFEHiN4HPytGyvEBzaWig2ZGLH1FLGQTsT6eVTVEQied58roxIPdM1wF/UejIyuoRiM73BBgU/rHWQ99ZDjNekvZsoCaaH4LB1JyXjj6GByqASx2WpHFYZvOizph3JHi+S5LT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tDUz5giV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tDUz5giV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCrjx8032668;
	Tue, 25 Mar 2025 13:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=+xjR2pbTQbyypUxgZ+isIN1Fi69CH6e8pGfM2FPXBpY=; b=tDUz5giVT5dS
	vF5zfnSdLJsm30LR3kOLErCUfPFojGNwj7yVmufahsDi2tvdthA+I0TbL00rtpEp
	kbEUg/3ZGffgefuIWogHS1zZQ6N5HnraKUjPKIT/FWPINb8KdB+/uc+KDbkLwsss
	Hs1bXU0os/iOGQD24mN3uJZDaiowbENwcqtRNauCgBaTqtxVgX14RbSzSThxAu2a
	ik44Q/H0I23OVnsvdNhXRctH/ngR/3TjqwmjDO6BxuKNJ5+gO+RG1qKjhnWC2rQB
	T94f/m0Fk+CndA21UAVDiKouniQbJqwpE4AN7gFTnb+UcwtxWLxEtQEzpEIOjrKT
	zaa2PSvfpg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k8tpe4an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:32:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBvQvo030325;
	Tue, 25 Mar 2025 13:32:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htbs4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 13:32:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PDWQAB63701258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:32:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C3758059;
	Tue, 25 Mar 2025 13:32:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AF758055;
	Tue, 25 Mar 2025 13:32:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 13:32:26 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 14:32:25 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 13/20] s390/zcrypt: Add small mempool for cca info list
 entries
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <8fc15902-2156-41a7-9baf-7daef6315cd6@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-14-freude@linux.ibm.com>
 <8fc15902-2156-41a7-9baf-7daef6315cd6@linux.ibm.com>
Message-ID: <d8935d52b99f2bd4a5724753c2f7d7c8@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jq4P9pGMwfU4uOd9ZBRDntP2AEl2Xc0I
X-Proofpoint-ORIG-GUID: jq4P9pGMwfU4uOd9ZBRDntP2AEl2Xc0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_05,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250095

On 2025-03-20 15:34, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Add a small memory pool for (pre-)allocating cca info list
>> entries. These entries are rather small and the pool is a simple
>> way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the requested change,
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_ccamisc.c | 67 
>> ++++++++++++++++++++--------
>>  drivers/s390/crypto/zcrypt_ccamisc.h |  3 +-
>>  drivers/s390/crypto/zcrypt_cex4.c    |  4 +-
>>  3 files changed, 53 insertions(+), 21 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index ff7ba2622484..e4ec922aae0d 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
>> @@ -1828,6 +1834,7 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 
>> *pdomain,
>>  	u16 card, dom;
>>  	struct cca_info ci;
>>  	int i, rc, oi = -1;
>> +	u32 xflg = 0; /* xflags */
> 
> I'm confused. Why not just calling it xflags? Anyhow, as mentioned
> earlier: findcard() has no consumers, so please remove it completely.

findcard() does not exist any more. :-)

> 
>> 
>>  	/* mkvp must not be zero, minhwtype needs to be >= 0 */
>>  	if (mkvp == 0 || minhwtype < 0)
>> @@ -1859,8 +1866,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 
>> *pdomain,
>>  				if (!verify)
>>  					break;
>>  				/* verify: refresh card info */
>> -				if (fetch_cca_info(card, dom, &ci) == 0) {
>> -					cca_info_cache_update(card, dom, &ci);
>> +				if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
>> +					cca_info_cache_update(card, dom, &ci, xflg);
>>  					if (ci.hwtype >= minhwtype &&
>>  					    ci.cur_aes_mk_state == '2' &&
>>  					    ci.cur_aes_mkvp == mkvp)
>> @@ -1882,8 +1889,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 
>> *pdomain,
>>  			card = AP_QID_CARD(device_status[i].qid);
>>  			dom = AP_QID_QUEUE(device_status[i].qid);
>>  			/* fresh fetch mkvp from adapter */
>> -			if (fetch_cca_info(card, dom, &ci) == 0) {
>> -				cca_info_cache_update(card, dom, &ci);
>> +			if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
>> +				cca_info_cache_update(card, dom, &ci, xflg);
>>  				if (ci.hwtype >= minhwtype &&
>>  				    ci.cur_aes_mk_state == '2' &&
>>  				    ci.cur_aes_mkvp == mkvp)
> [...]
