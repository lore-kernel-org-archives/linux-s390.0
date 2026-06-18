Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231D257854
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764570; cv=none; b=rupTWA/Gim8YPEzNmUSHBJX/U/X9rZB1gi9vZPHjxdU1vIijwVeEhK185TF/j+Ys7yZEBctBXEXm++EIOUsWR0Vx+S2c3yinCjL02mt7VG8o/AQxENRK8sxol1mRdO/N7nNAIMaOAc7FIQY/qHrkiqis3hBMUC+xRbjjt8u0ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764570; c=relaxed/simple;
	bh=FpEzOGj/rOayM/xik0H1zRKbjdAs5pqd9Bv77c3a+kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2rbG/698oOUh2FsFPwX2bH2rwB9e+uX2/CBf3paoD/6OlFJepabddZ69PIG2Lc8QYGlU9gzv+an/Byt1x0vv/r4VIfnQLCJXm8mxvMdZFWfYCXP7m3sZOOUcEq4iQWe5dMaDSjnhWC8/mSLITw5/MrUZk51kQPdxxGCsrMgx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tVoDzHxj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tVoDzHxj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmDkT1106562;
	Thu, 18 Jun 2026 06:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tgCjdl
	yGnsCQcxuHwZ8S+HXp/ymtrYmszQ6/864AR30=; b=tVoDzHxjFWSYyUFwUNfPv2
	v8EWnrOi6pm/WYWP2tusCSYaDM1+1x1No9FmVEjMkVpaCySgPwluE24ebnF3FnAe
	5uEmzdLdo5In8uXLqC9DXFj4/HR1Q2UAxBY0eZslScOJFJTeR/ukm12loTfr++xc
	DmV6la6LjXXhOFkACheMbs1yZxPAUWZ5BhOfb78JjcUsGAi+VcpDIP6LztUv6IGV
	kr9ScJH2CzNrifVCtg44R2lpBQllMGbX3tFsYPLKuEMKg7D3FNgnqb9lBxxyw8lW
	35zIywzz1hvV0s/DZbNtKcUo29XkZG+SfN1Yi/Lau3wQrPNJN7Q8WTBFnbSWtR8g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtpqew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:36:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6YZ1c000627;
	Thu, 18 Jun 2026 06:36:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722ct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:36:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6Zvin42402254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:35:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC2120043;
	Thu, 18 Jun 2026 06:35:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E06F220040;
	Thu, 18 Jun 2026 06:35:56 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:35:56 +0000 (GMT)
Message-ID: <5687001a-95db-40b4-af59-b2cb8c42ee4a@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/17] target/s390x: Use generic AES helper functions
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-18-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1vP0oAzXlu56HmjE2Qwm-uK3VXcmC621
X-Proofpoint-GUID: 1vP0oAzXlu56HmjE2Qwm-uK3VXcmC621
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX0P0g6y4nogM0
 XfNGYRRV1QZypQBMcMFJiA37mLnDZCW6XdQD46eC9eNeNS2DD+9RMbOK+o3Y3TWEQYnhoPH609E
 LBVydBYj49jOfeP7lfYXcSTCMb59AfnuAV1NySrtgZma92um+yFGq6NwCanQGT7al+6zK0UOut0
 OtrAoCUX12lXMFjT4vwdwN6XcyKPWYdCW2jMRG5+nD1xJ6a1t66j0KykjNG6CaWVUgOaQ11l0mr
 9dY1ygIbpiwDsDXh/f4P7vmNy7oSstxtZ+/fbvNFmvEIOTIC1buocWrxFYongwTBFmEh/L97vOt
 YoValBE2T743/qzKKIOSs6gH1isE1wymEBKJL0EsChsqsMi9j79jEBrEHTDmWyTzx0CxISgd9+0
 Ed0UE99UHYD5ZJq1Gmew6M1VTBSMBuEcljE6Os1ujIOpsglyQHcJuQ2fGN3y6+ou1M3q/Bkjlos
 HHauX1a5oaYlYJ1jkkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX4S2/PiCYtkd8
 KlVJP73NBNV44dK21nrvEMH2md/OmoEtecOOOSqB41sPmPkI0vXiAoR10H/IKsLKAer8mp4jUrd
 Tv+vN0+6eLQehTgpvNZWOumcrE8Gv/8=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a3391d1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=5tY82SRV8Fo6CFT2nY0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180055



On 17.06.26 11:48, Harald Freudenberger wrote:
> Rewrite the cpacf implementations to use the generic
> AES helper functions from crypto/aes-helpers.c
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

LGTM

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
>   1 file changed, 36 insertions(+), 88 deletions(-)
[ snip ]
