Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40A41E6C4;
	Tue, 28 Jul 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233635; cv=none; b=hVj1YfjwOJHfENM9h/ELsT80Ja/rQqyaommH8RUAqd/GiyJkki9opLGjeiMzFr/zHXrOOJApCVDQ1FGI7swvolTgO6/29+V+9qxuRqEqeW62UDCKccJgqCtkIcUzzzWZ4iuESR1KUbwEq+fA1+mCouw6xcDk5ASE6dCnOL1zoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233635; c=relaxed/simple;
	bh=roihhmV/KuXAPFGLQkWJEIMky73WYz72A0NtvpF5Nfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as0y3tJOKxooYwO3SEj6cXJiHXSK9aR5rwm9mKTgJcM19Aygfahhm1T+07RX0dMC1uZPNsplMdBuiTbG1Q/VfA3wcySil0EDa8cbq9lIRHLAyuei2Pmo12JiWfWtiYOZPzEKWTUuwlKyO/d5lo/7bVsttH1Zqhr4Uv8lE8g+m+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GpRQpOWU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpRQpOWU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8HkQJ404897;
	Tue, 28 Jul 2026 10:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8XpQTG
	4/JT6HenoyfhiMZVRbm5cs7MuTDf0QErL059Y=; b=GpRQpOWUp4+2oZv7lYAuTY
	B8K49o5mdBt3JsCQfiCBlu7aICZbHLpSvwZSJuH6tpcXLT7c56vsCF4OG/eFvWgR
	Fa0qQG63qsPyJPPD15f3Z5dbY1ew6kADOyUha4dEEVRB5YaITh5+QZlcYiIaP71F
	qAOWtVGDBchLMXCtJn89dtEklf36KRgCKq01EJECTtKUJXJsaD9ZBboZ5RbaQXe+
	6OUAvMg3jw5oTyRGns7psgNe3R5BXcwKwzTlMNrZg6EIBqH652zC/kDODmNkKiMr
	nzeiIajfrr5pKXw6Sv5XAvgD2XZlA0xoe6Q2Fa1coQc1GedhsJD8At70BqPpH0DQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nm0w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:13:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SABF0e007110;
	Tue, 28 Jul 2026 10:13:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk1akj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:13:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SADYwp31719854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 10:13:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0540220043;
	Tue, 28 Jul 2026 10:13:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A467220040;
	Tue, 28 Jul 2026 10:13:33 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 10:13:33 +0000 (GMT)
Message-ID: <6b856add-646e-4e44-a0f8-98670fd6d663@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:13:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] panic: Introduce arch_do_panic
To: Bradley Morgan <include@grrlz.net>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
        borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pmladek@suse.com,
        sparclinux@vger.kernel.org, svens@linux.ibm.com
References: <FF4C0015-29DD-480C-8905-E9594659521E@grrlz.net>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <FF4C0015-29DD-480C-8905-E9594659521E@grrlz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NSBTYWx0ZWRfXy2EMj1vTDv6L
 Hg6rlkZHIwRssRY49CVlt9CZKjhAiWUwiZowwJl1ZBb1v6fhmbd9wOEafXSlJG0o8n4JjtBUC9N
 Z4qQAgsbN+SgHgeO8Rwv0+dAKZYdKJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NSBTYWx0ZWRfX4XhAOb1sJ9Ej
 K7yrl7Kkte0mGY/1gC68MMbpvWfCCqb4A1UrwPbwBYyE9oTNyTK9q4qwWxTER2SqKumwr7z/PPv
 jHPE2zVuo9lzX4IlXZ7zi1dAb/Biy5GV4cYSyOlHrf6Q6/3AMzHzptE33qnht9tvB57vNw5SM7r
 8emOGN/66SUc9bi5wQAgDt0zSJXsKZ/wgdqWavXwdUsSBG43cApnK0jwti98kByuH9hcWPX+NBR
 lfsxecLROqGygAPBSf4B3PAQ232wY8cerKytLFQJeQwLBpb6+FTDhZFd+C4zuuNdf2DQu8KZsZ6
 ucZEPtGbw4CGsBt5ZlJL6DvAxT2OunA6+SrUD/KLQY26+FVzSHqFFB4LK4QJF752IBSxxt9YpL3
 ReT9eGnWLa0YFBdP0kCIKzfpS5HKXSJ9rxVLXnYkubqfdxquejdBc6uajDixAEjoaHf2Nuznh/2
 8iyIIuGlD4zeSH9+5Vw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6880d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=e9N-MU80HfMvdWsBPgEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1I5N1iDypNOqUmFAxfshBltYuO6bnT0c
X-Proofpoint-ORIG-GUID: 1I5N1iDypNOqUmFAxfshBltYuO6bnT0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280085

On 27/07/2026 14:59, Bradley Morgan wrote:
> Hi Mete,

Hi Bradley,

>> +#ifndef arch_do_panic
>> +#define arch_do_panic arch_do_panic
>> +static inline void arch_do_panic(void) {}
>> +#endif
> 
> this is fragile. the arch override only kicks in if whatever header
> defines the macro happens to be in panic.c's include chain. if it ever
> falls out, the empty stub wins silently, the arch version still
> compiles as a global nobody calls, and the hook is just dead. no build
> break, no warning, nothing.
> 
> use a weak function instead.

While I acknowledge the benefits you just listed, I got the
notion that maintainers don't prefer __weak implementations
and instead opt for arch specific override via ifndef guards.
Therefore I wanted to start with this approach.

However I am willing to switch if the maintainers would favor
that approach.
> 
> one more thing on the call site: arch code now runs (and prints, on
> sparc) after the "end Kernel panic" marker, which until now was the
> last line anyone would ever see. tools grep for that as a terminal
> marker. probably fine, but say so in the changelog instead of leaving
> it implicit.

Right, I'll mention that. And by changelog I take it that you mean
the commit message, right?

> s/already has/already have/ in the changelog while your at it.

Thanks, I'll fix the typo in the next version.

