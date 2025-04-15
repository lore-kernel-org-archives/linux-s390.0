Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D611C5D57
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729668; cv=none; b=GvEJb8jMbAiKkaCz0ERlxlpQR9egIc2J6HMo8HPvrAqn2K0Md0NYDiRBBPZSAeXewCaBwgkIDymZck2JLF/ksvdlzzTgPydXQTu8EIlhRoizEQLmelLa8Q2WrTSclzRDmlkP6FBH3Y3ddGTg/vK9Sc5psFp5Os2eFWp0b0OtINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729668; c=relaxed/simple;
	bh=93xjOyrVfrj35sfNFQHXgXMGjSHv0A0APhhvC68e7X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6IwWaDY5/sP/zb+4QVTtXFzeSxgX/31tl1mKGyYEEWaRrr6vC1Rv+7auGlAo9x5+pHsyMml8Hgoz3TDser9buoQyKqVdGnvv4Er4OH850EQZajQVTFVucvwV8EW2nWt2GADiyedd2sdo9AGTdPoSeyJ1m+sLBRmTet84DfD7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j3To8zuR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j3To8zuR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAeln3021162;
	Tue, 15 Apr 2025 15:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pjQZLenKQRl/4mdCy8YKlaBzjQbwXI
	+tX7hcpuePQNo=; b=j3To8zuRgYcESRxnPucTrlCTTGE4KqxA9ok340HriG169m
	DVvzGLIx1AEqZac3f+v6Vvl7Bzd3RLhrLz8sF7+bggSLClylMgUW3076+M9yeQ4Z
	dMK7DET0N7hXV/Aq8x/3pitGmhQXYTf8Iog0yGF03/dU/oCrQJSmPy1jymNIEsLK
	OGxjBzePXYgcoDRAbxvN72mp1/3P2xL+NgmjrbRmfyDzzQEUEoXnkJQb222+kneU
	DQZYQkcnyRfoYdAPHXdKcQDegQwkKeXjJWDUt4zhU9/Rn1vxEwmo/da2l6q9N1ct
	LWEGraykZqXBgiU9mleJPZsCHh2DWV9zpVIpIwDA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq1b0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 15:07:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBOGu9010392;
	Tue, 15 Apr 2025 15:07:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk3d9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 15:07:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FF7dDC50332078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 15:07:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A7512004B;
	Tue, 15 Apr 2025 15:07:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A213C20040;
	Tue, 15 Apr 2025 15:07:38 +0000 (GMT)
Received: from osiris (unknown [9.179.9.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Apr 2025 15:07:38 +0000 (GMT)
Date: Tue, 15 Apr 2025 17:07:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v5 06/25] s390/zcrypt: Introduce cprb mempool for cca
 misc functions
Message-ID: <20250415150737.12735Fad-hca@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-7-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415142438.118474-7-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: usBATE0daigzDiIDsUiBD4bZhTbwhrCC
X-Proofpoint-GUID: usBATE0daigzDiIDsUiBD4bZhTbwhrCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=947 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150105

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index f753c0403a18..9ca78411737f 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
>  		   "Copyright IBM Corp. 2001, 2012");
>  MODULE_LICENSE("GPL");
>  
> +unsigned int zcrypt_mempool_threshold = 5;
> +module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 0440);
> +MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply mempool minimal items (min: 1).");

Please remove the "." from the module parameter description, here, and
in all other patches which introduce new module parameters.

> -void __exit zcrypt_ccamisc_exit(void)
> +int __init zcrypt_ccamisc_init(void)
> +{
> +	/* Pre-allocate a small memory pool for cca cprbs. */
> +	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_mempool_threshold,
> +						   CPRB_MEMPOOL_ITEM_SIZE);
> +	if (!cprb_mempool) {
> +		ZCRYPT_DBF_WARN("%s mempool_create(%d,%d) failed: %ld\n",
> +				__func__, zcrypt_mempool_threshold,
> +				CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}

Please remove the ZCRYPT_DBF_WARN() for the !cprb_mempool case, and
just keep the return code handling. This will never fail, except for
the memory allocation error injection case, which is not relevant for
production code. If this is forced to fail you will see a nice splat
anyway; so no point in logging this in any case.

Please also remove all similar constructs in subsequent patches.
