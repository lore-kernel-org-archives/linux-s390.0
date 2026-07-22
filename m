Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36985126C03;
	Wed, 22 Jul 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725719; cv=none; b=n0WmJS9sbwXVcPJeof01jOIo+i+i2H8Y5ySwuyBiKQ0n/eh7bIxD3kH4zCUSjbxfoDr7JGpvMOlQ6u821S5/4Ulx6zcVNjS8SLXvOZzLq5MA67Kx+6Omab0QcH0RddxZBik3USS1kLROueNoqkM2xSBCi98lcIbDwkABP7Vr9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725719; c=relaxed/simple;
	bh=3HNBmMXvaB8DRgI3KgHIW2KHZNvU0fGv3QIVaoPR/44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzBl3z0qEq4S1ExzNRgDRXxfLxgqh3ADz7S3Na7zPCywIjbR8Mh1iBBaAODpBYHAi+JN5ArJrEY2MadeXgXkTdGTLNGTjS8jVrpGc+VEuoq7CfPZbJzIwXLxfpj7dZyCwKfvWWQzEKAFR3AAHM4PiEFGw/S0/0lhBjKX/KqoPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hntyl+Z3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hntyl+Z3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9Bsj23671718;
	Wed, 22 Jul 2026 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MGbfkh
	N+JtezAP6LHFbe/f1Ia9PWkA75eq9DLH7is0Y=; b=Hntyl+Z3x3P85VvGR3ePbz
	hCHms+QnHtM4e+OVXoq0vIVVT72zVGt3re8m56T7d87GfMkwuf8l9XyGUp6ihreE
	qvkYfOTgXmpGxkU/Y5MwgbO2ytSLNXlEnzRxVQLQkAQJNck3Y3fvXepNUW06vVPe
	bZLesgolgT3zN2IeNnfhfLfhbJpAe2ljIy2efsQPm9TBGrsELD37bFJfvvUKp+04
	X6vTzupbe/VmFTkmGCdCd/WaEm2nbjPq11yWDj952F51BCu2ZCo/2mxtPG0hnfBG
	fPTbsr3ASxo3JXIG3aeXuKET4shCbJrSuQD11sGuXoPoF7HyrmjckXj/AHOhEzPg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah9sbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 13:08:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MD71Nx028473;
	Wed, 22 Jul 2026 13:08:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah7b5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 13:08:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MD8O7S61735256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 13:08:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D55565805A;
	Wed, 22 Jul 2026 13:08:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DD058054;
	Wed, 22 Jul 2026 13:08:21 +0000 (GMT)
Received: from [9.224.66.107] (unknown [9.224.66.107])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 13:08:21 +0000 (GMT)
Message-ID: <920eed15-7e40-4e62-84d7-1d8263a7264c@linux.ibm.com>
Date: Wed, 22 Jul 2026 15:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] MAINTAINERS: Update SHARED MEMORY
 COMMUNICATIONS (SMC) maintainer entries
Content-Language: en-GB
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20260722122701.20514-1-wenjia@linux.ibm.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20260722122701.20514-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NjpiYUpLErlIruXEzTyW2gFEpnozKvae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfX0eKsNBnr2462
 iimMmLe3IAl9A+hSp7MAcTJFGn91kIMuCOZOGF3XxjTqbikWVDoyRzxryqarrE8/GWXxwQ0wc/v
 QH9cDyWQ2RmW9d5lISwDKqNdmOS7OXtIWEiPEOcFimlFCy1Ren8G7l9IXrIdnrkIJWg6fjOvBo1
 iLqpahhXqV/aWcdkxNN4pWwRGrfBtjMt+0HdYb4IxwMGlJl6OHX3d+EU9jo/7CmriQvlxmGlj3S
 a6/wvCqbVPUMBEkvImTC+SoARKOjs/8zPT7+9VVkCwfrD8C+j8H/OEV+i0Ab6+Zn3mMMmxDt9s1
 xWFobpn1+1uyUh7h8DsqNCWJ0cE5rxBRo7N3nf7Xf9GrVX1rqgLy6dCIhMGwn0iff9rENLhwktD
 jenqLvm1+ufrQTP+8r1uJDzFPHZEs9ph/0vxAomS/N8MyWoAs2A0t+ifKoDAyVnvSZvzqroAl7y
 qW+uO0mLFPe1L6HOWtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyNCBTYWx0ZWRfXw9VZGpgGRR5B
 UeyMP1j3rrcjmg/sIky7l3vVKaDyl5XeqVP1MuecrT7a6QfIQ4fjMMJnib6vh1fLmuVcHA/YFS5
 l8zM9Z6/KctrnQva5kNZIOvp22krUcE=
X-Proofpoint-GUID: 4xbAh7BO72TnrXhoYNDJIRxrpEwK1NkV
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60c0cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=9yvDrr_bpRdAM4W6hlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220124


On 22.07.26 14:27, Wenjia Zhang wrote:
> Due to a change in responsibilities, I can no longer serve as an SMC
> maintainer and need to be removed from the MAINTAINERS list.
>
> To reflect these organizational changes, promote Mahanta Jambigi
> <mjambigi@linux.ibm.com> from reviewer to maintainer.
>
> Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>   MAINTAINERS | 3 +--
>   file        | 0
>   2 files changed, 1 insertion(+), 2 deletions(-)
>   create mode 100644 file
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ab8736850ea..f60ccc62e710 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>   M:	D. Wythe <alibuda@linux.alibaba.com>
>   M:	Dust Li <dust.li@linux.alibaba.com>
>   M:	Sidraya Jayagond <sidraya@linux.ibm.com>
> -M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>   R:	Tony Lu <tonylu@linux.alibaba.com>
>   R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-rdma@vger.kernel.org
> diff --git a/file b/file
> new file mode 100644
> index 000000000000..e69de29bb2d1
This doesn't belong here either, will send v3
