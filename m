Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72A3D6663;
	Wed, 19 Aug 2026 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123922; cv=none; b=XdyeCfz1x8yUPsMS4NNfonqyM01SHyFvjV8MT+4Hir97dbjqj/E2vQ8V2Kw+yGhwpR6JxzcuBQwdlz1rYTcqUQI6HrSI/ZzH4xbAWSMf8pUYL1/33j9TzAA7HjIIp7yAmLzVMEGgffInnSjzmy0T9iNBI/Fmj8i0Ihzr6+wur9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123922; c=relaxed/simple;
	bh=99kwK6UDVnyg7qFO2RoQd5U7bDhm3sLzCy0zNM22F90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nio/+IDhH24Y2HJ5nCEDGXA1Vrgh+52EpSI8IaTZak2BXNPC3umOwX4PGGJfuO4oqVzqmQ/nwroAzVme4w1srwqKjBMZlCL4m9oNLKPl1qZjjqAnZIIRm39pRNhTXTcyhcHhPfZqqsjancjsDl8YSfN8cIQ4ITM5Cdr6fRsnCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oMb/kTp9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oMb/kTp9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WOkq2700550;
	Wed, 19 Aug 2026 07:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=syedAU
	O2Gd35q7+IcUhI5vNVLvrH2akCe1SxxBJCpPc=; b=oMb/kTp9fiSt6o2PhSXn38
	OB1w51gRxoMCgJYfsb0lmfht4ObHNn+hjsHfNk8X4WxzcCNgilzSG4tHFLZUsh5y
	bQoGlTXAMnkpS5nF4stl0yQJ7Faq79nJwPJ99zXm61V/BLQKrEV5DfWHRY7DPl9T
	uJHTOfxctgL3N4Xhby2iwsctq3ZGyHyGNpplUzwBEDEG1JgDfwKHlVPnxAYTryvA
	0s4UaO/VYjnsJUqxNR9QShE8aAckCkC8qsSUeiCZm7hOfrxUqKitWBPyJztrJdGo
	LhmFCbmf1pTnleT1Cr9IiANIL6ouFFHhAhyApvCoyi8tuO+I4Xi9mu+JfHc8+o6A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4254e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 07:18:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J7BPSw013383;
	Wed, 19 Aug 2026 07:18:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh7mv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 07:18:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J7IXOQ48693728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 07:18:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285CC20040;
	Wed, 19 Aug 2026 07:18:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A731120043;
	Wed, 19 Aug 2026 07:18:32 +0000 (GMT)
Received: from [9.111.16.238] (unknown [9.111.16.238])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 07:18:32 +0000 (GMT)
Message-ID: <5bb2ece6-acef-4348-a08b-5adfab758b1b@linux.ibm.com>
Date: Wed, 19 Aug 2026 09:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] s390/uv: Various fixes for UV secrets
To: Steffen Eiden <seiden@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8558ce cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BNTsRa6BAOaZY4Ar6rwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _MGAbTGANB5nrRYuPWk_DnHGwms7bx9a
X-Proofpoint-GUID: _MGAbTGANB5nrRYuPWk_DnHGwms7bx9a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA1MSBTYWx0ZWRfX1cROLNMkmsas
 Hc5zj+tgF5UFTvops3zbhZvJGnTe5TW4UMHL2BXRggl/bGZKV2fM5kDgLE/5L3q5QTMeCjZEQaI
 1eaxMxsh8PQKZu6wODtQ0C/Lfwy3aSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA1MSBTYWx0ZWRfX+ZslbbIrb7TY
 iVGnIWV5YnwGYCreCqQYtz+TIL95t2iVOkgpbV2ejkwznUFwyyvek92t1Cl2nPa1XjMmsV6quUm
 N3mzeEyIr+wsFNi2Ud5eVNrp2bsYuMgQOGrMs24TvRDTQabGuBYzti+2ipKmt4X/wBvdINIbgMB
 dFKyiGtpPcyxmXIPWe2BIazg4DRkcwwY12IFqqOsjU+x+M06pvt3RQKl+8KUjbaRaJFeqRohRmj
 XI7OO0Zzg1LFmXiekEMU4Eff73D0581y+U9Ph08/mP6kv69po0xWu7xSLCVaGg/n9Ta8I9Firly
 KdYrd1stYRi6uMRKR8A4DlRWjEfe13v3uYaPofA7qGePZUUO/xIJiHbq+EGAvS/pdKmSj8qFv4q
 auk/nnaNbgoGaCslqbibCq10ZHBdhynNFdLVdqoMm8sFvqdHdQgjI9Dba1siibZ3YATrnE6RbCr
 GGuH+CbAnMydUbACzug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190051

Am 12.08.26 um 17:55 schrieb Steffen Eiden:
> To: Christian Borntraeger <borntraeger@linux.ibm.com>
> To: Janosch Frank <frankja@linux.ibm.com>
> To: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Steffen Eiden <seiden@linux.ibm.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Fix some issues in the retrieve secret infrastructure. First, fix the
> issue that the loop in uv_find_secret cannot ran more that one round.
> Second, fix a potential out of bounds issue in find_secret_in_page.
> 
> ---
> Changes in v3:
> - Add R-b from Christoph for patch 1
> - Improved commit message in patch 1
> - Link to v2: https://lore.kernel.org/r/20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com
> Changes in v2:
> - Add Ack from Claudio
> - Add patch that fixes a potential out-of-bounds access in find_secret_in_page
> - Link to v1: https://lore.kernel.org/r/20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com
> 
> ---
> Steffen Eiden (2):
>        s390/uv: Fix loop condition in uv_find_secrets
>        s390/uv: Prevent potential out-of-bounds read
> 
>   arch/s390/kernel/uv.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> ---
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> change-id: 20260811-uv_secrets_fix-58a63b4a4ec4
> 
> Best regards,


Thanks applied.
