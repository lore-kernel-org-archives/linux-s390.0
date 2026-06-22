Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566A3346A0
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112785; cv=none; b=Ahemv6vbE9VPFgCL8jXUgrui4lF4WAB4CVQNe40Eo47Y/SYKS620fsbZPrq4v1aj+AOXssj6NoM3YPzA8cF45G/akeHAa0/AeJwvjzcbQ00NLkEz4dR4/86VNYndkCjoPpvfBIm8Mx/BqlKI6A2/kHBh/amCByDtM6sJyM2FA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112785; c=relaxed/simple;
	bh=lYLE8mYiBhFN+P0aMvbGLf43y7ShL24KwtasVOGj6iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1gHbSPiiI8uZpDQlfq8mileZvqXLq/ethby9qJKlfQER6NMLtlsTzApjcmnvM9yOx515rzAOpevJhync9gF0Esiuuo6jBMoKdJVaG6DX8qGRc0pfPcVeiIyqOQErPSPduFPyAm8ohzcgo7NnjQLLEeFmgg21Dc4n+jdlqfz2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1B8Vjoj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1B8Vjoj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5IY221572644
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SKX0Zo
	7oPVLOfKdxzBO1NilNwFm1nQx2qaF/KBryoxw=; b=h1B8VjojV3zb3RNJkKkHAC
	K0FL2/4RgqbWgF9S1XT+UHb1nOMCUzZy9fUFWU6Ect+8KxtSOUCFBy/W1Y/J9mZ4
	n981t+jEoRSDuJVkoE/yn+8aOAx7DCaZrSBdIsw1WMbo5S0PbMHy3c3zHSj2xvO6
	Gw2qQZljFdm6u52rHIcAT/1VwO2FczJe72F36s9DrNC9EqWW+0aoeu5Q43nj69E0
	O9ndR8E8g1Ci82UoC/lsQ3kA/HKronDtFSkv4UMgBXRr8YkZoMcE5uhTuhYQJ2zz
	qg4xzoE0nhBJ96BSMJEf13TOM7YY/MAT6JmBLDF2kIyvyaJDDaSm4WNyUSE4NdYw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsfpep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:19:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M7JfRV017044
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:19:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph4wc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 07:19:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M7JaOU31326650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 07:19:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1D782004E;
	Mon, 22 Jun 2026 07:19:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914342005A;
	Mon, 22 Jun 2026 07:19:36 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 07:19:36 +0000 (GMT)
Message-ID: <6164f7c2-94c1-43b2-bdec-7f1b3307bdc4@linux.ibm.com>
Date: Mon, 22 Jun 2026 09:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/traps: Add exception statistics
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260617123350.3220729-1-hca@linux.ibm.com>
 <36ffea91-aacc-4687-8a25-7c4ebe7c9b74@linux.ibm.com>
 <bafaf879-74b9-4f64-82aa-2cc1ad7dd9d8-agordeev@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <bafaf879-74b9-4f64-82aa-2cc1ad7dd9d8-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3MCBTYWx0ZWRfX35s1BsB02y0e
 7T7kD/+oFeqyUijzyx/v6gkpf1UcC92kfEtoOLBG6YoGYaUJu7bCwHy4u8VqQN8voUuBa45geZ4
 93KNu/QN2CF5RnOLJeITGFx+h3HLfhiSM7/AU6HJ96PS7LziwGican61dM5hmY39EMy2EyDHcYi
 o1fEb81GMfkhFIDfGp+mJpRZlSlzKf9b+000Uj4z9hevxBnsUOfpBqaXvKTlZHH7zUDL4a6a2AW
 JRqSp8Vj8VctgelUZfv8t+RrJBuGbWB0qEH1siqZFnKeUhHoPyNGhlFwJwrHE5gv2aFFQuh3vJa
 vCiBd35NQnM/aFHXd0A15ukFCiZfto/8+LHPqXh+0REpm7Gd8BgpfgiTaQtT6x1XJCoqlO4w1p1
 UbQ7Lrt9YBh5IjAPm+c2dN90Ae2DR0rM72irXDzJ6Evnymnwz2eRvKmhKjdDEfUHLLcLxmtblwj
 2nqZKllrbDBZL6GxkVQ==
X-Proofpoint-GUID: 2On0cVrgpCIbkl3cJi8PZu458Tn9M6yw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3MCBTYWx0ZWRfX8JIq0lHHWQSa
 rEqVLcbSSFOEuAQBOx2MWcEzCvWWrlWgofcjlnTJvC36Fpdp6CZ9FrLHQHLVjgb1U0R9ut0PNeP
 gw0bgRYptBjVAxApEmRYpF9pvMZNCXU=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a38e20d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=xKjoIydlSz5RTcxv2qcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2On0cVrgpCIbkl3cJi8PZu458Tn9M6yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220070



Am 19.06.26 um 15:57 schrieb Alexander Gordeev:
> On Wed, Jun 17, 2026 at 04:37:56PM +0200, Christian Borntraeger wrote:
>> Am 17.06.26 um 14:33 schrieb Heiko Carstens:
> ...
>>> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>>
>> Looks good to me
> 
> Does it also translate to Acked-by or Reviewed-by?


if it still matters,
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>>

> 
>> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Thanks!

