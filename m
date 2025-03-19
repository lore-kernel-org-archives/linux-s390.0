Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755B2248AF
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382202; cv=none; b=ZziaFL6l4OxwmK0VQe1N8nMi8i6T2AmnOydkQDkkwuwiP/YUWqv/B1pxxlbtwzLtgqgbG6ChAcoMmcPQZK6Ym9QG90ihkCTR20Avn3/QmnomW9TzgewwCmQu7tTKNr21bNGfAQG8LJHWezON8sZXUlFzYwZPVbcSOxevWazxDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382202; c=relaxed/simple;
	bh=Fy0fWLsXp7ml6lDG584es2shlVnDDu14yoS86D/bgko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f630m3Ifnisz3yohNWl84dUBVG6/3JNUiZHdr7bNXjsK/niLlSzAu9qp3JJdgtqJ9J/+pugKnIgQGU4FkyJbJJyg885GGbOSYS5+WVXogYyZnrUpbpJ2Xeq5um5rcrrnTg0EyIKXiOrJXryc2j/bqaRMSTNFk4wfgdjDT0Zst9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XN+ZeJXW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XN+ZeJXW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J3kW02019598;
	Wed, 19 Mar 2025 11:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ezeOvo
	lR8BM6R52MwQVwOv/J4ao1gEF9kfrSFDks7cg=; b=XN+ZeJXWn4xx+ywoqu5NgV
	sNLRYKkzi3K6PsL8m40Exl+O8jAToYK2xfZX3IF7q0DNwFvj78hQDHwSSzacy6CF
	Pvnwx2JPsreH4Wiq4zOxrxAGV3CYlxAiM8OkmPdvr4USUb5q4f3Vm/oYFGHfC74r
	ITbc1SAEcGXAIzXmQbJmK7RR3DyxABEeliQhTEw2zE1RCsOjnmOeD3i4SONIKf/r
	JQZUmpls3MKik+8n/efsDHIGFZOK0sl+ZrFBpetvqdro8RdKFm8RpkvcZ+lMtUmJ
	89mzTnY1A26T1hwnbkgfyeT8mrwZ3uEdgrT5+MCNsg1z9GhzqDxXCZteYCctOVuQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9hv8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:03:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J89fUe032041;
	Wed, 19 Mar 2025 11:03:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvthcns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:03:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JB3DQq47186242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 11:03:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4336720043;
	Wed, 19 Mar 2025 11:03:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C873B20040;
	Wed, 19 Mar 2025 11:03:12 +0000 (GMT)
Received: from [9.171.69.178] (unknown [9.171.69.178])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 11:03:12 +0000 (GMT)
Message-ID: <64bab2ed-4302-45bf-b831-009c5b2d34e1@linux.ibm.com>
Date: Wed, 19 Mar 2025 12:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] s390/zcrypt: Rework zcrypt function
 zcrypt_device_status_mask_ext
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-8-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WMeOFffYOPRRDwlRsQSnx1uUThUyCEl7
X-Proofpoint-ORIG-GUID: WMeOFffYOPRRDwlRsQSnx1uUThUyCEl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190076

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Rework the existing function zcrypt_device_status_mask_ext():
> * Add two new parameters to provide upper limits for
>   cards and queues. The existing implementation needed an
>   array of 256 * 256 * 4 = 256 KB which is really huge. The
>   reworked function is more flexible in the sense that the
>   caller can decide the upper limit for cards and domains to
>   be stored into the status array. So for example a caller may
>   decide to only query for cards 0...127 and queues 0...127
>   and thus only an array of size 128 * 128 * 4 = 64 KB is needed.
> * Instead of void the reworked function now returns an int.
>   The currently only way to have the function return != 0
>   is by providing card or domains limits beyond 256.

I would prefer to stay with a void function and limit the card and domain values to the current maximum. Details below.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c      | 20 +++++++++++++++-----
>  drivers/s390/crypto/zcrypt_api.h      |  3 ++-
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 22 +++++++++++++++++-----
>  drivers/s390/crypto/zcrypt_ep11misc.c | 14 ++++++++++----
>  4 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index 62cc05881b13..bd2738e3792a 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1317,19 +1317,25 @@ static void zcrypt_device_status_mask(struct zcrypt_device_status *devstatus)
>  	spin_unlock(&zcrypt_list_lock);
>  }
>  
> -void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
> +int zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus,
> +				  int maxcard, int maxqueue)

Keep void and ...

>  {
>  	struct zcrypt_card *zc;
>  	struct zcrypt_queue *zq;
>  	struct zcrypt_device_status_ext *stat;
>  	int card, queue;
>  
> +	if (maxcard > MAX_ZDEV_CARDIDS_EXT || maxqueue > MAX_ZDEV_DOMAINS_EXT)
> +		return -EINVAL;
> +

... limit maxcard/maxqueue to the maximum supported values. In my opinion, it does not make any sense to call this function with higher values than the maximum.

maxcard = MIN(maxcard, MAX_ZDEV_CARDIDS_EXT);
maxqueue = MIN(maxqueue, MAX_ZDEV_DOMAINS_EXT);

As a side effect, it keeps the caller code much simpler.

>  	spin_lock(&zcrypt_list_lock);
>  	for_each_zcrypt_card(zc) {
>  		for_each_zcrypt_queue(zq, zc) {
>  			card = AP_QID_CARD(zq->queue->qid);
>  			queue = AP_QID_QUEUE(zq->queue->qid);
> -			stat = &devstatus[card * AP_DOMAINS + queue];
> +			if (card >= maxcard || queue >= maxqueue)
> +				continue;
> +			stat = &devstatus[card * maxqueue + queue];
>  			stat->hwtype = zc->card->ap_dev.device_type;
>  			stat->functions = zc->card->hwinfo.fac >> 26;
>  			stat->qid = zq->queue->qid;
[...]
> @@ -1635,9 +1643,11 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
>  					 GFP_KERNEL);
>  		if (!device_status)
>  			return -ENOMEM;
> -		zcrypt_device_status_mask_ext(device_status);
> -		if (copy_to_user((char __user *)arg, device_status,
> -				 total_size))
> +		rc = zcrypt_device_status_mask_ext(device_status,
> +						   MAX_ZDEV_CARDIDS_EXT,
> +						   MAX_ZDEV_DOMAINS_EXT);
> +		if (!rc && copy_to_user((char __user *)arg, device_status,
> +					total_size))

With the change above, you can stay with the current error handling. Only the addition parameters for zcrypt_device_status_mask_ext() need to be added. 

>  			rc = -EFAULT;
>  		kvfree(device_status);
>  		return rc;
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

