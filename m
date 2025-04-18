Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562F26A084
	for <linux-s390@vger.kernel.org>; Fri, 18 Apr 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963053; cv=none; b=O1H03ZtsyPWwSPAlXh+Rpy/J5FHQcH6SecRmd/cS92VyIEd8R57Qv7DDhVT5IQwDIKcrVldf6v9E6jOAUG8cPP6VoSHr08IyAbStNbLdNQ3xY+Bw89o9BF1bYaAeyTKMaRhgQjQgjPFaLofnWWlmusIN1rnSXUOp6A/RNA6wlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963053; c=relaxed/simple;
	bh=9tQPjwbJZwyW44fIg3InGoEiR8lbr0XLhq1tQZi9XVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfE9cmu+tCGL8tjDaZ2YK371yx7kt+0Mgb/Yw2xWBFZl62aPlaJKRDtUSfwUCIwIq3iKV3gL9UJv8q9JOY+96sDRX6OXbp059U1ln3dFyTDwFB5ANSFqvA6eTze1Ebjeb2MhrqZXwZhiNRQuZ8b3fzJr94bFLds6E4DBVDyR3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rrOPWro/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rrOPWro/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HLYDXV031697;
	Fri, 18 Apr 2025 07:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VJtSXY
	XZV/kbxw9cZTPTaHMrz79tK8Phx5iql35T4rQ=; b=rrOPWro/vcZIq0p+Oehlt7
	H44pNH9ECHoukolE7BLAjt6zB2a0jDzKHytTjRFiLX2hZl7Rdn6e/q5L/PNqBfzP
	L0ZX4+81FbHhitGy6Zp6TtoBOAregqWQbFX0fqF4Y1KNwh836AzmJnAhau81kgIc
	PatfktaJjLjw271bFAXR7/qqVLqMAMw4U/9AkbKFWhZMbSOCP284nKZezWGVdlLE
	/dCW7uq+TJF3g5qRXXEZPpzwlACgCP8G9ph3tPON/ogvBVUfnOqjuNpdVwppq61J
	7FaaCPwmvEkLkq+LXGodwlcEgbXnUTzUeXQn0rArToGaB6b9rJfw9CCkFunWz3ow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462yjjd8km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 07:57:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53I6KIXX030910;
	Fri, 18 Apr 2025 07:57:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gp1tx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 07:57:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53I7vNj351053034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 07:57:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 310FB20043;
	Fri, 18 Apr 2025 07:57:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A828E20040;
	Fri, 18 Apr 2025 07:57:22 +0000 (GMT)
Received: from [9.111.39.25] (unknown [9.111.39.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Apr 2025 07:57:22 +0000 (GMT)
Message-ID: <ad59b9e8-4d53-43b0-a9de-4af6ed4b9f99@linux.ibm.com>
Date: Fri, 18 Apr 2025 09:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/25] s390/zcrypt: Avoid alloc and copy of ep11
 targets if kernelspace cprb
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
References: <20250416135801.133909-1-freude@linux.ibm.com>
 <20250416135801.133909-5-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250416135801.133909-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LhQVgHu03Em9PpYzgjWJO40DZFc7hV4O
X-Authority-Analysis: v=2.4 cv=MsNS63ae c=1 sm=1 tr=0 ts=680205e8 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=mwhX2nSu6CT3Wa2O0zoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LhQVgHu03Em9PpYzgjWJO40DZFc7hV4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180054

On 16/04/2025 15:57, Harald Freudenberger wrote:
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

With the change below
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

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
>  	if (target_num != 0) {
>  		struct ep11_target_dev __user *uptr;
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
> +			uptr = (struct ep11_target_dev __force __user *)xcrb->targets;

I mentioned this earlier already, the cast is not required here, because xcrb->targets is always a user pointer in this if clause.

> +			if (copy_from_user(targets, uptr,
> +					   target_num * sizeof(*targets))) {

You can use xcrb->targets directly without any cast (and also drop uptr).

if (copy_from_user(targets, xcrb->targets,
    target_num * sizeof(*targets))) {

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

