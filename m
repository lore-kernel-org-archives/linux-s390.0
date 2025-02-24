Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEE1925B8
	for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410609; cv=none; b=XkxvdhXOgZBGGm1frjFQX+sFLrZpV/fbuk1Vp95vwhCioQR+NJ6/seQWSPvShKPI3OpOqmxjRUOGgBTwwHskkEQl8DzGqUfS2GtPJAyNSQ8k7HwEsg9bo1sG9wdiZiSNKYhGLuc3LnXeFyBnjcAJAR4v+Ot3JyFwrMG0gWZsrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410609; c=relaxed/simple;
	bh=TxgpLU9DXHicLCjWzGVrbHcn+PZYukNLOZ1NZIlkOG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRJOGIPfDzy2BTwNAOhDM0ZrzLKoYeEaMcYvxHK3eWQyW5LiRP432BjooJ6/crC1axyi1Z7EQ2NnulSL1bpw/kUAt31u57i5iXHbCNXM3gkag9u7oQOQBO9LGhgOSvQ+ijiz6DWPSahFFTNxjxBJwg3bAEfJQiAbVLHruYFdMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lfq43o0s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lfq43o0s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5O9Q6012154;
	Mon, 24 Feb 2025 15:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fdXN83
	Oo6pcXkCMe+Hw+CuGV/HhBm1jOgf/lZe0HHLg=; b=Lfq43o0s4+rcL89qL+049m
	KF6tsYsa07gdiAlr9DH9xQCUghwMqC3k25pXAYPlItPfa1P0Ws66t1JJWNRJhnF1
	U/cfyzTPQ8YO6QvPHJUgnXGDjcz7lXzA75YN5F+0ixxAdDV8eGydnl/Lx4HcUmz2
	iUR8KGmpbYW0eOfP4jP6Gwp3ENQbOkH7S8oFjdms/E8rZZ4dRK6VQYAZ4/HwJGs9
	SeAfp/zUhG82I228a8vfwv8/QX3h0++ay1a82x79PEfJ4yAAyWNEzvt+zDiIhASQ
	aVyJq6gj4Lz5/yQ8OX8ntBEDO6IfkiYhcKzwBuElZcGF1Np/9kh58BDjiMOPjflw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450jk82mfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 15:23:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCdrVY027479;
	Mon, 24 Feb 2025 15:23:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk7njn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 15:23:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51OFNJP626673434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 15:23:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236BF2004B;
	Mon, 24 Feb 2025 15:23:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA7A420043;
	Mon, 24 Feb 2025 15:23:18 +0000 (GMT)
Received: from [9.171.13.48] (unknown [9.171.13.48])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 15:23:18 +0000 (GMT)
Message-ID: <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
Date: Mon, 24 Feb 2025 16:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] s390/ap: Move response_type struct into ap_msg
 struct
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-2-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AbDq3l7oUaTTI-9uCrlvinDaNISwMQ5_
X-Proofpoint-GUID: AbDq3l7oUaTTI-9uCrlvinDaNISwMQ5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240107

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Move the very small response_type struct into struct ap_msg.
> So there is no need to kmalloc this tiny struct with each
> ap message preparation.

I understand the intention for this patch, but in my opinion the layering concept between ap and zcrypt is violated by defining the response-type as part of the ap message struct. But I don't have any better solution, so for the moment you may leave it as is.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.h           |  12 ++-
>  drivers/s390/crypto/zcrypt_msgtype50.c |  22 +++---
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 101 ++++++++++---------------
>  3 files changed, 59 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index f4622ee4d894..a5d8f805625f 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -214,6 +214,15 @@ struct ap_queue {
>  
>  typedef enum ap_sm_wait (ap_func_t)(struct ap_queue *queue);
>  
> +struct ap_response_type {
> +	struct completion work;
> +	int type;
> +};
> +
> +#define CEXXC_RESPONSE_TYPE_ICA  1
> +#define CEXXC_RESPONSE_TYPE_XCRB 2
> +#define CEXXC_RESPONSE_TYPE_EP11 3
> +

I would leave the type defines in the zcrypt_msgtype50.c.

>  struct ap_message {
>  	struct list_head list;		/* Request queueing. */
>  	unsigned long psmid;		/* Message id. */
> @@ -222,7 +231,7 @@ struct ap_message {
>  	size_t bufsize;			/* allocated msg buffer size */
>  	u16 flags;			/* Flags, see AP_MSG_FLAG_xxx */
>  	int rc;				/* Return code for this message */
> -	void *private;			/* ap driver private pointer. */
> +	struct ap_response_type response;

I don't like this change. The completion and the type are both message-type related. That means, this change pulls messate-type related data definitions into the ap-layer. On the other hand, I have currently no idea how this can be solved.

>  	/* receive is called from tasklet context */
>  	void (*receive)(struct ap_queue *, struct ap_message *,
>  			struct ap_message *);
> @@ -250,7 +259,6 @@ static inline void ap_init_message(struct ap_message *ap_msg)
>  static inline void ap_release_message(struct ap_message *ap_msg)
>  {
>  	kfree_sensitive(ap_msg->msg);
> -	kfree_sensitive(ap_msg->private);

As far as I can see, the kfree_sensitive() was not really required, as this only contains the type and the completion, but no sensitive data, right?
If the assumption is true, the change is ok (if not, we should replace it with a memzero_explicit()).

> @@ -454,25 +454,24 @@ static long zcrypt_msgtype50_modexpo(struct zcrypt_queue *zq,
>  				     struct ica_rsa_modexpo *mex,
>  				     struct ap_message *ap_msg)
>  {
> -	struct completion work;
>  	int rc;
>  
>  	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> +	if (!ap_msg->msg)
> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);

This change will be removed by the next patch in the series. Please drop it. There are other occurances later in the code, see my further comments.

>  	if (!ap_msg->msg)
>  		return -ENOMEM;
>  	ap_msg->receive = zcrypt_msgtype50_receive;
>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>  		atomic_inc_return(&zcrypt_step);
> -	ap_msg->private = &work;
>  	rc = ICAMEX_msg_to_type50MEX_msg(zq, ap_msg, mex);
>  	if (rc)
>  		goto out;
> -	init_completion(&work);
> +	init_completion(&ap_msg->response.work);
>  	rc = ap_queue_message(zq->queue, ap_msg);
>  	if (rc)
>  		goto out;
> -	rc = wait_for_completion_interruptible(&work);
> +	rc = wait_for_completion_interruptible(&ap_msg->response.work);
>  	if (rc == 0) {
>  		rc = ap_msg->rc;
>  		if (rc == 0)
[...]
> @@ -504,25 +502,24 @@ static long zcrypt_msgtype50_modexpo_crt(struct zcrypt_queue *zq,
>  					 struct ica_rsa_modexpo_crt *crt,
>  					 struct ap_message *ap_msg)
>  {
> -	struct completion work;
>  	int rc;
>  
>  	ap_msg->bufsize = MSGTYPE50_CRB3_MAX_MSG_SIZE;
> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> +	if (!ap_msg->msg)
> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);

Same here, please drop it. 

>  	if (!ap_msg->msg)
>  		return -ENOMEM;
>  	ap_msg->receive = zcrypt_msgtype50_receive;
>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>  		atomic_inc_return(&zcrypt_step);
> -	ap_msg->private = &work;
>  	rc = ICACRT_msg_to_type50CRT_msg(zq, ap_msg, crt);
>  	if (rc)
>  		goto out;
> -	init_completion(&work);
> +	init_completion(&ap_msg->response.work);
>  	rc = ap_queue_message(zq->queue, ap_msg);
>  	if (rc)
>  		goto out;
> -	rc = wait_for_completion_interruptible(&work);
> +	rc = wait_for_completion_interruptible(&ap_msg->response.work);
>  	if (rc == 0) {
>  		rc = ap_msg->rc;
>  		if (rc == 0)
[...]
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index b64c9d9fc613..21ee311cf33d 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -31,15 +31,6 @@
>  
>  #define CEIL4(x) ((((x) + 3) / 4) * 4)
>  
> -struct response_type {
> -	struct completion work;
> -	int type;
> -};
> -
> -#define CEXXC_RESPONSE_TYPE_ICA  0
> -#define CEXXC_RESPONSE_TYPE_XCRB 1
> -#define CEXXC_RESPONSE_TYPE_EP11 2
> -

Please define the message types here (see my previous comment).

>  MODULE_AUTHOR("IBM Corporation");
>  MODULE_DESCRIPTION("Cryptographic Coprocessor (message type 6), " \
>  		   "Copyright IBM Corp. 2001, 2023");
[...]
> @@ -1061,28 +1046,26 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
>   * Prepare a CCA AP msg: fetch the required data from userspace,
>   * prepare the AP msg, fill some info into the ap_message struct,
>   * extract some data from the CPRB and give back to the caller.
> - * This function allocates memory and needs an ap_msg prepared
> - * by the caller with ap_init_message(). Also the caller has to
> - * make sure ap_release_message() is always called even on failure.
> + * This function may allocate memory if the ap_msg msg buffer is
> + * not preallocated and needs an ap_msg prepared by the caller
> + * with ap_init_message(). Also the caller has to make sure
> + * ap_release_message() is always called even on failure.

Please move this change to the patch, which makes the allocation optional.

>   */
>  int prep_cca_ap_msg(bool userspace, struct ica_xcRB *xcrb,
>  		    struct ap_message *ap_msg,
>  		    unsigned int *func_code, unsigned short **dom)
>  {
> -	struct response_type resp_type = {
> -		.type = CEXXC_RESPONSE_TYPE_XCRB,
> -	};
> +	struct ap_response_type *resp_type = &ap_msg->response;
>  
>  	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> +	if (!ap_msg->msg)
> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);

Please drop the kmalloc change.

>  	if (!ap_msg->msg)
>  		return -ENOMEM;
>  	ap_msg->receive = zcrypt_msgtype6_receive;
>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>  				atomic_inc_return(&zcrypt_step);
> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
> -	if (!ap_msg->private)
> -		return -ENOMEM;
> +	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
>  	return xcrb_msg_to_type6cprb_msgx(userspace, ap_msg, xcrb, func_code, dom);
>  }
>  
[...]
> @@ -1158,28 +1141,26 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
>   * Prepare an EP11 AP msg: fetch the required data from userspace,
>   * prepare the AP msg, fill some info into the ap_message struct,
>   * extract some data from the CPRB and give back to the caller.
> - * This function allocates memory and needs an ap_msg prepared
> - * by the caller with ap_init_message(). Also the caller has to
> - * make sure ap_release_message() is always called even on failure.
> + * This function may allocate memory if the ap_msg msg buffer is
> + * not preallocated and needs an ap_msg prepared by the caller
> + * with ap_init_message(). Also the caller has to make sure
> + * ap_release_message() is always called even on failure.

Please move this change to the patch, which makes the allocation optional.

>   */
>  int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
>  		     struct ap_message *ap_msg,
>  		     unsigned int *func_code, unsigned int *domain)
>  {
> -	struct response_type resp_type = {
> -		.type = CEXXC_RESPONSE_TYPE_EP11,
> -	};
> +	struct ap_response_type *resp_type = &ap_msg->response;
>  
>  	ap_msg->bufsize = atomic_read(&ap_max_msg_size);
> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> +	if (!ap_msg->msg)
> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);

Please drop the kmalloc change.

>  	if (!ap_msg->msg)
>  		return -ENOMEM;
>  	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>  				atomic_inc_return(&zcrypt_step);
> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
> -	if (!ap_msg->private)
> -		return -ENOMEM;
> +	resp_type->type = CEXXC_RESPONSE_TYPE_EP11;
>  	return xcrb_msg_to_type6_ep11cprb_msgx(userspace, ap_msg, xcrb,
>  					       func_code, domain);
>  }
[...]
> @@ -1279,20 +1260,18 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
>  int prep_rng_ap_msg(struct ap_message *ap_msg, int *func_code,
>  		    unsigned int *domain)
>  {
> -	struct response_type resp_type = {
> -		.type = CEXXC_RESPONSE_TYPE_XCRB,
> -	};
> +	struct ap_response_type *resp_type = &ap_msg->response;
>  
>  	ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
> -	ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);
> +	if (!ap_msg->msg)
> +		ap_msg->msg = kmalloc(ap_msg->bufsize, GFP_KERNEL);

Please drop the kmalloc change.

>  	if (!ap_msg->msg)
>  		return -ENOMEM;
>  	ap_msg->receive = zcrypt_msgtype6_receive;
>  	ap_msg->psmid = (((unsigned long)current->pid) << 32) +
>  				atomic_inc_return(&zcrypt_step);
> -	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
> -	if (!ap_msg->private)
> -		return -ENOMEM;
> +
> +	resp_type->type = CEXXC_RESPONSE_TYPE_XCRB;
>  
>  	rng_type6cprb_msgx(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
>  
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

