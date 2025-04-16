Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F2226534
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796223; cv=none; b=m3wU7TB9ujYh8FY4Am7UrKNJrgR6hMbpv19RCm3bS02QxK/nAU/HfNRk8r9cgxEKvbOPEEYrmmuxwiAow4BbK82Koek5/LRzR9wLQ6PC4bGvhPOloXQv3UHC7NFcbp4Qe9O2qSQT2dONaduixD0gvAIr0uUwRQVuquxrPoTHj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796223; c=relaxed/simple;
	bh=/dWqiC0zkAe+6GlKg5GZVRRj0VuVAMcJBgYzNB69CzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdymWPcQnoQWT68vDhVONBg6cPSTj/YP3sdJ3zkP46w/niuVi+28Goh1WUBVS0R9vqZ6tSThFlECLuq4KIbr9if90T2ISeDD01siOP1yUeDeRPuX05L1nUZyJb0Ck3NcHvPYA6+Wot1khc5BAg916yGAFoyoXz+71+IUx7ffi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oEX8ybG0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oEX8ybG0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G2MhUB019246;
	Wed, 16 Apr 2025 09:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Dze3U
	yKqRmsrwVVPHdpCC9Hm140dejkv2Dnv8kPRWw=; b=oEX8ybG0LUWx//plbKrfQC
	Pqyjbo8LTzFU0FI0PvR66YbpcnghIBXhdVsSJ7Cbe73DvylD478PM6OyorZcmnJk
	US+B8elRMfl/NVjOU6tqRymevU/VqhGUaG8TuMuiZPeZ1iaHc1tHCjTaajXg6+sb
	WrV5UMYQRF8h2EwFoXw+kYOJSQulJxcRyzYhQvJl3jvXDZvL4dPSga2EmHp1SCmA
	5OP6N3KN/nHSUFiKnq/ui2X9ZEsRW602ay34m7ZTLlBcSBvJLxPE3SaX0oFP2Vcx
	6X7zi48xjdUAt7Z5YUqemrP65UdQAhlK6iMURHbenvlC/UYz1H7+Kw7hsIBplPbg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ncfp47x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:36:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G6Ir48001272;
	Wed, 16 Apr 2025 09:36:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyytb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:36:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9asBp41157016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:36:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ECC32004E;
	Wed, 16 Apr 2025 09:36:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5EB2004B;
	Wed, 16 Apr 2025 09:36:53 +0000 (GMT)
Received: from [9.171.38.231] (unknown [9.171.38.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:36:53 +0000 (GMT)
Message-ID: <fbe73ee0-ee08-4d44-aeb8-779094c9ddc0@linux.ibm.com>
Date: Wed, 16 Apr 2025 11:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/25] s390/pkey: Provide and pass xflags within pkey
 and zcrypt layers
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-25-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250415142438.118474-25-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qwzDxvNhwYzGsWwuGJz8MY3vptL9f_bi
X-Proofpoint-GUID: qwzDxvNhwYzGsWwuGJz8MY3vptL9f_bi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=553 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160073

On 15/04/2025 16:24, Harald Freudenberger wrote:
> Provide and pass the xflag parameter from pkey ioctls through
> the pkey handler and further down to the implementations
> (CCA, EP11, PCKMO and UV). So all the code is now prepared
> and ready to support xflags ("execution flag").
> 
> The pkey layer supports the xflag PKEY_XFLAG_NOMEMALLOC: If this
> flag is given in the xflags parameter, the pkey implementation is
> not allowed to allocate memory but instead should fall back to use
> preallocated memory or simple fail with -ENOMEM. This flag is for
> protected key derive within a cipher or similar which must not
> allocate memory which would cause io operations - see also the
> CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.
> 
> Within the pkey handlers this flag is then to be translated to
> appropriate zcrypt flags before any zcrypt related functions

reword?: appropriate zcrypt xflags

> are called. So the PKEY_XFLAG_NOMEMALLOC translates to
> ZCRYPT_XFLAG_NOMEMALLOC - If this flag is set, no memory
> allocations which may trigger any IO operations are done.
> 
> The pkey in-kernel pkey API still does not provide this xflag
> param. That's intended to come with a separate patch which
> enables this functionality.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

Looks good now, thx.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

