Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954B1B422A
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488496; cv=none; b=nwCZOanvqsiJi5FZbX2BpWFVZc+7u2MSKljPkrsvDw11UKsolgig/kjCtxiW3CE1gGX19tH/fXFFyb4c3G5ZK6KhCdNhI8FHMuv9kH3SbYJlPejhuxeoCok+7NZm2HHEC8yZcXqRTOJG0eCad+lsKX1ARJ9/+MujZUFverduKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488496; c=relaxed/simple;
	bh=KTs4C/nB2y3/jOk6RoH96lgAjcdSmHwZI7N9tkx9RYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao00qk/hv61X2ezzA0kDLye8p7EkWfmCLVyJ8HSTNy7usoUszP1Xx7mGzMGNCBuPUAaU7B7jo/So5YDK1Am6Vi8kCnUSMyOA7dfWX8GDIvh40jYGHtMYZYIJbdqtgAxtRTARK2QSOpXVUSOX+ukfbOJVZ/1MesE9B+yMGoEFQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z3JtcJLT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z3JtcJLT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KFB44B029932;
	Thu, 20 Mar 2025 16:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y5Sbew
	jE9cZbWyrsgUVHa6UH7oRx8YrQu8yNSrK9+hU=; b=Z3JtcJLTCtTYMvtB748fqj
	J6KYImoaC1SYGPYYW7NhiLBpLY1TltyDl3Q8W8QqqC2Y7MfxzYnDVCt1dz7SnsTc
	x2H5AcfcQFNN6mT2EP1TFXWwmmqUhwQdVCveEQIZOqn1BSmUd/FcMReg5CkgmMeV
	e36Cr6fqnNnWlnfVMoqWq4xhUzJHXgiGYbPwrG4hzc/rPEOu0rdJ3xIZNovVOmX1
	GSLCgem1Ocq7KXRltOcllkOOIqM4g9q7scZPIpibhduLUUtEV3ovPQCoGL9/j88t
	p8ngpnzXQ2qTPPYXTKkSp7MpFgNdejq6s64rqRiuiQjgBLf/69HWNXsNhvNqWC2Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qdbqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:34:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDn3g4005803;
	Thu, 20 Mar 2025 16:34:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2rjwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:34:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KGYlO933751678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:34:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D86420040;
	Thu, 20 Mar 2025 16:34:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5AAC20043;
	Thu, 20 Mar 2025 16:34:46 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 16:34:46 +0000 (GMT)
Message-ID: <96b38fd7-b134-4b54-bbdb-7fea6b37dbe1@linux.ibm.com>
Date: Thu, 20 Mar 2025 17:34:45 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] s390/pkey/crypto: Introduce xflags param for
 pkey in-kernel API
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-21-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-21-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jxph_4Us5K3G9DFfcNOp2VgK-BA69LM7
X-Proofpoint-ORIG-GUID: Jxph_4Us5K3G9DFfcNOp2VgK-BA69LM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200104

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Add a new parameter xflags to the in-kernel API function
> pkey_key2protkey(). Currently there is only one flag supported:
> 
> * PKEY_XFLAG_NOMEMALLOC:
>   If this flag is given in the xflags parameter, the pkey implementation
>   is not allowed to allocate memory but instead should fall back to use
>   preallocated memory or simple fail with -ENOMEM.
>   This flag is for protected key derive within a cipher or similar
>   which must not allocate memory which would cause io operations - see
>   also the CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.
> 
> The one and only user of this in-kernel API - the skcipher
> implementations PAES in paes_s390.c set this flag upon request
> to derive a protected key from the given raw key material.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

