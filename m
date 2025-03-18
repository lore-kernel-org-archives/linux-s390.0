Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720120897B
	for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310989; cv=none; b=pc/vNCzVMZs5Ci3HTkYEwSadGzu+f5MNSV+ugFUemde7ycgelLQHnA0eWhFGb7GARpu+dlPHLCSau0QDJtQPn2M7GaNKZKN2SMUyqz3ZzFSJeZrn19sBY41WhKGU8X9JleGOiuhAJIXS8Mma2WdOsuotR0mJ6axN22VFBitoaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310989; c=relaxed/simple;
	bh=Bui+y5WctYiEiO6MXT3ylkngtAsf3mKDLJUm4+T99/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHYODE1PFGhAhQOD/voGwSBURnUjljy3D5IVmtkZxMmwEzbi4ZyETLtSurt7BNXlv2DyUxrzS5wtyG+gRt5UAE4F67EySW1xNNYrVTYvvj/rKc71YehdIz0uyCzLIsxJTdPCEZE6nrBiMlRY832DQPzc9Dn2nu46ko4zNZg4YEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUkkRXSV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUkkRXSV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9Aj3S011320;
	Tue, 18 Mar 2025 15:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9OVlok
	mK6zGyhI1spqmOYEgIWAAbeKK95byw7TIDhWU=; b=RUkkRXSVmpLOsqlJZelQSA
	Df8AHmFKxLHG1M165FN/FOzW8A3Cch5FAub1DnV68s6uKrc1fWTN5bp2hYvmIuF9
	Y6WIa8/4lVsjX1TT4ncLLpezI6rEenRLAQWw8xiKP71o9Tg6bbvqJbj2mUUgkR26
	U7iANT2YVRL8OWDRCrVhh8M/xghDq1asWepkEr2WFGDzxVl3l4SVLyVn7JocYGeZ
	4gVpG0sw1sRez94NnkuHlPgp6oSudWvAFGG/mEgCC0cYQkbmwn6Ka2b4oxnMhp9K
	jDHvloFDdr7ZdLWd3+poBohF4cjq/RF/OGy6JzlOrbOqGo/LlEdbqln9rqLXstEg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55vftm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 15:16:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ID6nXM005628;
	Tue, 18 Mar 2025 15:16:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8yvmf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 15:16:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IFGJkk18809218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:16:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85DE220040;
	Tue, 18 Mar 2025 15:16:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 075F42004B;
	Tue, 18 Mar 2025 15:16:19 +0000 (GMT)
Received: from [9.171.69.178] (unknown [9.171.69.178])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 15:16:18 +0000 (GMT)
Message-ID: <6ca68b33-eb2a-4840-830b-273e6d96becf@linux.ibm.com>
Date: Tue, 18 Mar 2025 16:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-7-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tZzCEzUreDiBSBXYPCmVWaHwIJcDRRp4
X-Proofpoint-GUID: tZzCEzUreDiBSBXYPCmVWaHwIJcDRRp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180110

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Introduce a cprb mempool for the zcrypt ep11 misc functions
> (zcrypt_ep11misc.*) do some preparation rework to support
> a do-not-allocate path through some zcrypt cca misc functions.
> 
> The mempool is by default space for 8 cprbs with each 8KB.
> For EP11 a CPRB either holds the request or the reply. So for
> a request/reply there is always a couple of cprb buffers
> needed. The minimal number of items in the mempool can get
> adjusted via module parameter zcrypt.ep11_cprbpool_min_items
> on module load.
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the minor change (see comment below)
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c      |  10 ++
>  drivers/s390/crypto/zcrypt_api.h      |   1 +
>  drivers/s390/crypto/zcrypt_ep11misc.c | 158 ++++++++++++++++----------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>  4 files changed, 109 insertions(+), 61 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index b60e262bcaa3..86578a95b140 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
[...]
> @@ -621,22 +652,20 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
>  	req_pl->query_subtype_len = sizeof(u32);
>  
>  	/* reply cprb and payload */
> -	rep = alloc_cprb(sizeof(struct ep11_info_rep_pl) + buflen);
> +	rep = alloc_cprbmem(sizeof(struct ep11_info_rep_pl) + buflen, xflags);
>  	if (!rep)
>  		goto out;
>  	rep_pl = (struct ep11_info_rep_pl *)(((u8 *)rep) + sizeof(*rep));
>  
>  	/* urb and target */
> -	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
> -	if (!urb)
> -		goto out;
> +	memset(&urb, 0, sizeof(urb));

The memset is done each time before a prep_urb() call. Please do the memset inside the prep_urb() function and remove the other ones.

>  	target.ap_id = cardnr;
>  	target.dom_id = domain;
> -	prep_urb(urb, &target, 1,
> +	prep_urb(&urb, &target, 1,
>  		 req, sizeof(*req) + sizeof(*req_pl),
>  		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
>  
> -	rc = zcrypt_send_ep11_cprb(urb, 0);
> +	rc = zcrypt_send_ep11_cprb(&urb, xflags);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)cardnr, (int)domain, rc);
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

