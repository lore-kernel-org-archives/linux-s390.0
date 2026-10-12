Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273C3515F2;
	Mon, 12 Oct 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811641; cv=none; b=U9LjOhktXBK+dOw4QpslEXt8y9of7iGhNclbY4W5Drn3wgbe9fcci1o54YcVXLs4Uaii4F0R+p9/9zwf/TPfCMVbATwmLfHXJEGrxymZWd9f3/D0tiIxXRDjR1Tbxn+aXW5UvZi9FDna/bIzCN4YjylF8LxaJVQGcS3nezZz+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811641; c=relaxed/simple;
	bh=hZNfmnEkUzNTCkLCN/dJFGoebRc0UW8QFQN7ci+uqZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAFgvxXi4/tvBRFqWq7CVOh/rZpGYJlZVPRKgjuzA2PqyGFA6PKR7qgzDJd+u/rHE79N6h8YLcVF3fCeyHB+nBCo2Tzr4FOhFwnDS6yWcxCnoCxMmy22+5ygaILYTSQdMgXZKKkohCRqWJu+DUsWxq9jzxwJXQTW21nZl5zY/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/IMnMnK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/IMnMnK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCER2G073731;
	Mon, 12 Oct 2026 13:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n0F1pV
	58cpZioU13clhnKhNvYOa7mpnwtGuhBo+lVas=; b=Z/IMnMnKiJzO2rghWJp4+f
	eKNTdD9af6ohy9tI1nIMoM6J4nEQE5SOU38lpRJ0nyV0abqXk3BJY8pjAnD9/aut
	kNE0drbMdB1iwXyxcxMY6uhPcO3q3j/hp+kIGBKw9iX75oOeP5eksQM+ZJI78Yu4
	hsfOyX2E9rja5Jsw38ztsNI30vKR13KQZqhBlnjiZ0DfP1zrYlAnjO8yRTtIEMvs
	nUo9AqFVofPzONFdreRUGWUECchX9xh6oBwwPpx029NjtQ+VF8vBafGOQRPqA10b
	X9OeE6X9cwcIAKJMwcpmHDlWFoA4BtqfwA0T+ZAz3bPl9+pSm7pgSSZi08FMzkog
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhrtj3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:27:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4xl11212050;
	Mon, 12 Oct 2026 13:27:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnayr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:27:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDRE5538797812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:27:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3871A20049;
	Mon, 12 Oct 2026 13:27:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89CE720040;
	Mon, 12 Oct 2026 13:27:13 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:27:13 +0000 (GMT)
Message-ID: <6ec7b092-0505-4b04-95ea-13dc2394323f@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:27:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/32] s390/futex: Convert inline assembly to
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
 <20261001103247.1989111-14-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-14-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfXwEZXmmtEFOka
 FYZtT2RHkb4LhqkYJE4qHGUH5QtIEzFQudnN9NhlBD7Egrv5dAoqSf+O8jzB19Y7MwOqVCIXLU9
 Xhe0wZBKm8LsR3yfqbFIy6F1GSWD2/YDbpt0hfTfjoukAo7eGxEG70n1zn+WlYOC4J3CBTFpSiH
 cIpl8PP0NO2+Pvhkx6DNMWvKMZ5itHJzMLf+9e4ZT45wC8G6GIy1t7owYQ5TD1QNWHGK0MQjcRH
 yXZrtXoZ1NLJMQjmUr34p+x9IASP78XL+8ASfLgDeax+N9o/FILs8SzqM0zVLPglDfVqPmBxnvm
 jKw4Fltsrify9sqM3Rty4S0BsslvKQOc95Dsc6njBXw4TzENybYu8FUX0clxUl3tLropUND/2KV
 DMqmXdQePgc+sZ6M5mRDCnhWaDOe4cTRxAAarldrseQUYPByxxL4YXhjQkE8d6SD0KxpIKVUkrm
 yLUqy05XVk8jRyHulYA==
X-Proofpoint-GUID: GosTnVoGqSEcUHowVuEzSoBf9wFn1YSC
X-Proofpoint-ORIG-GUID: GosTnVoGqSEcUHowVuEzSoBf9wFn1YSC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX6f+L73p+THLn
 q/kJ+pjWynfjhUaaKEcoElEpmzakpO/96AOL31pFtVsb5jZDBSgWfKQIvbBcqCLfNyq/pdJZUH2
 Cv5vHmKXTqJsPi6MPjngdUMFrlKTFrI=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acce036 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mFjd_-IuNDSFCaioFy4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120052



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all futex exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/futex.h | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

