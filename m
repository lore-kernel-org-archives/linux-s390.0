Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160F1DE3A4
	for <linux-s390@vger.kernel.org>; Mon,  3 Mar 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990578; cv=none; b=TJp6+ZtehkcdCJnl23MorwMKsXlVQoG7yYOYWYu11eqlrT/tKhwbHEZUA5F625g3qcObZNWi9aLsYuXXrdtPKXiTt6tPpmFeNAxxj5+g5Z3j6HUnKkI0h4cy3a2xUXuGVd0I+oSICQ7VwcGcy3uOFK5MSrkzKpwmrp5hby9e96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990578; c=relaxed/simple;
	bh=QQB7bfmxcfy9CVP4KqVMPTAAN3hrgZHAzg6meOZsaLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/8L8CBbBuluo3oIYZVMQLbpRsma4kpicVI6EMLiaPg2vMYLj4e5Fv5SkoNpu/gHcgFtCyJgMOx2SKp6opSKgaXSa692ZOno97ITff+v4uj8xq+gm4PIzL+r5xv1/HaJrf8SHajW143aPMSqS0x09+ChubbkdooTWL14LneLdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GPvlypJY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GPvlypJY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KepAu022148;
	Mon, 3 Mar 2025 08:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RdmslV
	6VCKrB2nZoJr/YzJWoWBxew8NFaO3DHzSCc+w=; b=GPvlypJY63qDlAk1RbDye0
	/BFar6/HO+ICYCBaK1TlTn/AI1mwr1UQujI6dtAhkY/zpzpeNKvzIgYqIiMjDRbB
	J8oUWaPLmPplxEk2XEfnv0W0jBzNi3Z0DTLDXjCR/4DntxODXd7YFg5LEeWmGZ9E
	Nr1hG8E7iwtidznj8j6NsbmahZf2SAK4TsEgGHcPB3jT9zl/zJDQx6vbC/fnNdW6
	ZtgezXMlbRi3I0rVjocu3Y9XclxpryToVlVp2lTPDPWYCwEF9x9VRnAUevc1UdLg
	t+VKFdg2Qjf/JzG+3+in+kenWI1pBNvy+cZO64Qs4tI1WaXZNcOk6+9tuChTpf1Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xhyj6he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:29:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5237LCwn008934;
	Mon, 3 Mar 2025 08:29:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxy6c8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:29:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5238TRfi41550156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 08:29:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652CF2004B;
	Mon,  3 Mar 2025 08:29:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F067620043;
	Mon,  3 Mar 2025 08:29:26 +0000 (GMT)
Received: from [9.171.16.64] (unknown [9.171.16.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Mar 2025 08:29:26 +0000 (GMT)
Message-ID: <89e6560c-5376-4f61-be78-b845c1b9fbdb@linux.ibm.com>
Date: Mon, 3 Mar 2025 09:29:26 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/20] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-7-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250223095459.43058-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D9W73OTEDG2swMiubGYDc2ValgLRQ2OM
X-Proofpoint-ORIG-GUID: D9W73OTEDG2swMiubGYDc2ValgLRQ2OM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030064

On 23/02/2025 10:54, Harald Freudenberger wrote:
> Introduce a cprb mempool for zcrypt ep11 misc functions
> (zcrpyt_ep11misc.*) and do some preparation rework to
> support a do-not-allocate memory path through some
> zcrypt ep11 misc functions.
> 
> This is only part one of a rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not jet complete.

typo: yet

See my comment below. Beside that and the typos, it looks good to me.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c      |   6 +
>  drivers/s390/crypto/zcrypt_ep11misc.c | 159 ++++++++++++++++----------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>  3 files changed, 105 insertions(+), 61 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index b60e262bcaa3..3d96bd236c16 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
[...]
> @@ -30,6 +31,15 @@
>  static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
>  			       0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
>  
> +/*
> + * Cprb memory pool held for urgend cases where no memory

typo: urgent

> + * can be allocated via kmalloc. This pool is only used when
> + * alloc_cprbmem() is called with the xflag ZCRYPT_XFLAG_NOMEMALLOC.
> + */
> +#define CPRB_MEMPOOL_MIN_ITEMS 8

Same here as in the previous patch: number of items as module parameter (with default 4).

> +#define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
> +static mempool_t *cprb_mempool;
> +
>  /* ep11 card info cache */
>  struct card_list_entry {
>  	struct list_head list;
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

