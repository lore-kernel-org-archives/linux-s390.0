Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575563D3D12;
	Mon, 27 Jul 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188159; cv=none; b=lcDfOmJUdren7w18ss48O/oEvZfGQI0HMl0tmviSp6O/mvlOBnCFVExRflue9EsOfrK7CtXxR4+ra8Q+VpWDQ21eMOyukIRPcEYW2zbPYxnuxVYh3dc3uP6sAO20kghYwUMdEhRyI0FDjl5hd6xPHgwA9+3Zy66e4oBh1ECohgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188159; c=relaxed/simple;
	bh=sslahAKqFMNzt641eHji6bzoZpDcjvSoPENfzDY5eJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diz4ntyZuiNBrBpmmf4mIuRkxC46F2IxZi7LEJ3usdbwP6t2sSmN1up6Jd2UOsyG1GeyHIfsFp0/pBTDxi6OSH5J8a8xtFM/hRyaGHJMuq5VkHdxm/4z/XTb/5ql5cDvVplFqDC/zqEj9iNTxHDgh8LldQzzMDE4iIQF+iXVRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I9LcjWVG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9LcjWVG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHfEt2994647;
	Mon, 27 Jul 2026 21:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dE8rZk
	wyaPm7qAqM1crLFagZD+7Yx/kb2l9/TqZUES8=; b=I9LcjWVGNbEAHJuOZPxVph
	ckbbnyBcxSY/6boE56T2eXbHXED7Y7iO04+Juxul0i13vl27zPRPkM+z21bVYt9v
	UwBuYPrS3MCZatCLcE7YN2l8rxZZIvIBEV5Ef194PS1L1jWBlgDOY/qJX/13aN7I
	3T1VryRB1MQ+Mbuu/hY/9b/IB3/un0t46yFn0qCVcpFiHzpWD7GksIlzAyPS3bCl
	NH+OtVS2SZAQQqWLx1oJRv59Wpm9hxLiBB3/FbHkPv3jStyLcJ0ibBitlEXBDVoO
	bjGFyzRAFAwrqsK9DfhJG2kWAj2oQ+cpyjTnYRPRwIfYyta66+lUCMAFHYNvX0Xg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcsqxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:35:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RLQGGF022426;
	Mon, 27 Jul 2026 21:35:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg6whh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:35:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RLZtiT1901064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 21:35:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A19658057;
	Mon, 27 Jul 2026 21:35:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2305805D;
	Mon, 27 Jul 2026 21:35:54 +0000 (GMT)
Received: from [9.61.242.187] (unknown [9.61.242.187])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 21:35:54 +0000 (GMT)
Message-ID: <73119673-8b77-4f39-a313-a199e8da55a9@linux.ibm.com>
Date: Mon, 27 Jul 2026 14:35:53 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] s390/vfio_ccw: implement a crw lock
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-11-farman@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zyvaumYtoj_n3jXSl9la74mCE62Phbnk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MSBTYWx0ZWRfX3QfaZAsfCMTd
 BqIK+1hY2FF3TSwFglFdNBivGeNacYnDDFfah38hmDoquy1PoHm8fkXNDQaIk+cJ5NFtnMSPpBB
 YMmTMITzu4WGudWrl9sWnwLTTp52kOQ=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67cf3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FSRJRI22FEfhziw6eBIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MSBTYWx0ZWRfX8/sT8TEx9P2w
 MvnIZachfPKNxB9cuiSIhustO4OI1pp5HICfeBk0afPaDBEAGZ7g0BxQJ0rVq+nL+jMlfZF4/zj
 xoa1Ra9sgFequSySXJU8JJ9vIa2IGW/pz7P/lIrNotbokPcCGu5OAMi86Lup6o7clBCeppdZy8s
 AzpKy7C4b+GxVQ7qTmxT/c/2zm/JtyceWL6ncSqsMcefrqzYRjXGYU90qy+rwI5BrGoeDn85v08
 rogk8PEUaerdY+3Y0I9EjMlYJ+trHFb+BWbxKvXawaNLqy7u1Pb5/G/9RFFOhRcVbB4c00qYZPq
 FKbiwFIxwrqQFFeWsfRqkmf74cNPpl3PKUhG73MxhkW7LeUGgRa/T5Pr5pLf+v3F2guXUDP95Q/
 VUjvgWZW6b16h9jjty8SysnzPv5PlGMuUX3XJBMfwOXD7RsuogXlP6ygMR6ukCzmXm5sYhIYCMN
 Ya2nPu6n6Zwt1Em+1Pg==
X-Proofpoint-GUID: zyvaumYtoj_n3jXSl9la74mCE62Phbnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270191


On 7/27/2026 12:22 PM, Eric Farman wrote:
> Unlike the channel_program struct, which covers synchronous I/O
> submissions and asynchronous interrupts, the CRW region relies
> exclusively on asynchronous events coming from hardware.
>
> Implement a lock to manage the list of those payloads, to ensure
> they are read cohesively.
>
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc:stable@vger.kernel.org
> Cc: Farhan Ali<alifm@linux.ibm.com>
> Reviewed-by: Matthew Rosato<mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman<farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_chp.c     | 26 ++++++++++++++++----------
>   drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++++
>   drivers/s390/cio/vfio_ccw_ops.c     |  4 ++++
>   drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>   4 files changed, 30 insertions(+), 10 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



