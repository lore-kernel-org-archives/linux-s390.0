Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98781471CF9;
	Wed, 29 Jul 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324132; cv=none; b=Gawypas3/klLAzQ1dM7mA4AXQERhIYvecFwPUZwvfyYKjmN4ohNw15EQb3M/gcVewB5I83DDBeBjhLC67sq10GVu1oXVgsc7EZHTSAWXJmJtdSEGO2mnhO2+V5N1cBSur3dcSxm8rzpqGwC+Xuf1M8Rp2TmbJQxTYcQOmH6PO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324132; c=relaxed/simple;
	bh=j96oaOgPTVV94hypkqd8Bk55BQjdQH8Kyvgp/syPBOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozI6RLjMLKQjqSRaIn+92YfB3ETa/niY2CGyEySdNviobMW7BrO/rINiepRa7gDqtj94rehds38A9Wm8Gj0+IMGzA+XrCgd0kRS1mf21L1YxWyC1ZYRGUcqL24dmEcvsOyt7VxcPIiOymw7k57yqRBDXk+NNrBt23rDkG2pKZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m4uu9nJX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m4uu9nJX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHak54030026;
	Wed, 29 Jul 2026 11:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+KB3MD
	QpNoiG0yS7JE8kHjadgUTX8LXYJbFgWZoSg5s=; b=m4uu9nJXp/PA0DENc8XABq
	yJYrbnzZ9Rpp7e/jO0bz0vIA4t3JVF4wV2o8AfZSUP/7oWv6wNM9T43oL8aK9KE+
	HP6N0tgkx5YRrOW4MV+JGOvv6SA1eD1pkFVhqc7tg6qSQ7CD/LwTsJ9WM3bO8cKY
	9xZU9T4XPxkqsghqxOJi5mtj34gZcXRzgGCUKl/0yrEDWRMycoxlRzXXvyOHXpc2
	7L87TbSAhmaaRC+wT5v1c/aLnqACbbRGYiFgB0CUtSYTk6vyRnNvCLSi+CRe//0m
	rl4ji91uNHfNdoH2sccrE+mLrqp4A9US7mXELn+v4R7PLCsfTir+3LEAp3DRsTKQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jbev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:22:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBBdNH020864;
	Wed, 29 Jul 2026 11:22:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y65gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:22:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBM53L47317352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:22:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA90920043;
	Wed, 29 Jul 2026 11:22:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC45320040;
	Wed, 29 Jul 2026 11:22:04 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:22:04 +0000 (GMT)
Message-ID: <498b23ec-ab49-4cdc-95c1-ffb62fd03eb8@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:22:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC private
 key requests
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-3-dengler@linux.ibm.com>
 <20260729101612.0D4A11F00A3E@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260729101612.0D4A11F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i-GUmTBGqKVxc9RgOwnMhdW7VDvaRtzL
X-Proofpoint-ORIG-GUID: i-GUmTBGqKVxc9RgOwnMhdW7VDvaRtzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX/nSkexQjhnMI
 IErdL/F4cDwdP3EoHu7m/zMZSRbHUiJ93eFplnl6pENr+Pb0sNJLQEIgPmcgzUNNH944nZPlV91
 7BFw04KOPJ2W9gxQv+5FImgeS5ezfnJU2SyXgUqo/QDDizQ2xAzdpdqacSdVQsujh8X1PoEoM/t
 9vjET3FLJQi2qf3Az7zLAfES1LfxjELfFpULCF6ela5vPOi9zZw/qm1wo96Tyc0mHN2dNPio+ae
 5TK9GY+x4YtHj5sfcW54VJFhs431mgsetPUEvggp4tS9ObCf2TtfdFR4I7vG2tHKxSDVqpIYk4q
 OUNqmL/t1xGQrcUI5V6Hdlww62xuiJpnerpxZdkO9Kmvg8vAsEz2AbmhbzXF1RfX3RtROSR6r/r
 IaCJT4dHWbJqxO7Y3gTCHaBU7qNTRA/nFE74Jol5bkkuUpO5l6uOGc5VVc0a4Qh4zldbq02r8AD
 Pi28ozOAKWbFc3ENnig==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a69e261 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AospXY2Czllo1zpkj0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX4iaIoZGgboiu
 OxHfCPDTuPvFO41MbaLMhSHIu8Ya7rTUZfKUXr5+f+HxDzdfS4BIzpTWAtIgHm3aLE4PJ4NLRoC
 IuON+aFOd4Po1r2Bmm3OrKQHPV0BynI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290093

The findings will be covered in a separate series.

On 7/29/26 12:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing bounds validation on user-provided keys leads to Slab Out-of-Bounds Reads.
> - [High] Unvalidated token length from hardware reply causes Heap Buffer Overflow and Out-of-Bounds Read.
> --
> 
> --- Patch [2]: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC private key requests ---
> commit dd9e9a635152d7bae8edba05dc9b9aad02d9a1e9
> Author: Holger Dengler <dengler@linux.ibm.com>
> 
> s390/zcrypt: Validate length for CCA ECC private key requests
> 
> This patch adds a length validation check for CCA ECC private key requests in
> cca_ecc2protkey(). It ensures the key token length does not exceed the
> available space in the parameter block before proceeding with CPRB memory
> allocation.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index db6a4211a97e0..322677a8d3200 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
>> @@ -1428,6 +1428,9 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
>>  	} __packed * prepparm;
>>  	int keylen = ((struct eccprivkeytoken *)key)->len;
>>  
>> +	if (keylen > PARMBSIZE - sizeof(struct aureqparm))
>> +		return -EINVAL;
>> +
>>  	/* get already prepared memory for 2 cprbs with param block each */
>>  	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>>  				    &preqcblk, &prepcblk, xflags);
> 
> [Severity: High]
> This is a pre-existing issue, but since we are adding length validations in 
> this subsystem, is it possible for unprivileged users to trigger slab 
> out-of-bounds reads in other functions like cca_apqns4key(), 
> cca_verifykey(), and cca_key2protkey() in drivers/s390/crypto/pkey_cca.c?
> 
> If a user triggers an ioctl like PKEY_APQNS4K with an 8-byte buffer and sets 
> keylen=8, _copy_key_from_user() will allocate exactly 8 bytes. The code only 
> verifies that keylen is at least 8 bytes, but then casts the buffer to 
> larger structures.
> 
> In drivers/s390/crypto/pkey_cca.c:cca_apqns4key():
> 
>     if (flags & PKEY_FLAGS_MATCH_CUR_MKVP)
>         ptr_cur_mkvp = t->mkvp;
> 
> Could this access t->mkvp well beyond the 8-byte allocation?
> 
> Similarly, in drivers/s390/crypto/pkey_cca.c:cca_key2protkey():
> 
>     if (cca_check_secaescipherkey(pkey_dbf_info,
>                   3, key, 0, 1))
> 
> Does this pass the key buffer to a function that reads up to 60 bytes, 
> without verifying the key is actually large enough (since checking against 
> hdr->len could be bypassed if the user sets hdr->len = 8)?
> 
> And in drivers/s390/crypto/pkey_cca.c:cca_verifykey():
> 
>     *keybitsize = t->bitsize;
> 
> Does this access t->bitsize at offset 56 directly after only verifying the 
> 8-byte header?
> 
> [Severity: High]
> This is also a pre-existing issue, but I noticed there might be another spot 
> in zcrypt_ccamisc.c where we trust token lengths without sufficient bounds 
> checking. 
> 
> If a malfunctioning or compromised APQN crypto device returns a CPRB hardware 
> reply with a large t->len value, could this lead to an out-of-bounds read or 
> heap buffer overflow?
> 
> In drivers/s390/crypto/zcrypt_ccamisc.c:_ip_cprb_helper():
> 
>     memcpy(key_token, t, t->len);
> 
> Does this trust the t->len value from the hardware response blindly, 
> potentially causing an unbounded write to the destination buffer?
> 
> Also, in drivers/s390/crypto/zcrypt_ccamisc.c:cca_gencipherkey():
> 
>     if (*keybufsize >= t->len)
>         memcpy(keybuf, t, t->len);
> 
> Since *keybufsize is user-controlled (up to 8192) but the CPRB parameter 
> block backing t is strictly allocated to PARMBSIZE (512 bytes), could an 
> oversized t->len bypass this check? Would this cause memcpy() to read 
> beyond the 512-byte allocation and leak kernel memory back to userspace?
> 

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

