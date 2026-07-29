Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79548D871;
	Wed, 29 Jul 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340920; cv=none; b=htYxQ0euG0IL49tPaV2zO6icCW8VK9wa2w3Wq2LoH6pkh3tVRPD8ZoiI8lc0qpXRh4VZ9kTOJh/8q6pTp//BLpFh6M2In7t30o0Zo6w9bl2wlYAoK9MccT4GiBmd4uuZUXi2XBTHZ+8qhYtrhKfsJteaLYaT07WWpYBsiWPATlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340920; c=relaxed/simple;
	bh=ohKfusJRwx0iTbct+FwMIzCGClpsh2yUwRgAedNLOXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p71vMmQSiFh+x0Rj5MjKo8lLYi4Nkm2+4M9aF8JelMsypPrEGTJVd2eT01JagFK+GexOUuJjpTiYlIRJsHQsxL2GdPoUN2KF5EqZ/YNlBfcQueQnQH+uQhvYu99o+mXrN0ItAm9yrhHJQQBGryep7BsdwRBSIjSEY2vj8j+3+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMU6f4ls; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMU6f4ls"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFIA8v284411;
	Wed, 29 Jul 2026 16:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZwX4f9EiOSG9m6D2RbreDZGHVCtd3xDWxVN0ZpNmsUg=; b=sMU6f4lsTiAu
	lZHChJbQM0I3dTOPUfy9Q0MZS8zr2MIybnzoPfca01X47LJkMrBRuokV3kGybTyf
	kR3Zn17D3ewkDuhzxpDXK+i/NxXOqkjG5bFK1Vzq6NoUtAY3zsN/gGdic+Uy2N5f
	gloVybW2esRXuFeZjNKrjHfJf2+s7+/UQIZA+tw+mmIMGt6AI8yQbOGJ+w9ipEgK
	zodIdthSwt7EFATOwxlbGVB33CjFlBOk6nRn34RBMDva7bEV6pP780ccuNO5mtf4
	sY9rWRcNOEl0rdVr1Fc4nw9l6bnE25y0enIl8lcuKeFcmnhmFV2V4d3rsyzh8Lqu
	vzLD6Ao6OA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntqna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:01:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuFAX032366;
	Wed, 29 Jul 2026 16:01:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y73r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:01:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TG1IR316319172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:01:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9ED35805F;
	Wed, 29 Jul 2026 16:01:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56F7058059;
	Wed, 29 Jul 2026 16:01:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:01:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 18:01:53 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear key
 import in cca_clr2cipherkey()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729141220.E28071F000E9@smtp.kernel.org>
References: <20260729140134.191448-1-freude@linux.ibm.com>
 <20260729140134.191448-2-freude@linux.ibm.com>
 <20260729141220.E28071F000E9@smtp.kernel.org>
Message-ID: <5bb7d8d0522857816245a260c7b98c23@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX3BNskV+Em+hC
 +ZLsH+JsrsPCRUFGSk14UvTwGEPz8X+e2UyqgwSpA8cTnwQB931p03p1R8qkriARN9bDKNPHezb
 JnTgwhxqngPiGsukqTJQdaycMnSL/gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfX7hYK7f63bLaC
 7s8Sg6AYJ4OUhfGCJna0dPmVWVMAhadZxGt3unKL0amTc3JY+eqtKpJsPS9lUmkgmIS9TR96fQd
 kJT2tgsPnXkcz9bjLHoZFQDngDJc6rP+l05Qv8+7NVjDoGmcGu40PZxnaufw6zwNY0XD1Kzpetd
 d8kRDRsy/mSe0OSKgm7ZYq1FHL3j5PyNNM11IpL0Q9IxnvvffaNV7+WjXl2QqhQkUCIERyFoPvV
 J12FiNmS9RdSHAYA5ProYzZ6eT5RiP2mTLFdTJC09FeXijzetEBstd/G4JsDiaIDmGYJTZ7RzCH
 ux3dfpntdcQ/UjBojl5Ek1di3PoWmNI/tLtVTBsKnVsIxwp1VYuWvJkdKeci+JuqqTErcwM6jwG
 +aMOVEMF38irghbEgBTIoAZxwOHC9Vi0FCHMuuHRNcUCtN8OxUYrk613j8l34/d9AlnGqXQeJZP
 FCGfw1gX9zHfztKIO1A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a23f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5OT_ED_vbPaHr4bv3HIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 023fXyXMIT3hlk0loDhaouTVZoFrZ02f
X-Proofpoint-ORIG-GUID: 023fXyXMIT3hlk0loDhaouTVZoFrZ02f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290126

On 2026-07-29 16:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unvalidated length field `t->len` from an untrusted hardware
> response leads to severe out-of-bounds memory accesses during
> `memcpy()`.
> --
> 
> --- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at
> clear key import in cca_clr2cipherkey() ---
> commit 0678dd664c1b50d9a38dff946d27b4823de1e205
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix missing mem scrub at clear key import in 
> cca_clr2cipherkey()
> 
> This commit adds a parameter to _ip_cprb_helper() to scrub the CPRB 
> buffer
> after processing clear key material. It also adds explicit zeroing of 
> the
> buffers before freeing them in cca_clr2cipherkey() to prevent sensitive
> data exposure.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 84936a795b956..9cf268efd4abf 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [ ... ]
>> @@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 
>> domain,
>>  	*key_token_size = t->len;
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for a compromised or
> malfunctioning hardware device to return a maliciously crafted response
> length in t->len?
> 
> In _ip_cprb_helper(), the unvalidated t->len from the hardware response 
> is
> directly used as the length for copying just before this line:
> 
> 	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
> 	memcpy(key_token, t, t->len);
> 	*key_token_size = t->len;
> 
> Without bounds checking against the actual buffer size, could this lead 
> to an
> out-of-bounds read from the device response buffer and an out-of-bounds 
> write
> into the key_token buffer?
> 
> Also, on subsequent iterations in cca_clr2cipherkey(), the poisoned
> *key_token_size is used to construct the next request:
> 
> 	preq_key_block->tlv1.len = sizeof(preq_key_block->tlv1) + n;
> 	preq_key_block->tlv1.flag = 0x0030;
> 	memcpy(preq_key_block->tlv1.key_token, key_token, *key_token_size);
> 
> Does this cause another unbounded copy into the smaller parameter 
> buffer during
> the next loop iteration?
> 
>> 
>>  out:
>> -	free_cprbmem(mem, PARMBSIZE, false, xflags);
>> +	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
>>  	return rc;
>>  }

These issues will be addressed with another patch (series)
