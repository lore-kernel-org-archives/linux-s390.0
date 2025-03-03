Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DDAD27
	for <linux-s390@vger.kernel.org>; Mon,  3 Mar 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989245; cv=none; b=JnPOTHZf+fXEEcUvymarBzNxSgdPMncawCL3pgFuhmv+dAtrOL/zeo7b84KuGD0IPscojKvc42EFIGQxtp0u66gkdbXK9vmbnIjwEuS489vNYjylkZksg42HufoncY4KLRYr0mjCFQAoLKb/zsarXU9MtM8QMNMWWiAgFNyG7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989245; c=relaxed/simple;
	bh=PjO9IHoIBTIpHhIzrJzMMBfL3wJMLHcR1kqr3nmlb0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmU/MufIWKBKEQOzJCUgfRfKK4vEIAM8t0edb+ucMTN7tI13eA6VjPiN2o1GQ69pyIp1DkCphyBaaqxpmtTQqp3h8Xb1AjxwuF6wjk3pygfP5y8bPcYz71RyTSaXksgZIs5pkfo4pc1Xg3E77cXRw1IGHVJnQeLvKAWrByH3o+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HaczJ1RJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HaczJ1RJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522JMunp013141;
	Mon, 3 Mar 2025 08:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z/qWjA
	11PfqIgHdz3oaUq7W0E652sppRrcn0WR0jFNs=; b=HaczJ1RJ7oSqTcZY5JCDDJ
	M1hJn8MnHHjyI4FUdCpHehFpk3beRYwISUwZBPVj0DI3V2ceotaJCQjGCCzgDYfG
	PAYMw3tqIfvNhjJV2S9U7m7lOq63xp2746e+Z+1uMiJnR0YoL8/6uK3w++hshdGx
	NHYURsranRMwPVJtFpZeIcLzft7FW3Oj74SBfu4SCqVANEtVXOnW8A1k9YOnQlP5
	pHrqGZVbUFNU/Gbkh8JTZIrNtPEPNcXze+og+6wRGorzXK8M8fVsgktHC4RlNyna
	AsxtzmrroiHhpMFT16hXl2ADihZi4Ybzh0kbScyZbTbtZl/u3K2dLX2bJnOKkNQQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454qc1kpxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:07:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5235VbOI020877;
	Mon, 3 Mar 2025 08:07:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjnudp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:07:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52387GME36438392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 08:07:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7414B20043;
	Mon,  3 Mar 2025 08:07:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2493E20040;
	Mon,  3 Mar 2025 08:07:16 +0000 (GMT)
Received: from [9.171.16.64] (unknown [9.171.16.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Mar 2025 08:07:16 +0000 (GMT)
Message-ID: <62ea73cb-16af-4b5d-95a6-959b4931ee11@linux.ibm.com>
Date: Mon, 3 Mar 2025 09:07:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/20] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-6-freude@linux.ibm.com>
Content-Language: de-DE, en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuErlf9igYoYn2X8A7MyP8TY0DoURvzw
X-Proofpoint-ORIG-GUID: uuErlf9igYoYn2X8A7MyP8TY0DoURvzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030060

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Intruduce a cprb mempool for the zcrypt cca misc functions

typo: Introduce 

> (zcrypt_ccamisc.*) do some preparation rework to support
> a do-not-allocate path through some zcrypt cca misc functions.
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not jet complete.

typo: yet

See my comment below. Beside that and the typos, looks good to me.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c     |   9 ++-
>  drivers/s390/crypto/zcrypt_ccamisc.c | 115 ++++++++++++++++++++-------
>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>  3 files changed, 94 insertions(+), 31 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 521baaea06ff..e604a69e40fc 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -40,6 +41,17 @@ struct cca_info_list_entry {
>  static LIST_HEAD(cca_info_list);
>  static DEFINE_SPINLOCK(cca_info_list_lock);
>  
> +/*
> + * Cprb memory pool held for urgend cases where no memory

typo: urgent

> + * can be allocated via kmalloc. This pool is only used
> + * when alloc_and_prep_cprbmem() is called with the xflag
> + * ZCRYPT_XFLAG_NOMEMALLOC. The cprb memory needs to hold
> + * space for request AND reply!
> + */
> +#define CPRB_MEMPOOL_MIN_ITEMS 4

4 slots might not be sufficient in setups with a large number of encrypted filesystems. In my opinion, this should be a module parameter (with default 4).

> +#define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
> +static mempool_t *cprb_mempool;
> +
>  /*
>   * Simple check if the token is a valid CCA secure AES data key
>   * token. If keybitsize is given, the bitsize of the key is
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

