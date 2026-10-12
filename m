Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665335AC20;
	Mon, 12 Oct 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810814; cv=none; b=UyJ+3PuQm6R2ccUv/kEglBNia19f/oN+gOozeEb18HFupEf7BETmjuo4ZOxuDHw+nWd0jGyQBDFKOtH9Sr7IBevq5QRiCERFaoEdhXx62Nv9nqONMIM6VGwoDmevZRPiOECp1M7/8BvtE3lenny2u9Yu9+cNpvb8Hurw/1YlD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810814; c=relaxed/simple;
	bh=a2enl9M9tN2bm99hsYDcDCpyL1Y+uoATCKste0BWACw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5YCqPA9O7XFR8MwThkJFjOY3+nlSPlpdVGFZLiG9Ms2zGYRvE2PegURj9UsggXplqFcfDbJkVgWYbTowpa/SKbkV0BPU4d9Mr82pJ3UxYIdNdK3GI99kD0FN6ctv3kFJ3oBAYskf1BmiLUnmAuVQmaiSM6RUJZ134OcAW2t0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T3R1tr8L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T3R1tr8L"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCGfvj078133;
	Mon, 12 Oct 2026 13:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BatX9o
	4yLD34ZdXZqy2jopqlmQzKQzAYz89tbeGxvwk=; b=T3R1tr8LCEx0qq9Js706tM
	LWOnbn5AFfcdF6hrPBeNisE3ibqSY6fVuEEVSrbHXAes+hwjTUi46y4MfdtlX37i
	j4cLjN/1yz6BK2P1eHnoXANoZuJ3nnrr2xQ19TPAxy98W3qgYkNFGGJsjhEy6xNn
	Q/bOp0gE7ZAt3CuHrYy3Y7zhRY4Pi3wgiSVS3KggPJfusQtTAWrjvDEJvYazZA0Y
	5ga6QV3ebESNLOgzbTnpU0I69QgUUNoxllS61RDhf1llWiKzaZE+Vkim3WLYCoRu
	LeK+QmQZgdIU6sijC6p31wpE4gywBX00svj3a9u2yVJ19AIdv3VDjC9/XQGaGYqQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhrrcb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:13:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC51oV1212074;
	Mon, 12 Oct 2026 13:13:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjn9ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:13:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDDRhJ55902562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:13:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2BB20043;
	Mon, 12 Oct 2026 13:13:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84AA20040;
	Mon, 12 Oct 2026 13:13:26 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:13:26 +0000 (GMT)
Message-ID: <6804ef9d-e5f1-4b40-aeb8-f2b0b8c84f29@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/32] s390/diag: Convert amode31 exception tables to
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
 <20261001103247.1989111-11-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfXzH3eabfaIiVG
 lQMrMDIusnICLnDzfD/k+g3a9i7EqyTjEo/dsYjgV2ng0b40IzEpxDkBNHNpim1XgRAyJp1U6k1
 AQUfGsSr/uMFEymJI3uoqZ6waHV3FZtRJU0P68RoYnhcs65NG+UVF9sKO9vaiqcpSlVOxW02m6a
 17jkjQ1LDebNbi9+TpzgJcBDekw2Ym9R4s7cTOW1XQaSvAIzlFjSVN+XqE4+gEDkkQeU7OrfAsA
 xrW1mZ0UyvN4uLXF6QyXEAdDRZM64cQ+V2dpF6yD4nXGGuLao2iYpxNfkcj6imeRmklqD4CiNz/
 3Z3hM8Ago2u0v/7UbYxDyifzq38oC6kKiMm0xYDsVHVBUd0jmvs0YpXBaQYFbFQyvLItScmNy2i
 LffbswN6jSAsBsmF7F5hbAGO4Ankx1TINFwu2a5MWSQ7XSvPvddsC1zev70sUQozA9AIK5Ua/+0
 TzyzE7H+D7HqZ/oG+UA==
X-Proofpoint-GUID: PzTmBvI4nZ8c_1Ppx91rmtQEMMCl_rzz
X-Proofpoint-ORIG-GUID: PzTmBvI4nZ8c_1Ppx91rmtQEMMCl_rzz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX7EHWOeoAjqbn
 J+laEKzx9+8NOs/bmZKruqOjQK7vvz8dVvlFCr2hzi/dLBbkRt7nlgeVGo/88ywWoxdTNQHwKnb
 f2J/o2y7UpV/3PDd28tmMbCgXYiMFdU=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accdcfb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=cU6BJfqmKN0XCpvlu1QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120050



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all amode31 exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so named labels are replaced with numeric labels.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/text_amode31.S | 34 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 20 deletions(-)

I'm not sure if numeric labels are more readable than named ones, but
the code looks correct to me.


Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
