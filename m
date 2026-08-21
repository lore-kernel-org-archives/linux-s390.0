Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC539282C;
	Fri, 21 Aug 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299697; cv=none; b=bECVSsAfFTvNCn0s/4LsIV1oaqPP8J4FwK3f7/2pPl82TAMJ13GDczQrbk5J+2UUFcJT3W6VvoKsD+d3SQ1FLn8GUETIk74pjQzqBLrMXi4FutFYR0WuWzQPEnErqnSC54R0+pusWAzLcAKTVywi2v0uLZwY37ZOauaKOfBAXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299697; c=relaxed/simple;
	bh=lQ/dAX+RXRXAsAeaExiSJ+arco3Cp2j3ILR3ZYZGCjw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mGVs5DcgiiwGHMK67CGzjeIucwgduFUzi2bNY0RUoZRjfbykTGueCx7a9NPXB2TisxI+3av4YfdKLITHtk7VBGG0ErpTWDM8LayQwcB955w98H34IgTdeWTCFwDEmQfM1mtCGkj0RUBeXls9t83pp+fmG1uNdi1GdI5rn/lLs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GttcPNzQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GttcPNzQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5WH8k3646036;
	Fri, 21 Aug 2026 08:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=eL+8jpYcsZarGjEHQo1e5+TKaOjNsmN3QPixUfvYYLw=; b=GttcPNzQFRzm
	hmEilZ4LidN0aJ5Nd5pCwL83y9tmpYXMAZf3q/8dDnIKot10BalDJolCjoGuT1Vg
	dAjou+mcjm+7tttnHKe18aCkiRx1gXixWDmosq9/ItQHeBo7T+9SNVllzhVZZJJ/
	H5SmJXSufEBbHM+wg0hz4P72JKK05PyooTG7zkb6wXivVqqPpYvMto9me8PYaBD5
	ThsVyN84JZe0v35FhjGAHVeuHV0qioByQZGHXjm0mqX5fpXJ85cBPu1o+CNdKkN1
	NO29vRsNsOo976AahiUGh7BYRwTqpqpVN0JsknT815H6b5pagUhcE1i2YojEn5tc
	rE8WlQVjPA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2fvmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 08:08:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L7uQxO011075;
	Fri, 21 Aug 2026 08:08:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twkgfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 08:08:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L88CM626149394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:08:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE0458058;
	Fri, 21 Aug 2026 08:08:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3B8058059;
	Fri, 21 Aug 2026 08:08:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:08:11 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 10:08:11 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik
 <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5 6/8] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260820143522.7C3221F000E9@smtp.kernel.org>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-7-freude@linux.ibm.com>
 <20260820143522.7C3221F000E9@smtp.kernel.org>
Message-ID: <4be21507d2d364d9a36d81512f4b3e5b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88076e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=eGWD9COVx0Xut67NzgsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gkgFXwFiT6aVgjYdMDDD3dUOAdBbFneN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA1NyBTYWx0ZWRfXxJvPEcgyFhiB
 U1YYKt3U+9+4gj2p3gNwipR7ScEWYz0XrlG6OVgtj3lGK3JQjnhndwj/lxwDXUBmQ+FUF77V2M/
 x2rEvsCql8qrdbncgJNbitjccFJb2Y/dusccrG+6sITEx7fLbDJdHR7N+AcfdXTO2rX1egCmfOQ
 +cTpj0J93yfHiEv6utnNmTj09CtwbNFG+M86oZWooI18RCdYe3TdCWqtWUIlz0MdKUhwjONqWAg
 N+eroIiywFyC8O1Oraz6ajt1i3R5uPsSwW2/IxHOY+d8rEyFMUTNvQqChmhGzPlbXO+4QoHGIMq
 oymW2pWtpD2/yZZF23kplaUdogn8Op95XHd+bOiLMJm2CPeQzbRYC4KpQGAVnI6IBq0sm4D/8ql
 NzXrB28XbKVc015zmY7bulvp3f7OXRzNoF0T4h8bV2gJOr9vvWal/ZrpHuZsQNT78kw/qJuptxj
 czitypbCwRYcX3qLEBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA1NyBTYWx0ZWRfXw64Hu/bY1jlc
 +qjdKQ31baur7viJLv+MvL1YWu1aVPRXK3diItXVTtKn7wGSk1j48rWWr4yrhu+aA3SlFqW1Hrw
 oBaPh9sIGGSdpN67OAPWIwsb3Brgtlo=
X-Proofpoint-ORIG-GUID: gkgFXwFiT6aVgjYdMDDD3dUOAdBbFneN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210057

On 2026-08-20 16:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect module teardown order in `s390_phmac_exit` leads to
> kthread leaks and Use-After-Free of the `crypto_engine`.
> --
> 
> --- Patch [6]: [PATCH v5 6/8] s390/crypto: Fix handling of EBUSY in
> PHMAC when req is pushed to crypto engine ---
> commit c74c807c2aeebffc7e981ca45b5b377727342ad1
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to 
> crypto engine
> 
> When a request is transferred to the engine via
> crypto_transfer_hash_request_to_engine() there are two return codes
> signaling a successful transfer: EINPROGRESS and EBUSY. However the
> correct handling of EBUSY was missing and has been added as a return
> code indicating a successful transfer to the crypto engine.
> 
> Cc: stable@vger.kernel.org # 6.17+
> 
>> diff --git a/arch/s390/crypto/phmac_s390.c 
>> b/arch/s390/crypto/phmac_s390.c
>> index 03ca33ffe6ccf..30c8a59af1a4e 100644
>> --- a/arch/s390/crypto/phmac_s390.c
>> +++ b/arch/s390/crypto/phmac_s390.c
> 
> [ ... ]
> 
>> @@ -716,15 +726,17 @@ static int phmac_finup(struct ahash_request 
>> *req)
>>  		/* req->async_op has been set to either OP_FINUP or OP_FINAL */
>>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>>  		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, 
>> req);
>> -		if (rc != -EINPROGRESS)
>> +		if (rc == -EINPROGRESS || rc == -EBUSY)
>> +			cleanup = false;
>> +		else
>>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>>  	}
>> 
>> -	if (rc != -EINPROGRESS)
>> +	if (cleanup && hwh->walkbytes > 0)
>>  		hwh_advance(hwh, rc);
>> 
>>  out:
>> -	if (rc != -EINPROGRESS)
>> +	if (cleanup)
>>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>>  	pr_debug("rc=%d\n", rc);
>>  	return rc;
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this file I noticed a
> potential module teardown order problem in s390_phmac_exit() in
> arch/s390/crypto/phmac_s390.c:
> 
>     if (phmac_crypto_engine) {
>         crypto_engine_stop(phmac_crypto_engine);
>         crypto_engine_exit(phmac_crypto_engine);
>     }
> 
>     for (i = ARRAY_SIZE(phmac_algs) - 1; i >= 0; i--) {
>         phmac = &phmac_algs[i];
>         if (phmac->registered)
>             crypto_engine_unregister_ahash(&phmac->alg);
>     }
> 
> Could this lead to kthread leaks and a use-after-free of the 
> crypto_engine?
> 
> If s390_phmac_init() fails to register a subsequent algorithm after
> successfully registering the first, it jumps to the error path and
> calls s390_phmac_exit().
> 
> Because the first algorithm is already registered and the module is in
> MODULE_STATE_COMING, a concurrent userspace program can successfully
> allocate it and continuously submit hash requests.
> 
> Since s390_phmac_exit() calls crypto_engine_stop() before unregistering
> the algorithms, the continuous stream of requests keeps the engine 
> busy.
> This can cause crypto_engine_stop() to time out and return -EBUSY,
> which leads to crypto_engine_exit() returning without destroying the
> kworker thread.
> 
> Finally, misc_deregister() destroys the device, freeing the 
> devm-managed
> crypto_engine struct, and the module is subsequently unloaded.
> 
> Would the still-running kworker thread then access freed memory and
> execute freed module code, potentially causing a kernel panic?

This will be addressed in another series. There is a new tracking 
bugzilla for this:
https://bugzilla.linux.ibm.com/show_bug.cgi?id=222134
