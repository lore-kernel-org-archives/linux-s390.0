Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DB2EA481
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763518; cv=none; b=jK8b1xnpjdVTydn9y6QkToIZORhjHGVU0mBacqSmauc1RGO2CvGkhuNw8meoBiAzoiLywZvzoHh5Upj+zOL0wRAuoYl6PYlzFPLdWaEt693keTXiKZHTTzcwBtb2rcl2f2BwpHYkH/6mHXTEAr/IgmSXewQrQvxcPOCI3xxUGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763518; c=relaxed/simple;
	bh=bZzi6D7cbbFv1cTDwTz0g8FrchlIfk+jvajJsnRfHG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYw91QTVCjkk1AzzmUHdTjLkNMyYM3++51HlgcFitIWuM87VAkHZYmqe4FyfiRdSzTtMrLiacm57vy/YuecDp5NLad7GhTvzIrtN7YqR/h6zqhmHEoMeovJeVOyvvBED7aboMYUIBxJbaktslZit7+rKev56iHgZby5f7PivI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W6XHLGgl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W6XHLGgl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmWri1000576;
	Thu, 18 Jun 2026 06:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xlbQHL
	7hfw4CBF/pPGdCMk7QbCL/frsMC2oG5PqMGgU=; b=W6XHLGglaHiSY/0apu/zKv
	7NzSSd8bQvtsKeHNHNp6sAlxjS/8MlgHiNt2Y/HwSy6jvuL/ke5YJMWLl9GM8qIG
	LDRhzMjo5dGLwi27j8kr6T523CZaCc2AvanDtW7I9Bhmjc0c7kYvCSQ0tGLUiJ0f
	1pSbf+Bd7S9UONEA+E5LeK62a1vaWCRERy2YjDh+ha8nZlXsAzapi2a6EJI8WdiR
	YaYduisksLWxA8Gfya4l7Xzx3ZqqerZoY3iL4OAc0DN88D5jG0pVY8a54piIvYaF
	1G4qUK1xuh2zuIP5FOaD4kLnixBPXXJV9ZNPnkNbaDClciOW+Vt68FXW22QCx+gw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6jpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:18:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64ZSN013479;
	Thu, 18 Jun 2026 06:18:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722b4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:18:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6IP0L58327332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:18:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8024120040;
	Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E6CE20043;
	Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Message-ID: <e427e3ba-49e0-4daf-820a-62942173fd88@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/17] target/s390x: Minimal protected key AES XTS
 support for cpacf pcc instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-14-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX3PMhdnl8uwWD
 FX4FkDLf6FecOfR+t1zJJU9MP7fQWKoU+YG2SDqSYOUih3HAE7epac6CqZerKtwguF8nDOUHe1k
 jBFI8rkyoaB5Vurme3SQVTJvALem08hbLfyULR9PTtBqHgMt3PGgXhtR/rW8+sIW5bcnJB1/aIz
 k8G3k4jcjBStVRA0/vxufMOemSbXfFZe62ffUtTTTtyqP1EZDhlgEMTyclQ2lf+IUX7rVDywnBm
 OML7sOX3GWLkmlFV3pcDUoIP76hv3PoXQ4ZNgqHi0lEg3CvmYxdzNV48QTygessB5tKuM3Ugl0u
 vcr00pNXcS2hPWm9AniW7kxjOv7GQ7pNBumsXaFyEH6uyV9rV5+5jQRRP3HCvzw2PNVaW/FYODD
 e/BT7p0XirptNxunTfjUD7UIdh809259+A9jzTnsy1ddawiEkXMTVeAXuVIMJelBFsRRRp5Lh/o
 qYUNOwWpMkL9rTQ5HNA==
X-Proofpoint-GUID: PdxUSfULzifwCStjajX1pFQQ07aBDkZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX1rKqhhFCJI6J
 yKdKfkS/1m7B6NM5+kqT5Bq1BkGjM4+KMr3Gw7Yos2U/e33STaCTdQbpU3bYn+JsXB3di69uAm1
 vB1xxTrBmJQ56lPXLTbLkssoafl3Ov8=
X-Proofpoint-ORIG-GUID: PdxUSfULzifwCStjajX1pFQQ07aBDkZW
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338db6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=eUxyj7r3WZgfnnLVGjMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
> and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
> case block sequential number is 0. However, this covers the s390 PAES XTS
> implementation in the Linux kernel.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the suggestions:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  4 ++
>   4 files changed, 88 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 4a131dc191..126bacb281 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -943,6 +943,8 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KMCTR_EAES_256,
>       S390_FEAT_PCC_XTS_AES_128,
>       S390_FEAT_PCC_XTS_AES_256,
> +    S390_FEAT_PCC_XTS_EAES_128,
> +    S390_FEAT_PCC_XTS_EAES_256,

EAES -> PAES or EAES -> ENCRYPTED_AES

>       S390_FEAT_PCKMO_AES_128,
>       S390_FEAT_PCKMO_AES_192,
>       S390_FEAT_PCKMO_AES_256,

[ snip ]

