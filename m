Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB82F12C5;
	Mon, 12 Oct 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807347; cv=none; b=AK9RxapvurtOwS9rjeYLb6idV46iK4CVGV5UcJmc2ouI++7p+TIHw1yHoJCQyxwMlNaYmUWSDB2ErYasUAaBrfeH9yEpBDH7jykpHxYmgVniUcojsgv1f3pDFVH2N9r74Vy4aeR1J5lPNca8ZUJzfPCC7+63snhNkVhP/2GKZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807347; c=relaxed/simple;
	bh=caFIRNq72+6z7zDGcv9uB7w33j8HJXl29EEQJr6qJd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1SCcwAL1XNormHlmWJSNXK/PbCzy9XdzJHzKEKVqUDrHHuJRHiPHicgwSe0HwIxRTCfbNUTK2h+Vi8rrrFA6JWHLzSHEdZs8hR6brehu7MbAa6l657rwHlazSZDHT6pZaEf+WwQA/12+VeDryMBdB1tMQzS6D20GyLBgytI+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuYjOusa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuYjOusa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCECQh2640536;
	Mon, 12 Oct 2026 12:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hbKx65
	m+JQYMbIvQoeHttf/qLI/7OJfOlxTZ6ujvNiI=; b=CuYjOusaIWy70a6qG2GCa+
	/Q9xP7hWBRHBHqFvgItnClyEXWyaYpPmPSseuSHI1LYb2Nwq5WU9Dg9mY9UzOpuV
	3XpZ8F+6gA/pOgYsWa46/JeyWMOajU6lr8IUqk3mFwiy7Am5p4WapSD+hiNwJIPC
	UO2gDexrW7RYJ3C4GV8QFjCx64Mds4bXD8DJUSbXU3n1LECFHEDIwKHT7TjV7/5l
	Rby+GIWO758kJr8yGQ4cJSdMUz3QkqZ2NA/ZCCfSQM0T5NoKNctb5fISZ5uvAwIS
	7+An47XUV/6soXagDFHRE8a/OCc8qk1++nWW0cwnk8dPfzpnMdcQctLVZnItE1nQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh8s3a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:15:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4t851212027;
	Mon, 12 Oct 2026 12:15:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjn2rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:15:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCFeJr40174030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:15:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8DC020043;
	Mon, 12 Oct 2026 12:15:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6189220040;
	Mon, 12 Oct 2026 12:15:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 12:15:39 +0000 (GMT)
Message-ID: <c7915254-f6d4-4dc6-8e90-2637bfd75a77@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:15:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] s390: Clear pt_regs flags field
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-4-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX48KGmb/aAFco
 2kskXwwdddRxktuPsEE00i+ifWNzmPstwEXC/udMy/38Dn+xn4R/KbosxWVmpvfgOxma2elrrPb
 iZHLlvHRYTb6eR5WpJ3QCpDc8dpBivI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX0cbT/qPsY3Zy
 wiu8+B4cEGwaj1HTS1aowGqAnv6UMvnUpqX196Q8+BQzWhpazcw3xINnV1CrhQo2lxi4IuWxeDb
 BrUgcu1gPa3GNKk9e3yXen0QFdi00/GaqoDYAeR+GWfELHDVbaG/UvLUdsvs3zI1C+t1sNMpqj7
 rTx27Q8RJAXtJn4dtcLL4EpYsEsEOln95b9czn4vBJlivsGojDakkudbEIjxnqFLsKeBh2r5tTX
 UeKgyJfuCZ2omCQU234KxPuWDj5SViY8gRYN2U4GmMC8dmOk+/9Eq//7L78s2S29FeNsSZDpwCS
 N9xI8flhQpuwPN1BgPT/amAGIhgMlYkE2vJlzxkB28vKfuIwN2XFXDab2hVaow0+nyP4efhtBdA
 7kjsCITdLYpmMVhMtbTySb9omNTUZSvtVO0o2Bba9v7SqFQbwPnJPtG4VU5HfZxmE4+GdqErb8c
 eieDti3GtuGDTLFlemQ==
X-Proofpoint-GUID: QAQeW0Nc3wXzXMqw-cZZgcylTWwb8EoY
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acccf71 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=v2unHTK_Llls-_ZGkLEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QAQeW0Nc3wXzXMqw-cZZgcylTWwb8EoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120048



On 10/1/26 12:32, Heiko Carstens wrote:
> Clear the pt_regs flags field in the early program check handler as well
> as in the stack_invalid handler. Without this the pt_regs flags field will
> have random values, depending on previous stack contents.
> 
> This matters currently for bug reporting and disassembly, where flags like
> PIF_PSW_ADDR_ADJUSTED may then be incorrectly set, which could lead to a
> partially incorrect disassembly or wrong code markers.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/early.c | 1 +
>   arch/s390/kernel/entry.S | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 1fc153d8385b..b8e3c065fbec 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -154,6 +154,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
>   {
>   	struct lowcore *lc = get_lowcore();
>   
> +	regs->flags = 0;
>   	regs->int_code = lc->pgm_int_code;
>   	regs->int_parm_long = lc->trans_exc_code;
>   	regs->last_break = lc->pgm_last_break;

Just for my understanding, why can't we do it in C for all handlers?


Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
