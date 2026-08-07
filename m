Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C5481235;
	Fri,  7 Aug 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108078; cv=none; b=FDAK/7YM09vdOcE9rhgochkRXdC8uOyKBGKGk0BlxK2kj/e9g77+qDvecsY6bTcPX9LPECXYfy1BsT8B7Jgf6JnFor0QYJujWghggXJQJCJs3IplL2kVMPHoFLY+bV9mOD4G5DDRsw6A4ap3MQdKBv4u5iEqcitmg3rE4JvPc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108078; c=relaxed/simple;
	bh=dJrZLgCeq6zO89rtUH1Mx8hET6Cv4wT4KbHedfvoeco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+E3Gn6Xe6E6jnFU2XxCKFcbrtrzMGLsW2t2kzalDS6UrohHVTTbgxcdQ4yM6AH9oPatZMa+fszvb6uEfCb153xcs74YPgLTl0ySYjXSlBYn/bbpgTBfhCQbDMqZ0AVp/iPRhFueU4DKExHbikcHNtuyTL7Oux0OwhCscw1WKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZIVhOgrd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZIVhOgrd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClqBM1420153;
	Fri, 7 Aug 2026 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2SFLbj
	HUMbsyTE5RRzIK6polPho4fTVJV5SBIzfT46o=; b=ZIVhOgrdtjdaAKQrbbZiIv
	1by7MklWDcnsKzCgkmn3OVyBjU6SbF1owuqkUUpHI4fzynkWCX64zrd2JVKd8e8W
	dKmm2TK1pbDgsz6y6p0SbbsA7KdMnGwJbkGRxOCvuiIuUnd0heXtn1o9ZhVDCBCM
	cJo1JS2PVM2gO92JLKNeCADN8KGURC/Xu5sbNLs5AVobz60andFxxjtxSFqrs49I
	a98gay//z7ap0inZwi5xrfHpQe5VOJe1uDeX9BfanMFclFjMAGi9jsW019f5jMql
	unHILm0taPvCGDluwbdZCOBcTsByu1sKzkenoo/4MfG6Uqr7iQLdzlVp0etUjOrw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy023v6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:07:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CuGSH000984;
	Fri, 7 Aug 2026 13:07:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyyjdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:07:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677D7Z7F42271168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 13:07:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9364420043;
	Fri,  7 Aug 2026 13:07:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D2A92004B;
	Fri,  7 Aug 2026 13:07:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.90.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 13:07:35 +0000 (GMT)
Message-ID: <5219b8bc-9d91-4ed6-873f-595d489da08f@linux.ibm.com>
Date: Fri, 7 Aug 2026 15:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/cpacf: Unpoison instruction results
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260807122132.3592583-1-iii@linux.ibm.com>
 <20260807123804.6A8171F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260807123804.6A8171F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IOzaBVpZNaVi0GmEC-jMT9oht-1FCWRj
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75d89c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dbhAHS79gimNbExnxjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IOzaBVpZNaVi0GmEC-jMT9oht-1FCWRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX8iB6/+kvUJW9
 nzXYO4K5O/pE2x/xUB10vHz+3JRXgr5X/T6rCbs7jnxWKyqfiF8lvnlj1nmMTBmt1v7j/22KlfO
 Dh0Pu6B3PZLycJ09k0tiBXI+OkHTNIUZMKQNEvnPpuAV148GGbU2bq/W388hBVuhplNkouQsDTu
 llrX8PrY1k7uh0JWxHAsfD3Jh2SBkNUQPYM9BS5xA32NRknVV4hcU9NBGwDPVWNQdAItDAo5c+M
 YIsbYuKfk47O50sv5ZsUNNsVOSFMLaLqGkBJPS6IqqgNgVBf5Y3wbSP3QC4PCt5VWNU3P5Ye7mg
 8yliIVil+4BQkFequhgavCJe0jbK8W8Bjfetwo0VnkzAoqxwNR7a+1w5DjM7YFyITH99C5yuOiL
 biAr+X5x7ZF8F0XkR05BjkI78VGDjYMASYKM8K8rngss3GQVRNNZJ++NQFdy9Ct8c8YAZTfw4dZ
 OyCjwKXZj75lJ86tIzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX+cefnfkrQ38c
 i9hDxnTUZzVD/fkYtNqyrQjGJ9Dk9fWA8rrPj5/pTvp0J7HIFsS5SwgAPO4/K1c+sqaGrwBWVNS
 J/Ro62L9xB8YvrYjonFw16xFsHDI69M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070100



On 8/7/26 14:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `__cpacf_qai` unpoisons the entire 256-byte `cpacf_qai_t` structure, which could mask kernel stack leaks if a specific instruction's QAI output is smaller than 256 bytes.
> --
> 
> --- Patch [1]: [PATCH v2] s390/cpacf: Unpoison instruction results ---
> commit 587dbefd826fa4c40d5401b72be74dfb37147586
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> s390/cpacf: Unpoison instruction results
> 
> This commit explicitly unpoisons CPACF instruction outputs to stop KMSAN from
> reporting them as uninitialized. It leaves variable-length parameter blocks
> for the callers to handle.
> 
> Link: https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux.ibm.com/
> 
>> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
>> index a83683169d98d..13d6a6344802a 100644
>> --- a/arch/s390/include/asm/cpacf.h
>> +++ b/arch/s390/include/asm/cpacf.h
> 
> [ ... ]
> 
>> @@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned int opcode,
>>   static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t *qai)
>>   {
>>   	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
>> +	kmsan_unpoison_memory(qai, sizeof(*qai));
> 
> [Severity: Medium]
> Will unconditionally unpoisoning the entire 256-byte cpacf_qai_t structure
> potentially mask kernel stack leaks from KMSAN?
> 
> If a specific instruction's QAI output is smaller than 256 bytes, this
> unpoison would hide the remaining uninitialized stack bytes. In
> arch/s390/kernel/cpacf.c, the uninitialized stack structure is copied
> directly to userspace:
> 
> arch/s390/kernel/cpacf.c:name##_query_auth_info_raw_read() {
>      ...
>      cpacf_qai_t qai;
>      ...
>      if (!cpacf_qai(CPACF_##instruction, &qai))
>          return -EOPNOTSUPP;
>      return memory_read_from_buffer(buf, count, &offs, &qai,
>                                     sizeof(qai));
> }
> 
> Could this regression lead to uninitialized stack bytes leaking to userspace
> via the sysfs attribute without KMSAN detecting it, if any current or future
> hardware query instructions write less than the full struct size?
> 
>>   }

POp documents that code 127 (Query-Authentication-Information) format 0
(and there are no other formats at the moment) blocks are always 256
bytes and all of these bytes are stored. Reserved bytes are stored as 0.
