Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30414CC273;
	Wed, 14 Oct 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980872; cv=none; b=GDuDJAAollkG5zMQmCKVfO1QxUKWOOuTlgWAtYoAKkKgd7A0rNiuquLv2Jz0TtT1XNY68d5Gee3QFTOTpzK+HQN2DTFBZPmy3KTZQJnizJoGjowVLS+aSdo7giis5KEYbMlgZYe8/mQIxsbMvVhThhBm1EuRX0TRBsxwvJAjCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980872; c=relaxed/simple;
	bh=aGG2qbTWFN8mGxnmyVptsvYmWUnxywdFI1v/hG+RFS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X69xXGdvWgQ/xAWVlODfQpV7hE+a0OOlkqokZezGp2jPprVuu0QjA2ZLfQFBMW9jcXV8QyHuWPuLpCVXOjtyGVnZrohIpmUwJSult/mQESJvHb475A7udGnDuQktIqW3nd1bakWaZDv8kCWwEhAk7L3oiZYFlNqWtxJTtVRr5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtE8SS2Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtE8SS2Y"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBOsnS2016029;
	Wed, 14 Oct 2026 12:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mRaORC
	N7j9jug7Hta8uZhtHbGSVrv+WNH7LgT+Ln5Mk=; b=gtE8SS2YwGuxOEANkIlilp
	fFrXM1rweF3zjuhVnMJEHUS9wXWb5r+zCSOxLeJEQSY9PeASg7rZYnIz5rDU7Tvm
	BzWxf/ndNLzpJUDowXBQZoT8Y9OMn1VWM2qNljMJXek7UdktVWlsJzPjQ0LbcPbq
	BiWHbtZ/T4WNcVmFlvblVPfx3muAHd5VF6W9DdZCBSPNzdo7PJnXiiiKbJZFw0mJ
	tdbZ3+EgR+NW5NzuEyr221ksYB5P9j5pI7kRtd0rpnpnj7IlT79cqLR1VspYc+IU
	yy9QTKIqLeGxB3jO+R1vgUUUrHObCNx5Nm2lufHBIfP+mMr+ABQkmB3KMwDBOvkg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugm8vp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:27:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8YMtq2585771;
	Wed, 14 Oct 2026 12:27:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg2h94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:27:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69ECRj7W55968094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 12:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03DC2004B;
	Wed, 14 Oct 2026 12:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A0F120040;
	Wed, 14 Oct 2026 12:27:45 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.31.234])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 12:27:45 +0000 (GMT)
Message-ID: <f51e6630-080d-4eb6-9d28-51e177b00c30@linux.ibm.com>
Date: Wed, 14 Oct 2026 14:27:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/signal: Cleanup coding style
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261013133453.2288894-1-hca@linux.ibm.com>
 <20261013133453.2288894-3-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261013133453.2288894-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acf7546 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=T3KARuhPW4_36WootycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QmwmBom0gTzvuVveQn4Xr5RybgMHWUoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX2mAF/8H8m/xv
 nXqHjSxCd6+ejEFBN4XDwPn5CwfDUnlzQBrk1SFIXzGogsHi+q5S6lWOhjXYjIrYObU2LooCcll
 c1IDYaSrT5KcPm83PR986UdQwIKEsTTCnUh3c2yrgsasACXWd8MTFrapmQRTe3Z/RnyCRWlpJ4Z
 vLAfE0VLYvmNzHCrvbmPrwQ66k9X72fQirLJ3RszYcTs74ZGBXQ4m8WmVQrmSHi3JKBWrcAqeqc
 Oa6WzeUBr47oSD2ahLZgHC1eGwU/+MqtmwoXBYanTHMYB0/f26V/HAW6mD5+sM7HPRl5OsndxUo
 1Ar6PyEY6PjnNXs+HP+nsJ8oDZFDgn2oMbEj0HZL/+IhyyYC0ogRgCQaUx9VHDckP7hwZL2su++
 a/6WzCn4LDrWvUBOnoA7amP8b4DTOW8FF45Zp93A2XQR01CWWc4BGUxVf0i2ZXOAbk2Ty3rtJdR
 Glz9UTNVp8GmF7I4U7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX/rpBR007BR46
 L61dCbzy4R0cIyFZB2O6SwZaldFacA3Vog3CExibq+NFWXYHWt1cKg9BInAXNmnvtQI2Dd6SqoA
 6oyhB2alWuqwF/bCjcpxL5v5QGX4q7s=
X-Proofpoint-ORIG-GUID: QmwmBom0gTzvuVveQn4Xr5RybgMHWUoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140048



On 10/13/26 15:34, Heiko Carstens wrote:
> Only whitespace, comment, indentation and other trivial changes to
> adopt signal.c to current coding style.
> 
> No functional change.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/signal.c | 224 +++++++++++++++-----------------------
>   1 file changed, 90 insertions(+), 134 deletions(-)

[...]

> @@ -257,94 +249,76 @@ SYSCALL_DEFINE0(rt_sigreturn)
>   	return 0;
>   }
>   
> -/*
> - * Determine which stack to use..
> - */
> -static inline void __user *
> -get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
> +/* Determine which stack to use. */
> +static inline void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)

Checkpatch complains: this is now longer than 100 characters.

[...]


Otherwise:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

