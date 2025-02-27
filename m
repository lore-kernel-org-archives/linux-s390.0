Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F7A59
	for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644519; cv=none; b=tg+GVs6zBNSyhqbmWfipZxzRGleTm7fyQe9ZNMrwIse7M4IHIRaKxlZ6mUGfKnszk+jZa7Cn+XyhMTanuzbxwHPR6eoj+GHAdbeN12v2PIPEP2aZlhLW5FSSf+t0GI3fyxyQ/2TfW7YuZSc6PsVBc3PcEzQapFlYuwy43VRqQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644519; c=relaxed/simple;
	bh=gVWVEdKQ8HzOPC4xqePddxkVpcsRTNyYqLPjR6J2uEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfSpdDKLTycJoik8rUwY8ksMg/YQxwDXZH8KpV5Z6bs2cJNrRXnJ+nPtx/ubu6KmLzbhCehA3xaB+imLcQQbis85b6QKQ8zsCJotQXFgZ9GZJSmA1jLjxYa5iDrIu757a9pbLTLcVk0TpKCgOaT/0w/WC9j/jqmpcaJHh7R4TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fn/r54c/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fn/r54c/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R212LG004668;
	Thu, 27 Feb 2025 08:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g7rLGe
	FP8kA1qq+Uo2bZ32Q/x5XXclo+Tx/RFwJKakg=; b=fn/r54c/8ArcBz/8KChYz3
	ah4l5Emzo6SJdoCQtQi/IgSTfgGwzWKr5Pw+npCcN9hDsgqxVH5nBClvGQaitQhx
	6rQYO1QXi2I/C6BUE7sV2gw9h7LU9+9yW+UTkr4gs7NjZvPZDT58FN7rtR1nYRaJ
	ox5vCcjGUwn1mDpfpgBv/w0rGTD+4jW9LRcDC0mhGFrXbOr2N8hsnlDc8mrTRirM
	2c6Mv1MHO6r0GNVDnM8yJP7DSv+D7jTCBOPPjqBUe35c9Fmvvj5QJxVRXREMPzSi
	hpCtbb2n789mGRzFUcjiSNOsPz0zm5fwzsK5HnwVPoY1cppwdvdrGfgPkSBttLvQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0hces-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 08:21:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R4hBCQ012507;
	Thu, 27 Feb 2025 08:21:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yqqwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 08:21:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51R8Lm3017695004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 08:21:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF25C20040;
	Thu, 27 Feb 2025 08:21:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4263D2004D;
	Thu, 27 Feb 2025 08:21:48 +0000 (GMT)
Received: from [9.179.31.31] (unknown [9.179.31.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 08:21:48 +0000 (GMT)
Message-ID: <e2b05ff5-cd5a-47fb-8b4c-dd8e90a97cd8@linux.ibm.com>
Date: Thu, 27 Feb 2025 09:21:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] s390/zcrypt: Rework zcrypt layer to support new
 flag NOMEMALLOC
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-5-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vbrd5Jp6AaO_PXpvMxaZJrjKmrrqg4oT
X-Proofpoint-ORIG-GUID: vbrd5Jp6AaO_PXpvMxaZJrjKmrrqg4oT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270060

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Introduce a new flag parameter for the both cprb send functions
> zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
> xflags parameter ("execution flags") shall be used to provide
> execution hints and flags for this crypto request.

See my comment below. Please evaluate, if the boolean `userspace` parameter can also be implemented as one of the xflags. 

> 
> One flag is implemented: The xflag ZCRYPT_XFLAG_NOMEMALLOC
> tells the zcrypt_send_*() functions to not allocate memory
> via kmalloc() and friends with the goal to not trigger any
> IO operations. If this xflag is given, it is also forwarded
> to the AP bus functions as AP_MSG_FLAG_MEMPOOL when the
> ap_init_apmsg() is invoked.
> 
> If the ZCRYPT_XFLAG_NOMEMALLOC is given, the zcrypt layer
> does not allocate any memory but may fail to send a crypto
> load:
> - The number of EP11 targets if given must not exceed 16 APQNs.
> - As the flag is passed down to the AP bus functions the
>   AP bus uses a limited mem pool (with limited item size)
>   to construct the AP msg. The AP bus mem pool may be depleted
>   and/or the message size may exceed the item size of the
>   AP bus mem pool. Currently the AP bus mem pool is limited
>   to 4 mem pool items of 12KB each. On not being able to process
>   a crypto request without memory allocation the result will
>   be -ENOMEM returned from the zcrypt_send_cprb_*() functions.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

See my comments below. Beside that
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c      | 65 +++++++++++++++------------
>  drivers/s390/crypto/zcrypt_api.h      | 12 ++++-
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++----
>  drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++---
>  4 files changed, 59 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index ce5f7cb974b9..f6deb10329e6 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -846,7 +846,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
>  
>  static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
>  			      struct zcrypt_track *tr,
> -			      struct ica_xcRB *xcrb)
> +			      struct ica_xcRB *xcrb, u32 xflags)

This is an internal only API, right? So please either use a bool for the NOMEMALLOC case or move the userspace boolean to the xflags.

>  {
>  	struct zcrypt_card *zc, *pref_zc;
>  	struct zcrypt_queue *zq, *pref_zq;
> @@ -861,7 +861,8 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
>  
>  	xcrb->status = 0;
>  
> -	rc = ap_init_apmsg(&ap_msg, 0);
> +	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
> +			   AP_MSG_FLAG_MEMPOOL : 0);

This is hard to read, because of the line break. I would prefer to have it in a separate line. 

u32 ap_flags = flags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0;
[...]
rc = ap_init_apmsg(&ap_msg, ap_flags);

>  	if (rc)
>  		goto out;
>  
> @@ -977,7 +978,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
>  	return rc;
>  }
>  
> -long zcrypt_send_cprb(struct ica_xcRB *xcrb)
> +long zcrypt_send_cprb(struct ica_xcRB *xcrb, u32 xflags)
>  {
>  	struct zcrypt_track tr;
>  	int rc;
> @@ -985,13 +986,14 @@ long zcrypt_send_cprb(struct ica_xcRB *xcrb)
>  	memset(&tr, 0, sizeof(tr));
>  
>  	do {
> -		rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
> +		rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb, xflags);
>  	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  
>  	/* on ENODEV failure: retry once again after a requested rescan */
>  	if (rc == -ENODEV && zcrypt_process_rescan())
>  		do {
> -			rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
> +			rc = _zcrypt_send_cprb(false, &ap_perms,
> +					       &tr, xcrb, xflags);
>  		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
>  		rc = -EIO;
> @@ -1031,11 +1033,11 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
>  
>  static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  				   struct zcrypt_track *tr,
> -				   struct ep11_urb *xcrb)
> +				   struct ep11_urb *xcrb, u32 xflags)
>  {
>  	struct zcrypt_card *zc, *pref_zc;
>  	struct zcrypt_queue *zq, *pref_zq;
> -	struct ep11_target_dev *targets;
> +	struct ep11_target_dev targetbuf[16], *targets = NULL;
>  	unsigned short target_num;
>  	unsigned int wgt = 0, pref_wgt = 0;
>  	unsigned int func_code = 0, domain;
> @@ -1045,36 +1047,39 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  
>  	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
>  
> -	rc = ap_init_apmsg(&ap_msg, 0);
> +	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
> +			   AP_MSG_FLAG_MEMPOOL : 0);
>  	if (rc)
>  		goto out;
>  
>  	target_num = (unsigned short)xcrb->targets_num;
>  
>  	/* empty list indicates autoselect (all available targets) */
> -	targets = NULL;
> +	rc = -ENOMEM;
>  	if (target_num != 0) {
>  		struct ep11_target_dev __user *uptr;
>  
> -		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
> -		if (!targets) {
> -			func_code = 0;
> -			rc = -ENOMEM;
> +		if (target_num <= ARRAY_SIZE(targetbuf)) {
> +			targets = targetbuf;
> +		} else if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>  			goto out;
> +		} else {
> +			targets = kcalloc(target_num,
> +					  sizeof(*targets), GFP_KERNEL);
> +			if (!targets)
> +				goto out;
>  		}
> -
>  		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
>  		if (z_copy_from_user(userspace, targets, uptr,
>  				     target_num * sizeof(*targets))) {
> -			func_code = 0;
>  			rc = -EFAULT;
> -			goto out_free;
> +			goto out;
>  		}
>  	}
>  
>  	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
>  	if (rc)
> -		goto out_free;
> +		goto out;
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
>  
> @@ -1082,11 +1087,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc = -ENODEV;
> -				goto out_free;
> +				goto out;
>  			}
>  		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) == 0) {
>  			rc = -EOPNOTSUPP;
> -			goto out_free;
> +			goto out;
>  		}
>  	}
>  
> @@ -1154,7 +1159,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  			pr_debug("no match for address ff.ffff => ENODEV\n");
>  		}
>  		rc = -ENODEV;
> -		goto out_free;
> +		goto out;
>  	}
>  
>  	qid = pref_zq->queue->qid;
> @@ -1168,9 +1173,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  	zcrypt_drop_queue(pref_zc, pref_zq, mod, wgt);
>  	spin_unlock(&zcrypt_list_lock);
>  
> -out_free:
> -	kfree(targets);
>  out:
> +	if (targets && targets != targetbuf)
> +		kfree(targets);
>  	ap_release_apmsg(&ap_msg);
>  	if (tr) {
>  		tr->last_rc = rc;
> @@ -1181,7 +1186,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  	return rc;
>  }
>  
> -long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
> +long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb, u32 xflags)
>  {
>  	struct zcrypt_track tr;
>  	int rc;
> @@ -1189,13 +1194,15 @@ long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
>  	memset(&tr, 0, sizeof(tr));
>  
>  	do {
> -		rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
> +		rc = _zcrypt_send_ep11_cprb(false, &ap_perms,
> +					    &tr, xcrb, xflags);
>  	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  
>  	/* on ENODEV failure: retry once again after a requested rescan */
>  	if (rc == -ENODEV && zcrypt_process_rescan())
>  		do {
> -			rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
> +			rc = _zcrypt_send_ep11_cprb(false, &ap_perms,
> +						    &tr, xcrb, xflags);
>  		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
>  		rc = -EIO;
> @@ -1539,13 +1546,13 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
>  		return -EFAULT;
>  
>  	do {
> -		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
> +		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb, 0);
>  	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  
>  	/* on ENODEV failure: retry once again after a requested rescan */
>  	if (rc == -ENODEV && zcrypt_process_rescan())
>  		do {
> -			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
> +			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb, 0);
>  		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
>  		rc = -EIO;
> @@ -1569,13 +1576,13 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
>  		return -EFAULT;
>  
>  	do {
> -		rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
> +		rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb, 0);
>  	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  
>  	/* on ENODEV failure: retry once again after a requested rescan */
>  	if (rc == -ENODEV && zcrypt_process_rescan())
>  		do {
> -			rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
> +			rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb, 0);
>  		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
>  	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
>  		rc = -EIO;
> diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
> index 4ed481df57ca..06ff697d171c 100644
> --- a/drivers/s390/crypto/zcrypt_api.h
> +++ b/drivers/s390/crypto/zcrypt_api.h
> @@ -76,6 +76,14 @@ struct zcrypt_track {
>  #define TRACK_AGAIN_CARD_WEIGHT_PENALTY  1000
>  #define TRACK_AGAIN_QUEUE_WEIGHT_PENALTY 10000
>  
> +/*
> + * Do not allocate memory xflag. To be used with
> + * zcrypt_send_cprb() and zcrypt_send_ep11_cprb().
> + * Currently only available and used for the in-kernel
> + * zcrpyt api.
> + */
> +#define ZCRYPT_XFLAG_NOMEMALLOC 0x0001
> +
>  struct zcrypt_ops {
>  	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *,
>  			    struct ap_message *);
> @@ -161,8 +169,8 @@ void zcrypt_msgtype_unregister(struct zcrypt_ops *);
>  struct zcrypt_ops *zcrypt_msgtype(unsigned char *, int);
>  int zcrypt_api_init(void);
>  void zcrypt_api_exit(void);
> -long zcrypt_send_cprb(struct ica_xcRB *xcRB);
> -long zcrypt_send_ep11_cprb(struct ep11_urb *urb);
> +long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
> +long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
>  void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
>  int zcrypt_device_status_ext(int card, int queue,
>  			     struct zcrypt_device_status_ext *devstatus);
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 43a27cb3db84..521baaea06ff 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -379,7 +379,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -517,7 +517,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -644,7 +644,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -872,7 +872,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -1038,7 +1038,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -1249,7 +1249,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -1412,7 +1412,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -1526,7 +1526,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
>  	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
>  
>  	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
> -	rc = zcrypt_send_cprb(&xcrb);
> +	rc = zcrypt_send_cprb(&xcrb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index cb7e6da43602..b60e262bcaa3 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -636,7 +636,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
>  		 req, sizeof(*req) + sizeof(*req_pl),
>  		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
>  
> -	rc = zcrypt_send_ep11_cprb(urb);
> +	rc = zcrypt_send_ep11_cprb(urb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
> @@ -892,7 +892,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
>  		 req, sizeof(*req) + req_pl_size,
>  		 rep, sizeof(*rep) + sizeof(*rep_pl));
>  
> -	rc = zcrypt_send_ep11_cprb(urb);
> +	rc = zcrypt_send_ep11_cprb(urb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)card, (int)domain, rc);
> @@ -1049,7 +1049,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
>  		 req, sizeof(*req) + req_pl_size,
>  		 rep, sizeof(*rep) + rep_pl_size);
>  
> -	rc = zcrypt_send_ep11_cprb(urb);
> +	rc = zcrypt_send_ep11_cprb(urb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)card, (int)domain, rc);
> @@ -1212,7 +1212,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
>  		 req, sizeof(*req) + req_pl_size,
>  		 rep, sizeof(*rep) + sizeof(*rep_pl));
>  
> -	rc = zcrypt_send_ep11_cprb(urb);
> +	rc = zcrypt_send_ep11_cprb(urb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)card, (int)domain, rc);
> @@ -1372,7 +1372,7 @@ static int _ep11_wrapkey(u16 card, u16 domain,
>  		 req, sizeof(*req) + req_pl_size,
>  		 rep, sizeof(*rep) + sizeof(*rep_pl));
>  
> -	rc = zcrypt_send_ep11_cprb(urb);
> +	rc = zcrypt_send_ep11_cprb(urb, 0);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)card, (int)domain, rc);

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

