Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08F260A29
	for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473824; cv=none; b=daI1DMbLbjMbFcHycjpTS5enC13Ey4QzMhsLAmZbyjnISgurkZj0F4YOv1vqGxKizjBBtkn4Op7LotYH61tGxnGCVNMwzPYr5zZYtZLCCnGpkfmOd6yv4dYjrF+r36PNE1u+SMrkoHiN48Y8X8GB3tJwqMNL1+pmqeRnfvIXlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473824; c=relaxed/simple;
	bh=HBkfWUvaOCsLjYoE+RMGKDQqEfPoo8bHuPZv5+FJ0Rg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WN38rxbuDbkIkAslbSs6SCnmGQq2HTvVg2gM5sVfG7Jz5lEcywaJ8ZnSCX7CE3T3uO+owNCxvx/ZtyIlE5dB6PJmFD5yP3VhZO1nqdchKtoz60jH6BCYI/AwbrS/kv00BT9rgciO/jNDAGLd2TDaoZ+jazk0TVWHrmelmBerfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fvi1ASmd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fvi1ASmd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P20cd4003173;
	Tue, 25 Feb 2025 08:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=LA4DhyYNVi/L0ZfVf+sPp/ieNDmzI9adwaSw92DijGE=; b=Fvi1ASmdGP9s
	Q5ENyvNLDoonKjpJnsNvYhprTIJBQ5tKKn3RCz85WVgoUXu18E4DinhMOty7vo9l
	pP2KPXlLTigCJ0sSxJp9phma9IMVzK9xXzSLlLTLw2cPMBKJ6hP1fPu+V5/rlQ7A
	/ZRdDifmeSCiRcSwMe+bNsS7N5tQiDtBWVu/DOA4L5H816m9cAm6u2cveQLyzFM/
	kkM8RN112bbWWQxpCjubXCV6R7ihOtvw9L0ujCTBFcWAunPxvIgABLikSeod/ma7
	arf7+uLqmfol0CMohX54vIyLSTXsrkI7i7sNdGOr7djlLHOMYEpMmU/eYOEH6uPJ
	aQeTxmcJwQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4514q09ft2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 08:56:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P52h7o027376;
	Tue, 25 Feb 2025 08:56:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1uf2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 08:56:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P8uuTF56820002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:56:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B4F5805A;
	Tue, 25 Feb 2025 08:56:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47AF458051;
	Tue, 25 Feb 2025 08:56:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 08:56:57 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 09:56:57 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v1 01/20] s390/ap: Move response_type struct into ap_msg
 struct
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-2-freude@linux.ibm.com>
 <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
Message-ID: <604e9fbfd03fdfa4af7764ba54d8103b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zrfoZXiDf06ELg2z1yEmkJ4YR5hczuC1
X-Proofpoint-GUID: zrfoZXiDf06ELg2z1yEmkJ4YR5hczuC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250057

On 2025-02-24 16:23, Holger Dengler wrote:
> On 23/02/2025 10:54, Harald Freudenberger wrote:
>> Move the very small response_type struct into struct ap_msg.
>> So there is no need to kmalloc this tiny struct with each
>> ap message preparation.
> 
> I understand the intention for this patch, but in my opinion the
> layering concept between ap and zcrypt is violated by defining the
> response-type as part of the ap message struct. But I don't have any
> better solution, so for the moment you may leave it as is.
> 
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/ap_bus.h           |  12 ++-
>>  drivers/s390/crypto/zcrypt_msgtype50.c |  22 +++---
>>  drivers/s390/crypto/zcrypt_msgtype6.c  | 101 
>> ++++++++++---------------
>>  3 files changed, 59 insertions(+), 76 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/ap_bus.h 
>> b/drivers/s390/crypto/ap_bus.h
>> index f4622ee4d894..a5d8f805625f 100644
>> --- a/drivers/s390/crypto/ap_bus.h
>> +++ b/drivers/s390/crypto/ap_bus.h
>> @@ -214,6 +214,15 @@ struct ap_queue {
>> 
>>  typedef enum ap_sm_wait (ap_func_t)(struct ap_queue *queue);
>> 
>> +struct ap_response_type {
>> +	struct completion work;
>> +	int type;
>> +};
>> +
>> +#define CEXXC_RESPONSE_TYPE_ICA  1
>> +#define CEXXC_RESPONSE_TYPE_XCRB 2
>> +#define CEXXC_RESPONSE_TYPE_EP11 3
>> +
> 
> I would leave the type defines in the zcrypt_msgtype50.c.

Done -> v2

> 
>>  struct ap_message {
>>  	struct list_head list;		/* Request queueing. */
>>  	unsigned long psmid;		/* Message id. */
>> @@ -222,7 +231,7 @@ struct ap_message {
>>  	size_t bufsize;			/* allocated msg buffer size */
>>  	u16 flags;			/* Flags, see AP_MSG_FLAG_xxx */
>>  	int rc;				/* Return code for this message */
>> -	void *private;			/* ap driver private pointer. */
>> +	struct ap_response_type response;
> 
> I don't like this change. The completion and the type are both
> message-type related. That means, this change pulls messate-type
> related data definitions into the ap-layer. On the other hand, I have
> currently no idea how this can be solved.
> 

Well, the "private" data could be opaque allocated in ap_init_apmsg 
without
any knowledge about the data - just the size. And the msg type 50 and 6
implementations could just check for the right size and then overlay the
private data bytes with their own struct.

>>  	/* receive is called from tasklet context */
>>  	void (*receive)(struct ap_queue *, struct ap_message *,
>>  			struct ap_message *);
>> @@ -250,7 +259,6 @@ static inline void ap_init_message(struct 
>> ap_message *ap_msg)
>>  static inline void ap_release_message(struct ap_message *ap_msg)
>>  {
>>  	kfree_sensitive(ap_msg->msg);
>> -	kfree_sensitive(ap_msg->private);
> 
> As far as I can see, the kfree_sensitive() was not really required, as
> this only contains the type and the completion, but no sensitive data,
> right?
> If the assumption is true, the change is ok (if not, we should replace
> it with a memzero_explicit()).

Your assumption is true - the private data only held a completion and
the type of the msg (type 50 or type 6) - all that is no sensitive info.

> 
>> @@ -454,25 +454,24 @@ static long zcrypt_msgtype50_modexpo(struct 
>> zcrypt_queue *zq,
>>  				     struct ica_rsa_modexpo *mex,
>>  				     struct ap_message *ap_msg)
>>  {
>> -	struct completion work;
>>  	int rc;
>> 
>>  	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
>> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
>> +	if (!ap_msg->msg)
>> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> 
> This change will be removed by the next patch in the series. Please
> drop it. There are other occurances later in the code, see my further
> comments.
> 

Done as you suggest -> v2

>>  	if (!ap_msg->msg)
>>  		return -ENOMEM;
>>  	ap_msg->receive = zcrypt_msgtype50_receive;
>>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>>  		atomic_inc_return(&zcrypt_step);
>> -	ap_msg->private = &work;
>>  	rc = ICAMEX_msg_to_type50MEX_msg(zq, ap_msg, mex);
>>  	if (rc)
>>  		goto out;
>> -	init_completion(&work);
>> +	init_completion(&ap_msg->response.work);
>>  	rc = ap_queue_message(zq->queue, ap_msg);
>>  	if (rc)
>>  		goto out;
>> -	rc = wait_for_completion_interruptible(&work);
>> +	rc = wait_for_completion_interruptible(&ap_msg->response.work);
>>  	if (rc == 0) {
>>  		rc = ap_msg->rc;
>>  		if (rc == 0)
> [...]
>> @@ -504,25 +502,24 @@ static long zcrypt_msgtype50_modexpo_crt(struct 
>> zcrypt_queue *zq,
>>  					 struct ica_rsa_modexpo_crt *crt,
>>  					 struct ap_message *ap_msg)
>>  {
>> -	struct completion work;
>>  	int rc;
>> 
>>  	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
>> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
>> +	if (!ap_msg->msg)
>> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> 
> Same here, please drop it.

-> v2

> 
>>  	if (!ap_msg->msg)
>>  		return -ENOMEM;
>>  	ap_msg->receive = zcrypt_msgtype50_receive;
>>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>>  		atomic_inc_return(&zcrypt_step);
>> -	ap_msg->private = &work;
>>  	rc = ICACRT_msg_to_type50CRT_msg(zq, ap_msg, crt);
>>  	if (rc)
>>  		goto out;
>> -	init_completion(&work);
>> +	init_completion(&ap_msg->response.work);
>>  	rc = ap_queue_message(zq->queue, ap_msg);
>>  	if (rc)
>>  		goto out;
>> -	rc = wait_for_completion_interruptible(&work);
>> +	rc = wait_for_completion_interruptible(&ap_msg->response.work);
>>  	if (rc == 0) {
>>  		rc = ap_msg->rc;
>>  		if (rc == 0)
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index b64c9d9fc613..21ee311cf33d 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -31,15 +31,6 @@
>> 
>>  #define CEIL4(x) ((((x) + 3) / 4) * 4)
>> 
>> -struct response_type {
>> -	struct completion work;
>> -	int type;
>> -};
>> -
>> -#define CEXXC_RESPONSE_TYPE_ICA  0
>> -#define CEXXC_RESPONSE_TYPE_XCRB 1
>> -#define CEXXC_RESPONSE_TYPE_EP11 2
>> -
> 
> Please define the message types here (see my previous comment).
> 

done -> v2

>>  MODULE_AUTHOR("IBM Corporation");
>>  MODULE_DESCRIPTION("Cryptographic Coprocessor (message type 6), " \
>>  		   "Copyright IBM Corp. 2001, 2023");
> [...]
>> @@ -1061,28 +1046,26 @@ static long zcrypt_msgtype6_modexpo_crt(struct 
>> zcrypt_queue *zq,
>>   * Prepare a CCA AP msg: fetch the required data from userspace,
>>   * prepare the AP msg, fill some info into the ap_message struct,
>>   * extract some data from the CPRB and give back to the caller.
>> - * This function allocates memory and needs an ap_msg prepared
>> - * by the caller with ap_init_message(). Also the caller has to
>> - * make sure ap_release_message() is always called even on failure.
>> + * This function may allocate memory if the ap_msg msg buffer is
>> + * not preallocated and needs an ap_msg prepared by the caller
>> + * with ap_init_message(). Also the caller has to make sure
>> + * ap_release_message() is always called even on failure.
> 
> Please move this change to the patch, which makes the allocation 
> optional.

done -> v2

> 
>>   */
>>  int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
>>  		    struct ap_message *ap_msg,
>>  		    unsigned int *func_code, unsigned short **dom)
>>  {
>> -	struct response_type resp_type = {
>> -		.type = CEXXC_RESPONSE_TYPE_XCRB,
>> -	};
>> +	struct ap_response_type *resp_type = &ap_msg->response;
>> 
>>  	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
>> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
>> +	if (!ap_msg->msg)
>> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> 
> Please drop the kmalloc change.

done -> v2

> 
>>  	if (!ap_msg->msg)
>>  		return -ENOMEM;
>>  	ap_msg->receive = zcrypt_msgtype6_receive;
>>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>>  				atomic_inc_return(&zcrypt_step);
>> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), 
>> GFP_KERNEL);
>> -	if (!ap_msg->private)
>> -		return -ENOMEM;
>> +	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
>>  	return xcrb_msg_to_type6cprb_msgx(userspace, ap_msg, xcrb, 
>> func_code, dom);
>>  }
>> 
> [...]
>> @@ -1158,28 +1141,26 @@ static long zcrypt_msgtype6_send_cprb(bool 
>> userspace, struct zcrypt_queue *zq,
>>   * Prepare an EP11 AP msg: fetch the required data from userspace,
>>   * prepare the AP msg, fill some info into the ap_message struct,
>>   * extract some data from the CPRB and give back to the caller.
>> - * This function allocates memory and needs an ap_msg prepared
>> - * by the caller with ap_init_message(). Also the caller has to
>> - * make sure ap_release_message() is always called even on failure.
>> + * This function may allocate memory if the ap_msg msg buffer is
>> + * not preallocated and needs an ap_msg prepared by the caller
>> + * with ap_init_message(). Also the caller has to make sure
>> + * ap_release_message() is always called even on failure.
> 
> Please move this change to the patch, which makes the allocation 
> optional.

done -> v2

> 
>>   */
>>  int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
>>  		     struct ap_message *ap_msg,
>>  		     unsigned int *func_code, unsigned int *domain)
>>  {
>> -	struct response_type resp_type = {
>> -		.type = CEXXC_RESPONSE_TYPE_EP11,
>> -	};
>> +	struct ap_response_type *resp_type = &ap_msg->response;
>> 
>>  	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
>> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
>> +	if (!ap_msg->msg)
>> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> 
> Please drop the kmalloc change.
> 

done -> v2

>>  	if (!ap_msg->msg)
>>  		return -ENOMEM;
>>  	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
>>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>>  				atomic_inc_return(&zcrypt_step);
>> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), 
>> GFP_KERNEL);
>> -	if (!ap_msg->private)
>> -		return -ENOMEM;
>> +	resp_type->type = CEXXC_RESPONSE_TYPE_EP11;
>>  	return xcrb_msg_to_type6_ep11cprb_msgx(userspace, ap_msg, xcrb,
>>  					       func_code, domain);
>>  }
> [...]
>> @@ -1279,20 +1260,18 @@ static long 
>> zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
>>  int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
>>  		    unsigned int *domain)
>>  {
>> -	struct response_type resp_type = {
>> -		.type = CEXXC_RESPONSE_TYPE_XCRB,
>> -	};
>> +	struct ap_response_type *resp_type = &ap_msg->response;
>> 
>>  	ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
>> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
>> +	if (!ap_msg->msg)
>> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> 
> Please drop the kmalloc change.
> 

done -> v2

>>  	if (!ap_msg->msg)
>>  		return -ENOMEM;
>>  	ap_msg->receive = zcrypt_msgtype6_receive;
>>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>>  				atomic_inc_return(&zcrypt_step);
>> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), 
>> GFP_KERNEL);
>> -	if (!ap_msg->private)
>> -		return -ENOMEM;
>> +
>> +	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
>> 
>>  	rng_type6cprb_msgx(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
>> 
> [...]
