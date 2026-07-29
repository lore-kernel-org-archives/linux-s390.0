Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1935445ACD;
	Wed, 29 Jul 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322911; cv=none; b=eba4+JzuMkgTDt+oSllsoJomGicJOLm4e93BcVCsq+RF7R+55wk+h+R6LjXTiCdb9zvDcLuP5cQpDee5Pa7KxIT3vCvH4tzVL/wZT+qU3Jn4VkFnEWLYCxnba0dOeCqknX5DujR1pfUDyYHzdqKPWg46f9FkLKOCh/6ILorbyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322911; c=relaxed/simple;
	bh=4Isp2CNER3u+Q+mIiimu0sA6lS9VHK0ZkGs4vtaGw34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL67SdaYkHwa3utlEZB7q9dcByYhaD3XsglEG9DxXXTWsiTrkm44jf1Bbpee6wmpuZ0dUTDl11Y6UdsAgj6udGWV6JhJ1ZdgY7oYKXb47JypYW3h7qt/FQ6kA34S9l+rbwRoZj46ltxRZ9JZZw/mnZt4RQjWGzS8e5GX5bEZuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rlyl4pVV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rlyl4pVV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7llYj3506406;
	Wed, 29 Jul 2026 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mN2b6+
	u81xwYLeultjCcTKK8R1VR8uU6banDoZZeWNk=; b=Rlyl4pVVhO/ONFf989vS5n
	as2ujlZ/loW2lN377ir6uowH4afVoorLjaOpKUx8xP9i3C2bP1p+bpsr6igFnrGc
	zRpDPEEOR8EsTCWOozXvEZh9p/q5YxwfiJbqrttsrCqLaHm8CDCIqvUAWGdG6H/i
	jSurG0HZmS3SrllAMLRLu4oqvJVw/xnNfXNEn0GThovMBmpNnqdbWqkvYv90y3dn
	jV1ii153gMstpjNTPEJB3twuvUhkv1cmcO2jcmUF41oL4il2hiO81zmmecvVZL0w
	EPeRlNED6RCfAYz42rMlkmF61A8zTQWG+YqFkvwvXrAsZqHUrvfu4VDWcJiAlJwg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9g97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:01:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TAuLGt001182;
	Wed, 29 Jul 2026 11:01:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y632m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:01:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TB1hY031457776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:01:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A71D20043;
	Wed, 29 Jul 2026 11:01:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF6D20040;
	Wed, 29 Jul 2026 11:01:43 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:01:43 +0000 (GMT)
Message-ID: <213d770e-1d10-4505-adbe-4212a65e4e63@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES cipher
 key requests
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-2-dengler@linux.ibm.com>
 <20260729095821.1DE5D1F000E9@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260729095821.1DE5D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfXwyEvoaFDmjbE
 QAYot/L1bBjLbfP+5g0tXOSrzID0NLnBDIKy3PlK372NPcOMeK4igQPkfqEsW0YaX7u1mpT+Jau
 oOb3ZQZ+p1KlB+2U6MWjKX9KffgvQ/A=
X-Proofpoint-GUID: lqQuBSIJic3FaxAff1hdzITFTXjf7I1S
X-Proofpoint-ORIG-GUID: lqQuBSIJic3FaxAff1hdzITFTXjf7I1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfX/Dke298YL5VN
 LIPqh/rmahI8kdOfjyAla68vWhjOF/DM+dkHFqHDzS3GlWD4SfCLO8tl8btQQZZ8nLd1SwJTTcB
 marXO3lg9IL7hG0ojkZdGU7YBxfQME8kMOH+M+L2TpQ8CSLgIc7RPCKl/L53SgJoNQJIQuGQzcT
 HucMFDO7NIX8RmB1dZCJj2P0jQuU16HwPxCnLojbj5meSP32iHA0pSiPNaajABCLpn6R7M/40YR
 iOS4jzo7lrtrYxCZ4JjRfJ71YscOYq72mwi0W6zEqh2lvhXzMQE4NgJ5q5tWXRxLfBG/oUcnGMU
 git1X9cZ7nb2RmudNCyyrRFaus3QoM/xcV2PEV+v6qNX6K0xDu9UNVNkfRfYOwE6Q9+tPkXZFpm
 DPbIEzws2NJasdddY5SIv9k4jcEXfoMrFh9cPdppnXs5nuornFeYKLRcrcxubY7+Z8CXaGO9ZbO
 UHl07PoDKhyOGbuds8A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69dd9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8QO6JNy322oCE5HFMPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290089

This is fixed by patch 2/2 of this series.

On 7/29/26 11:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Heap buffer overflow in `cca_ecc2protkey` when copying a user-provided ECC key token into a fixed-size buffer.
> --
> 
> --- Patch [1]: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES cipher key requests ---
> commit 7b35c8aa05e7fb7c7837b88e5f3b7fc85f721c98
> Author: Holger Dengler <dengler@linux.ibm.com>
> 
> s390/zcrypt: Validate length for CCA AES cipher key requests
> 
> This commit adds a bounds check in cca_cipher2protkey() to ensure the copy
> length derived from the key token does not exceed the available space in the
> CPRB parameter block. If the length is too large, the request is rejected
> early with -EINVAL.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 84936a795b956..db6a4211a97e0 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
>> @@ -1261,6 +1261,9 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
>>  	} __packed * prepparm;
>>  	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
>>  
>> +	if (keytoklen > PARMBSIZE - sizeof(struct aureqparm))
>> +		return -EINVAL;
>> +
> 
> [Severity: Critical]
> This is a pre-existing issue, but does a similar heap buffer overflow exist in
> cca_ecc2protkey()?
> 
> It appears cca_ecc2protkey() also copies a user-provided ECC key token into a
> fixed-size buffer without a similar bounds check. A user with access to
> /dev/pkey could call the PKEY_KBLOB2PROTK2 ioctl, passing an
> eccprivkeytoken with a large len field.
> 
> This would be passed down through cca_key2protkey() to cca_ecc2protkey(),
> where it allocates a 512-byte parameter block via
> alloc_and_prep_cprbmem() and copies the token:
> 
> drivers/s390/crypto/zcrypt_ccamisc.c:cca_ecc2protkey() {
>     ...
> 	int keylen = ((struct eccprivkeytoken *)key)->len;
> 
> 	/* get already prepared memory for 2 cprbs with param block each */
> 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
> 				    &preqcblk, &prepcblk, xflags);
>     ...
> 	/* kb, cca token */
> 	preqparm->kb.len = keylen + 3 * sizeof(uint16_t);
> 	preqparm->kb.cca_key_token_len = keylen + 2 * sizeof(uint16_t);
> 	memcpy(preqparm->kb.cca_key_token, key, keylen);
>     ...
> }
> 
> Since the parameter block header consumes 90 bytes, any keylen > 422 bytes
> could overflow the allocated memory. Is a similar check needed there?
> 
>>  	/* get already prepared memory for 2 cprbs with param block each */
>>  	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>>  				    &preqcblk, &prepcblk, xflags);
> 

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

