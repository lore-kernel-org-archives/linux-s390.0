Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F848EC6F;
	Mon, 12 Oct 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815145; cv=none; b=nE9KlzFK9zC/3w3VfFFAIEG/QrUR/l8AMu/fYU0Ut6keQzRSSeqUdMS2ZF7ZndIJXX1mI5DXWbu5vIBo0r2MletRQCq8pkLl6JNAdIk0BXF8bgLh89YubYANM+BPr27IlYNW7NpPQt4Aj78H/4WZGUKfJkRlC9nCKGqSkXtoNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815145; c=relaxed/simple;
	bh=ZnMDo5vOahzFNQi+LRKoxEqbLmczXQP3eJ4WHRLekuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFSzzdZtErB1pMg6exgQgDjLxbQfJn7ND20vz9mfcc8thw/+b9DTrho3ownboWOWyPkWcsCs2LAFAKjbg+y8x/twov5b8iXYNY6UwR2zKTzc5Fh3oK9ZsOh1a8O0qPexkGXO+cFCaDjTqeLYgeT6VOWkun5il9+EBrc/eWOKhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0U2rbND; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0U2rbND"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEMZ32640926;
	Mon, 12 Oct 2026 14:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UC/1HS
	KFrnndW30cwCJSCuZubK267SkBMIgLL1uHNn4=; b=r0U2rbND0lenMx9TtcMN2W
	d+tR5xm5M5IHvtVJ1MUpyZ+3D4DQAU4MJrz7PVMVwLwkjKf1M2ImI5ddykgwFINk
	O3M3Qkqi+aSmsLezEP3q5gyz4DZaXdlNaH5oVSxC3CWI/mAf1k6tzTKueGDIDtAp
	sKz2TUuCr+Mye72gDIue3uXlbueNy/2LGffBmD22YvlMM9waNGM3tD7rd/r0byWU
	7DPVi1uNqSc/OH+vmiweKg7NUf/NoODRWbWatV5ph5HpQWjEUkxfpWjV21BlR5uE
	ybK/tLrX7skhRO7Gnf6xJtWIfb070oZR74gd88z/7ry4hVAoAcQqMKyJs2oR/piw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9bg4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:25:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC52h7013510;
	Mon, 12 Oct 2026 14:25:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwc00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:25:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEPdGI46596546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:25:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C4C2004B;
	Mon, 12 Oct 2026 14:25:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B8020049;
	Mon, 12 Oct 2026 14:25:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:25:38 +0000 (GMT)
Message-ID: <ad955834-a484-485e-a83e-8cdced2778e7@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/32] s390/traps: Convert inline assembly to
 EX_TABLE_INSN
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
 <20261001103247.1989111-23-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-23-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX2DhDzsbm0m6y
 kcwYr8gSDXQNYhmdQTzMP9Z5rl9BIqcUTSkumXv+r9+CnXB2FtMcozgZxlLYj3TgrrJiK51Fncu
 zUhjAb8sMVIBXkp0nBvLvMvk7iqABv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX4/+cRyHa7VdW
 XJA1jW2BjNSRUJ9gHqScx6UbnwNenW4I7rUwFnr0tj/tHfll5z1vwuaKm7s6EwmgZY9Be7w9zmx
 +o8ce8NRdKVARvgQh0h+MV6ojUJIJZdohhdIHSpyEws4h1AHvO6Zl6eCZl84S1SIuSh0Mtgm3Gn
 5IeSl9iLPwjj2neImWcrGJWg2mryOjBXMvBTmCYwltea5nAStKUBt/TVDpUFjyH7viPBcgRNbem
 HpjYZ463+X4FTCzktRCcI01i0aw+G3FPyc7ptdZnBSV7t9GIn+VhzDxnp1LJPK/Tw0MtvUrmCXx
 JNTCMTpKCNNEMHafqTKegztsRu+3Q+WODy1KQUOcnhAAJjj+rJbbwE06RU0xE88e/bFZHEwTnVR
 I8oPO4FH7zPmRtAQM3fNVg6yyX3bDzCcX+MGlYmxD0ictu/e6Lo49AHFGwd8/6BPsOXuxjfc3oj
 chV6mE6Z5wwJcLeIGLw==
X-Proofpoint-GUID: zXR6wpaC_CJrN-uBSPrLCml1Aqrx3YKG
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accede7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=w_t0WWM1F-p4_GTPpoYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zXR6wpaC_CJrN-uBSPrLCml1Aqrx3YKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the monitor call exception table entry to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/traps.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

