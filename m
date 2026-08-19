Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5763A48CA;
	Wed, 19 Aug 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145801; cv=none; b=kwpaFWXfgnWyoN4tarlzmHibzz2yq2LUuuS3xuJ9uJ0DnnNWt9gLIg+t4qdzi8HC2LydEc03kk6tu4X36dpWH4/YMXXSkPV4P95tYP6V9VBE27FQcvRfLDfcIfyDEP9rcSmwnCSoZonij8PsF50txB78f5QkjstN9WzuX0Va5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145801; c=relaxed/simple;
	bh=16vdKvHSdIJF+eemIURO1Y7j7obp9td9Ff72DRecJs4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Tq2aQCAcMTwVrS1yS9VA2QdqtPo12DVXyZq950P4bNVBwjqrKUoczwDVex+LsSVq9DY3V09zfwv5WBgsWy5ju6xQ3J5c+QrwcT2Gd7SvXD3/EgrjOebRE3Y6X8Wq8+NZ7myq/eTeVHuoFI24KaLmiH2J9HAJK6H5ITNCv59rSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bf5D1WgW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bf5D1WgW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD1YKO2405773;
	Wed, 19 Aug 2026 13:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Js6KbFWQjFgjZKzT+PsegcoRRbCZMVKE75H+7oDSexo=; b=bf5D1WgWkkfi
	Umwl5iy+0lnYcqs2oyvR+b8ao5h4RNk6UUS1+YnhXpHkVenWJyvIImzt05elwA5C
	ZI5N2HQY2y3fY/3D9nqqzX98gUdLqYHQUk9NAPIt7DLFF53fQ0Q2ct7XwbrolZec
	SJwXMEKUPjZdiWZ7FSs0TBqS3hR7yh9PIchziB9gEOjA4onG0dlQZrbbo6DYvn3W
	C1OL0heKWBMNyUGMQczSiousKn9C4otgJMX1dK9LgNemgg7gxz5YxRIzyaEp7FUZ
	jbq+BNAk+pIjtl0tIJoVGh+YtFoJvZCayZqc9XEOGMqau/jS2HcwfSh1za4orGEH
	WDYajSHmiA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu23uwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:23:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JDBHGb022993;
	Wed, 19 Aug 2026 13:23:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq983e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 13:23:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JDNAlH22872670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 13:23:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E35558057;
	Wed, 19 Aug 2026 13:23:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D902458061;
	Wed, 19 Aug 2026 13:23:09 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 13:23:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 15:23:09 +0200
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
Message-ID: <cf1644a4ca745c763a041f5a8a54c836@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a85ae40 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=m3xwgEX8F2NfDoi_QdUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VZEba92-6PCBrDKS-vPlnd0z-APUTwb7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMSBTYWx0ZWRfX5J9QGT/TQ+UG
 1sQoy5s0cOSoaZk+yjVKS6wo0ABkwPA+8Lfc7Yp43PebrM7R+F9yMuWnJ7ACfq0cR1bwqY6NHCm
 E5D6LzuhIF1m2HQLeLnS8YBqtvaSQENFe2Nb8rWL1BI6MdTzE4OdolJ6sy5vJF3v/bobndNnsr2
 MaIxkqcMtPD0BDe21QalEV0gqiWUrEcj+X5uZBNRgdcBMmQ5ARg0hyRSuaO2zeh0eLENIRLY8hC
 slLw+OBoLoDC4am7bh1oBzwx/AqOcYxSrU1XubqC7Y4FIt7jhSYRvmIFL/grLkJDw8REHgcxlJC
 DPtUDzrdCCmAZVx6MrR+p/kOyZ3dCqVxOsWF/cuXvPwb1Jo2nXFdAwxsOrMDZHBC9L5jHtrVXV7
 sbzPXOapkx5Mz2R5DDsh29TNh7rUn47v/bBDq5PZHpf+XO6eq9GQ1OZflxW7mjBiP8yx/ClSmB4
 sNCEEeC/uuWxRLFiPvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMSBTYWx0ZWRfX9dkT060jmbJr
 ukc81ahINp/G6xCEY5KYP6VZ/3XlKViJPeI3SMzfjD23/pneikcMpmFatYZq8r6nExN7A41jjfl
 uYCVQQfqGZquavyaVvoixtn1DFwryzk=
X-Proofpoint-ORIG-GUID: VZEba92-6PCBrDKS-vPlnd0z-APUTwb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190101

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

This is not exactly true. On s390 CONFIG_HIGHMEM is NOT set.

 From /ext/git/s390-linux/include/crypto/scatterwalk.h:

   static inline void scatterwalk_map(struct scatter_walk *walk)
   {
      if (IS_ENABLED(CONFIG_HIGHMEM)) {
          // Uses kmap_local_page() - THREAD-LOCAL
          addr = kmap_local_page(page) + offset;
      } else {
          // Direct mapping - NO thread restrictions
          addr = page_address(base_page) + offset;
      }
   }

So there is no thread restriction on s390 and paes and phmac are both 
only s390.

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
