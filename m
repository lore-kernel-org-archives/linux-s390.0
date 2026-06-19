Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8C2C325C
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858643; cv=none; b=hbL3rNquzFt6plxMQgju/7flrn9o6VrpCadb9KLGDNAkqLma8LSA5bxpUbU+0umxzNw1OBatpt5Y3aafag3UVY9VQOyJn7/41A1lMgoqRq3Rt17/DMzLn6v2kLHURFn2DRqCTf37QndURS41RR2EXcAIzZiy6VvBQ5rNjT8L8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858643; c=relaxed/simple;
	bh=S8qCxOhQFuC2PPSznthdYeYm/NelGQm+5B12sKRvUZk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D+SpjwKrJlnkrBI67CzncP2LIOtWv1OysMhv83eYIv/DFkeKNln6juWTpYUOTzgDrH6OzF4QZivlaTzp6Y9k5sKxz9VdGdgQga48RE2LhGk3ZxyFkRiE0KVxBobNfCGWBCQDLlpHqUXPPE6hDhrlokoSKIE/RffjEJJLqWBlLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jnKCdr0n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnKCdr0n"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mQGH1674590
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=HlSoISH3YaZ902sJN6y1S1xd7kY5SuVQ7QJx+XIxGY8=; b=jnKCdr0nwS+C
	obbE5PdPup6JfCWWIrc+EW1Xwjc4LS3O/bRjWShcWEcueNcDSVsWLCWnWOnZWs7H
	rxCovkUJ+I5atbi/7kg0G9q5mlZSRjI5bSyLxppVE/THtEX2H5cz0afvR5uELeJM
	CjxEfcECab/k1vmrRmkC7MISIB58GaMcstWxonX3C5BmwgU70/lpCFHBI1/FJgpc
	i+WvGCpLhRPhsv/45pv4I51qvJ0HlvFKyjigH77KUpokpGn2Hp6J3JcU/ma64zKJ
	PseiJuaxFFcJPr7aHjNZ2e01/uQbehAitaYEvyKGgvmLNAjvcSigTisSCeRroyAK
	4TLl74xBtg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw4mc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:44:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J8Z2Vb015947
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:44:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fyhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:44:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J8hwP218612878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:43:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F22058054;
	Fri, 19 Jun 2026 08:43:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56ED5804E;
	Fri, 19 Jun 2026 08:43:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 08:43:57 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 10:43:57 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ingo Franzki <ifranzki@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
Message-ID: <c701bc8554683dab75d5fcd95f01175b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfXyZ5BcYp6HlwI
 AwWHBHnn5E0JWaph7FEse5JKZ3RDcYfBdeUlipbFLNOw+YRS8bI0BbvpNCASB0V3imEEsDiqo70
 c9HzRzEEqmEng0rBLQAtRHUdHDSF0XE=
X-Proofpoint-GUID: aqqmTmlJ5uSeM4XYYaUSTJ_0kvuKxzMb
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a350151 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=s3SrIzr4Emr5MCFJissA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: aqqmTmlJ5uSeM4XYYaUSTJ_0kvuKxzMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfX528n4I9ieI0G
 K6CjIeQCI8ABACINt628VW9a+agzjlKtGi8rk9QdiDeUDMSr1hgLobB7xMbCdDxoIq7QNprqt5O
 r3qU++nnjJ+vq+5tGmJrlk5Wa1GeZNpO7jH9IupENzOeG0HJKrPqo4EfEVSNLIKBRF7oDQOIpxU
 3ouskMKNTn1s66pDi9VBh6PnpJFYdLKtyEer8yBtc1aozzsiQc8ZiSDFZIzPLMDZmwKm+oDvgeo
 Jg9485d29iMmBB8+Jrhc1vya6QNnn1St06B+8Jx2f15gRUZa/oc3LtznIRvVwYze7uJtovTF56W
 OxES1tbPASBmusYcO75/DfHBJNiaAjAQ7KHJGosYj2upvE23bRQ/8jiNh3iDwPgy9atcAETdDTC
 fIE3w2tI3u0ZBwtjHWPKwLj5S2DBrwpT4Wql2+x5/0n8kZy9JZKSiaGhtm49/kFXW4+sXsWx8co
 iwBE4bW4Nd12WsSerRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190076

On 2026-06-19 10:32, Ingo Franzki wrote:
> On 19.06.2026 09:45, Holger Dengler wrote:
>> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
>> supported keytype, which are derived from the bit-size of the key. The
>> calculation for the bit-size of a protected key has to take into
>> account, that the length of the protected key blob also includes the
>> length of the wrapping key verification pattern (WKVP). Subtract the
>> length of the MKVP from the protected key length fixes this
>> calculation.
>> 
>> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler 
>> registry and handler modules")
>> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/pkey_api.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/s390/crypto/pkey_api.c 
>> b/drivers/s390/crypto/pkey_api.c
>> index d6b595eb3370..2160e1de3014 100644
>> --- a/drivers/s390/crypto/pkey_api.c
>> +++ b/drivers/s390/crypto/pkey_api.c
>> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct 
>> pkey_verifyprotk __user *uvp)
>>  	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>>  		return -EFAULT;
>> 
>> -	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
>> +	keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
>> +						   AES_WK_VP_SIZE));
>>  	if (!keytype) {
>>  		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>>  			     __func__, kvp.protkey.len);
> 
> Why not simply use
> 
>      t->keytype = kvp.protkey.type;
> 
> and remove the whole 'keytype = pkey_aes_bitsize_to_keytype(....)' 
> thing ?
> The type of the protected key is already contained in the protected
> key structure, so why trying to guess it from the size again?

Not sure how this comes from. However, as this function anyway is only
valid to be called for protected AES keys I would stay with the guessing
from the length.

> 
> You will need a length check for the 'memcpy(t->protkey,
> kvp.protkey.protkey, kvp.protkey.len);' (regardless of how you
> determine the type).

As you wrote, the length still needs to be checked here for <= 
sizeof(t->protkey).
