Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D741D239;
	Wed, 14 Oct 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980441; cv=none; b=LrbQxvXdO/8+a1A2TygCW6aiKroZDmL5Sis3BvCO51qu0QODwvyNJzQksAHxDXniYM4Npdkg9JnCRA/5gbAixJUgEk8sB4KaXtJCUsi7aueslimMh6lP0cqtZCQ9chsPjNDrqEWjs9qOXR8N3nTWuh3ExAvAS+oBAa/jLqove9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980441; c=relaxed/simple;
	bh=8wFPiyAlN7bZRRzc0eDJhxyslFZM3xPNRb3kQflYrPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etJmBbtPa440G+/wHCf7ITQQEdsGblv+YyGG/dB7GW5M7gZ/nw3pEdSQmcq7ePKUr14ekmrwW25F4pCvFiBMtmCamOLqPc0vFV90bWNmDhdF9xAsj/45S2lXxgLJjGS/trX9/uVTvpUdZCqEKE1RVAfo0k0+vDMYln6iCgmdbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bV3oIRrf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bV3oIRrf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAZdkS1775178;
	Wed, 14 Oct 2026 12:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v0pAU/
	+aOZgBAQla6dvbndZ7uBHuCsSWYhz85j8CZGE=; b=bV3oIRrfV1uS4CB58SAht/
	FU0dlkk1byBXPIwjaUVuqyh7oVBASyzfI3Eb9NKjf8ualj6RisUEk6/iwibZIniO
	bIlYP7qRsXM0CxTQ//q0Q98h+tdqsoPGiCNN2fdaX3Da/OP6vvUIJh10OrIkPD0a
	csU1HJ9vmNf+dyTYJSiTc0R5zNfgZrZAswAZunBfzo9yQhttcrSlZjheG66llcw0
	q9k/vGn8XOtWMwOE1GZckGNwza7EwfkXp3m9Q0onOHKr470way6NlUGWPT4MjG3R
	PrzyS3mCWBvtd4QN8Ew0qQ3fugBTs+anc0LRU5EHrouKKw6t1augcHMc0abqnEAw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj3srv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:20:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAdc3R3211854;
	Wed, 14 Oct 2026 12:20:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ymqwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:20:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69ECKYF650266610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 12:20:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27002004E;
	Wed, 14 Oct 2026 12:20:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D3E20043;
	Wed, 14 Oct 2026 12:20:34 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.31.234])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 12:20:34 +0000 (GMT)
Message-ID: <6255e61c-6c0c-4a36-8d78-9157440919fe@linux.ibm.com>
Date: Wed, 14 Oct 2026 14:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Select ARCH_MEMORY_ORDER_TSO
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261014115006.537790-1-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261014115006.537790-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX5nff2lZapeg3
 LfPNdFUN7T/lf6cGtcjtG1mo3jlrVqmhjblLqkJIH7eDU9g00/aaNbyV/SeeBUBBpqr0Z7Om8vB
 pKaJdoYmqPQJvh0HcB6ZnAuz2JA7KPPeBlNX07XrEl3JNSixz/KcqNzAVUSOunKXX4Wrrpq7tm2
 JFu6Gw85kQzBr/ipTfeduOOWAy9qRbHjVnPMo5iSpGRmS770z8D8xMQatlaIvwGsg+t+ky/gSgf
 C+tal3XqvcaGlUozxrqkAiKnyurAFW2mJ/AJF1bR6Emp22xUS8lNiPHkOBqF0vTG6Yy41IgZnbO
 rL03OzmKIjlBLpqsn6NgR3M2KCg1+cXdiBr4pXFP4b3fdrfKJjMphbjTim1ACxbFlvlVZsokPpt
 e1BRP+SL24bhN1PHoLzFqpHN46+nAtsvGt2ac7e+h07V+GF/iMvY3+u2KnJOeT0nCJ9zjRRR+WR
 kC/YzSIb+6op3MJdvPg==
X-Proofpoint-GUID: uCwBFjm2xAEOKSmbwIAE9nXnnq5lcquQ
X-Proofpoint-ORIG-GUID: uCwBFjm2xAEOKSmbwIAE9nXnnq5lcquQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX46fieTKEb/tc
 FSlOQkOTp3JrZ27IbSeSq+eWhFYbBvResoHTyF539T2ezWISeUlsZ/YK7Q0JjK672RvvbNweDOA
 pG4VbIp4z2Q9/1wgPC/mv3sRvEoJ9kY=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acf7397 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=LQFbTukdLxTeUF92zhsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140048



On 10/14/26 13:50, Heiko Carstens wrote:
> s390 is a Total Store Order (TSO) architecture. Therefore select
> ARCH_MEMORY_ORDER_TSO which was introduced with [1]. As of now this has
> only a small effect on futex_robust_unlock(), but that might change in
> the future.
> 
> [1] commit 6149fc36c09b ("uaccess: Provide unsafe_atomic_store_release_user()")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

