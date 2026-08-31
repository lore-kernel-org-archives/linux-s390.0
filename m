Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF93F482A;
	Mon, 31 Aug 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178466; cv=none; b=EhWX2/VPgYu8UaqeBgASaRkRDc5UVo964uBEESD9YOnmVSgzbucIKuAm0ZFNtduKPoOGfaSOV4OfVuozyouk/st4WRagScVOT2SIVSxD2FK5SUgxolvQ1Jgm0Gcvoo4wQE6LrMwytK5OInwjFJ0Z5HJ7jc5mdFw3MXZBpBxWs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178466; c=relaxed/simple;
	bh=azEBWLfAkO6B8Pqb3rqyqFapx7soZ0/o4+mTq1peHJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HggPa4YulGPyH7NfvLCTPs0P11t9PjTZ/tVFdtF6+aoCwElbEOWaVchEe6Opva6nltUc3RdKlUFApoecNTLUOfGxSnyK6R8gkmX1KyZ7NcXV2cknvtk6tIyTdwF5VCUGeFhHgIrxYuzevAWoDAvMLkhAy5k+v8izIwmXQMiIpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGJQBX9D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGJQBX9D"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBW73r2142487;
	Mon, 31 Aug 2026 12:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LBrGsS
	JdfvY2ecwrvS0hcETW0ul3ptQjtuFMlPB/+r0=; b=PGJQBX9D9ttefz4r3gMOut
	qqpC2YMF2xtfB962r2m1E3jnjdycFB7sMRSWyM/0BeYc2XNUUT2POd2P+GToujkC
	RWixrdecde4fPKiwJV2KXyAL2wEVi2blSlgZRekuA3jviE2NiIUvkTwbeXm/wbm8
	OrerWn5RIxJw6Y5gtxGcOlcfcc78MJnU8Afbr8YJrIJf9YCRC8W6+OE2R0UTqg79
	S9n7gwC3bdJnDPXNs+bLHQf3rEqyTCvGo8FzuUVwQMuBCXA2C2pf0zqVNmuNhtJR
	iTdYfBCLxXCEWFqjmmXektwZ3HgqkKT52qp7YTTxtQ3WEXAmOMBBulcTEtgubVjw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0xbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 12:14:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCBIXi017166;
	Mon, 31 Aug 2026 12:14:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vwtw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 12:14:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VCEJiI47317356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 12:14:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F30F2004B;
	Mon, 31 Aug 2026 12:14:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A02620043;
	Mon, 31 Aug 2026 12:14:19 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.4.184])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 12:14:19 +0000 (GMT)
Message-ID: <43d49c51-0a9c-40fa-8967-2439331972bc@linux.ibm.com>
Date: Mon, 31 Aug 2026 14:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390/ebcdic: Add character classes for the
 invariant subset of EBCDIC
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
 <20260828140057.1728173-2-iii@linux.ibm.com>
 <20260828140945.EAA981F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260828140945.EAA981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a957020 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fjRjbmclWrV-STaFBfAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX32+nnqd2KUo4
 A9swljJu/mtjr6FejBT3+FasMBx3f+CanSFowytrAkfKlXxZp/saDI0Jl5w21DGOHqXHsZVmXGE
 w3vkD9NMTZm+f3RmrsEYEWlOkVbRNC4=
X-Proofpoint-ORIG-GUID: uUpb2QZS9Su09G5tz6iy_hwiuEfuBvyR
X-Proofpoint-GUID: uUpb2QZS9Su09G5tz6iy_hwiuEfuBvyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX0tYTs20JXyOq
 P1y4b4eZvCVfAzjzPz0wMcVylamVa8OCjh8v8yyhPtwK5NUca72mWq831YdPQVLQ+gY3R1woClo
 U6bGM3grKz1fUVQSolGhWGAr25f6QF86tYlNnWivuMnsTTDW8Jn8V1ILPyr3hkiQmumSx60lL6f
 9FTF7LrO9MnBcM2p7gbDXNAusy34srjjAkwWhGp0RNtcIr2rsecCkcWe0t+VSTKLOshVoU3561z
 BrXY+mwO3e2h5HEuhp/oT5g3PoNslv++xCJ96UMii2UPp0ugkHSrloMYJwrO/fWqF3DZcgS55SY
 BUBo3pSHM2orExyO0sokmMqnOGTpQzFwvwDz0RmyjaX2n+Wyli0nA07WtY5qGIlMpdFM1KwanJm
 EDcYBhDalCP80PkQ4tlt9a2imHwFNT2BxUNxC5XqDwDz5NIutHqN0LApbRZwnBQ+QloQTYL8vBe
 +39dMbXrxdXxzeXQNkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310104



On 8/28/26 16:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `_ebctype_inv` maps variant EBCDIC characters as invariant punctuation, violating the definition of the invariant subset.
> --
> 
> commit 4c4158381dc4e63b906d199cf0d49673aee1a203
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> s390/ebcdic: Add character classes for the invariant subset of EBCDIC
>      
> Add _ctypes-like array for the invariant subset of EBCDIC, which
> consists of characters that should have the same assignments on all
> EBCDIC code pages that use the Latin alphabet [1].
> 
>> diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
>> index 0e51fa537262b..15cbb0b42aa6e 100644
>> --- a/arch/s390/kernel/ebcdic.c
>> +++ b/arch/s390/kernel/ebcdic.c
>> @@ -392,10 +392,48 @@ __u8 _ebc_toupper[256] =
> [ ... ]
>> +/*
>> + * EBCDIC -> character classes
>> + */
>> +const __u8 _ebctype_inv[256] = {
>> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x00-0x07 */
>> +	_C,     _C,    _C,    _C|_S, _C|_S, _C|_S, _C,    _C,	/* 0x08-0x0f */
>> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x10-0x17 */
>> +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x18-0x1f */
>> +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x20-0x27 */
>> +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x28-0x2f */
>> +	0,      0,     _C,    _C,    _C,    _C,    _C,    _C,	/* 0x30-0x37 */
>> +	_C,     _C,    _C,    _C,    _C,    _C,    0,     _C,	/* 0x38-0x3f */
>> +	_S|_SP, 0,     0,     0,     0,     0,     0,     0,	/* 0x40-0x47 */
>> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x48-0x4f */
> 
> [Severity: Medium]
> Does this array incorrectly include variant EBCDIC characters?
> 
> 0x4A is mapped as _P (invariant punctuation) here, but isn't it a variant
> character (e.g., '¢' in US 037, '[' in German 273)?
> 
> If a kernel command line contains these bytes, they might be incorrectly
> accepted as valid invariant EBCDIC.
> 
>> +	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0x50-0x57 */
>> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x58-0x5f */
>> +	_P,     _P,    0,     0,     0,     0,     0,     0,	/* 0x60-0x67 */
>> +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x68-0x6f */
>> +	0,      0,     0,     0,     0,     0,     0,     0,	/* 0x70-0x77 */
>> +	0,      _P,    _P,    _P,    _P,    _P,    _P,    _P,	/* 0x78-0x7f */
>> +	0,      _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L,	/* 0x80-0x87 */
>> +	_L,     _L,    0,     0,     0,     0,     0,     _P,	/* 0x88-0x8f */
>> +	0,      _L,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0x90-0x97 */
>> +	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0x98-0x9f */
>> +	0,      _P,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0xa0-0xa7 */
>> +	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0xa8-0xaf */
>> +	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0xb0-0xb7 */
>> +	0,      0,     _P,    _P,    0,     0,     0,     0,	/* 0xb8-0xbf */
>> +	_P,     _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U,	/* 0xc0-0xc7 */
> 
> [Severity: Medium]
> Is 0xC0 also a variant character?
> 
> It is classified as _P here, but it can represent '{' in US 037 or 'Ä'
> in German 273.
> 
> This seems to violate the definition of the invariant subset and could lead
> to missed warnings for garbled boot parameters.
> 
>> +	_U,     _U,    0,     0,     0,     0,     0,     0,	/* 0xc8-0xcf */
>> +	_P,     _U,    _U,    _U,    _U,    _U,    _U,    _U,	/* 0xd0-0xd7 */
> 

This is a naming and not a functional issue. The IBM037 punctuation
marks must be present in the table for the series to make sense.

I guess a 100% proper name here would be something along the lines of
"invariant with IBM037 punctuation" or "IBM037 without weird
characters", but I don't think it's that important: one can look up
the Wikipedia reference in the commit message to get to the exact table
I used here.

I will defer it to the maintainers, whether I need to change comments,
names, or the commit message here.
