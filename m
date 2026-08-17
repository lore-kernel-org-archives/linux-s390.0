Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32523C0606
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956386; cv=none; b=F7P6nOv0XIZlSM3s2moxMnmwMmZyUsF+x56LtGEWHvQ9fN9aw7H0GuB4G7sxhMWAWiWfMUGUKLIf7SkmC8HUBkk4AGFDL2J0GctYPCVGv2CZmlpZ6cM7vsWs89giQtIFz+gwp59yAeB5FINU1WnB2mxpyxq3v4wV01KrKtLbpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956386; c=relaxed/simple;
	bh=XUgwNpMM5nO6R1X1PzF/Vaa4yKXLuKJx5Vvz8R0GvjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGNCxvFyUM2RI2/eyvpRX/qpRv0XnAUqnC3BAw5ZdvTez4gIS7UB3Q5sZAGaBivPPp/F4FxbDyYypYrBMUavFH+BLwE7ej8INAQAuN3xmGf9ZhOchKDhoioLsV17m90YbcqVlqdOmpB+cuD2KlgRirL2bDEQsDAP0qSI5GcYOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GDQiZo9P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GDQiZo9P"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVdvH3727923;
	Mon, 17 Aug 2026 08:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SuS5zr
	hOdVR2kcdMkzR49E9LTt+MnFeMzeh6X/TpiDY=; b=GDQiZo9PF7caBqG9T6MNfh
	V0koLWjeeVIjC7AUUrkuammMhsDNW0KNTm1qycZm2UqixMR4fFpey0VbFOjDBwxo
	cQmWwMej22Lr0HG0okBLPdol5qMM2IqkMgd/KGTM9hXmwjWWZHO1lIdw6aj5bDVM
	7nz0qBldCqs2OPqrKh7kIFWKs/NSl0CVe309n9aAj+2jITHD+thaOiXjic6+SILF
	0HFu2f6CoHQjwItCtP2PTLcWLWIPbSXDxqD4gY5CcCz9DdEVP+NqnQM8eYXb+Oj1
	ztq8fDq8lSRraP0DO7mJXCxr0jlyHas+7rzOvGq5ZRc+LgbzelXE6WggXHS3suYg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4h9tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:46:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8fMmt029634;
	Mon, 17 Aug 2026 08:46:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvwah9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:46:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H8kCVP49676586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 08:46:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F7B2004B;
	Mon, 17 Aug 2026 08:46:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B38C620040;
	Mon, 17 Aug 2026 08:46:11 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 08:46:11 +0000 (GMT)
Message-ID: <86b9b530-063a-4797-9cf7-ff2d62e42b73@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/19] target/s390x: Minimal protected key AES XTS
 support for cpacf pcc instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-17-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-17-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1dxkNKevGT0Kz66zKAcCcmuzGAyv249k
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82ca59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=WiiJXzFiPMjYteBh_hQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX6KXS5CY8D3Ke
 GaSncUpw6DP/tPUPJG9y7oL9ab9efHNHzrSVYb/8WHvy+NirjGC+1zzjgOARq5a977DFWgNQXsy
 S1Iw4HDG3zOPk7pgid1oHkeJhI3Mg5I=
X-Proofpoint-ORIG-GUID: 1dxkNKevGT0Kz66zKAcCcmuzGAyv249k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX74NQWWV/Ar76
 8q8XbqX6f2mFKR29aahcw5ho3R4fcpCdDZ/tI7OFaFmLEiQKxYmwawhSpAuGeNUl1PaSfun8c5r
 Cm/yUikN+1QMp6f6ufjrk0wWqgj05DGzglf1YycE21VzclIX7UkpNgLHUc4uCs2jEHSbKDQbg9K
 9N9nbJZbzVmrGOKeKUPmwwD4GZ1tQ9Rd5bIYIoLk02GNew4kLN4WiVpd86DORftY+/Mmh4N96yY
 PZ4PFYnU3+5u4tImJJtTYx0bG1fgSwDTlxtFDK34SnGsOF64e2z3Elg0DCFcvdQVVDAog34XALX
 fMSD4BoS2/ceZi67M4ftUawRj8ggorg7p21aLpV9OVIB9iSouo/z6dRuAIeKf+WRgO6Iz1D6kwH
 lHMHUxBOKTM1D1Qk0nBOSkXw05wteqsee1ENFZWYXIZR3sNCLuq4SG43KbAvFIzW2DRr0vUxLyr
 Yu4qihEflQG5pTuy8Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170063



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
> and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
> case block sequential number is 0. However, this covers the s390 PAES XTS
> implementation in the Linux kernel.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 65 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  4 ++
>   4 files changed, 73 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


