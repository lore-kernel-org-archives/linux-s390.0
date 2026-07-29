Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E348CD48;
	Wed, 29 Jul 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332993; cv=none; b=t79E3qwpx38ZmXAANDTZoaokrIdYLi0OHmqxGvOFIMsQ6TOBQmuAC6QZdDLkUKMeujEpwLEFs+gVyNOBkcvmkKh45evyVsSLSeGz9a2DSFtmhvdJOEpr8i1Qv02hlFXISMBu+N8STYpPwH3rHB48NNpiFAOoFcaWQl7YhNJMXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332993; c=relaxed/simple;
	bh=6yLAhpkVf+diSxK00Df9zcO4wY0bjh82ZMEwL2Zp4nA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EcLPYB0VRHJkBOyhhvM1L/jjiHqKrNXJoddr8Tm9lfmgvwy0eSJoRs8ybe5bbw7eEU390GbK2tO6K3Aki1UXv09cq6jsowcRueexRxevrIn++FcyZ6uR5oFzEvTM6u624j0CYyn2hpSvN4fQETzMydRU5oyEJiH+bByFrTWYOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SfH8ssy4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SfH8ssy4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHuWN095364;
	Wed, 29 Jul 2026 13:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=f0uqmnmJ7eO5JPij8wC6Iijx9rbffTn/PzgxgG/LhRc=; b=SfH8ssy4idXB
	UW/JGgsOf/Xq6Aafa8HlrLIF4KvIwrah/EO2l/0TBd4Ty19kSHEPqNXTkDzOukAw
	fD0SLAue6Z8STV76ALDfDBZt37ggUjD/J7KtsDX/N33IcgLVnX4XZCfdmfOuMTMT
	CwZZX7x6n7Db/FNHFm+x4BIo9GqxmBRtWHzFv/00CGEmDsEWIxWRlJA1RE5xBKHn
	AVaKExFRNruzt3R5eorBWzwnji7yhpUTPgfdJfvP3l999YVUJIVxrEpG5dShXZYu
	rLGpY3QwVmuqFnuIeze1Ehk0JnuQimxG2PFVAndC8CjTgWhZ559D/FfMWbhYFOT8
	KIjgh755QA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jyby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:49:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDfIEt000789;
	Wed, 29 Jul 2026 13:49:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw72c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:49:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TDnc7e42664270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 13:49:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A24258063;
	Wed, 29 Jul 2026 13:49:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41DB858056;
	Wed, 29 Jul 2026 13:49:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 13:49:38 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 15:49:37 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] s390/zcrypt: Fix buffer over-read in
 cca_cipher2protkey
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729120659.A1D361F000E9@smtp.kernel.org>
References: <20260729114009.187946-1-freude@linux.ibm.com>
 <20260729114009.187946-2-freude@linux.ibm.com>
 <20260729120659.A1D361F000E9@smtp.kernel.org>
Message-ID: <13a08af540172b32e8e119b6711995d9@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uQGFIxDMjfLvXIy0BcZUF94ec5_gI5TI
X-Proofpoint-ORIG-GUID: uQGFIxDMjfLvXIy0BcZUF94ec5_gI5TI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfXysGFGxoKMAkf
 H8Elr2tdQdzYVNNBC+amVY1RauQInU75VIgxpJKsV09M5+KNUowSAVWmsj+MGka9uQD+t6/DFbF
 Qg5vRMuYVvozizZUmamK4HzRB7ZMca3mUcmpbsjwGJffeIr3CalsXkFDZ8DmO1R9xsOmDO8xTVU
 fjrqM9Dt//trtsf7eWRYu1BtZeFHvaHVdMMTFA6xFEoJdBE91sbqw37PvECl9hd8OVT2NNLNif9
 vT6qhtR7Q1K1sbdlhc4tB4SrF4J0w0jmvszIIy22UHiK50KltUFwoiOijfmA/uU1UCHdIVKLG9O
 tGc/jcO1/pRcCOcKxjHf46UNMU0N++LpzZRDtidSX4xk/bYsVwKUrLTwPfxR4gaas2p0EXFy40X
 vwdzipr/E2Nm9VdwaKd7kbNWmg/k5vElkeC6Q4xxZgn4/h7g01r7mHFeblfS59DXwcd7uSX8XYJ
 QWvH4iy7GUOlYmyrNjw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a04f5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UUZeX8ReztZoQV8DkmEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX9PQjguFz8za2
 71OHFe6FVxDMsqUQiHk3mHzMZv3d+YXAboxx7IRPktkjo50R5MxJudVSW56hn5HCCC2hxZFxe4C
 pLsEh7EdCUxwDlE3Hp2xVogAG3H7QvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290114

On 2026-07-29 14:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Unbounded token length allows heap buffer overflow in
> `cca_cipher2protkey` and `cca_ecc2protkey` when building CPRB
> requests.
> - [High] Unvalidated firmware-provided length in `cca_gencipherkey`
> can lead to a massive out-of-bounds read and memory leak to
> user-space.
> - [High] Unbounded `t->len` in `_ip_cprb_helper` can cause a heap
> buffer overflow when copying a response from the crypto card.
> --
> 
> --- Patch [1]: [PATCH v4 1/1] s390/zcrypt: Fix buffer over-read in
> cca_cipher2protkey ---
> commit df110319f8dcc4a61962c0699f5ad1038f1b9085
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
> 
> This commit adds validation of the actual key buffer size and token 
> length
> fields in the cca_check_sec*token functions. It prevents buffer 
> over-reads
> and under-runs that could lead to kernel crashes or memory exposure.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [ ... ]
>> @@ -936,23 +975,28 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 
>> keybitsize, u32 keygenflags,
>>  	}
>> 
>>  	/* and some checks on the generated key */
>> +	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
>> +	if (prepparm->kb.tlv1.len < 2 * sizeof(uint16_t) + sizeof(*t)) {
>> +		rc = -EIO;
>> +		goto out;
>> +	}
>> +	keybuflen = prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
>>  	rc = cca_check_secaescipherkey(zcrypt_dbf_info, DBF_ERR,
>>  				       prepparm->kb.tlv1.gen_key,
>> -				       keybitsize, 1);
>> +				       keybuflen, keybitsize, 1);
>>  	if (rc) {
>>  		rc = -EIO;
>>  		goto out;
>>  	}
>> 
>>  	/* copy the generated vlsc key token */
>> -	t = (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
>>  	if (keybuf) {
>> -		if (*keybufsize >= t->len)
>> -			memcpy(keybuf, t, t->len);
>> +		if (*keybufsize >= keybuflen)
>> +			memcpy(keybuf, t, keybuflen);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can an unvalidated 
> firmware
> response lead to an out-of-bounds read here?
> 
> The hardware returns a response containing a tlv1.len field which is
> used to calculate keybuflen. If a compromised or buggy crypto card 
> firmware
> sets an abnormally large tlv1.len, does this memcpy read past the 
> 512-byte
> parameter block into adjacent kernel heap memory and leak it to 
> userspace?
> 
> Could we add a bounds check against the 512-byte allocation limit 
> before
> performing the memcpy?
> 
>>  		else
>>  			rc = -EINVAL;
>>  	}
>> -	*keybufsize = t->len;
>> +	*keybufsize = keybuflen;
>> 
>>  out:
> 
> [Severity: Critical]
> This is a pre-existing issue, but I noticed a potential regression 
> involving
> buffer overflows in cca_cipher2protkey and cca_ecc2protkey when 
> building
> request blocks.
> 
> In cca_cipher2protkey, if a user issues an ioctl providing a malicious 
> token
> with a large len field, does this overwrite the 512-byte buffer?
> 
> drivers/s390/crypto/zcrypt_ccamisc.c:cca_cipher2protkey() {
>     ...
>     preqparm->kb.len = keytoklen + 3 * sizeof(uint16_t);
>     preqparm->kb.cca_key_token_len = keytoklen + 2 * sizeof(uint16_t);
>     memcpy(preqparm->kb.cca_key_token, ckey, keytoklen);
>     ...
> }
> 
> The cca_check_secaescipherkey function ensures t->len is less than or 
> equal
> to keysize, where keysize is the user-provided size that can be up to
> 8192 bytes. If keytoklen is larger than the 512-byte limit, could this 
> memcpy
> overwrite the allocation?
> 
> A similar pattern exists in cca_ecc2protkey:
> 
> drivers/s390/crypto/zcrypt_ccamisc.c:cca_ecc2protkey() {
>     ...
>     preqparm->kb.len = keylen + 3 * sizeof(uint16_t);
>     preqparm->kb.cca_key_token_len = keylen + 2 * sizeof(uint16_t);
>     memcpy(preqparm->kb.cca_key_token, key, keylen);
>     ...
> }
> 
> [Severity: High]
> This is also a pre-existing issue, but I observed a similar unbounded 
> length
> usage in _ip_cprb_helper that might cause an out-of-bounds read and 
> write.
> 
> When copying a response from the crypto card, the t->len field is 
> trusted
> directly from the hardware:
> 
> drivers/s390/crypto/zcrypt_ccamisc.c:_ip_cprb_helper() {
>     ...
>     t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
>     memcpy(key_token, t, t->len);
>     *key_token_size = t->len;
>     ...
> }
> 
> If the hardware provides a malformed response with a large t->len, does 
> this
> memcpy read out-of-bounds from the 512-byte parameter block?
> 
> Additionally, if this corrupted length is returned to 
> cca_clr2cipherkey,
> could it be used to write back into a new 512-byte request block and 
> cause
> another overflow?

These issues are valid but are already addressed with another patch 
series.
