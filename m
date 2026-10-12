Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204247CA9F;
	Mon, 12 Oct 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815554; cv=none; b=neba6So/FdAT1g98uQuPxBjPDVRDJiVnEgW+ZlH2sm2xrGPUAunCORVwS+jvk4iVi48mKfpqMU2zWcjFtOmRninZie5BWWWhG6w3az2Q2VILMMwKTznhnzChYpphKI2dUtXMPmA5wMgYGi/chspU7yp2kd4UC4QFQr/G8PQP85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815554; c=relaxed/simple;
	bh=uh7mgTvBBuMZ8EOlvnMkNjBC2VdJvW4ZwBl32bB8FGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR711wtS6NJm1HOZ95XEP3BxVi04lb1H5/qYO457FmrPIMoJ1qBYrVmmmw7Er+sc6JX6jplkRdM5zqzjmc0qa+8DgHIDDuG8pq2OY2I3+Pc9iOxhTb3LepzGXN3EmMLd3qJcSWSsPTMIQMGA6EMOOrqbmlm6QCeO8+3+hX5zL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mb55eqls; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mb55eqls"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEYDO073909;
	Mon, 12 Oct 2026 14:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Imxgla
	8iNp7yJvLmQAqG/imScThUT94P7KlwM3uEUy4=; b=Mb55eqlsodks/uY1NskK4M
	26vRG3RJGhsRvy+d3lwdnlHa6NIw0FpdDlPZWexmW0EY33+4Jz4Pu88qSoBGnAlI
	Y8EH3LLpvem5Z2p2Z6Z9bX3F62GM5mf5DhGp1OxPkscjtc8SlgjrxLjnnfM4rl3u
	q1jBraqJSTTMnYsWJaW/nXVJO0cDnnPxjk/zjhj3KWtGU9yssjE93RZptB8fXCxe
	6yD9xTH4CqAWMlxRVCwASzvywSTIhDeLXKJYCNcOJGvGelNs0Lxl10Fnzru84h+L
	X6gIzi+o5tk6rrZWcwzeCUmFjTHPJ+2i9q3XSW2QKBD2CcEt3tGQihoSrUoVXUvg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhs3wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:32:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4wnO013490;
	Mon, 12 Oct 2026 14:32:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwcwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:32:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEWR1Y37421520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:32:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D037620043;
	Mon, 12 Oct 2026 14:32:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F74320040;
	Mon, 12 Oct 2026 14:32:27 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:32:27 +0000 (GMT)
Message-ID: <b7af3e55-352b-49e4-9d68-709604376f01@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/32] s390/cio: Convert inline assembly to EX_TABLE_INSN
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
 <20261001103247.1989111-28-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-28-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX0FWJXRTBkoq1
 WvAGYVOmSSSwrrNYM8lxVmh5cDAlTBzXZwNusRPsxe02hUQQ5GyYop1ff8RC/qmwlyk2SxlCvN4
 DHSVmPeIlNMsjZeKbgvP5x5NdmpE2W7JpzEtOxXu7LCY16dFxeSTVTLOGPaQaF35MCcQdDhDNBe
 WMnH4Ao3VEAnftzhoh2ofnWMuhtoq80r/lx1hkoCeJIg1BUZ+Z36uIC8jzGANhDD9OC25TC9K6R
 /3T41690Klde/xqehbyRAHAnvqFoXAefDzObycQpI1dbnWlhiNWqD3eo73p9LT6FlxR8BWqnDYM
 UcHxnJJfmilPpdwjeKZEmtDAwfM4q+2iVE1v0PlhUXdL839O2PyWcVga4b2Lg2TXvbwjImf1WUy
 DJ5r7ucpZZZckpktL8Fg+UCG8dlqJzqFoRm9SM2hirxmovK8r6lFmnoD7NiUjAr1AZBmPoLDVo+
 A+8cE8P1nrbPkxViO2w==
X-Proofpoint-GUID: IadX912yXf5cijlYic819EMZMo2qZSbG
X-Proofpoint-ORIG-GUID: IadX912yXf5cijlYic819EMZMo2qZSbG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7Vd5HZoXp4bq
 O6Mjr7asJf55rObiop3OOEO54X2G0cWNnLFTnhISHcyh7vcHkAYkjYtMeRdiNFTHseWqk+c+9nD
 vky/HJgiEeZ6FBFV1gCF5nVO4nZ0N9A=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accef80 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=rMXgMUZShWUmtgROjOEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all cio exception table entries to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   drivers/s390/cio/ioasm.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

