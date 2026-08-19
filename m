Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D036654C;
	Wed, 19 Aug 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148191; cv=none; b=UWIvvGMs/p6u3XjCWrU1zBwyHwhASqLt/OF+3qn+WNM0wSmoAuWoRkMlYeGn/3OQ5WSua3aTdaWaHoGLod67/ZdasPZ/qy169XjShZASs5NqHxHrGC4bMyMwXKNYsL3GF+0/j3ddS3dfm0Rp1iLUO2+5pPZAqi+Saxow6JOnKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148191; c=relaxed/simple;
	bh=LCro2tYiBscS5issuaQUV6QpN7NWXpP6qzms4eecEDY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k5+cs5H06YtNzezetsky0/WZI+COyrj71feWt8YezhcJRdaIpbWXbgyq9f+4AC7yCUyOvszfv3BQUEgg7FxnBJxQui6taTye6eqwc/x2jq7O4nWWwCVq3RQRVg9tdfpxoER0Wk2z8RmOYgUleW+SMAC44LCKedusROVzxTlR91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2fzv68a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2fzv68a"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD1WPl3480027;
	Wed, 19 Aug 2026 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=zEbypElYEwL0PY2qHrfil0IYvxeMSmOeS+L3sP8XU2k=; b=s2fzv68aEEvm
	v/sEr9PIOCAbbNAm4AiLyCbysjhAzxV88Gq01XVMaoUOsZ444F2tjG/8TXc9SFgv
	4OMkbFj1rI17EYb3dgIGx2AAsVVKcyEyfV7CkaPmxiHwWeY2Nm76b1g/61VYOKro
	EpL4FGPuOtPi8MWO8rDm1tAmTY9sK9EiNHpDFviWbVRHk1aHYmkrmm8VpTzzb86R
	KR3y12Sw3J8o8rotGNWnTV8P1CSafcR0NQY9jgMAFngHCK/UIH2dUCYUV1zr3kmY
	9YJkgr6fNOVAQXLByw0G6tBiBxCBWJ8rFbjYcIwBUquNhR4UuPyOLe2oa9e/QHQK
	840qvF3pWQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1c5gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 14:03:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JDuLOE003513;
	Wed, 19 Aug 2026 14:03:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngh276-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 14:03:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JE36IT20251324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 14:03:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9836058058;
	Wed, 19 Aug 2026 14:03:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E91555805B;
	Wed, 19 Aug 2026 14:03:05 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 14:03:05 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 16:03:05 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260819093709.52A491F000E9@smtp.kernel.org>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-7-freude@linux.ibm.com>
 <20260819093709.52A491F000E9@smtp.kernel.org>
Message-ID: <9c6a24923189fd72dc20aa1bd539d73b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85b79c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=m3xwgEX8F2NfDoi_QdUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: CyJj3yhzngg6aC0OMEd7772pGRFJybzs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX++P/cBUWzW/b
 hnkKvhjWr9+MLw/Hj6dtqtowKqTf3iLSWIdJXM4dO2gjC5sQpLNuKZw2y34IIBM6mkQ+Z8+XfX6
 DMTkI56qR21HH84FElxnVheunVWI63U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX96QuXlCeTEaG
 HpoPYiDgcWzFMH9BUHxvqfFJtzUL1svXVmdPieiBm/6FHGZO0icnqYoVgj08o2t+z79Eo2kn3un
 aH16/1k4EU2Om7OFsti7Uk1K9Fye/U95aEedMT+HA4fL0cO+JFLg+pguTn+sSYQe7RwHVKRtyp9
 kzSm4urKWbo5YGRzLbCLCpzTKGpsOSkBo9+yOylNbzJUzDRk1DtbaTudBnJMFMGc14neUEKXfeJ
 pHZe6M78yM9QaSSJ64bI2j1fDiA36Xe24BoW749ea1jUkBhsDAOjh4xaxHV2WmHu3fDfJmuKfz7
 Xr8ICYh3IdSD5xTop1rp8JUNRy2KN/GF4ZiYmX/W9PKN2xw2V5l6BAkas1vKo0LOANKq68LU58f
 9RZXa2MNZBl8IN57c7JayTL0wMiAKlmWKoNfwPuYFg3OVlY9YOhDdHUvCHeD/OlbyxU6gujxOVR
 ZTZQOoC3CyVk/R7+aiQ==
X-Proofpoint-ORIG-GUID: CyJj3yhzngg6aC0OMEd7772pGRFJybzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190109

On 2026-08-19 11:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Thread-local memory mapping (kmap_local_page) is leaked
> across an asynchronous boundary, leading to an invalid cross-thread
> kunmap_local.
> - [High] Double completion of asynchronous requests on error paths in
> `phmac_do_one_request`.
> - [High] Persistent hardware busy state causes the driver to complete
> the request with `-EBUSY`, which the crypto API swallows, leading to
> an infinite wait.
> --
> 
> --- Patch [6]: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in
> PHMAC when req is pushed to crypto engine ---
> commit 85264caf4d41b4adaeaed2f15efd8b287915969c
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to 
> crypto engine
> 
> This commit fixes the handling of the -EBUSY return code when a request 
> is
> transferred to the crypto engine via 
> crypto_transfer_hash_request_to_engine().
> It adds -EBUSY as a successful transfer indicator alongside 
> -EINPROGRESS,
> preventing premature cleanup of the request context.
> 
>> diff --git a/arch/s390/crypto/phmac_s390.c 
>> b/arch/s390/crypto/phmac_s390.c
>> index 03ca33ffe6ccf..30c8a59af1a4e 100644
>> --- a/arch/s390/crypto/phmac_s390.c
>> +++ b/arch/s390/crypto/phmac_s390.c
> 
> [ ... ]
> 
>> @@ -629,12 +632,15 @@ static int phmac_update(struct ahash_request 
>> *req)
>>  		req_ctx->async_op = OP_UPDATE;
>>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>>  		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, 
>> req);
>> -		if (rc != -EINPROGRESS)
>> +		if (rc == -EINPROGRESS || rc == -EBUSY)
>> +			cleanup = false;
> 
> [Severity: Critical]
> This is a pre-existing issue, but does setting cleanup = false here 
> leak a
> thread-local memory mapping across an asynchronous boundary?
> 
> When the submitter thread maps the scatterlist page using 
> kmap_local_page()
> via hwh_prepare() calling into crypto_hash_walk_first(), the map is 
> strictly
> thread-local. If the request is pushed to the engine and the submitter 
> thread
> returns, the local memory remains mapped in its thread context.
> 
> Later, the crypto_engine kworker thread processes the queued request in
> arch/s390/crypto/phmac_s390.c:phmac_do_one_request(), calling
> crypto_hash_walk_done(), which invokes kunmap_local() cross-thread. Can 
> this
> cause a kernel BUG or panic by violating the thread-locality 
> requirements of
> kmap_local_page()?
> 
>> +		else
>>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>>  	}
>> 
>> -	if (rc != -EINPROGRESS) {
>> -		hwh_advance(hwh, rc);
>> +	if (cleanup) {
>> +		if (hwh->walkbytes > 0)
>> +			hwh_advance(hwh, rc);
>>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>>  	}
>> 
> 
> [ ... ]
> 
>> @@ -667,12 +674,14 @@ static int phmac_final(struct ahash_request 
>> *req)
>>  		req_ctx->async_op = OP_FINAL;
>>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>>  		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, 
>> req);
>> -		if (rc != -EINPROGRESS)
>> +		if (rc == -EINPROGRESS || rc == -EBUSY)
>> +			cleanup = false;
> 
> [Severity: High]
> This is a pre-existing issue, but does the driver properly translate 
> persistent
> -EBUSY hardware errors before completion?
> 
> If the hardware persistently returns -EBUSY when deriving a protected 
> key in
> arch/s390/crypto/phmac_s390.c:convert_key(), it exhausts its retries 
> and
> returns -EBUSY. This propagates to phmac_do_one_request(), which 
> explicitly
> finalizes the request:
> 
>     crypto_finalize_hash_request(engine, req, rc);
> 
> Since the crypto API's completion wrapper ahash_op_done() explicitly 
> swallows
> -EBUSY because it treats it as a queueing status, completing a request 
> with
> -EBUSY prevents the final completion callback from firing. Could this 
> cause
> callers using crypto_wait_req() to block forever?

Yep, this may be an issue - never complete a request with -EBUSY.

> 
>> +		else
>>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>>  	}
>> 
>>  out:
>> -	if (rc != -EINPROGRESS)
>> +	if (cleanup)
>>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>>  	pr_debug("rc=%d\n", rc);
>>  	return rc;
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
> 
> [Severity: High]
> This is a pre-existing issue, but is there a risk of double completion 
> on error
> paths in arch/s390/crypto/phmac_s390.c:phmac_do_one_request()?
> 
> If hardware execution fails and returns an error like -EIO,
> phmac_do_one_request() manually completes the request:
> 
>     crypto_finalize_hash_request(engine, req, rc);
>     local_bh_enable();
>     return rc;
> 
> By returning the negative rc back to the crypto_engine core, and 
> because the
> engine allocates with retry_support=true, the core in 
> crypto_pump_requests()
> will treat this as a failure it must handle. Does this trigger an 
> automatic
> fallback crypto_request_complete() that invokes the user's completion 
> callback
> a second time?

Fixed in patch #8 of this series.
