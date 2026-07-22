Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF5481AAE;
	Wed, 22 Jul 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718104; cv=none; b=L0IrM111snrul3OPHLbF6aMYWu7cNSomPU8RXvBwULHTxcUk3mLaTo4H05i2UnFfSRVKJSRE6yZUwvQYt91eh8HwGOW0+w0icDXEO2ZbEyZb98BtJgkosrQkph53fcfMfV9ftHCUyACAZh9DXlZKm1nbUZIAMv0fuMKDdO4F/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718104; c=relaxed/simple;
	bh=9YaNevITp5zziLKtTkueKQrfLGXZmMVSfB0pQXoOJI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTnvWxNSSjRLDHL29SM8Af5kqcuQUlz3CW1+ld3FRIPqnBruZ7r4QquZO+OKn5gthWTuqkIdJpsdHQWAdC9OIMyeNSdNzTEz2j+Sa4JZ6u4Uu8ecB6By9EYu0+4JDyQW1jgKgbb4s3VQS6yKakqbNrdKxBeX72Zvi8LrRDfOqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j/IMPHnd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j/IMPHnd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9C1ml3592016;
	Wed, 22 Jul 2026 11:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UvcPnd
	rlYMa8S35/lSIPRT5TPd5cMCuiLuFhgPF5ijo=; b=j/IMPHnd3VJXMBPfwqI/xq
	34frzBiFJQSjrBjy2rI++6RdHVBwjtE6CebGaRBkcY7+AVaCf8/6z8MapyFMSglc
	9OeOJmyHZqa0A5UiZpCdfCD99xj+mha5Nt008vkCaM5HHt4ahqBKHt5vbWFPoqmp
	KNldde9YVVsPod+km3RXGJ46e3TPunqt4loyUzs01gF6PlaL7UHvrXfFgycWv3ey
	m8+zWQruxDU3Dg9sgqMnSadwMEmHwsFF8z7RvcInYLDzxq15WEnCmhS3reQHKzU+
	0iBXQsOUMwNbynBp71rJMWnEIMiFkeb+WLCZcdNreuLVrPZUZ+93+DSsumoRpyYw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k9asg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:01:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MAngBr032515;
	Wed, 22 Jul 2026 11:01:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq751u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:01:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MB1WNC16057018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 11:01:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD11D5808A;
	Wed, 22 Jul 2026 11:01:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF235808D;
	Wed, 22 Jul 2026 11:01:26 +0000 (GMT)
Received: from [9.39.18.174] (unknown [9.39.18.174])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 11:01:25 +0000 (GMT)
Message-ID: <ea854b04-82c2-42af-a75f-2b2eec2ac224@linux.ibm.com>
Date: Wed, 22 Jul 2026 16:31:24 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS
 (SMC) maintainer entries
To: Wenjia Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20260722085705.56755-1-wenjia@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260722085705.56755-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a60a30e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=gUIg_fxKUUYeLYk5HKsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX3cwNjSiVZuc7
 2EbGoinfLbEACTvBviRDMbWILue6VjEiiD4bzxVwvN5rKyMSAZMixf6yzLwW8ApgVql7R+RYRVF
 3BX5NJBEu3g5TuvhW/LKHVcRcPe0Kbf6TfIlwgZZB2IC7KZ1ItWDQpUyidh0wW/vyL6LgYYiT9T
 XnjrZOVO8RH0nYpLk+fPjhOo72Wl2bj67xyMPZOv3M65CHvsoHtlkvOqeJ9zGAGQ8LEOrfAenIi
 saeByChyUyboymHuIOBpGu7/lUKs25+RF9pl8uk8EfXAYGFfGtlIpiwu37l0PuqP419FZ3IFZeK
 XPKGyM0VQ3fZsMRGDwKNB1/CgBMd+7/rREq9+qPd4/UB/CZPgyYiBFxLaJkn6GcsE1D5C3jFmts
 k4GhdOrXLEG789GTbxk9Z2dXg/UHEbOvV76yROpwP3oVHAC2IgW5A8XGrD6nBOdKZWOCm0D2pw5
 NzCkjtppYUSeaLgphyg==
X-Proofpoint-ORIG-GUID: GEAo77438hLwA3xtFpg0yfSs0kKSZ8r7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwMyBTYWx0ZWRfX8A99qo/ECPbi
 KbPB59c02UTDjCxEuXVutcYpVNbtdw3AjRgF7NkAGhNnC326aLNX6rjW/gEZhNx5u6fTbWrums7
 QWisZanbB1/dIH7oVCD6us5POs3cpG8=
X-Proofpoint-GUID: 5Djy9ADd-gmZI3y6yLyjYdpt53BQxtqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220103



On 22/07/26 2:27 pm, Wenjia Zhang wrote:
> Due to a change in responsibilities, I can no longer serve as an SMC
> maintainer and need to be removed from the MAINTAINERS list.
> 
> To reflect these organizational changes, promote Mahanta Jambigi
> <mjambigi@linux.ibm.com> from reviewer to maintainer.

Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>

> 
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  Kernels.code-workspace | 1 +
>  MAINTAINERS            | 3 +--
>  file                   | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  create mode 100644 Kernels.code-workspace
>  create mode 100644 file
> 
> diff --git a/Kernels.code-workspace b/Kernels.code-workspace
> new file mode 100644
> index 000000000000..9e26dfeeb6e6
> --- /dev/null
> +++ b/Kernels.code-workspace
> @@ -0,0 +1 @@
> +{}

I believe this change happened by mistake. If yes, please remove it.

> \ No newline at end of file
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ab8736850ea..f60ccc62e710 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>  M:	D. Wythe <alibuda@linux.alibaba.com>
>  M:	Dust Li <dust.li@linux.alibaba.com>
>  M:	Sidraya Jayagond <sidraya@linux.ibm.com>
> -M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>  R:	Tony Lu <tonylu@linux.alibaba.com>
>  R:	Wen Gu <guwen@linux.alibaba.com>
>  L:	linux-rdma@vger.kernel.org
> diff --git a/file b/file
> new file mode 100644
> index 000000000000..e69de29bb2d1

