Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6A219E8;
	Fri, 24 Jul 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884429; cv=none; b=HJLA2OzpAyyWYAmwANZ275nyBsWHJWYu0sPp2QgrULCBAi5MnwAnzAiqQDA+OcwfCyZ7aEPCH+aDiUk5ZsL/+8atyPAkF4mL88XuDwSul6+UcFu6qFNDZh6JVmmh7goeHkxql9fsQvfJVxWx6IJ9LJLEnwFccRjTA5Yv+XJJN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884429; c=relaxed/simple;
	bh=xPqEUlhl5C0cCNg0yKKCZmDA5P5Yr//ZhyIW8a7sCOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2HaigEoyPUapi7d34W88+mS7B+udHPvl+zlP7kRu00uSQ0IbENlBKYMCNAzs2JivnWf4LKztDgywMfMLI9+2W3pJHdOS7XvvafIhlhbr5O71Js1HEJ2hVcEBj1Kjs1PXo73aqX2X/th0eEsO2GzJLdMEIktt4IjuAKxEFm2jOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y0aDlGFr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y0aDlGFr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bwqu825908;
	Fri, 24 Jul 2026 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dcRpZN
	ZzzQYNt7v2OyE5mClrIoIErcJsGVKfnBbyR2w=; b=Y0aDlGFrLiOfOccfB3ZNuQ
	bZSDQZns6NlzaJBadW8b7ck4zc6Qb40bJU9DzjXHbtySgolWVTlkY4/FAvpoqhY6
	9DmCYVCDgWnolVyU0ERkGp8jI0sN5vSJhv+15wNyjPqhRvep9AogjIFD9teHZtII
	EVYInBaO1kC/m8YsraCLHZNs3LCbNNdxRQ8+4pSBkxD/PfCz4lDcuipl4J2gB0sJ
	oebbNt41XXZM2ILLjGYKpLczM1M07hwTKJeTWmwT1XhVM177sxZTHiEp6UyMrzqB
	WLK5zAhob2f6D/3RbgjcqEGebOjZM7K34+fDW8krRJUmt4qrsxnyWgajE+06oLfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kkasa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:13:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O94fsg012366;
	Fri, 24 Jul 2026 09:13:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahg6mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:13:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O9DYXW50069990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:13:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8B73201CB;
	Fri, 24 Jul 2026 09:13:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93436201C7;
	Fri, 24 Jul 2026 09:13:31 +0000 (GMT)
Received: from [9.123.3.72] (unknown [9.123.3.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:13:31 +0000 (GMT)
Message-ID: <28831f1e-b138-42d3-8566-23e5f603567d@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:43:30 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] MAINTAINERS: Update SHARED MEMORY
 COMMUNICATIONS (SMC) maintainer entries
To: Wenjia Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20260724053752.3084-1-wenjia@linux.ibm.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260724053752.3084-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a632cc3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=Iqf_Y9A1iTEqXqYGlk4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX2GOX7ZgOyaop
 AIPCn4b8ed2nSxu3xXfBacX4I6sgSlpeeR16vjBjFRxmLvg2hNcHHZ/t9Bks9ufDiRiItC8R/T+
 TAodFv00c1DdwHIyyemtU7GZf4nzEXOzW8X5VNKOnxabsZ1YYpIIyZK3QUnPZ5AalCqCb0IeyJ2
 4e4yT3EiWHgiVYYExfCOibSQrVndCBZWlc0HZyHSR5kfZWypIn/K0L5GQp1kU5dEcEnW5ED4kZT
 39KqKnHy2A59F8/gKuS3tdQ9/HBoIsqjD9LBVCphED4x7Ya1JlbLTDUmXm7bAHXYS9Q+BIWYk5s
 iRri2EFvMCfl1EmXZ4m24TcBNdaeDlmJ5FES0fTziM6icgsDRIqlEYH6/e7genpDgOtO/KMSyJN
 D7s5vnSmBaAXyg5uUpARHqGES9Lq9fhH+LULgl0i53P33N2aq/3EV65od9q8F0GZAKAPiU9fn83
 9IAIZK99tdYXADroXng==
X-Proofpoint-ORIG-GUID: uFeaP31iR2AcoBSKxn-3kQkmR0NrItHU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX5UNdovSXBwSC
 bQ1F96uLKI7JvMAOwL7t1+DJP22rRBHAndGrtNymoMD3CPYpkpWppD8dan5+8WY1bFMB0MlQsow
 RAey6TVcOQ77jfAnFPYYue9KAOlTOBg=
X-Proofpoint-GUID: _flJAMVD2a0TeQ75C9yqUoVncj5b6q0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240083



On 24/07/26 11:07 am, Wenjia Zhang wrote:
> Due to a change in responsibilities, I can no longer serve as an SMC
> maintainer and need to be removed from the MAINTAINERS list.
> 
> To reflect these organizational changes, promote Mahanta Jambigi
> <mjambigi@linux.ibm.com> from reviewer to maintainer.
> 
> Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff93f3954fd1..031db6fa5522 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24632,8 +24632,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>  M:	D. Wythe <alibuda@linux.alibaba.com>
>  M:	Dust Li <dust.li@linux.alibaba.com>
>  M:	Sidraya Jayagond <sidraya@linux.ibm.com>
> -M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>  R:	Tony Lu <tonylu@linux.alibaba.com>
>  R:	Wen Gu <guwen@linux.alibaba.com>
>  L:	linux-rdma@vger.kernel.org

Thank you Wenjia.
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
