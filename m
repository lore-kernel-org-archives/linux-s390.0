Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D928DB72;
	Tue, 13 May 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141125; cv=none; b=rqC6FbUU9RjDelPwBCmZsdi34tuo8dDX26z4aZm4OBtPFpxtO6eQHnqH3L9uCphkKUkyRqO/K9He9dBB98obGy3jPjpSCcMJZbrL+Dq7PMgggWtjyZzV11NWcX4p17O2GF1mLJXd7aEQhzOwNdLAtBtsYjP24GugyqORTvTzRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141125; c=relaxed/simple;
	bh=2xIaivkbZl7DdZBmxs97N/RKaoCOHaz1NNoE7jjdeNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVp1YIL1jwUt21rf7/Jy1WvrH0+s7Z7s6Ku5uIfBV3j8nLs0JZNA7G1aALAMKG5zu61825BghByJFk3mbhjF41LYE+XScuFKxBJZhCSxRasZ6t61gRLOlbSkMT1eJKdC9QV1qbbDTiWOr26PiiIYKdI37Cnlca36vhfeXjFA5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HJa03EcJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HJa03EcJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7edHg019138;
	Tue, 13 May 2025 12:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tp3MLZ
	KG7W7RFaoIcRBdhZwY4PyTxg2MSIoSNLmN+6A=; b=HJa03EcJYRaNtIVFYivMYr
	komzX8EKc63Ha9FbmMMb5wDjlMjrELWY8WEWFC+1JXbexmwzu9uGS4eYgkCKfor+
	MKfbguq5IiMxw270kSknPt36ztpf+KGduMJ0araV8iixWKKTYi3Zc5vGgW2z807f
	14MtIu7b1JSbRZXus136GD2KxxvQlpBVo3bos920p8qE6MJ6SnKE5GQDes/eJZK0
	++I/qpOaeaBus/eRqmP1qQP6LBpOTaMB3+B85VcrClSL4O2x6KORAXYKhUkXc2XI
	ifFz7+rnV+BlpOvKkCn9ghJu1JAeGHcTKMm1cFVpsHWYMrQT/S2+laMOSifAXiWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kpp7c7qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 12:58:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBG55W003781;
	Tue, 13 May 2025 12:58:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkjwha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 12:58:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54DCwbx528312126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 12:58:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB655805A;
	Tue, 13 May 2025 12:58:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B472858060;
	Tue, 13 May 2025 12:58:36 +0000 (GMT)
Received: from [9.155.201.30] (unknown [9.155.201.30])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 May 2025 12:58:36 +0000 (GMT)
Message-ID: <3bd33a06-f8e2-4901-ada1-e970d18afcd4@linux.ibm.com>
Date: Tue, 13 May 2025 14:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 10/24] zram: add zlib compression backend support
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
 <20240902105656.1383858-11-senozhatsky@chromium.org>
 <6046d139-2a46-4824-bdfc-687750c1ee5b@linux.ibm.com>
 <gekqwhcpombpm2u3b4xl7zladuyzbxybeq5wcwt47k7tsgo4bh@rfrxaeqwzypi>
 <df805c0e-bf25-4cf6-9601-aac594fa0f45@linux.ibm.com>
 <uaxb7sbvrg3eqn2sp66sg77urjzr7jwi2m2bwigvj5n5cta2xu@qsks2da3zrha>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <uaxb7sbvrg3eqn2sp66sg77urjzr7jwi2m2bwigvj5n5cta2xu@qsks2da3zrha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OID9ya9tM6jNP4UBa0tR3CjUMnw5YYIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyMCBTYWx0ZWRfXwGe/IBl2fgcA LUPgZKVmYN1EYSp06KyPYbiP2liaz3/zY5INM/bhLx2YB/gR2WUFwlzVhc8DNAd054HkNrdZmAm GyDTww2ZDW2t4dRGfr0LE/CQZ9mRNvwBf0KPyLUlX+0OYGQhmc2wOzZV9jy9S/TnM1zfml4imh8
 KidxaUGHzUEtMxl3PmnjaM8nuugB1w3fbFcgFklbT3IVCWMHE/boSnU42Nuuw8FrygyYetTCQ5K OTKIrM5hqeUy7BIk5gbyjDRcGeXsYdap5UQxacPEpQYwDDQNTm+gIEd1bahS+nKKxCbT5htPDR3 DZ+imPRTlLbKbqxYXkmPXXTlJPgGE3TGU3hOtcmik2punG7aQWgnPxS9RwYQhbWRtkWlSHpwwT5
 KjS3d57a+eF6uTfB6GRyCzCBhyAdflr6w9lJiIh0ltT99ZI0mmT5dZLR+Tj5SUVEaYosdz9B
X-Authority-Analysis: v=2.4 cv=ZY8dNtVA c=1 sm=1 tr=0 ts=682341ff cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pkiKMm3ovRzUbvQedLsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OID9ya9tM6jNP4UBa0tR3CjUMnw5YYIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130120

Hello,

On 13.05.2025 07:41, Sergey Senozhatsky wrote:
> Sorry for the delay,
> 
> On (25/05/09 17:18), Zaslonko Mikhail wrote:
>>> When zram transitioned from Crypto API (scomp) to custom compression
>>> API I picked the CryptoAPI deflate DEFLATE_DEF_WINBITS value:
>>>
>>> crypto/deflate.c: DEFLATE_DEF_WINBITS	11
>>>
>>> which is then passed to zlib_deflateInit2() and zlib_inflateInit2().
>>>
>>>> I tried to build the kernel with DEFLATE_DEF_WINBITS set to 15 and
>>>> verified that s390 hardware deflate acceleration works for zram devices
>>>> with a deflate compression.
>>>
>>> If we define it as 15 on non-s390 machines, will there be any
>>> consequences?  Increased memory usage?  By how much?
>>
>> On s390, setting windowBits to 15 would lead to zlib workarea size
>> increased by 120K (0x24dc8 -> 0x42dc8) per compression stream,
>> i.e. per online CPU. 
>> On non-s390 machine, that impact will be about 115K per stream. 
>> Increasing window size should improve deflate compression,
>> although the compression speed might be affected. Couldn't find any
>> relevant zlib benchmarks though.
>>
>> Not sure what other consequences might there be for zram. Do you see any?
> 
> The increased per-CPU memory usage is the only thing I can think of.
> I guess for zram we could turn this into a run-time parameter, but for
> Crypto API compile-time is the only option, I guess.

With 'run-time parameter' you mean adding 'windowBits' as another deflate compression
algorithm parameter for zram? Guess we could do this, using default value of 15 then.

> 
> Can you send a patch series (for zram and Crypto API) that sets
> windowBits to 15?

I can do it for zram. Not sure if Crypto should be changed as well. Or is it
supposed to have the same compression defaults as zram?

Thanks,
Mikhail
