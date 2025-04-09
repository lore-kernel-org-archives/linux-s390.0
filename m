Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA667268FEB
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215588; cv=none; b=FjpXo+tQLmbckiO0OxgemBnXX1lzSlxLuy0hVKZ3iOHmoTEkBKyuyvHnh3Tplg1TBWYV/GwRMpmMp0lWAbv2cYd7x/ZiYhNzCr1xwqIDHMLZxTwFi4ketQD3OLBlR16G7s2nw6seImN3Spxkdq1OT9hajWmY7LR1atelDN62FCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215588; c=relaxed/simple;
	bh=up1gEinRNM91odG0H7wty+/7LYHB2SqwZlsnj01bVPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiQ1Ci/SALW74iY+a7OtjfPYv410EZinAT59mQD9lAwYZ96A9VoYsba1uk8pQcAQ8ddjG25im5F7Y7bRAL+3TZmY7+pXEDqLDQKkNOCwy3y9jrCjPcWfcLgEIK5tS6vSr5YTXKDh1bVLOnaEMvLC3asG44nsUVz7ADU739gMt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h2T1IpkR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2T1IpkR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399pgUp008925;
	Wed, 9 Apr 2025 16:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eSF5jr
	0uMJP0aV+h2wLjjrLGNxuZuBqK5xQ29ajex/8=; b=h2T1IpkRsiLP+Gdy4ktkJN
	4q13mquMcMayR0GPcOi7baU2QSmoxSSOcTrbLhPNlN/MHBy070T28J65znL/+zdJ
	ChMNPm5TNy7fc49qBPPlw15WC/dQZ/5ny0H4VJo/ogONzSnGdh/i2Em14EJj4NCR
	1n057TGLm64QGsYI6cg9msZnQQe5LZjRig68HkPIcjIZbwchekB0/6IQPj09bz/8
	GxQwcrrrYiktxs2AKwhhXo/2MhdCeB5mLHwGre2xm/frh2Uukt6V4ZP1UpRz/93J
	GKt21gd9UUcUAbW6+z8a4itO9/j3wAxVmyqS11xYBUxU1sKSl/K+jOLONnDQa34A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr4qg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 16:19:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539E2UZY025598;
	Wed, 9 Apr 2025 16:19:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm0ewn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 16:19:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539GJbLE49414424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 16:19:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC7520043;
	Wed,  9 Apr 2025 16:19:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CC4720040;
	Wed,  9 Apr 2025 16:19:36 +0000 (GMT)
Received: from [9.171.58.154] (unknown [9.171.58.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 16:19:36 +0000 (GMT)
Message-ID: <ddb55814-f132-4db2-af3f-7e41b8f01cca@linux.ibm.com>
Date: Wed, 9 Apr 2025 18:19:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/24] s390/zcrypt: Avoid alloc and copy of ep11
 targets if kernelspace cprb
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-5-freude@linux.ibm.com>
Content-Language: de-DE, en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7B83RVnUKXhRJCSFlkVWK-BChMMVjR-k
X-Proofpoint-GUID: 7B83RVnUKXhRJCSFlkVWK-BChMMVjR-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090102

On 09/04/2025 16:02, Harald Freudenberger wrote:
> If there is a target list of APQNs given when an CPRB is
> to be send via zcrypt_send_ep11_cprb() there is always a
> kmalloc() done and the targets are copied via z_copy_from_user.
> 
> As there are callers from kernel space (zcrypt_ep11misc.c)
> which signal this via the userspace parameter improve this
> code to directly use the given target list in case of
> kernelspace thus removing the unnecessary memory alloc
> and mem copy.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

I have a few comments below. The rest looks good to me.

> ---
>  drivers/s390/crypto/zcrypt_api.c | 41 ++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index ad09c5306e28..f96f596e578f 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
[...]
> @@ -1052,29 +1052,28 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  	target_num = (unsigned short)xcrb->targets_num;
>  
>  	/* empty list indicates autoselect (all available targets) */
> -	targets = NULL;
> +	rc = -ENOMEM;

I would prefer to set rc in the kmalloc error handling. See below.

>  	if (target_num != 0) {
>  		struct ep11_target_dev __user *uptr;

*uptr is no longer required, as the userspace case is ensured by code.

>  
> -		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
> -		if (!targets) {
> -			func_code = 0;
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> -
> -		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
> -		if (z_copy_from_user(userspace, targets, uptr,
> -				     target_num * sizeof(*targets))) {
> -			func_code = 0;
> -			rc = -EFAULT;
> -			goto out_free;
> +		if (userspace) {
> +			targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
> +			if (!targets)
> +				goto out;

Please set rc here. It makes it easier to read as it correlates with the other error case for copy_from_user().

if (!targets) {
	rc = -ENOMEM;
	goto out;
}

> +			uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
> +			if (copy_from_user(targets, uptr,
> +					   target_num * sizeof(*targets))) {

The cast can be dropped and you can copy directly from the userspace pointer in xcrb.

if (copy_from_user(targets, xcrb->targets,
		   target_num * sizeof(*targets))) {

> +				rc = -EFAULT;
> +				goto out;
> +			}
> +		} else {
> +			targets = (struct ep11_target_dev __force __kernel *)xcrb->targets;
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
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

