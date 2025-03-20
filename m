Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B921EC013
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488261; cv=none; b=pGQ7xhgoqaoxvzGmZuOC3RkJJgMm9zJHp9TIGKdtO+1Kg89wjiDqTfsGE8NpJrsVZr9DJ0awkisvsNScW/XHwotLZIg2RbH8bARPK1p+FznWM5EVh1SzrdZFpL98+nJIqDYq1fz0a6iXF4ANJeZUdWMNqzmJ44Z4fT1U2Pcq+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488261; c=relaxed/simple;
	bh=XCM/agxpau/v0MorVm8L+sCronOpXaGqElbHixyUvHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCBzzFsiB5LjVt8Y1zEAHEb3UD71vR9wTX+QvbYgYxEz+/2KiKr9uZ1FMQXiF8rcAuTRjdeaHV716QDM3BfWqkK7pVFVF4jpSJDGEe3XYT9h9csyk1qRX5+SPfHU5beO4MkKxo3YflGfNM9DeQ3F3SJ1k823hVXh7iODTbKbopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tV46oWA1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tV46oWA1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KExQVt031667;
	Thu, 20 Mar 2025 16:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=heZqrQ
	JZmCxKX099/coU56jbKzNaDRdxk7sPYKGkG40=; b=tV46oWA1yKTIfl4or7kD1C
	3WRiYGhd6NcfBfN9enGLlA2e3D99ApAk+2lPUT3FRDvTIi2RSUcnDJmJYuNTLoMu
	G7GsipPf5j15jMguvQ4q/jqWftm1CN+0wb4Cij7BmrDM0XwN7P9nEqRM6cVoAcUC
	58hUavbVJIPbtMDGfNKVCQDyRyuGJkx1DhE5rRxPBX3+no2bCF6gOTuVC/sZzJd0
	VqgIxxY02e0CuUQWZ6IGkUtjWilMJW/s4/0qNEEmpljBoaKKTvzjxF1oyZPq7RoS
	1kMWMqchuK7020x/jDwLxO6/Lp8sOZhcNHysxLB/dHofBaF/Fo7GC6ksgQs3hSvw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5505aqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:30:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDnInc005664;
	Thu, 20 Mar 2025 16:30:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm9092hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:30:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KGUqwI41157036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:30:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4953620043;
	Thu, 20 Mar 2025 16:30:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFEF720040;
	Thu, 20 Mar 2025 16:30:51 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 16:30:51 +0000 (GMT)
Message-ID: <a9f2a853-5ae1-4352-b7f3-c4475efb5826@linux.ibm.com>
Date: Thu, 20 Mar 2025 17:30:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] s390/zcrypt/pkey: Provide and pass xflags within
 pkey and zcrypt layers
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-20-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-20-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: orh5aezaFBv9u6Yvv6sohLo1k-S-aj3-
X-Proofpoint-ORIG-GUID: orh5aezaFBv9u6Yvv6sohLo1k-S-aj3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200104

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Provide and pass the xflag parameter from pkey ioctls through
> the pkey handler and further down to the implementations
> (CCA, EP11, PCKMO and UV). So all the code is now prepared
> and ready to support the currently only xflag ("execution flag"):
> 
>   * ZCRYPT_XFLAG_NOMEMALLOC - If this flag is set, no memory
>     allocations which may trigger any IO operations are done.
> 
> The in-kernel pkey API still does not provide this xflag param.
> That's intended to come with another patch which more or less
> only enables this functionality.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Without the findcard() function or with a changed parameter name according to my comment
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/pkey_api.c        | 49 +++++++++++-----------
>  drivers/s390/crypto/pkey_base.c       | 34 ++++++++-------
>  drivers/s390/crypto/pkey_base.h       | 37 ++++++++++-------
>  drivers/s390/crypto/pkey_cca.c        | 59 +++++++++++++++------------
>  drivers/s390/crypto/pkey_ep11.c       | 49 ++++++++++++----------
>  drivers/s390/crypto/pkey_pckmo.c      |  9 ++--
>  drivers/s390/crypto/pkey_sysfs.c      |  4 +-
>  drivers/s390/crypto/pkey_uv.c         | 16 +++++++-
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 53 +++++++++++-------------
>  drivers/s390/crypto/zcrypt_ccamisc.h  | 25 +++++++-----
>  drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++---
>  drivers/s390/crypto/zcrypt_ep11misc.h |  7 ++--
>  12 files changed, 196 insertions(+), 156 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index e4ec922aae0d..3b80ce605192 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -1828,13 +1822,12 @@ EXPORT_SYMBOL(cca_get_info);
>   * Master Key Verification Pattern given.
>   */
>  static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
> -		    int verify, int minhwtype)
> +		    int verify, int minhwtype, u32 xflg)
>  {
>  	struct zcrypt_device_status_ext *device_status;
>  	u16 card, dom;
>  	struct cca_info ci;
>  	int i, rc, oi = -1;
> -	u32 xflg = 0; /* xflags */

If you keep findcard() please name the parameter `xflags` instead of `xflg`.

>  
>  	/* mkvp must not be zero, minhwtype needs to be >= 0 */
>  	if (mkvp == 0 || minhwtype < 0)

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

