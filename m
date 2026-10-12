Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F91D9A66;
	Mon, 12 Oct 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817255; cv=none; b=X9M25mJQaBaKgKhNqA4qu8VxDS2ydwpSzThMAqjPYsAsSi9rXyxcm3DvtoP25ELOtNVj2MRrVwQJPcGB7n4yqNAVLtxFilWVd6y+dTBil/6yjuYOimj0FX32BFkJNIstrsVs3qIVtFsLMSCBA6VgA4v1GaBsbgsPgTe315mqhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817255; c=relaxed/simple;
	bh=ayyPQ4z+5De5S+CH6wBzDTIfJ8yaHWPq8tdR8wAgqzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrSQLIV2hCOvgBO+24da1aHfFW6okAazJS/UXahZ/v24aZlCc+FsDsJ6S+48kztVYN/ZTSTAPQJNHt94Ykl9bKuRRW4yFRPMTMobHbQY83qsL/Ju9XZKToDlhg6MivLAHb11arYZnTesXaypxzRuJuiuHSOjjTuBQ35pfwk+E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HYz6JP13; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HYz6JP13"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEOd4073652;
	Mon, 12 Oct 2026 15:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T75nQs
	JWdc7VPipnH1yPJH1w2o7Nf721U9AwZATf7Cg=; b=HYz6JP13RChb4XqFejhxaY
	2eJ6IefFDVBAGvRUonEO/9VACuZQWo0JZJKjp8guebdTbt0xoQ4c4wdJ4JYvL5E7
	ZObMz5YWikVoYXX810nsUInDK6IBelwxpqPiLlgt9wSV+AROyzJYevk60i8f9QRk
	kuzK277b8zL8YZ0w5Z7EdlVhdkNYefye6dFz1FWM4x+Tni56SNInx64qsiqCGgcu
	SC+/ftufXx6mWbPZh08JvRct+vz0UVseXBPi4bi3j1JuoitfQCHYTOwBT4liIfua
	jBdYyJM0RTKgVR+lVtmvI617U5/1ghEK+d6Q5q6VrEFTOJwwJljkqDFg6IeqQIrg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhs7md-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:00:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC53MT1287128;
	Mon, 12 Oct 2026 15:00:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwkks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:00:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CF0hYZ59048422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:00:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 453675803F;
	Mon, 12 Oct 2026 15:00:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3319558056;
	Mon, 12 Oct 2026 15:00:42 +0000 (GMT)
Received: from [9.61.99.49] (unknown [9.61.99.49])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:00:42 +0000 (GMT)
Message-ID: <a3f68cb3-ce09-4a55-9328-d798f88bafd4@linux.ibm.com>
Date: Mon, 12 Oct 2026 11:00:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] s390/pci: Add function handle to RPCIT insn trace
To: Gerd Bayer <gbayer@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012-rpcit_trcfh_upstream-v2-3-1812db73dfa5@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-3-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX6CJkGYHFE/Ue
 lnLUOYAXVvxE/8NKTLlTy/zuV5m8Gro9XPROfcTCxaBBI7t0F3gKUTwlFje5ZrqWOud4I7Gf5x8
 riFFmTz38rFyWWpmzJMACP9AxSk4e4cKTIM7Zb6wxhhWed6jsnA+lpj6Fj9bnhSXAPRWt8MlFQc
 PtXYf8hrN9WYzDIdqjSG7v+zFtSkcOlxRPgQRoidI0ZyLibaApxucqCbrkVU8PCQP9xBwNc0zPS
 mGFn71WD1F81h9hjP+gTTgCuLShDUJ3qdS/I6sMNyJbLB+UJfdtxGnf/r8kYiwGz2MQtPoGuayl
 FLfrXQXBl9SZe3cufVbaRUzkjLDFIw71vDkpG1+sqmhX9KsDPi1trPZOezfH1XX9nOCbJVV9mfN
 1Xs3Qd4vL+DHrM/4Pqzlv7ufNkiMoHWAzSw5wbbmjQITgeMzpE8jpNBek/mygdD0i2RvrLSBZx3
 L5hBQuUcemIugv3wiKQ==
X-Proofpoint-GUID: 6SitaoCJBp5HP-7OBKw9Tvi8c_NVK5Gd
X-Proofpoint-ORIG-GUID: 6SitaoCJBp5HP-7OBKw9Tvi8c_NVK5Gd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX5q8Ni/4KUoX7
 L7rEGFmgxqQvEQaQuxPzc/DVOseGS6tdm0FYLaf5VOIICNct/hkI6nK5vyZlD0vLoqb2FouS7iL
 MYQoIhk8f4a6a7aqg8QmQkr4tG3295Y=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accf61d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=B2SnNno4fJaH8Yx9rOgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120058

On 10/12/26 10:21 AM, Gerd Bayer wrote:
> In certain debug situations it would be helpful, if the insn trace for a
> failing RPCIT would reveal the PCI function on which this was attempted.
> 
> Introduce a variant of zpci_err_insn_req() called zpci_err_insn_rpcit()
> that accepts an IO virtual address and a range parameter together with
> the req conveying the function handle. Switch zpci_refresh_trans() to
> use that new error trace.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
