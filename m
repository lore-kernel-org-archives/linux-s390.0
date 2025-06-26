Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522F1B043C;
	Thu, 26 Jun 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923565; cv=none; b=oEub0fMMnxWEUcfC2NvTZWTEDoZ5h5b9NmIqLPraOaQKWW6vJVFp++5aSv2MXyFAUDt+Z/wERfrR0YClcSCCyXe8OjO6YAvrN4eDB5uuAwNORiEElid8GJ8TbglDrroqvR9WSNU+KOd3DYYku26FNtnSzzdz+A6VwSlaEPbbTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923565; c=relaxed/simple;
	bh=EtPDjFi+XnuRhMRKP3rZUOFK2bjQDeiMwOur+xiZTUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2Vr7QbMorGa831D9NDqr++ohqDpoVPrQbRV4VuM/21AZP2Na/wwpSaZxkPtYiQdUqT1vzCpX0nXb2LuINfTWsmU/yerMNb1bSW/KL7iuJF77rBpVwXfiV/eiuneFxfV9kcA5kJbjAGSpB5QklUff8n9O7pqPGgmRy1Zn3RMTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YFoNCyfq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YFoNCyfq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZht015779;
	Thu, 26 Jun 2025 07:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XqhQ1W
	VIGZgb/9ywZtvmcV5uYQ5lVsNXe04xKbEf1LU=; b=YFoNCyfqhIP6P9ZGIrwvc0
	lZdq6vLMlsFDwPdl7NiIsPaNaMazJccTfyEfyMHtYVVT+EXVe/SMbstbqlp6HR+T
	0AdSeWsxNJATaSrG3tWORNfHyzh+gDejUDYV0k2aEJ2lpPXVGQfBYWF9LiK+Wvp6
	ANs/xEpq/kiA5+S6Dhm8qC6wzP0XMW1HMKgQwxd9qNEHtOiPdBCsEvisvbVWnKX2
	08749Zwxgap0Hl1ZPmyNm/WXLvNfJ2M2h1QOq8A4DOLEZv2NaZvTklXXx5N6FAZF
	Vm7Oy4ixSYA21P7Vvr/Y2Lhic1MDoCTlokG+J5gMTVsnh/JElhwfwCatar1DfMnw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jmwbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 07:39:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q7PE4h009937;
	Thu, 26 Jun 2025 07:39:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jmwbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 07:39:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4wbfU006397;
	Thu, 26 Jun 2025 07:39:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pdsxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 07:39:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q7dDb417564288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 07:39:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A4C85805D;
	Thu, 26 Jun 2025 07:39:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16D9B5805A;
	Thu, 26 Jun 2025 07:39:10 +0000 (GMT)
Received: from [9.87.149.7] (unknown [9.87.149.7])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 07:39:09 +0000 (GMT)
Message-ID: <7349ba11-f977-443c-b60c-c401cf58a23d@linux.ibm.com>
Date: Thu, 26 Jun 2025 09:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] MAINTAINERS: update smc section
To: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
References: <20250626051653.4259-1-jaka@linux.ibm.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250626051653.4259-1-jaka@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1OCBTYWx0ZWRfX2hq+g/X2FgyC LFeUXWKxcoIiwPtjuKCuiF9d9+mw+99hkfstxnIW7Dq2WFqP63oLY3qs2uGCGfloJsQPerGQUBy mRvlZ4X6xyeNtHPIMB3tvaobT89IHkrDfbbs9yXm08l81HSSYIp8nZS3FPEwp6d91oW82xB4Lp/
 sXgsxIXnXgT6yXA+a4fq1aDYg1eviZ9KndVinmc9NYGUWSo3QFcamXbGH8ur0uVc9mIo1Z2G8nt RSPnZ4t3xSrHsHJWezIkx8mysFhxdFFPp91zoVrA8kBmEHN+imH1bxrjOmqktZTShEIoNFtAQMQ BkjFHElqsNxqWxPmscy5B68RbhR0v0NqOS+e1WP8OdxByjx3CAVSVjrN1rJjy9NVLnu7ZEh0x76
 FY8s1MiNNZlIDeisP+Y0ZxloFo2KoTYsurF0WNfhOq7haFl2JsRs8oMtV2KkZIfLnMKE0Tau
X-Proofpoint-GUID: rhdBHarsnlOQeBsy9nQoyi_Enq38eJIh
X-Proofpoint-ORIG-GUID: -6JO3-8b-ByJPCxafyVT6NP9Mq-yJjLr
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685cf924 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=qPgYS-SWOX8TBiLe_hsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=937 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260058



On 26.06.25 07:16, Jan Karcher wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.
> 
> As a result of the co-operation with Alibaba over
> the last years we decided to, once more, give them
> more responsibility for smc by appointing
> D. Wythe <alibuda@linux.alibaba.com> and
> Dust Li <dust.li@linux.alibaba.com>
> as maintainers as well.
> 
> Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
> and Mahanta Jambigi <mjambigi@linux.ibm.com>
> are going to take over the maintainership for smc.
> 
> v1 -> v2:
> * Added Mahanta as reviewer for the time being due
> to missing contributions.
> 
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3f7fbd0d67a..cfe9d000fbff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22550,9 +22550,11 @@ S:	Maintained
>   F:	drivers/misc/sgi-xp/
>   
>   SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> +M:	D. Wythe <alibuda@linux.alibaba.com>
> +M:	Dust Li <dust.li@linux.alibaba.com>
> +M:	Sidraya Jayagond <sidraya@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -M:	Jan Karcher <jaka@linux.ibm.com>
> -R:	D. Wythe <alibuda@linux.alibaba.com>
> +R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>   R:	Tony Lu <tonylu@linux.alibaba.com>
>   R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-rdma@vger.kernel.org

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
