Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AA3290AD
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763679; cv=none; b=VlbyE4oRRTr55uAf0MQEmQwdguPqoxOYe4u8g6Kij8v14Djb44vRU4Re2zJE7X3EN/TEG1/sCi0O+ZxGWlR1Z/s4uR50dQJ5qkli7fq4fcCQZ22TSSFWB7l6KezgpGRaCvK1Ov/wkAJwbladJXDglHt2/3LdminyA34sDhD30Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763679; c=relaxed/simple;
	bh=HAvefAgPe3okymN+VLGNNIQ0eFjYXCv9uMiUtPSjrbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQG21utE2S1JIp8Yi+0gINGsYZpsJcLaUy+zF5HADI2Dr8Uvo0raa0hyah7sY8nqxPjx9NkdJZteqbXbSNnUtLqD+wvgoFQ53U2F2FojHytfEqQOEGbjNUzTSdC1AHHNYFNQQkuzomTlRT+whXCSOhZnVyhUZvxh34CLfHApHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FctnFCX+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FctnFCX+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmK6n1000460;
	Thu, 18 Jun 2026 06:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A+xmfZ
	sGRK5zq/kb57rEfyEptBhq0JZBwm4Aa+tV4qo=; b=FctnFCX+zzkNG7wLL1lmDV
	DKXqv66AcDUSuhfQMpCEi+ypSrLWbi54ocDj0VO2BbXXz7B/xyhe5Z/16cJJ9wqH
	caCKWx1xsrDXatz38UlyW44diTiNPKhfb//fltnh9cWWvGAL2vVAwJxiGdF3vL8Z
	Nlxt7fN8se7TGVKliBRdyD33XsyVtbzsJRhtKcHUwWvOFpGORqD9k5KYBI/hKjG7
	b9+HBt6nO56HHDYi089ADxpWsaSukHWAfn0/M76W6394CPjnv/THFFroCG4co527
	EpUvoRP4EYpNkLx/hCqwINYZgyxYNRmYO3aWccvb/0bTgd0aZlRf4f67nf0gmqrg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6jxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:21:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6Jc6U020066;
	Thu, 18 Jun 2026 06:21:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172ab6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:21:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6L6Dx59638128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:21:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F29A20043;
	Thu, 18 Jun 2026 06:21:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB4C20040;
	Thu, 18 Jun 2026 06:21:06 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:21:06 +0000 (GMT)
Message-ID: <f05331fc-d2c5-452c-8896-a4b532f5de6d@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:21:06 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX6e4UhCaQ+F6T
 UsVhX4oZcyAxeoJzas4MMxTZhczzpS0kBvMqe+KMgnBB0UHv3b3UMFAqqY/wN/mtxu0k8kjWh9J
 OZEI3HAzybgh9n4ganN7vjdQWly4KmS1vIK2zt4zEyYmaOhIcnQhFo/da7RHtJL/TUvVULtjjrz
 oNfWjv73P35SjT4QzsJBNbEm1tReloM2v/QAKUI41xLzLosJ5X5Tm3NI7yoBzDD69DsCuTsofFl
 3cLKdWFO0UTGTYGJqTTRXzbnVp3tAh3tLsbHQIsX7LDca9vVJoHL4j05bsHanaOzvuZAFJtPL9x
 wOCQM7vWBnYqIVjNNtGOkixo5q1Z6+0er+W9RZVCEOjob0KPYSQxeerBQlTEMacLSCkeCrVmOxr
 9AACVmyYUobVtNDgqDyMQMWtby4bS6XJ5/R+tgeAFtkabztEWrRXx62FFDVCHFJOxe2VZi/EnKy
 AKJAXfjrnVzAbaX5WSg==
X-Proofpoint-GUID: 8F_xkfEcMRodRQ2nEMLIL1n9-etT8BHp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfXxpdugRjB2F8x
 2NCvUZed/POTFHfFFET3cjFRpDdKTYSJ85q5cPzryJayiIuZtMxB5FJBXvLCRGjCl0z9Xi1HkE4
 fHQZSsYvnJ8kw7fdymntChBG3+jb8eQ=
X-Proofpoint-ORIG-GUID: 8F_xkfEcMRodRQ2nEMLIL1n9-etT8BHp
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338e57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=mwe8efuGiVFpxy27h4EA:9 a=QEXdDO2ut3YA:10
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

> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 60c3ebd79e..38f7d900fa 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -206,6 +206,10 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>       case 0x34: /* CPACF PCC compute XTS param AES-256 */
>               rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
>               break;
> +    case 0x3a: /* CPACF_PCC compute XTS param Encrypted AES-128 */
> +    case 0x3c: /* CPACF PCC compute XTS param Encrypted AES-256 */
> +            rc = cpacf_paes_pcc(env, mmu_idx, ra, env->regs[1], fc);
> +            break;

Funny enough that you got the ordering here correct xD

>       default:
>           g_assert_not_reached();
>       }

