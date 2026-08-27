Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA91331EBC
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807179; cv=none; b=BCwnPcGR1o0G0DnKcm7fEREqbnhL1hkv9xtrsnntyZ1PrG+/iFohznJa0h3vYNQ2FZ4Qdk9LsZgMI+kL4g/SJ6/1P1b30lx4bzO2uyRQg1MJe7bedkf0Eszvaj4W1oKAxZzGyNddzL316dCImiW78EOduVZmedEtV05hekr9rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807179; c=relaxed/simple;
	bh=yBRLG+s3/PA4il89IeA7KXz+qRZ01idqvUzMOcU1iZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmHB86iiUEM5dGcSihI46B2irjzZ9vCEUGYgDYWBGFBLQywffmMtGDtv+xTTKrtgWXuoSt9AdfS1Cs05pEoWl6fbqSAZPtkEIfC2F7cj2HsjeHV7Q57AV5XG0DXK8ZjvKeh01361IMgdSS/JnuXYPojdS1YWMXcr9gkca2K4toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DujAH2J7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DujAH2J7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VbKM1823545
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 05:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XFdWn8
	7/VkMgVJrfx8zhLT3zukTCC1FxyJSs+5m188o=; b=DujAH2J7u5Bk8+GxC5C1KS
	KAg5FRXTNy40GyIM5w6UTjIGksSxlH9mFTlYzTl4Fjf+tBPmYw+5OYOdQZTNW7kt
	ySvjsoiIKA4v7uhwKtVXrGui5BH3M7VS/eaIwIw5S+a0czinMd7EkbmVpBFdGHET
	Fjsi2E1Rn96xD1cJa9uxjModQlp2ENsgLq45qtJlpSzns3sujffWEkherBxRixiC
	6RO2NkTLwQpLZIJlGo4m1KHgkygtsjyW3AD/B974JpnU648HuLs1dMZOMbFiWpFf
	WyffPX3xylAacbMVd/21aTBZqL4S83xgqJbXTM4JGi/bPc4gbZRrzKPaShxl/ZuQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g53aur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 05:06:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R4uI08027672
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 05:06:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k660g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 05:06:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R56B5551905016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 05:06:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC6A020043;
	Thu, 27 Aug 2026 05:06:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3F320040;
	Thu, 27 Aug 2026 05:06:11 +0000 (GMT)
Received: from [9.224.68.213] (unknown [9.224.68.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 05:06:11 +0000 (GMT)
Message-ID: <94c20832-0eeb-43a6-b5c6-4f47c4ea32b3@linux.ibm.com>
Date: Thu, 27 Aug 2026 07:06:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/crypto: Fix out-of-bounds access in zcrypt
 message type handlers
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260826141252.113706-1-freude@linux.ibm.com>
 <20260826141252.113706-2-freude@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260826141252.113706-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y17rkth-7CzW0vNhnmOw01rXIyXAKJG1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDAzOSBTYWx0ZWRfX6nfnG5+Wh0jS
 5mATcb7O8QOuybKeRRnP1nmtxvPp/Wib7d30B/ApuQYkDjWCF/yNo8+UIsmEMBQ9UTM6QfpVDHi
 IVTUsvPz4tpzHjY0kRJ8qzNR4dzZUTY=
X-Proofpoint-GUID: y17rkth-7CzW0vNhnmOw01rXIyXAKJG1
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8fc5c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=xToQmiDlzRdd_f2M1PEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDAzOSBTYWx0ZWRfX6V26z0PTi7j6
 aUvx5/tB4VvW9gUqMD9D3bh/YL2nb4gmUjlbEzOppaCYtetudoYsbL1LeAyouhPuuwD9w1P1dcM
 QRduwOReriOef2wfQ14PMBFJMW4sEHLPHTmh4uQ0vPeoMno5gQJo6kzlvVPHK1fFfFQERjp/LOZ
 TMJzBlLf1jJmW71O9JKotwuJSjFy2AoqeK1O+ZAhYQQkQ8KDy6DCmsEoQ2cDLGJqDHYgtUcbLxo
 NTawC9Wv0Jw6D9dLPwns79CfvTfkuRrHOpCHIZ1XmCJL2hip4G34frfM5AZsa+a2pWWaiIOawSj
 31a43wyC+rd+MXRnd+RrEp6jQGzQSSLMBl8grjfVDrA6H77JfI04FfI2KVKVFZ0KzBYnk96fyUm
 qH6F5w9h5d7wkJ1lAPtQ+AdrDgk6Zyn7ky97oB/5d9v9hqcNwu4FQaLixEAWcXy5veyDlmqHSsb
 unANWyqOBrj3pHM1xEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270039



On 26.08.26 16:12, Harald Freudenberger wrote:
> Add length validation before accessing reply message structures in
> zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
> zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
> potential kernel memory disclosure.
> 
> The handlers now verify that reply->len is sufficient before accessing
> structure fields like cprb_ver_id. When validation fails, only the
> message type field is overwritten with an error code, preventing
> attackers from mixing user-controlled request data with short hardware
> responses to bypass validation and leak kernel memory.
> 
> Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/s390/crypto/zcrypt_msgtype50.c | 3 ++-
>   drivers/s390/crypto/zcrypt_msgtype6.c  | 6 ++++--
>   2 files changed, 6 insertions(+), 3 deletions(-)

[ snip ]

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

