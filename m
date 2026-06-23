Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188B2222A9
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221160; cv=none; b=XtIh7fHxcrW9c8YYg53fy9wHlthICE7QO6yOJ/q8x14ZF6cY9i5FoLfJJw3v1xPR57wfLbXCKgxNjgWk6yj3CT5+eh7W47VFg9OyxlAPqJC5D6pdgS10U5KlR7+H1RnEYQKdzd4SGeGJakXCbkSL0p69nuT2oEvLadDrUNgoDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221160; c=relaxed/simple;
	bh=KGvsBf5siKrTQ+/zo8UAHWmgdKgnzn+94KQIIeIavJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGypyWaALS++7F05iI9EuDbe17g4DO3/1sPNM+B61jmIYlK7uDYrcuNKSHcZCbbgvZWueFyXaoDHLyI5tiIVSLB3WfSGcXVBlXwTygYlh3ttNyqSFLvWwQYAyG73LfNgw2GR7V6S1OXSo0T8JuHeObAOztyg4xcsF5vhnyGcTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QsH3C11X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QsH3C11X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmH2f1983822
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W+7ABA
	Lcu1TKsWmU1DCgBg5t1bdYe859tU4Kt43g97Y=; b=QsH3C11XCg7CMXG7abh28q
	YotTUXJeDnedcssPbEn8jaLd26b8YW6r1BEk3qAf1PL4/TMyqRWsNcr8Nt06aOeo
	azTLPrgOwnAWjltCdrs88Gi7KaVfuXBB1FuBPLCAs0DDgn/4z0aBv+Y/B48fJs5h
	2gKNp0v4tFrQXVLB0nUz8FNoP0Q6PO8+VosXxr1D+wcoUImNvbjw3AWcMpHA5R9F
	6o7THqESoJxQIEC2BCRRUopipQS/EU7nA+ij/nL3RRkKqpfGEZo67FdK1cGtYZ/3
	C32yBjothDk/FOjbZPFp9ua+9tfuHrXawJKrMd93Hrn69th/xRe796jLe6zDGlWA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3ernt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:25:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJgsW003357
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:25:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyk4bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:25:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NDPpPK26411378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:25:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD61220040;
	Tue, 23 Jun 2026 13:25:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C99320043;
	Tue, 23 Jun 2026 13:25:51 +0000 (GMT)
Received: from [9.111.10.197] (unknown [9.111.10.197])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 13:25:51 +0000 (GMT)
Message-ID: <989332c2-721f-4e6a-b067-158b905163b6@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] pkey: Fix for PKEY_VERIFYPROTK iotl
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260623102016.3930343-1-dengler@linux.ibm.com>
 <20260623102016.3930343-2-dengler@linux.ibm.com>
 <05c89f53-760a-4014-bdba-6aa58d86c7cf-agordeev@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <05c89f53-760a-4014-bdba-6aa58d86c7cf-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a8964 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LqqE7Pt_1AgKCaewVQEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXzZIS+BT+pBo+
 kndQ7JkufWXixofnK/Q0JipeYNQPXwDfazuhMs73i2hziQsGHpDzN09/YfY//tj0ibTH1BL47j5
 qXNCaA1fUx1IccprdnxzTzSazIvayBE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfXzFY3bjKpGZEU
 BafaI9BblYvhKCU+iM04VechmBaHcvVoYkFNtQeu4t1qLyQn3x91syChS8RyFLfutdM1mIJAbI5
 ulgDy6oHxlU5ynXbSeXqh7aRCiTgbKueTkhsefAGheDVvbsUq3beXIFH+E7qXKL8FX35jBVlmbA
 7kqQ7NH1ZirNQA2dKmvnvX+Nejzt/flYShb22fDkXr1yuH47OoMdMsjSO/Z0H1ZovNzR3qM5jOE
 LGxIAftf2PB53XnS4uxL/j9xpvZHFLas2DHbRb128FWxV7chMM4NnXVyrE2d9Gdsd8UwdNYs9lb
 78JfjRBqtRBLcWa8or+wtYRx2KH5H9qbKt33RToyIKO9yeCYk6skpBqnrM6UQAFvoSN5AYf0s04
 vjyJIwDYo/rNhZwoq8OiVWfUY+Gh8w==
X-Proofpoint-ORIG-GUID: uPyK_D3B2WFA0NaAcE7q-mpCVTbITze-
X-Proofpoint-GUID: uPyK_D3B2WFA0NaAcE7q-mpCVTbITze-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230109

On 6/23/26 13:13, Alexander Gordeev wrote:
> On Tue, Jun 23, 2026 at 12:20:16PM +0200, Holger Dengler wrote:
>> Remove the keytype calculation based on key length. The verification,
>> including the keytype check, is the responsibility of the pkey
>> handler.
>>
>> The removal also fixes a bug in the key-length calculation, which is
>> now no longer required.
>>
>> Cc: stable@kernel.org # 6.12+
>> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
>> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/pkey_api.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> The patch description is too indescriptive.
> Could you please suggest a more specific one?

Sure. What about the following:
---
The PKEY_VERIFYPROTK ioctl takes data from user-space and verifies the 
contained protected key. While checking the integrity of the ioctl 
request structure is the responsibility of the generic pkey_api code, 
the verification of the contained protected key is the responsibility of 
the pkey handler.

The keytype verification (based on the calculated bitsize of the key) is 
part of the protected key verification and therefore the responsibility 
of the pkey handler (which already verifies it). Therefore the keytype 
verification is removed from the generic pkey_api code.

As the calculation of the key bitsize is currently wrong, the removal of 
the keytype check in pkey_api also removes this wrong calculation. For 
this reason, the commit is flagged with the Fixes: tag.
---

> 
> Thanks!

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

