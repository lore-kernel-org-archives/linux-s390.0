Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695C477999;
	Thu,  6 Aug 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027176; cv=none; b=NmQ+hpRiu2nLApLPCw3QmcVPjeuGn3p9p2yBr67wLod3/E9pt6quoYRtFeHKrxhKplTDM5eYWNhkcVd5ea3YPKK7oN1BNfLmsgqqLS2T9CTEjJH2mHoIre3Q2O4vmvKbAiUN/DiRgnVYgY7HI1uCPAQLmCXAjAaAcGyBWx8EXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027176; c=relaxed/simple;
	bh=9F/Uq/xyvj96/U1grsSBt1mIaNmrxXUYd1WuQpsJoTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptWekgSuiGM6G7eAFE31RaYlYUJhsysNn7IZjzDRjs/kzKx5DdLzdHY21POkvi433aiLhoojj4IdP9MUdoCn7xc+5mAmVUPMaBIl9bjJp46pNZ8zstjPSGbR0wQQ+NCuP/b3JGQUpOU3yy89AY2nGN8g3akEKXiI5OlYODddzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shmZvp0t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shmZvp0t"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676DhH0E994756;
	Thu, 6 Aug 2026 14:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vLbzfK
	Ycs8AFnqn49rygHRdKSEov+6B+VOA7S1PSy4c=; b=shmZvp0thz48LonFCRhb3x
	mpcAg78h647KCuW2uXCuRZTis/bUdz8A0asiab6jUF4BXsVloLGCjJ+rT3FsQSFj
	IZncFXRwyTO59xc41381dRxGMR4pvQNYGZfvCBbgHsZNh2ZpJd15PQ/9kfi3kmSR
	B/t+ulMkIibCksN0Zn0Bty3TEgD9F3FW6gLz6uZa1RDdsmhSK7prttjmgLGbIBR8
	sROQRYbi9zHxf/QY569Xa2EK+5KlSB+2FSAWwcGKTFUpWwhxEZHXAU8D52+g4F37
	7/m+2rwGnOfxFxhggWKHFhJ6yyHn9I5+hi0HZX96H9kA7TSlYoIpzp++YMMECZYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j0e1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:39:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EQIi8010671;
	Thu, 6 Aug 2026 14:39:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qups1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:39:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676EdRgP28967184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:39:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3568A20049;
	Thu,  6 Aug 2026 14:39:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCC320040;
	Thu,  6 Aug 2026 14:39:26 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:39:26 +0000 (GMT)
Message-ID: <d32c5862-1e64-496c-bf03-5928c2ea1dfd@linux.ibm.com>
Date: Thu, 6 Aug 2026 16:39:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] KVM: s390: Fix memory corruption by not reinjecting
 CK machine checks
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20260806125241.210170-1-borntraeger@linux.ibm.com>
 <20260806125241.210170-2-borntraeger@linux.ibm.com>
 <20260806163739.7b1ee8fd@p-imbrenda>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260806163739.7b1ee8fd@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfXxpgygjYTDHCY
 C6zRBkWJO9+PrJ8ujaEaXqN5XbJfklJ1lsdCcL3GOmDyHf9wh8yCp54fOorCA+aMXgaEj3A8YYT
 oWgp5WH9y/yf0RX9XyaSESbhaBOR6KA=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a749ca3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=GFNrkfC1HkkyiMQxMSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX4Q/jBi5FSxnl
 YJHMiFPd0zfWMG1sX9e/P3/OwWvVWfhdkZLMxIjay1NKYrAtByWHW9vIiCfOeAmVBpgHgii10Si
 54ZqzFSjE2BCKOhN/wS2ePTp0bQUBBrbq1fcRDDJAvAvYpY3HVLidGqyC+hvhZjzgJKrdMilV9j
 Qf2gww6oWmTE0cye62H514yEYCgjNYDyQWgHessIMhaqTuKj/ANwBzuEAM9avy20D7ntoA1S5zM
 Hh1iL403tonwGVy5jMoRAfVp7Fwyo2S02NhBfB+sZgjvuJKgqNQl5ORt7uliEdAJCsvhMkMt+50
 9oXjw+Y3xiXaII15PXbVjzS1shkvYotbmP1vgIPX2/aRQUmqGN3fEytbnKfD/2H7g2yrRlYn7wz
 nSaSNbXrC6+PsvPklikl1obPo+yUclbXIc68dNNvvwZmUIO8e5UIzZHPQehAmRz6RKITkjLFZz+
 fVRyCC/FqDJ7mRD6nFw==
X-Proofpoint-ORIG-GUID: 9ejSTsgxTaksRGaUSMCsGJSU3KjSvUTC
X-Proofpoint-GUID: 9ejSTsgxTaksRGaUSMCsGJSU3KjSvUTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060112



Am 06.08.26 um 16:37 schrieb Claudio Imbrenda:
> On Thu,  6 Aug 2026 14:52:41 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Channel-subsystem damage machine checks are for the host channel
>> subsystem. The guest channel subsystem is emulated in the userspace VMM.
>> There is no point in forwarding such machine checks into the guest.
>>
>> This also simplifies the machine check reinjection and avoids kfree of a
>> stack variable as reported by sashiko.  There might be still machine
>> checks that have the ck bit set with another bit (like instruction
>> damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
>> ED bits already are.
>>
>> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/nmi.h |  1 +
>>   arch/s390/kernel/nmi.c      |  4 ++--
>>   arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
>>   3 files changed, 11 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
>> index 6454c1531854..dd26c20bd231 100644
>> --- a/arch/s390/include/asm/nmi.h
>> +++ b/arch/s390/include/asm/nmi.h
>> @@ -22,6 +22,7 @@
>>   #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
>>   #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
>>   #define MCCK_CODE_CP			BIT(63 - 9)
>> +#define MCCK_CODE_CK			BIT(63 - 11)
>>   #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
>>   #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
>>   #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
>> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
>> index e17a59d4d5a4..652b98795243 100644
>> --- a/arch/s390/kernel/nmi.c
>> +++ b/arch/s390/kernel/nmi.c
>> @@ -345,7 +345,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
>>   	sie_page = container_of(sie_block, struct sie_page, sie_block);
>>   	mcck_backup = &sie_page->mcck_info;
>>   	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
>> -				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
>> +			~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK);
> 
> ... here, instead of duplicating it?
> 
>>   	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
>>   	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
>>   }
>> @@ -357,7 +357,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
>>   #define ED_STP_ISLAND	6	/* External damage STP island check */
>>   #define ED_STP_SYNC	7	/* External damage STP sync check */
>>   
>> -#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
>> +#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)
> 
> it looks like this macro here should have been used above... ^

Yes, see my comment in the cover letter. We would need to move this define.
