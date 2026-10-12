Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E147143B;
	Mon, 12 Oct 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809431; cv=none; b=gdfaYz3OC6X73k3OfDFGWgWHd6gPrK4xEcynC3K5IBpbz4+0uoKf/KtlfXXNyWEmK7dlmWh+Y6bBgHLklNFe6By9Sa0t/cYEdbQuJhEa4nTKue/a0DZBaYErsPEitS5A8BhJNK1h6xY6NkTj/i1PxJxWTa6p7Qcqj9F9amcf6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809431; c=relaxed/simple;
	bh=ZXuPogufWaovI7SE5G5371S8avR7oyZc2/8q7B27fus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3nAFKn5cdpvpASsOkKQXf+SOQfxYlkGPrWTUCWYsMzMJgcQU2ByjorVaWI9eTSfJ1BFAyKRZULGI5b0ffAgrT2XnV+fjDvVLOaopoSHHO6YW3rWijru/rmI95xyBBJtZC9wVQFw/q+9S+N9W0vtVlG0TPBEYz+Pr5JoG2/OyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GYEWq2K+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GYEWq2K+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEFnh3209703;
	Mon, 12 Oct 2026 12:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aEhece
	aBEmNoP3y22LWn4KVyv5pyGC/JV+UNhfRwIfI=; b=GYEWq2K+Vr7SCLIBfw6BZ/
	6XXqT+l+up0Su+Ezlu1dFIi9ARdFhsQ/lBhdLUHiI5tLOkf1TpFMonZOumuf0yhV
	tPs74nwSyvOTHLcF8Pbkpy22gndlHQasYQ3F1W+xW4AWu9RzaDcmtTh6ko2S+LyA
	343hgm2RLycwU1c3bzSrJXr7gv29ynNs+ucwkSA8Z2d2ohghrKHjDoPeXNgBL7g2
	6Bsrsxr0ZAMrUCSdRwHweKLeUH0frQb6ZBvqVj+K76St87pbJEz6/P5QRH1VzlvP
	j4GaDSuQBy8f3L2Eo9L0AoxVpcw5EWZCqexHd6S3/6Ob82Rze5zCVggIxfSO9iWQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv08kd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:50:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4sne1212024;
	Mon, 12 Oct 2026 12:50:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjn60j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:50:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCoO6q32637364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:50:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1BF20043;
	Mon, 12 Oct 2026 12:50:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3227720040;
	Mon, 12 Oct 2026 12:50:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 12:50:23 +0000 (GMT)
Message-ID: <84bf6d68-ae70-4f11-a617-349cee297170@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:50:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/32] s390/tools: Generate bitmap of nullified program
 checks
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
 <20261001103247.1989111-7-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX+lVryioic1ZN
 UyiuzR2s7xRDmCJy+Y/u145JNBrbGDJ+eQ8rBmHW/reN39QIBDRGtrWLat/1pgJI4XHTfk19TI2
 iqtI+58m+JuctVpoVSIy6lEKjhwkyEI4dpriQ8OGDPavOjuy/yURJcajvL0EpdsvhuqqZFqwYfw
 u44Y8vFUnZQuvY0A8adF1+dOvTUBD+lPdoLhuFbr5r0GkhG83V/0aQH2oBREt7XN38dfglV14/p
 TQsoY04wLFMF5QzQ+v0+xJfKxN1p8tv20h/BzCGGA3Jl40C10U3hBtZJvkJA2pffiEJwrrABI/p
 zlkajHGicaX8O7tT3U4ItRE3Gc/sPHfqznNmWJ2tKYccTf8Rz8/bAdtSFjoCd3kKNvqscV2NEHU
 GDcE8F1CdLDjnIPmS+WDFw1h/EEf7IIOHDqZMOeZ852m61YobzZzkJJFIh45Oxv0QrCx16OOf3C
 AcND6PGKupWu89/E4lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfXxj29mxTTKF2x
 rwazyMvthxXRTrpAApwc7xi4uMRTj5/z0xpK9lda7hVPdxwgBGkkJUaaW8bXFMM/8SrpeX9wwEV
 Lc/zwxRTaPgBGul2oP1gc3ceIuAluuc=
X-Proofpoint-ORIG-GUID: T63PF53TqjifaJ9kMGQ8cbC4sWYsgDQw
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accd795 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=gSfIQeQyo1-bQS2XZOAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T63PF53TqjifaJ9kMGQ8cbC4sWYsgDQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120050



On 10/1/26 12:32, Heiko Carstens wrote:
> Add PGM_CHECKS_NULLIFIED bitmap to gen_bitmaps and add a --pgmcheck
> command line option to generate the pgmcheck-defs.h header file. The
> bitmap specifies which program checks are nullified, and will be used
> with future changes.
> 
> Change gen_bitmaps.c so it can create bitmaps with different bit
> numbering: MSB0 bit numbering like before (most significant bit is
> bit 0), and LSB0 bit numbering (least significant bit is bit 0),
> which is used for the new bitmap.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/Kbuild  |  1 +
>   arch/s390/tools/Makefile      |  8 +++++-
>   arch/s390/tools/gen_bitmaps.c | 54 +++++++++++++++++++++++++++++++++--
>   3 files changed, 59 insertions(+), 4 deletions(-)

[...]

> +static struct bitmap_def pgm_check_defs[] = {
> +	{
> +		.name = "PGM_CHECKS_NULLIFIED",
> +		.inverted = 0,
> +		.maxbit = 127,
> +		.bits = (int[]){
> +			0x10, /* Segment Translation */
> +			0x11, /* Page Translation */
> +			0x16, /* Trace Table */
> +			0x20, /* AFX Translation */
> +			0x21, /* ASX Translation */
> +			0x22, /* LX Translation */
> +			0x23, /* EX Translation */
> +			0x24, /* Primary Authority */
> +			0x25, /* Secondary Authority */
> +			0x26, /* LFX Translation */
> +			0x27, /* LSX Translation */
> +			0x29, /* ALEN Translation */
> +			0x2a, /* ALE Sequence */
> +			0x2b, /* ASTE Validity */
> +			0x2c, /* ASTE Sequence */
> +			0x2d, /* Extended Authority */
> +			0x2e, /* LSTE Sequence */
> +			0x2f, /* ASTE Instance */
> +			0x30, /* Stack Full */
> +			0x31, /* Stack Empty */
> +			0x32, /* Stack Specification */
> +			0x33, /* Stack Type */
> +			0x34, /* Stack Operation */
> +			0x38, /* ASCE Type */
> +			0x39, /* Region First Translation */
> +			0x3a, /* Region Second Translation */
> +			0x3b, /* Region Third Translation */
> +			0x3d, /* Secure Storage Access */
> +			-1  /* END */
> +		}
> +	},
> +};

Do we want Crypto-Operation Exception (0x119) here?


In any case:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
