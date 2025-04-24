Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F21E0E0C
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477929; cv=none; b=V0f6mW8JP7UKr6VK+vCqDnhvAqo8GIMGGZnc62L9D8hxY1ujUXM0YAlnM7rj0+FqJvVcfEMflsA7CpgnwAR+Lf8UQAPR8eytxnHj7e16SRd1nHyeYeD3km4nagPvmQKXGdCsspipSB/6vpHvKO5UDxzXp36C1s5dD7e2KAPOEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477929; c=relaxed/simple;
	bh=RypCLmslyP3fVTAKXP0YHk5JlRKbc2ERLn/5Ys//K44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibMJRqc+MA13Ei2ZKwSB0wairhzEyJvmzZmfoehYMqiN/Pef6fs5u45O9IkOG5PlHsLxG3gmEcxV6J8ShyjVB0fvmuL4reFwdXmpgXkpi3WYqtSF3sIjNyXIvocX6bjHUs5/s8NFLHfhEfVmGWZUI15DcUFOXFhR1b8qnN4PfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbRtaoXB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbRtaoXB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJeRwf025243;
	Thu, 24 Apr 2025 06:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Txd58Sz2wrKOnQBBvhMHkOqCrndKQo
	rJtknZXPCYhbc=; b=GbRtaoXBRg63GvH6u0pu3OhZIpjwSYEhcJaAeiar2Rs9Kd
	aqLtit3vaUctZC9MoSeiu0eFQclWsr79TvcN5cuvRx0QvOGSCv9yur6YEyp5f8mR
	aJ16MnMWsa/Oa/0t3MfFKH9DZFrWXfw/p02E1myeZHC/bEkqiv9f/JrEN7E9KNPc
	2I3T/EMrkK/9X6o2fAhoK8+FdoPQl8dCSl3dTATzrMCT3nxGi77UoOb8kte3YMwH
	fSDyWAsfwP0UUlXBxES+msh8O1sMVbaE7Sy3KCCr4Cqqq19vanrc/Oc6pRvFmApH
	s3Ukq006WTbbmhNZqySxRz+b3B13ZpIY8ePygrRw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jw4gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 06:58:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53O2v2ht005893;
	Thu, 24 Apr 2025 06:58:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxexgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 06:58:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53O6wewf53936634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 06:58:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387A220043;
	Thu, 24 Apr 2025 06:58:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E753920040;
	Thu, 24 Apr 2025 06:58:39 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Apr 2025 06:58:39 +0000 (GMT)
Date: Thu, 24 Apr 2025 08:58:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v7 07/25] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
Message-ID: <20250424065838.7083Bd6-hca@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
 <20250423101535.143137-8-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423101535.143137-8-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=6809e125 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=EFORE0DBB9u_i97BHgYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KApki2SfAAoosuujKWV7GRmm_l6WuLMc
X-Proofpoint-ORIG-GUID: KApki2SfAAoosuujKWV7GRmm_l6WuLMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0MiBTYWx0ZWRfX3llWs+bh1rqI GqC1giNh1QgImmtZDrWWVC6wrX0CgSbsz+WubaAudYBIXv0vSrrsTN7cAEe4JUeRRuYTdl/zecA UvoKrQsqOrCUl7WHtJ3tNNmovGBONyiktMQ3ulRv9a3bol4TfXH9qvLAaJpr+AfHeTtbvJQz+iN
 VQaTA2BIASVZ3FM9ZZpxAIUy9oAeARdJruj1ICvdupKmUho9OGOsEvMYpzIE7GO/cHQoqY4Yl1s 05unmgGMfUO0iCdMfLpnmixzma7UrdlY0eS7VtKZvm4VZ0k5ewWFY35BPzCIcOItFyUUxNx6cIM 6cjHj4ZzHrtPg9FUsDCqQnGWcDGehGULu4en/Wsut5u4RByzjZZ0Jv9BTBPVh3IkgWhDwhd6ZZ+
 L+qj4PWpMs7Buh4uGjvG6K4YmmpXsC4Er6G3HOKyp0UvA241XYqnkaPkVGgOy+JC0gHcFW+g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240042

On Wed, Apr 23, 2025 at 12:15:16PM +0200, Harald Freudenberger wrote:
> Introduce a cprb mempool for the zcrypt ep11 misc functions
> (zcrypt_ep11misc.*) do some preparation rework to support
> a do-not-allocate path through some zcrypt ep11 misc functions.
> 
> The mempool is controlled by the zcrypt module parameter
> "mempool_threshold" which shall control the minimal amount
> of memory items for CCA and EP11.
> 
> The mempool shall support "mempool_threshold" requests/replies
> in parallel which means for EP11 to hold a send and receive
> buffer memory per request. Each of this cprb space items is
> limited to 8 KB. So by default the mempool consumes
>   5 * 2 * 8KB = 80KB
> 
> If the mempool is depleted upon one ep11 misc functions is
> called with the ZCRYPT_XFLAG_NOMEMALLOC xflag set, the function
> will fail with -ENOMEM and the caller is responsible for taking
> further actions.
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c      |   6 ++
>  drivers/s390/crypto/zcrypt_ep11misc.c | 149 +++++++++++++++-----------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>  3 files changed, 95 insertions(+), 61 deletions(-)

clang says:

    CC [M]  drivers/s390/crypto/zcrypt_ep11misc.o
      drivers/s390/crypto/zcrypt_ep11misc.c:1041:6: warning: variable 'rep_pl_size' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
       1041 |         if (!req)
            |             ^~~~
      drivers/s390/crypto/zcrypt_ep11misc.c:1121:20: note: uninitialized use occurs here
       1121 |         free_cprbmem(rep, rep_pl_size, true, xflags);
            |                           ^~~~~~~~~~~
      drivers/s390/crypto/zcrypt_ep11misc.c:1041:2: note: remove the 'if' if its condition is always false
       1041 |         if (!req)
            |         ^~~~~~~~~
       1042 |                 goto out;
            |                 ~~~~~~~~
      drivers/s390/crypto/zcrypt_ep11misc.c:1028:33: note: initialize the variable 'rep_pl_size' to silence this warning
       1028 |         size_t req_pl_size, rep_pl_size;
            |                                        ^
            |                                         = 0
      1 warning generated.

> @@ -1095,9 +1117,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
>  	*outbufsize = n;
>  
>  out:
> -	kfree(req);
> -	kfree(rep);
> -	kfree(urb);
> +	free_cprbmem(req, req_pl_size, true, xflags);
> +	free_cprbmem(rep, rep_pl_size, true, xflags);
>  	return rc;
>  }

Which is this hunk.

In addition:

> @@ -1161,7 +1183,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
>  	req_pl_size = sizeof(struct uw_req_pl) + (iv ? 16 : 0)
>  		+ ASN1TAGLEN(keksize) + ASN1TAGLEN(0)
>  		+ ASN1TAGLEN(pinblob_size) + ASN1TAGLEN(enckeysize);
> -	req = alloc_cprb(req_pl_size);
> +	req = alloc_cprbmem(req_pl_size, xflags);
>  	if (!req)
>  		goto out;
>  	req_pl = (struct uw_req_pl *)(((u8 *)req) + sizeof(*req));
> @@ -1197,22 +1219,19 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
>  	p += asn1tag_write(p, 0x04, enckey, enckeysize);
>  
>  	/* reply cprb and payload */
> -	rep = alloc_cprb(sizeof(struct uw_rep_pl));
> +	rep = alloc_cprbmem(sizeof(struct uw_rep_pl), xflags);
>  	if (!rep)
>  		goto out;
>  	rep_pl = (struct uw_rep_pl *)(((u8 *)rep) + sizeof(*rep));
>  
>  	/* urb and target */
> -	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
> -	if (!urb)
> -		goto out;
>  	target.ap_id = card;
>  	target.dom_id = domain;
> -	prep_urb(urb, &target, 1,
> +	prep_urb(&urb, &target, 1,
>  		 req, sizeof(*req) + req_pl_size,
>  		 rep, sizeof(*rep) + sizeof(*rep_pl));
>  
> -	rc = zcrypt_send_ep11_cprb(urb, 0);
> +	rc = zcrypt_send_ep11_cprb(&urb, xflags);
>  	if (rc) {
>  		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
>  			       __func__, (int)card, (int)domain, rc);
> @@ -1245,9 +1264,8 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
>  	*keybufsize = rep_pl->data_len;
>  
>  out:
> -	kfree(req);
> -	kfree(rep);
> -	kfree(urb);
> +	free_cprbmem(req, req_pl_size, true, xflags);

This would lead to a memset() with destination address 0 if alloc_cprbmem()
fails.

> @@ -1319,15 +1337,16 @@ static int _ep11_wrapkey(u16 card, u16 domain,
>  	} __packed * rep_pl;
>  	struct ep11_cprb *req = NULL, *rep = NULL;
>  	struct ep11_target_dev target;
> -	struct ep11_urb *urb = NULL;
> +	struct ep11_urb urb;
>  	size_t req_pl_size;
>  	int api, rc = -ENOMEM;
>  	u8 *p;
> +	const u32 xflags = 0;
>  
>  	/* request cprb and payload */
>  	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
>  		+ ASN1TAGLEN(keysize) + 4;
> -	req = alloc_cprb(req_pl_size);
> +	req = alloc_cprbmem(req_pl_size, xflags);
>  	if (!req)
>  		goto out;
...
> @@ -1405,9 +1421,8 @@ static int _ep11_wrapkey(u16 card, u16 domain,
>  	*datasize = rep_pl->data_len;
>  
>  out:
> -	kfree(req);
> -	kfree(rep);
> -	kfree(urb);
> +	free_cprbmem(req, req_pl_size, true, xflags);

Same here.

Please check all error paths in all patches and resubmit.
I'm going to revert the whole series for now. Thanks!
