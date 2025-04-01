Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447911DB92A
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512072; cv=none; b=qq+HOt9UWDQNBUOEj5y0b4+XbLX3L9Wsa7ffHIKTstUtyS9jcM8GgrVUlvBNGmL5h8wQULbiEzcN/g/P8aF0z1YXLyI0vjtcCsz0Dr6H0fUhQuBswc6kch7C1BzCpZUauNMTqKgIEY4MkiQSNsAP06MQxJ6TR+53yxfmbgNfIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512072; c=relaxed/simple;
	bh=OdhSQaDq5Y0qVqq1Fho5dIfN6qF5uwKVTl8yszfx4AY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AqBJ+69XCwFZ9ljyh8Df7PwkVM1UU3CTINSg4YeGQyRbkNA8m6myzSxLez2LqzBemFIrSqcADNXofsIvKHNJHKzEbNVnX9UXkgeo15Ct0vNOyszQQA0FcPgIUjcMiyff5VqezLk5x5SA2cmlvqLhZ/yfGDhbvVUic5RHhGGHBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VupfLY78; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VupfLY78"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531CSwv6028541
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 12:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=J0e4Ih0GptWkdvhdYVZgUim+Wd4wykcfupvJBPFO6gY=; b=VupfLY78unIH
	q/VKJopPsmbUhSmaHTVipqupbQOyVyBkCRhVsgbOqTTV28Lq70yvUbbb9BJ9wqQ1
	V+l/sjfZNmPsu6YodcOKAGJ0xqsgiOo0msbd/GArYKI3OeTm05YxOK1q38VrfHXg
	bWal1KfIjcbtCD6rJxF6oR5to3T6wDs20lfqS5AYRLZ9aq5dXBDdaK4gYq2XlBkv
	jylXRKsJP3lEkfQLlcIOFKbaFKB8NTeNftfm5EPbS2sVyiCXX/sy1QnB0a6MVVXg
	8apV0H4uvCi8LpiNfrvq20qxiN3XM0GG1fsbVdKNS9+Z/38xOHh59uRqBAd48MyO
	HTZFJKJUxQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rg67g3yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 12:54:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531BltDc019391
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 12:54:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t2sqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 12:54:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531CsRUO9568818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 12:54:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB45A58055;
	Tue,  1 Apr 2025 12:54:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38C5258063;
	Tue,  1 Apr 2025 12:54:27 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 12:54:27 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Apr 2025 14:54:26 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/uv: New param workpage for the
 uv_get_secret_metadata() function
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250331145554.25223Gce-hca@linux.ibm.com>
References: <20250331103505.15210-1-freude@linux.ibm.com>
 <20250331103505.15210-2-freude@linux.ibm.com>
 <20250331145554.25223Gce-hca@linux.ibm.com>
Message-ID: <b60ac92b9da968114397c5bb23ea8e96@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KA6s3DlW0_5R64Gcuu5ooKZXBHF7oOcf
X-Proofpoint-GUID: KA6s3DlW0_5R64Gcuu5ooKZXBHF7oOcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=681
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010076

On 2025-03-31 16:55, Heiko Carstens wrote:
> On Mon, Mar 31, 2025 at 12:35:05PM +0200, Harald Freudenberger wrote:
>> The pkey uv handler may be called in a do-not-allocate memory
>> situation. For example when an encrypted swap file is used and the
>> encryption is done via UV retrievable secrets with protected keys.
> 
> This doesn't answer the question if the context is process, bottom 
> halve,
> or interrupt context. If it is process context, is it sleepable?

Sleepable but no memory must be allocated which would cause IO 
operations.

> 
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index 9f05df2da2f7..0a8a6bc19c49 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -713,6 +713,9 @@ static int find_secret(const u8 
>> secret_id[UV_SECRET_ID_LEN],
>>   * uv_get_secret_metadata() - get secret metadata for a given secret 
>> id.
>>   * @secret_id: search pattern.
>>   * @secret: output data, containing the secret's metadata.
>> + * @workpage: ephemeral working page. Caller may give a ptr to one 
>> page
>> + *            here as ephemeral working buffer. If NULL, kmalloc is 
>> used
>> + *            to alloc a working buffer.
>>   *
>>   * Search for a secret with the given secret_id in the Ultravisor 
>> secret store.
>>   *
>> @@ -725,16 +728,19 @@ static int find_secret(const u8 
>> secret_id[UV_SECRET_ID_LEN],
>>   * * %EIO:	- Other unexpected UV error.
>>   */
>>  int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
>> -			   struct uv_secret_list_item_hdr *secret)
>> +			   struct uv_secret_list_item_hdr *secret,
>> +			   u8 *workpage)
>>  {
>>  	struct uv_secret_list *buf;
>>  	int rc;
>> 
>> -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> +	buf = workpage ? (struct uv_secret_list *)workpage :
>> +		kzalloc(sizeof(*buf), GFP_KERNEL);
>>  	if (!buf)
>>  		return -ENOMEM;
>>  	rc = find_secret(secret_id, buf, secret);
>> -	kfree(buf);
>> +	if (!workpage)
>> +		kfree(buf);
>>  	return rc;
>>  }
>>  EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
> 
> Please don't do this ugly workpage interface. Just rename find_secret() 
> to
> e.g. uv_find_secret() and make it globally visable. Then you have the
> unchanged uv_get_secret_metadata() + find_secret() interfaces, and in 
> addition
> can call find_secret() / uv_find_secret() with a custom buffer.

Will do.

> 
> Given that pkey_uv.c is the only user of this interface: how would the 
> changes
> to pkey_uv.c look like?  Or in other words: wouldn't it make more sense 
> to get
> rid of uv_get_secret_metadata(), and just keep uv_find_secret() and 
> push the
> allocation to the pkey code?

As of now the pkey_uv.c would continue to use the old function.
This would then change when my 20 do-not-allocate patch series is 
applied.
After that or with that, I would hold one pre-allocated page in pkey_uv
for exactly this purpose and use the uv_find_secret with this 
pre-allocated
page - thus not using uv_get_secret_metadata() any more.
