Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4C43D4EA;
	Wed, 26 Aug 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753339; cv=none; b=P2BRA5DX+xs/FpIv0cjSwtFte+AgC89kqs9tpXIoOd1bySUg4s6ZM2otZIAOcgsfSxOzdIeAoplJBxqFsYe/e1H5nKR0gynmZC+NwIRzJlRLS5g8FN0G/F3xFlS/B49WRKdi1gtyvHHwD+gWqUBy4bBmhGu2n13XbcfnMLPivZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753339; c=relaxed/simple;
	bh=j146Rjva9H0xPpQpg6NTtr4PEkb3NR4a9OiOa24+IX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd/K6n5ns01OKK9K4QqaYDwGjQXimRIVsP51W38FuJ90CkxPnwstuljB4B5n4h/lLz/JphhF0RrGvAPyO7CiMUCH4dcn2ZOoKaXB/HLg7kn6BAqicxJMJ7BdrqXngJtvigOy73G5YecM2SKqzHUBVvIMxVkhY6xsD7SvV9prZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h+6rSAsd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h+6rSAsd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1VQK2333695;
	Wed, 26 Aug 2026 14:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W9bs4t
	SX9koJrNl1ic+aTVRu8/+piiCjEUKzzQpwf2Q=; b=h+6rSAsdNaBoy1uzYKcovU
	KYcZEK805JNtduza+Z+R4dTSP8QPL0tUnPLXNIJyWt4ZNeqOU9SJ99l7TVrK40id
	ANjlZgwuSGFtyzHwM1IQ5o1nzRIgHwLZENzGFBxW7Lt2Mo1K5nOLgQziI2VxdZTT
	E9lQNrND1gumZ0O0bjG7U2VMQGw7NuYZt2kVmeuowW3Nxht+OmbsgLAfw/fpDs45
	t6ToMKqvSi1sL89q8PMr01ysA79jZ8fsfb/GVYp/yOOYz0jTzbGp070kS2YMaQGg
	9hQ/uf5utgoPcN8CecmXojv77xAi/u1ZXKA5KmqkWBG5zsejjUxDEGlC3MDcxb9Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqy2kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:08:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QE07gi010515;
	Wed, 26 Aug 2026 14:08:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2b3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:08:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QE8pVD47382884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 14:08:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1052220043;
	Wed, 26 Aug 2026 14:08:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9C020040;
	Wed, 26 Aug 2026 14:08:50 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.55.210])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 14:08:50 +0000 (GMT)
Message-ID: <4ed90c1e-0edf-4d12-b4d7-d439a8113669@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Warn if kernel command line contains non-printable
 EBCDIC characters
To: David Laight <david.laight.linux@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260825150840.537653-1-iii@linux.ibm.com>
 <20260826145129.204b6517@pumpkin>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260826145129.204b6517@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: h4B-JFj1JDp2gFDbwSWVZzFOv9VNhY5M
X-Proofpoint-ORIG-GUID: 6Ogj8i4bkQC0w-A16SrU04yGhNeAFInK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX0bAccMjhUxiq
 CZf1dbPYRflINWORUmUWedQKbzYf1euJNN2mPcWdxNMSD1I+tTwbz0RvxyCJ556Hlf65oKzeGv9
 sdsd37OPMZ8pfWiTeGMEeRhmYo2+sek4KTzfF4Xi2+GQ4cLiCRANqkNBBb4tR8vMm0LQYHw8uCr
 yBgfrNrbDctPRP3htAEvpEiVjgv9FC2wjLWWYLq0SE7G9tX+mQoZGz7EaPYhQpskHhLFu6qchQd
 ZZqELMj3so0cKJEKG+ZlZxzPISdyaMj9bnZPcWBD9vf+QuayOhOjGHzw7d5VfvBuZbALvKGNGZJ
 ISkUGk0tD3jyomrVTCv4pppSvMK8Q15YVlhqMTZLBIaVXOPO2GwBzesUDPZhu/VXvEnsvOIdxTi
 rmH+5MJb+LqJ2l8C4M2U+8A2jB5RecbcsrGi8KhSxkSa2gUjYxbHlQ/AELbKbhMS3pIVGk5MQeG
 SA9Q37r85vda8YxSE/g==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ef378 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KXNLNQijgZOW-xrDOuEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX+w+WeMvcKYrY
 uqiKoUlDh7TxLMmIVBJINBr0dOYZM+XgDWwQt9GhtcydDjD2e5tQ9rUiG8ryuQfIho++2fEeF+c
 M0Hz88ymqqPTq/vs/c8BeYQ9MW6sUe4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260116



On 8/26/26 15:51, David Laight wrote:
> On Tue, 25 Aug 2026 17:08:08 +0200
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> 
>> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
>> parmline, for example, by copying snippets containing non-breaking
>> spaces (\xC2\xA0) from web pages.
>>
>> The kernel will then interpret the entire command line as EBCDIC,
>> making it unusable. Distinguish this situation from the legitimate
>> EBCDIC conversion by looking for non-printable characters and issue
>> a warning.
> 
> Would it be better to check for the entire line being printable ebcdic?
> All of EBCDIC a-zA-Z0-9 have the 0x80 bit set and most of 0x20..0x7f
> are invalid or control characters (or punctuation).
> 
> David

I actually started with that, but this required introducing a new
_ctype-like table (unfortunately it's not as simple as checking a
couple ranges), so I decided against that and took a shortcut via
ASCII.

[...]
