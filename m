Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C76253B66
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891784; cv=none; b=uf/8Dmufqotc7X1WTFtS4s5iMNdGb4DRI+ZvNPB1gUhXRnj7/jbV6miAMfdLdCIFdkbYs+KTQ0Je9HIai8J953Mf5yBVyG8dqRbMKvrxPTeur9MsQLV8750aXSWGrmr1EMOmFb/c5d73GWHsf5K6kqG9fGXTYwCp3gI/F9UMy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891784; c=relaxed/simple;
	bh=eaDacNgx20Qo4lTbHn2ddyXZtElh1MkQPyYW90GCsps=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=txREVp28U8A6AOXt7jaX0Eg3HYBv9UIu41PRCIC05veAluvzDKD+rA26Qp/r9JM/zrsU3Qxi4cqsjVBT/e94dWaxyUd0+L/VQAjYtyRTEdQBLcMkRnYxhaMd2sUBcXXd1dfuhWGGRy3tX6J7KHQfaBhBbdqKmlxarLTwf8BmJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GWZliu4/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GWZliu4/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P1U8Bd032674;
	Tue, 25 Mar 2025 08:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=c1JY0bhuNCpzk5bbJrYjFYkNOUEbvZn04PbkMMgGhLM=; b=GWZliu4/95mj
	5sEmTnLyXNCM0BZzYZMnCgqc0XjCr6wuGZuqYVNwWbh2rdxHYzleU51t6MJQegRF
	H7Dyg3UJFcGN1eKV1NNrxx0cye1RDasTq46JhmNHVDL6eYSHPDtEfwFaIPQKwPCE
	fGHeZ9NLCsFTwYWd70eKNtOa9ePW/NhQye3yGoc9Kg2UWH4f+fJFiP6ubb5dx/RW
	dzo2uVH55QDc7JuBumIzOV7JVu+NfMnPtzpXniPqGecWGjuKWiIHvRuyEt6tpi8n
	mVexK/91ilFUQYjCl12yyzoN3aMLfWEpHaBr7mBQxQj8qf9qv9pw9+p2bqjKQmb/
	CAVADDp9Ag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k8tpcnr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:36:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P5ZHOb009718;
	Tue, 25 Mar 2025 08:36:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkj87w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:36:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52P8aI7p14811892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 08:36:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD9558055;
	Tue, 25 Mar 2025 08:36:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 759B05804B;
	Tue, 25 Mar 2025 08:36:17 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 08:36:17 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 09:36:17 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 06/20] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <6ca68b33-eb2a-4840-830b-273e6d96becf@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-7-freude@linux.ibm.com>
 <6ca68b33-eb2a-4840-830b-273e6d96becf@linux.ibm.com>
Message-ID: <fb7ae3d1358bec621d2b6ecacf9838cf@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3SV7VnLFJ6tTICiegn_7yDy6KJRjh99K
X-Proofpoint-ORIG-GUID: 3SV7VnLFJ6tTICiegn_7yDy6KJRjh99K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250058

On 2025-03-18 16:16, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Introduce a cprb mempool for the zcrypt ep11 misc functions
>> (zcrypt_ep11misc.*) do some preparation rework to support
>> a do-not-allocate path through some zcrypt cca misc functions.
>> 
>> The mempool is by default space for 8 cprbs with each 8KB.
>> For EP11 a CPRB either holds the request or the reply. So for
>> a request/reply there is always a couple of cprb buffers
>> needed. The minimal number of items in the mempool can get
>> adjusted via module parameter zcrypt.ep11_cprbpool_min_items
>> on module load.
>> 
>> This is only part of an rework to support a new xflag
>> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the minor change (see comment below)
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c      |  10 ++
>>  drivers/s390/crypto/zcrypt_api.h      |   1 +
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 158 
>> ++++++++++++++++----------
>>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>>  4 files changed, 109 insertions(+), 61 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index b60e262bcaa3..86578a95b140 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> [...]
>> @@ -621,22 +652,20 @@ static int ep11_query_info(u16 cardnr, u16 
>> domain, u32 query_type,
>>  	req_pl->query_subtype_len = sizeof(u32);
>> 
>>  	/* reply cprb and payload */
>> -	rep = alloc_cprb(sizeof(struct ep11_info_rep_pl) + buflen);
>> +	rep = alloc_cprbmem(sizeof(struct ep11_info_rep_pl) + buflen, 
>> xflags);
>>  	if (!rep)
>>  		goto out;
>>  	rep_pl = (struct ep11_info_rep_pl *)(((u8 *)rep) + sizeof(*rep));
>> 
>>  	/* urb and target */
>> -	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
>> -	if (!urb)
>> -		goto out;
>> +	memset(&urb, 0, sizeof(urb));
> 
> The memset is done each time before a prep_urb() call. Please do the
> memset inside the prep_urb() function and remove the other ones.
> 

done -> v3

>>  	target.ap_id = cardnr;
>>  	target.dom_id = domain;
>> -	prep_urb(urb, &target, 1,
>> +	prep_urb(&urb, &target, 1,
>>  		 req, sizeof(*req) + sizeof(*req_pl),
>>  		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
>> 
>> -	rc = zcrypt_send_ep11_cprb(urb, 0);
>> +	rc = zcrypt_send_ep11_cprb(&urb, xflags);
>>  	if (rc) {
>>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, 
>> rc=%d\n",
>>  			       __func__, (int)cardnr, (int)domain, rc);
> [...]
