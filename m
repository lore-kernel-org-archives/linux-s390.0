Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF03905E4;
	Thu,  6 Aug 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041706; cv=none; b=rZZL7cbxeN/uMPH9jopc0Eex3NKp3XvULmePKMSq2MkwNWjdG5/wBmnetgLJMwOjC9ZmoTFtNWGhTEcZCuTkQVgQSjq3BRPLNe+kw6sJOUPsQJwB7EuIZW+HKUTE5RnagaVKhTyIPUtL2b5jgIUganEuUGJgEc5zbd25OZ5I//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041706; c=relaxed/simple;
	bh=0xwahGb5i2l79NVOYvowMm2vflBT9vO3VJLKSkc7mHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwbIl6jpKyLfAzfbLPoeOdyYrZkvgtAEsBA2Icy8HfJXgoJLfNzhX5Uo2sAZ3BRo2dTb1g6Mmf7VCB0QE16pOIsgKkE8vy5/5HWpPppZEKxu1H/ZDyhks0Z6IytuD/P9WUupdTtsXURT+R5AHlRt9pL1h9zUjDhgtxUrp2EWcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FXqdwXcC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FXqdwXcC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHbPc3395678;
	Thu, 6 Aug 2026 18:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=186/Bb
	ERA8DxvjONULlBJ+PmwCnLzo4uWTveml6rIFg=; b=FXqdwXcCCHulFeOGFvnAbr
	ykgxdS/4WLKs46rgjaOHF7/5ytZpiK7REtzlZtSXzodk3GahzEyafHpG8gLDatrT
	2b62jhyQ7hDu2g5JXHpQCfVEW6rYdAwRaYYAGGVSrqFvtvXtsS3xHOf5xywB0BoR
	Ima6zUvsnI1+JQWFN571XcBuhc7UVeHA+YqvsLSUB2IZHUd/KOorKksG3mzCxG1t
	xrhf+OJsdXUMOtiw8cKq5t6HSl9ri70m8Osv/uJLcTK9C9fOOijQpq9WQg3n+vLO
	DwGo5UEpXNxNf98TbdhNi3nsw22CM5VzuYJb04Il5MlAWX9V9L26STv5hMKQc1jw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0408g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:41:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676IfLTv003940;
	Thu, 6 Aug 2026 18:41:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kcgq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:41:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676IfaVH35652048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:41:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A19520043;
	Thu,  6 Aug 2026 18:41:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0DC620040;
	Thu,  6 Aug 2026 18:41:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.90.112])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 18:41:35 +0000 (GMT)
Message-ID: <b3740897-3bff-4163-988d-ad160706ef0c@linux.ibm.com>
Date: Thu, 6 Aug 2026 20:41:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/irqflags: add out-of-line definitions of
 arch_local_irq_*() for KMSAN
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20260806100038.3163298-1-iii@linux.ibm.com>
 <20260806101740.15764C97-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806101740.15764C97-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MyBTYWx0ZWRfXwVIQSTnjbDwr
 cYBo3u6UKfteyzQdAF4M1OEp7hBM+p9nlkU7x9BdGp5sTfC9pymLS+j4x0Q4gtKfOo28teionnY
 ae5Ck0HpjQxgmjQZqShTo3u6i8giPrQ1ZesWi4apaN9xRS+Vd9sgKRWxlI8kZw61yqsIt772m3G
 18WVsV/uxMA+QZuyw7nvTpPcCdXb/Ovp43EhA6wruPEwX16M4feY3pqPHqhVgecyRBlY/LqAjIe
 YZbYALCXHMpnSF9BJ+e2N5hCDBvf62LeYo1mPawmgW+9Ka4feOs7VB+oX32SDahveHelpVR1+Hr
 +X8Ihdu23IrC3BaASzUQjDDRtGzZ2g9Rw1FTh19NJp3FLPaaY3YGBqiAzdOd+WQbN6G8rx4zcyy
 JgSaE17pDvICnvciU5vWRGwNexQG5jjTGhG9qEfZ5oFwsE2D2rQuD9AIcFZ+V02RFOu8mNJjDl8
 UPdD7K7YC+2ZWe8Q7vA==
X-Proofpoint-ORIG-GUID: 5G9Llul1cqbIG-YsZJDzQFvDTYIkvLiC
X-Proofpoint-GUID: EYkeu6dGn1KlY-LFjKJtEeixDpVijBR0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MyBTYWx0ZWRfXwQMxbyzabgWM
 7F+TWQdSMoKC58x/v+U/ItoIlqpv/Pgh6+b+O8P3kgYJ+mAFfi6ZfKzYUdwQeEdNh3I1URsjMrU
 2xiLgnLsRoZsGd0QtNHRbgupaExBk4g=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a74d566 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=0aiZPbNK6Qv_OZgPapAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060143



On 8/6/26 12:17, Heiko Carstens wrote:
> On Thu, Aug 06, 2026 at 12:00:19PM +0200, Ilya Leoshkevich wrote:
>> Inline KMSAN arch_local_irq_*() definitions run afoul of
>> -Wstatic-in-inline. Move them out-of-line. Decompressor is not
>> instrumented, so make sure it keeps using inline definitions.
>> Make sure non-GPL modules see the out-of-line definitions.
>>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>> Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*() with KMSAN")
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/irqflags.h | 20 +++++++++++++-------
>>   arch/s390/kernel/Makefile        |  1 +
>>   arch/s390/kernel/irqflags.c      | 27 +++++++++++++++++++++++++++
>>   3 files changed, 41 insertions(+), 7 deletions(-)
>>   create mode 100644 arch/s390/kernel/irqflags.c
> 
> Don't we have the very same problem in arch/s390/include/asm/uaccess.h
> with uaccess_kmsan_or_inline too?

Apparently yes. I will send a separate patch.


And I'll fix the rest of your findings in v2.
