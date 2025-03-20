Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B96155A25
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481707; cv=none; b=PmsI/8oxTPq3LAp2RV34k8Bhno03dDwBKwnqfkVKMTRa0H32AeZOe0QoiMIUV1+oTShc6ZkIMvnEP5hINVKGWfAs7bZe6rixVcyj5yS34vCws0lf5y4/aiCnXv7Jm9XdodKcRhVWEZ0G+tfRJaALJJMsBt4fQlYM20u1ld6+kWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481707; c=relaxed/simple;
	bh=64UNBNlJE7JIwU+oCP+TBUQ5sWPbTTOW8pX3Fxw5kiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0CK4Y5aO1OB+TQqxkaOu6ryOTAccQX8onnO+KpvZE+cqS1BbomYftczV0g8kSfW0/ziku6oryXOqSi1+z56eTZ5xM+fBW2ZMuVM2xwm8aeXPE27XDtnD4vFnbKJUkDeCA+n9hMtT3bFXsuVGjgjWeVcAYIRtoVG+OrYB2VHoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l9l+OSw6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l9l+OSw6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K90BlI031620;
	Thu, 20 Mar 2025 14:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iRQzse
	ULsomABRfyMx9T4WnLgtai9z9Q4Q8NHQEQWkA=; b=l9l+OSw698r/VavbhIENH6
	7OCYfamc8iGDZVZmuqugjmXE/JeFdmkmFQiiswMHeGgZVkaP75Zu4D9Gsgo3vH+G
	Smsp3dsXhYCNM4eL5DEHmKeMyvkwhas1SwYiFWbcDAKvEuqT9Z4FwD0hbSYFEN2a
	MbCPekZlLtJ3F7wKAjHLhICktXhY4tK66Vxgwfg/u5bSEbk3syhqeLKbs1YtCPvf
	VMGd8UE+BiM52SvTDlQBiMTDh1A1RVsOtOa0NWzTy2cW2AoWL8OHBn8LgYunoSki
	+l5O/vU+wSTbeAMD8lEflgNybGYyWxC0fs+VuajGvyiNerzUj/+4XmwItexT1pzg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5504nsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:41:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE1Sob023214;
	Thu, 20 Mar 2025 14:41:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3m08uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:41:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KEfZm838601168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:41:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8522E20043;
	Thu, 20 Mar 2025 14:41:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1818120040;
	Thu, 20 Mar 2025 14:41:35 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 14:41:35 +0000 (GMT)
Message-ID: <c64f1058-ec1c-47f3-bbb6-e1b64fc001d7@linux.ibm.com>
Date: Thu, 20 Mar 2025 15:41:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] s390/zcrypt: Locate ep11_domain_query_info onto
 the stack instead of kmalloc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-15-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-15-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 52SZPxP7ddAQ4ojK5E5vUU0MC2j49PvB
X-Proofpoint-ORIG-GUID: 52SZPxP7ddAQ4ojK5E5vUU0MC2j49PvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200090

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Locate the relative small struct ep11_domain_query_info variable
> onto the stack instead of kmalloc()/kfree().
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

One minor comment.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index 6005ef79c001..7fb55be3e943 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -790,36 +790,31 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
>  		u8  new_WK_VP[32];
>  		u32 dom_flags;
>  		u64 op_mode;
> -	} __packed * p_dom_info;
> -
> -	p_dom_info = kmalloc(sizeof(*p_dom_info), GFP_KERNEL);
> -	if (!p_dom_info)
> -		return -ENOMEM;
> +	} __packed dom_query_info;

Why is dom_query_info a typed struct? The struct type is not used and an untyped struct can be used as well.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

