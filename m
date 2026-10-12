Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BB485CF5;
	Mon, 12 Oct 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814972; cv=none; b=MYHgjwuf1e9IE5ljQzF4tvA2Pqn641CCj7efE9n9r8DNwF/PGv0TZ2dbFU+qaynUWy2pUFVC6EjBrkVe9X/k6D9ukLRZO+ieFZi3GDetSDOr2DBgYo9VsMVD/kirZnQgOiktXK9N4FIqPqfQa+YMpXB81qahEHNKJDAHTGxUN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814972; c=relaxed/simple;
	bh=I4D9KzNzY0IfoJm5MSCav121/NEsrR2RsB8xKfw5FNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5hSFt4chhvaidWr2VzICF+w4RgDNem0KlfQkA+TpOiV9qePpd1/C0XwxBDLZl71SZlK0OL1HhULuKxcUxhq7w8LcH+UhjMeZC29T7ButrTcWKTwjhQmykWn3OabHYlz1wHHscziUumwevuMIAt9q2VtgPKA7FnEzZS7EgAl83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+69/aDn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+69/aDn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE7q6182084;
	Mon, 12 Oct 2026 14:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IzWBjR
	lu+cLhGC9RYE5RvkiG3IuU4e4y53d/UHQVAgU=; b=P+69/aDnIRqO563DFFSJpd
	zPc3z07iXFPBcedbQKPJQ+yCqZlbw6l7Zx5Z0uwpVipA2rAutO1RYaR/XOUNUEnJ
	mLpKVXQUH4Smt6UL19WaDiaZm24VGkQMBhPrl5cOkScnSuykcZ6lAomJPyFYsxou
	ZZvZvGL3de5dtIvBGJXUTsbY8JeXzZCQ59CQwy5ertpSkVIeuW4O1ISQgZTWN34F
	W8koY0DIYVDnkSbVVMPSz1diSN/c1sODS7zAAtFdRlJSl8jxH3d2EHDKEthFOaCj
	/o9VhKH6MDADrdJUm8rohQcFCkftVRumDE91qH+MY6SxAdlvZDcOs0wkzf2fsu5w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39ax7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC515s1212062;
	Mon, 12 Oct 2026 14:22:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnhe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEMiH938797616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:22:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B332004D;
	Mon, 12 Oct 2026 14:22:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58EE620040;
	Mon, 12 Oct 2026 14:22:44 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:22:44 +0000 (GMT)
Message-ID: <f5703b82-151a-41f6-ae93-136ea58c0fc0@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] s390/cpu_mf: Convert inline assembly to
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
 <20261001103247.1989111-17-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-17-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sKdFZIrQycLic4oxRB01Lz2zSUWjIgEf
X-Proofpoint-ORIG-GUID: sKdFZIrQycLic4oxRB01Lz2zSUWjIgEf
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acced39 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=D29egp0LlRVJiIWQvIgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7MOe/tIh5mqI
 aQVkI0ZbyMgF8RKylJSxb/ubKEOJ+gIdIF71Ma4zxjSVAnRQ4dS0HO3oTnJse4uA3tosWPolsS8
 xVp8tzIoXfD/wD/wnrOF8Hb7LIFO+bA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXway6BnFcOIuW
 o/GA33dJ78B07fL1wbEccZj8q7gqsxo2Gk6GHqwX57fC4GKOsCPbHHRtiv4zT3yugcIgQzPGIQ2
 bWk2UE6kMmj3+s/R9xZ5u2BgGCCn/OlVr1q8qLA2vPbdcdB++b8NjWM57qYk3fBmQwyumTyfWbi
 lo7sMa8IfxMJyRhJSHo/zvVJfmHGsjD59++g2tv3FbDC7OPiyjkhjE1Cnd2DS/4hw+51Wn9BjO1
 VfrPLOsNabETUowQXMboWzBwGZmL5RiFDe9xIWsGFsW011xEjElcSdAfGYpWnelvDLBwffzAiYU
 JRMdD5LZTaQN/uYOGcvjA0OhGKW7w5pS0T9TKoW0KYQlSbvp5Y9dMxuC/CU6XvwYmhBaY3a6xzS
 ZWS5/RSkyA28YWuzEy+r11LXQfP9wdBXis+auyDqcABZrj+1kzNFjoNM0UL6IfasZn4i+4hi9HI
 WxNwqEK6XU5WmFJJaew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all cpu_mf exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/cpu_mf.h | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

