Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1725A338
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188044; cv=none; b=XH+y+K2BofVfvKp9LjEznWPGfcmYw7Dksh5ZsIYsoMOWUAcbjt6LFwo2SNVH2B1erjnvuuJJ1KS2w60cC+b7hsDgkMns3IIxaG8ACumG0tToOCIUVpBwt3NkiMZa2q8hvz6OjcWkByUVNQ1+umJOlQl5kW4fFiy5iYIw9ki+oxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188044; c=relaxed/simple;
	bh=62FC4Xu0rds4ZHcXSQsYlonxtS97yxr4Lvd0EGOPiD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3fWw7OdyNXUEMHe+s2CUsC4b0qe+lJj8Uexk73qXyNquPaJ5iCvtmEtmBYc4+nq3AlQa4K7nFPxx1Yk+Pi03z+GwhFmzD0R6l183jnQlWmocP5Z/E4jZUVvgEvOCURGwAoVdg9AL7YG8VFdg27DJbIOk1vcpFna1sl79zKhHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FyNxbPcv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FyNxbPcv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539657vW028046;
	Wed, 9 Apr 2025 08:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aavz8e
	o6qsdVh+2IVS3n30i37TfZQgmd07n7syF7eY0=; b=FyNxbPcvaHbCugvBE/E+R+
	PDfnJdWnRbRVJMQ4zxVHB/FBF4HSeZQYxKyOLv+YNMjjkNn0LgcNFw+R6v+HGmsx
	mX2g6U9PXlo1aJKM1XvmERQVQG1wEK8/6taQ/+91VbwuUu6O519kn463zQvgjwoy
	KuUPtvTNmprAGS+0XMOK/CXZmuRhwiJGxYD3X1ZHLW/Sl2tA3SXqXcv8d8kIKmmg
	bz1AXkAjZ1DnB2pu4wyYPHEJUtVEc4VIcLQ/ruAro2b5hIo98MMQBl5YLxVB6syE
	XoFWJCT1A1O20vL2LDb1lWpESdKdzq4Vz9UFpWd/POdQqWIz0vPWvH2bjhCb26XA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wb10jf10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:40:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5395gF1T018432;
	Wed, 9 Apr 2025 08:40:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kpp56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:40:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5398eYKE20971918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 08:40:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9733C2004B;
	Wed,  9 Apr 2025 08:40:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D79720043;
	Wed,  9 Apr 2025 08:40:34 +0000 (GMT)
Received: from [9.171.58.154] (unknown [9.171.58.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 08:40:34 +0000 (GMT)
Message-ID: <6e91cd67-e08d-4cb0-ada2-84125f566c41@linux.ibm.com>
Date: Wed, 9 Apr 2025 10:40:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/21] s390/ap/zcrypt: New xflag parameter
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-5-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250327143941.45507-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -TbglSNF2jm1oN8Dj1MrE4MoyYcaneAJ
X-Proofpoint-GUID: -TbglSNF2jm1oN8Dj1MrE4MoyYcaneAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090037

On 27/03/2025 15:39, Harald Freudenberger wrote:
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
> * The ZCRYPT_XFLAG_USERSPACE is mapped to the already existing
>   bool variable "userspace" which is propagated to the zcrypt
>   proto implementations.
> * The ZCRYPT_XFLAG_NOMEMALLOC results in setting the AP flag
>   AP_MSG_FLAG_MEMPOOL when the AP msg buffer is initialized.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c          |  6 +--
>  drivers/s390/crypto/ap_bus.h          |  2 +-
>  drivers/s390/crypto/zcrypt_api.c      | 76 +++++++++++++++------------
>  drivers/s390/crypto/zcrypt_api.h      | 11 +++-
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++--
>  6 files changed, 69 insertions(+), 52 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index ad09c5306e28..01cb72fed828 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
[...]
> @@ -1045,36 +1048,40 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
>  
>  	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
>  
> -	rc = ap_init_apmsg(&ap_msg, false);
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

As discussed, this alloc&copy is only required in userspace path. If zcrypt_send_ep11_cprb() is called from userspace, the targets pointer can be used directly.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

