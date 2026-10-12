Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92D374A0B;
	Mon, 12 Oct 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810588; cv=none; b=N5dZcI6EeVw7fdXDNbPWFLWqNchBSRzZRyP7ljCJ3JjY1T6Yv4qYKTAy/1YbEGcPZoRGzDBRtHQcnQSS8+6sGN03kd8wNLA+7Q9KbG87SeFTDx8ELm/RmQeJm+f1Nm7s9uZnx82C9ViNkdVAIhdAT6AxiJJuqSbvIHNRvKNCZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810588; c=relaxed/simple;
	bh=k67l4GPGOm0pUkpf5CSux/qvcmcZlmSZ4f5jazItOB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k77+14rEM/Ghiif//atV4pRGZmTwWQickMxFW2044db1g/+XaKs0rOVHPu8G5Br3NgmtHrSnYbc1zVlYxRjncYZe/Mb7/FaddTyf/7OqK1YLG8kX71Cab3MNposDAXm1+e1uIa7QIOX9bd4uzSKRQ9ZhaBEos3KMY1pSKD3BBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/XAfUeV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/XAfUeV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEGq4182500;
	Mon, 12 Oct 2026 13:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=82HgvN
	dDBqpCDPYO7lyddiVVW1FM/aUDzH7Q1sPRL2w=; b=h/XAfUeVI8rRbxraxM2IYz
	OPV6LknON1kVrHSUvaNoIDehJHH/dw7CgjKR6j1DafLUWuvoIf8ovnhSv9WNKTSL
	JRlxvCRhw0aAK4ecPLBqcahanUefREATqizmsIsWPOuvoq1G+MWjC30yTGfokjCm
	Z5Uk7sXCIDvMVVJY6CJhXAcJVMsuVNnGeFXNvrrn/K7nlZvX1e8vn2IREW8LdQVy
	g0rGA9JKNYU/hywrSl7JEoLDAJcCBG4qiZNIWF++zpzGcb5FscGoC76wI4hwlFwx
	DF5M+KBC+1nCm5HZMn4YeuzKEQTqcbW7yoYvrhsUfOkhf3DrjU9SIJrykMLfZDlw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3908r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:09:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4stV1212024;
	Mon, 12 Oct 2026 13:09:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjn8ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:09:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CD9fTm48234876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:09:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EE5820043;
	Mon, 12 Oct 2026 13:09:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E70720040;
	Mon, 12 Oct 2026 13:09:40 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:09:40 +0000 (GMT)
Message-ID: <38fe7660-454c-4847-8918-5e1afe6c34ab@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/32] s390/extable: Rework exception handling logic
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
 <20261001103247.1989111-10-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VtVtM6uVMeqFMVSRd3c03ZPphrjKj0ZW
X-Proofpoint-ORIG-GUID: VtVtM6uVMeqFMVSRd3c03ZPphrjKj0ZW
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accdc1a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=NdXluOHTnc1O5S20Jk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX/Gw0Tps5w717
 hVlT0R4s+eR/H8OLG907nakAAAd4UVoBrQTsH580fu2AArpmGmQR/vnyycChmaa5zBZ3RizgIz9
 5XfPmowf5dVvSrIqjQMoGWAp0m/gd/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX0e403L484hmy
 0kBlDCk7qrbtauGk2uvUKXbgsvuCc3wdCZ7k//ylx4H0pSL/xa6HlbEPblpYhsMzRjQiHRngwDd
 kL10Mffz1VVImCay6dXGc/10sVnW1Xp4mtRxOJV0Ryo/Yu0my6MGn0N/cLQU5LdTUDaovzBblT3
 G++YGJ3Lq/0ZS65YFpTk9CYDi6OZMBCYKDeg2Mn+F+L1BADUz1+xCgkUkO3spi3H/dNn5MmAXuc
 jamYc7NjevPk3NW+ZUkYLzEYCPNmIIBZc940qPzJTeCtT4pz/sgT/xkKJ0hfnXnHNQ2PN5GeQfS
 vsumRyIk4q9UT+/mSYVQXLI9cAueOGwqTjNCeTkBjCji3NiXjfFvJsWOdNub6j15tq/OgcvVFP/
 2kMSZekBKsmcM49e2kYSd9xe1Dmyu3RA1Tt1xs9HIuMWpqTGLbkAiMTKoV75pPAyjA8x20ZmxVi
 PAvlqXM/xI79e0pxqjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120050



On 10/1/26 12:32, Heiko Carstens wrote:
> Add EX_TABLE_INSN macros which will replace the existing EX_TABLE
> macros. The macros come with new semantics for the whole exception
> handling: with the new exception handling the exception table entries
> always point to the instruction which may cause an exception. This is
> regardless of exception type, and whether an exception is nullifying,
> suppressing, completing, or terminating.
> 
> This improves the current situation where exception table entries are
> required which point to the instruction (nullifying) and/or behind the
> instruction (suppressing, completing, or terminating), since depending
> on usage an instruction can generate different exceptions.
> 
> The new EX_TABLE_INSN macros are aliases to the existing EX_TABLE
> macros. The exception handling logic is changed to first perform a lookup
> in the exception tables with get_trap_ip() / boot_get_trap_ip(). If that
> finds nothing, it falls back to looking up with instruction_pointer().
> 
> This is a temporary solution until all EX_TABLE usages have been
> converted to EX_TABLE_INSN. When that work is complete EX_TABLE will
> be removed, exception tables will only be searched by using the return
> value of get_trap_ip() / boot_get_trap_ip().
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/boot/pgm_check.c          | 35 ++++++++++++++++++++++++-----
>   arch/s390/include/asm/asm-extable.h | 10 +++++++++
>   arch/s390/mm/extable.c              |  4 +++-
>   3 files changed, 42 insertions(+), 7 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
