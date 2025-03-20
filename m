Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0917591
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488854; cv=none; b=uyTUP7GSaYMttQTYRXKMkn5KoGHk4kBQLV3UAPTR6cgEi7jLM3IOV1kZ3AKfDtjxcNapyK2Dbqt+CddNI4fSyFg9Ls2sjquapKIxUhNq4KrfBPEoflVp85ItgiPZMLVLtoSDYP9RLAu318WBufLwOCt8Z7aW7ikk2I1NDbJXBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488854; c=relaxed/simple;
	bh=gTpSASa2eLooAUdm5tOmprGPI3wOwmy7TE+zyrNUoKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAB0K5uEb8Kmo1+IzVNlRb+aR1vQuzl2WLVEIHSTFIWb1+/K/FOI8jcVfcm8vamjyq5r6++lLlnwtlB32d79u2TSQno9deBgpqemzb2Fwg2ZbhOCf7Nyk1G5BonxPAK83OSA5YSDI8hVvvwmx2Qz9BzStcLRw0+mcW2KdqvtrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eoQV2xJS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eoQV2xJS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE3euU026009;
	Thu, 20 Mar 2025 16:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kO1ZB4
	BHUdx6RpYC4X9MCC7jPOUYc1Q2CdhYo16ltK8=; b=eoQV2xJS6NKiehdpIc/FoD
	bO5+l0tmnqQ1VP+4c8H3SaK/QBpVXHY2g0Pi7MQtEny6kFmZUdf4IE69sU7JhDqh
	+n86PPp3hqpYAwuUvPgI+WNY5QU8SS4e8GoeOS9HYB3sWEzhSXNVk0mh6bndQ/5b
	vWD/8L32gvC1GlCvbtQ21SMuL0PuHirso0aCnanwLMcN+Tj9t4DaWsUudfPpF4oB
	Wi+RGx4zKIgb3ppa3VvifKE6iV7yDhzDkqtADlMdAD7gUBMDb2Tw6mAbI4Kn//Hg
	pzQ/W+lbTkjkmZ3v/DK44rztIiC4fOi4niRd7RR5qrLr/LX4UxubsekhwV2sN3EQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gmep8xdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:40:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDx5vU032373;
	Thu, 20 Mar 2025 16:40:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvts7up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:40:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KGejQS43123094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:40:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A2A20043;
	Thu, 20 Mar 2025 16:40:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B43E20040;
	Thu, 20 Mar 2025 16:40:45 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 16:40:45 +0000 (GMT)
Message-ID: <ba404365-5f04-4e71-8920-32f9d42d04c2@linux.ibm.com>
Date: Thu, 20 Mar 2025 17:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] AP bus/zcrypt/pkey/paes no-mem-alloc patches
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jiPaTT_wcDthrBfA55Z1pmRzNtsVvxcm
X-Proofpoint-ORIG-GUID: jiPaTT_wcDthrBfA55Z1pmRzNtsVvxcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200104

On 04/03/2025 18:20, Harald Freudenberger wrote:
> This series of patches has the goal to open up a do-not-allocate
> memory path from the callers of the pkey in-kernel api down to
> the crypto cards and back.
> 
> The asynch in-kernel cipher implementations (and the s390 PAES
> cipher implementations are one of them) may be called in a
> context where memory allocations which trigger IO is not acceptable.
> 
> So this patch series reworks the AP bus code, the zcrypt layer,
> the pkey layer and the pkey handlers to respect this situation
> by processing a new parameter xflags (execution hints flags).
> There is a flag PKEY_XFLAG_NOMEMALLOC which tells the code to
> not allocate memory which may lead to IO operations.
> 
> To reach this goal, the actual code changes have been differed.
> The zcrypt misc functions which need memory for cprb build
> use a pre allocated memory pool for this purpose. The findcard()
> functions have one temp memory area preallocated and protected
> with a mutex. Some smaller data is not allocated any more but went
> to the stack instead. The AP bus also uses a pre-allocated
> memory pool for building AP message requests.

Please check in all affected modules: the parameter for the minimal number of element in all meempools of the module should be configurable with the same module parameter. Please also use the same module parameter name (e.g. mempool_threshold) in all modules. This makes it easier for users to syncronize the mempool thresholds accross modules.

> 
> Note that the PAES implementation still needs to get reworked
> to run the protected key derivation in a real asynchronous way.
> However, this rework of AP bus, zcrypt and pkey is the base work
> required before reconsidering the PAES implementation.
> 
> The patch series starts bottom (AP bus) and goes up the call
> chain (PKEY). At any time in the patch stack it should compile.
> For easier review I tried to have one logic code change by
> each patch and thus keep the patches "small". For the upstream
> version I intend to fold them together into only a few commits.
> 
> Changelog:
> v1: initial version
> v2: - Rework on patch 0001 and 0002 based on feedback from Holger.
>       Also there was one place in zcrypt_msgtype50.c where still
>       an ap msg buffer was alloacated.
>     - Rework on patch 0003 - fixed feedback from Holger. Also the
>       min poolitems is now a module parameter and defaults to 8.
>     - Rework on patch 0004 - as suggested by Holger the "userspace"
>       parameter is now included into the ap msg flags.
>     - Rework on patch 0005 - nr of cca cprbs in the mempool is now
>       a module parameter.
>     - Rework on patch 0006 - nr of ep11 cprbs in the mempool is now
>       a module parameter.
>     - Rework on patch 0007 - as suggested by Holger instead of
>       implementing a copy-and-pasted new function
>       zcrypt_device_status_mask_ext2() use and extend the existing
>       the existing function to avoid code duplication.
>     - The rest of the patch series needed adaptions but there is
>       no functional change compared to v1.

Please pick my R-b tags of this review for v3.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

