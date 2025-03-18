Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC118A959
	for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300183; cv=none; b=SR1r8lTBt/6XHR7+zIiN+SQ8T7xKSNB+qXDfRxnHmqf5MeuM+opmj0GupoGsN0Zwoe09G91udupttvrDf56rhMT866vZjdX/ItUkerzHoLrff47CqXsWvTp1JNkNcDIhXcsvnO+BOm44kKsC2JgxyB5w+IHocbQ9tyeAMLgs5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300183; c=relaxed/simple;
	bh=x3A52UxEPyz09GSRVMuj8HmjZ9lnlpvcjJM9T0jjXZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCSLS5kSLMCi+DI3HNfypeqO88ze0lhc8r0woyW5hlK6hbl+EbFWN7CYScoYQyxyG/9JgoqgB5NpMa3f0DtsRPSNnMNNMCvFCNhgvcLUWOidDhEk7CQ7gHJjkcR4rdw7OvlLWjQ6FqjdV1gDZeLbX5iKDAWyp+kOFx8xPzbshlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qb9Vp7fg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qb9Vp7fg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9XEmn002778;
	Tue, 18 Mar 2025 12:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uwvPM0
	quICqKhL5Sw6EX0rFWH653a8s9AKE8i9gfMnQ=; b=qb9Vp7fghN3RJt0jZhR+r3
	jUCabdQE7rj24ECcNkXsp0TEBmMS2jHHjCm3RQpcCD3GBFmo98KqMfSrCDDQqDPH
	0bY2xQG3M8RpT+JbdOXwJldxKfKX04tLmnotkKMkXYGF0wYwV2csuN3+eGZad1KG
	WpW0o4EyFriDxJIZ0FEL35mKrYV2HQvgWoYUvWccwnb92X5/EV1aVxkObTM2oTk9
	ixfjIuo77KNCfFLEM7szqX4HsAkWP9tMxPgYH2ntd0ih+vM/B4Ea8406r7qpKmLK
	CxB4PUZ8oaIKMOChLP5qSI5YME1GpIJBHKnnW+qQwjGfftzdNDvVnHQEc6Oj+fcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0kjh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:16:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IALsOb009583;
	Tue, 18 Mar 2025 12:16:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8yuvtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:16:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52ICGDOg32047842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 12:16:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0302004F;
	Tue, 18 Mar 2025 12:16:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB36520040;
	Tue, 18 Mar 2025 12:16:12 +0000 (GMT)
Received: from [9.155.196.190] (unknown [9.155.196.190])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 12:16:12 +0000 (GMT)
Message-ID: <eb0c67b9-4f55-4a3d-854c-c7a28e651607@linux.ibm.com>
Date: Tue, 18 Mar 2025 13:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] s390/ap/zcrypt: New xflag parameter and
 extension of the ap msg flags
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-5-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lA5bmvLNVZEq7WTOsyybeZiwqxHGmvDV
X-Proofpoint-ORIG-GUID: lA5bmvLNVZEq7WTOsyybeZiwqxHGmvDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_05,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180088

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Introduce a new flag parameter for the both cprb send functions
> zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
> xflags parameter ("execution flags") shall be used to provide
> execution hints and flags for this crypto request.
> 
> There are two flags implemented to be used with these functions:
> * ZCRYPT_XFLAG_USERSPACE - indicates to the lower layers that
>   all the ptrs address userspace. So when construction the ap msg
>   copy_from_user() is to be used. If this flag is NOT set, the ptrs
>   address kernel memory and thus memcpy() is to be used.
> * ZCRYPT_XFLAG_NOMEMALLOC - indicates that this task must not
>   allocate memory which may be allocated with io operations.
>   For the zcrypt layer this limits the number of EP11 targets
>   to 16 APQNs. But as this flag is passed down the stack, it
>   may induce further restrictions.
> 
> For the AP bus and zcrypt message layer this means:
> * The ZCRYPT_XFLAG_USERSPACE is mapped to the AP flag
>   AP_MSG_FLAG_USERSPACE stored into the flags field of each
>   ap message in the ap_message struct. This replaces the extra
>   function parameter "userspace" and makes some function
>   invocations simpler.
> * The ZCRYPT_XFLAG_NOMEMALLOC causes the AP message buffer to
>   use buffer space from the AP message mempool instead of
>   allocating memory via kmalloc. Note that the buffer space
>   from the AP message mem pool is limited to 12KB per item.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

The boolean parameter `userspace` should only be merged with the xflags in functions, which has the need to handle ZCRYPT_XFLAG_USERSPACE and ZCRYPT_XFLAG_NOMEMALLOC, e.g _zcrypt_send_cprb(). Functions, which either only take one or the other flag may stay with the boolean parameter. There is also no need for a definition of AP_MSG_FLAG_USERSPACE, as the AP layer does not care about userspace pointers at all, only the zcrypt layer is affected by this flag. See my comments below.

> ---
>  drivers/s390/crypto/ap_bus.c          |  6 +-
>  drivers/s390/crypto/ap_bus.h          | 11 ++--
>  drivers/s390/crypto/zcrypt_api.c      | 90 +++++++++++++++------------
>  drivers/s390/crypto/zcrypt_api.h      | 36 +++++++----
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 16 ++---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 10 +--
>  drivers/s390/crypto/zcrypt_msgtype6.c | 12 ++--
>  drivers/s390/crypto/zcrypt_msgtype6.h |  4 +-
>  8 files changed, 107 insertions(+), 78 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index a7bd44e5cc76..5581fb13af73 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -233,12 +233,13 @@ struct ap_message {
>  			struct ap_message *);
>  };
>  
> -#define AP_MSG_FLAG_SPECIAL  0x0001   /* flag msg as 'special' with NQAP */
> -#define AP_MSG_FLAG_USAGE    0x0002   /* CCA, EP11: usage (no admin) msg */
> -#define AP_MSG_FLAG_ADMIN    0x0004   /* CCA, EP11: admin (=control) msg */
> -#define AP_MSG_FLAG_MEMPOOL  0x0008   /* ap msg buffer allocated from mempool */
> +#define AP_MSG_FLAG_SPECIAL    0x0001  /* flag msg as 'special' with NQAP */
> +#define AP_MSG_FLAG_USAGE      0x0002  /* CCA, EP11: usage (no admin) msg */
> +#define AP_MSG_FLAG_ADMIN      0x0004  /* CCA, EP11: admin (=control) msg */
> +#define AP_MSG_FLAG_MEMPOOL    0x0008  /* ap msg buffer allocated from mempool */
> +#define AP_MSG_FLAG_USERSPACE  0x0010  /* pointers address userspace memory */

Do we really need this flag in the AP layer? IIRC it has only meaning in the zcrypt layer. If this is correct, please remove it.

>  
> -int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
> +int ap_init_apmsg(struct ap_message *ap_msg, u32 flags);
>  void ap_release_apmsg(struct ap_message *ap_msg);
>  
>  enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index ad09c5306e28..659fe7afb67e 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
>  
>  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
>  
> -	rc = ap_init_apmsg(&ap_msg, false);
> +	rc = ap_init_apmsg(&ap_msg, AP_MSG_FLAG_USERSPACE);

use_mempool == false should be changed to 0, not AP_MSG_FLAG_USERSPACE.
rc = ap_init_apmsg(&ap_msg, 0);

>  	if (rc)
>  		goto out;
>  
> @@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
>  
>  	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
>  
> -	rc = ap_init_apmsg(&ap_msg, false);
> +	rc = ap_init_apmsg(&ap_msg, AP_MSG_FLAG_USERSPACE);

Same here.
rc = ap_init_apmsg(&ap_msg, 0);

>  	if (rc)
>  		goto out;
>  
[...]
> @@ -856,16 +856,19 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
>  	unsigned short *domain, tdom;
>  	int cpen, qpen, qid = 0, rc;
>  	struct module *mod;
> +	u32 flags;
>  
>  	trace_s390_zcrypt_req(xcrb, TB_ZSECSENDCPRB);
>  
>  	xcrb->status = 0;
>  
> -	rc = ap_init_apmsg(&ap_msg, false);
> +	flags = (xflags & ZCRYPT_XFLAG_USERSPACE ? AP_MSG_FLAG_USERSPACE : 0) |
> +		(xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);
> +	rc = ap_init_apmsg(&ap_msg, flags);

There is no need to translate ZCRYPT_XFLAG_USERSPACE to ap-msg flags, the AP layer should not care about userspace/kernelspace pointer.
rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);

>  	if (rc)
>  		goto out;
>  
> -	rc = prep_cca_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
> +	rc = prep_cca_ap_msg(xcrb, &ap_msg, &func_code, &domain);

The prep_cca_ap_msg() - and all functions below - can stay with the bool parameter.
rc = prep_cca_ap_msg((xflags & ZCRYPT_XFLAG_USERSPACE), xcrb, &ap_msg, &func_code, &domain);

>  	if (rc)
>  		goto out;
>  	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
> @@ -956,7 +959,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
>  	if (*domain == AUTOSEL_DOM)
>  		*domain = AP_QID_QUEUE(qid);
>  
> -	rc = pref_zq->ops->send_cprb(userspace, pref_zq, xcrb, &ap_msg);
> +	rc = pref_zq->ops->send_cprb(pref_zq, xcrb, &ap_msg);

Here as well, stay with the bool parameter userspace in the callback.
rc = pref_zq->ops->send_cprb((xflags & ZCRYPT_XFLAG_USERSPACE), pref_zq, xcrb, &ap_msg);

>  	if (!rc) {
>  		print_hex_dump_debug("ccarpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  				     ap_msg.msg, ap_msg.len, false);
[...]
> @@ -1029,52 +1032,58 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
>  	return false;
>  }
>  
> -static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
> +static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
>  				   struct zcrypt_track *tr,
>  				   struct ep11_urb *xcrb)
>  {
>  	struct zcrypt_card *zc, *pref_zc;
>  	struct zcrypt_queue *zq, *pref_zq;
> -	struct ep11_target_dev *targets;
> +	struct ep11_target_dev targetbuf[16], *targets = NULL;
>  	unsigned short target_num;
>  	unsigned int wgt = 0, pref_wgt = 0;
>  	unsigned int func_code = 0, domain;
>  	struct ap_message ap_msg;
>  	int cpen, qpen, qid = 0, rc;
>  	struct module *mod;
> +	u32 flags;
>  
>  	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
>  
> -	rc = ap_init_apmsg(&ap_msg, false);
> +	flags = (xflags & ZCRYPT_XFLAG_USERSPACE ? AP_MSG_FLAG_USERSPACE : 0) |
> +		(xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);
> +	rc = ap_init_apmsg(&ap_msg, flags);

The AP layer does not care about the userspace flag. Please remove it.
rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ? AP_MSG_FLAG_MEMPOOL : 0);

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
>  
>  		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
> -		if (z_copy_from_user(userspace, targets, uptr,
> -				     target_num * sizeof(*targets))) {
> -			func_code = 0;
> +		if (z_copy_from_user(xflags & ZCRYPT_XFLAG_USERSPACE, targets,
> +				     uptr, target_num * sizeof(*targets))) {
>  			rc = -EFAULT;
> -			goto out_free;
> +			goto out;
>  		}
>  	}
>  
> -	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
> +	rc = prep_ep11_ap_msg(xcrb, &ap_msg, &func_code, &domain);

Stay here with the boolean parameter for userspace.

>  	if (rc)
> -		goto out_free;
> +		goto out;
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
>  
[...]
> @@ -1154,11 +1163,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  			pr_debug("no match for address ff.ffff => ENODEV\n");
>  		}
>  		rc = -ENODEV;
> -		goto out_free;
> +		goto out;
>  	}
>  
>  	qid = pref_zq->queue->qid;
> -	rc = pref_zq->ops->send_ep11_cprb(userspace, pref_zq, xcrb, &ap_msg);
> +	rc = pref_zq->ops->send_ep11_cprb(pref_zq, xcrb, &ap_msg);

Keep the boolean parameter for userspace here as well.

>  	if (!rc) {
>  		print_hex_dump_debug("ep11rpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  				     ap_msg.msg, ap_msg.len, false);
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

