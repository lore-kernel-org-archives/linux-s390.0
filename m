Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AA47A887;
	Mon,  5 Oct 2026 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199301; cv=none; b=A6Httfb5S0SmKxEsd4fSfvPlWOZ3v67bkW8u7Ws7v3JTNxOd0I9Zx4DA7LIgGkpv1DEPPoDIRmqFhZScGdmneu+IGECQehHtcebpp3Htk75Vva6IrDDEyRlRZR4aoOZrAyI7Ok2NHMYWBu7S0CUWoWFebMkShGwjAPDbGgFfU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199301; c=relaxed/simple;
	bh=AyDLpEoyRvOgDOu+yXv7RDMfW1ogp5fonPE2BRy1YEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnrrY5qhfL1TEqaLF9l9aHKB+Pypg0RQwE3qdbHTFyF7RCdX+fiaYJc+lh7zomOunJN/5XCdsOseDc0yCG8GjEOm4SckO5qc/K7fgE/rUHBWj5/Vms47CsyRRnVeT0KT3ZvZsz3JbmdhudB2OCFdaM67VI5vL0FnNx8/ziBhVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lMM1m7z6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lMM1m7z6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695B5OHC2849128;
	Mon, 5 Oct 2026 11:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hw27pP
	dFsRfOfDsJYAokqWBXsDjlVoezQ9ZokXxap6Y=; b=lMM1m7z65MiU1p9WwGDxZq
	jhRh8kZy8qdhLGruiPtpS4huoujTVFyOGIKQc5TdcKHocwAw9w7yKB7a2YqkjKjJ
	HKorAKuk0mKHSdEthuLzua7b9SQLvak47Uc8lj2jzlwpvHi6GtQGTW9FNprIPcH4
	4c8bldMvoM+BssxVheKQyFv389fkuojVyHa5H4jsjYqYtOIBR9jNnNtGxZuwtDBF
	fJVE/nh3AMO/JnvPOMS7SMc+jqua371JOZH5LI2KFUuUj8kxYom5JneyuGHmbWll
	Cw1BBhf+MX7sMql1ZqhRsCZ0kfjR3rGHIJATku+xXtsSFqM6ufGwjzKFXFiz8vwQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scr9vrj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 11:21:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695AntlD2776842;
	Mon, 5 Oct 2026 11:21:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jn6qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 11:21:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695BLXiB42795304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 11:21:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93D4220043;
	Mon,  5 Oct 2026 11:21:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AEDC2004B;
	Mon,  5 Oct 2026 11:21:33 +0000 (GMT)
Received: from [9.111.200.101] (unknown [9.111.200.101])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 11:21:33 +0000 (GMT)
Message-ID: <d7504722-3a85-438e-a2b7-fea15fe310aa@linux.ibm.com>
Date: Mon, 5 Oct 2026 13:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/dis: Mark non-NUL-terminated character arrays
 with __nonstring
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261005092256.2740363-1-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20261005092256.2740363-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0MyBTYWx0ZWRfX9nITxmlFiBwx
 4Z1LkxoPHvkclPbEBXy09fMBQpDNWKvECl2hdb4ISEck9Q+b+MTp30OQpfS5lqL7fSG7ZaUy/Ld
 ZxeHGHoFjf8BRFjluywIqScuxd4HHCI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0MyBTYWx0ZWRfXx7BKgSy8N89v
 ladbyiWD2o45pkOqVaPVa1dI36utw1L71eIjYGuGANRl5YOwR7RY6g/IR5zwdeqDku5Uu1ZwaHZ
 eZJ5PFC19NrmbJEFeFYkGya+cZQvonkKR12MLTsTQiAPpnHK1t44YWYy/RngADETU79ADZenjjd
 Zcy18461pa2cna0ceYGl6dmRwAUfjbbCB/7yTy/Bpfkc2wHr71M7EmIEs9X8Hok19U/QUC3pPuf
 A0SCZ6gCdLyKzMMmYTVKtBh4p+DbIn7xQajMnReoICwTgmq6bfa9+5g/84uVEj7BocuDXG2NF6i
 jODUe4aZGdV6hDP9JUi35tXd383QzRO0obr49qynyiDxwgKsYeCqa2B28RLOa8hiZP+AUt2zXKl
 rL/oq4RalqrrIqz4mFEN8EF+/4LE1EnmvTvuVZMNSkkTqQdPFILNkrSDq7MjjXRVnxd/wD1Dpn9
 0HZ46c6NcZH4KRF5Dtg==
X-Proofpoint-GUID: WdSy-J_6eVBj_6SO4zMk243AZfYJ4OnH
X-Proofpoint-ORIG-GUID: WdSy-J_6eVBj_6SO4zMk243AZfYJ4OnH
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac38842 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050043

On 10/5/2026 11:22 AM, Heiko Carstens wrote:
> With [1] the generated string initializers were changed to use an
> array instead of a non-NUL-terminated string. The reason was that GCC 15
> warns about string initializers that truncate the NUL terminator with
> -Wunterminated-string-initialization.
> 
> The better solution is to use the __nonstring annotation, which exists
> to deal exactly with this problem. Therefore use it and basically
> revert [1] in order to generate more readable initializers:
> 
> Before:
> [LONG_INSN_ALGHSIK] = { 'a', 'l', 'g', 'h', 's', 'i', 'k', },
> 
> After:
> [LONG_INSN_ALGHSIK] = "alghsik",
> 
> [1] commit 7cbae7ea3de5 ("s390/tools: Use array instead of string initializer")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

> ---
> 
> Notes:
>     Use __nonstring_array for long_insn_name array, since compilers before
>     gcc 15 will otherwise warn with:
>     
>     arch/s390/kernel/dis.c:343:1: warning: 'nonstring' attribute ignored
>      on objects of type 'char[][7]' [-Wattributes]
> 
>  arch/s390/kernel/dis.c             |  4 ++--
>  arch/s390/tools/gen_opcode_table.c | 23 ++++-------------------
>  2 files changed, 6 insertions(+), 21 deletions(-)

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

