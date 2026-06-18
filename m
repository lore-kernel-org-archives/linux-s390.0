Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6A2DA768
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764101; cv=none; b=pGn6QSXu5QZ3/ZCJmo3tIlgu9C6e/kYa/1NQczh9qOgsmUP6Zs062ozo1/03lsVq00x4VtUrx7k18kiLT75W3HO45JsNiFSDaoELuCQR1Z5cXOP4Vubm8zPF0o39/U+jYxgvk7fKf1O4uIsSIyptkbf38n4UnZc0BXwJBVhNQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764101; c=relaxed/simple;
	bh=+3WlgsX2JSiYQSM3lmhaIFcnytytJWv8d4oC3UzNTuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8W4pK7Wo/cgaXHezPdOYMfd8s5SnskG6w9+3NY5eOHHUybCm6FQoQtym6X9/hZIWOoqEAzUDBRuQSnMh9R4p8x6Ga3PbH2eC+OE8pTnVHL41BoIMnXDFWucMqOb9kyJGdxnAASPXJEmgfVjx+sXugaq8Avqp9bIMQwx6G0MRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FgE1z5jr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FgE1z5jr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmHfu1000291;
	Thu, 18 Jun 2026 06:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zmpOwP
	EaheRvJ3baU/R3TQDENnWzW79jt9AyM1jcy4A=; b=FgE1z5jrs43CN8JevrmlDE
	A/nRkZCPVPVI6Sst1/D0h53hREPF02p7BGjeRh40x3jG0C4uv4kfz8vS3vwlQRoM
	JAQF7mgH8YeKsbiQzntzYlcOlZ/4/ba2KpXg61w3z9lcKO1LhwUTdjnh9RUk3CBP
	dxt6tw/PSxlS0kPQaJyWeOJatlV8JIZP54klPEBteMcPiHZQqrdmw6QImnxdnUtk
	d5eR/g9a12kRGdVAHmzuz0Y3y3r+8ssG+y3LJaz/V6JHnTzZpYbA5eVdqJCJXg7D
	FfIpFvcx6zeT8Zu8qE1yEuVhQkl7s6GAwnn1RfSNakSExBJtRKBLzLWEgoHcoFiA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6kj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:28:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6JeYO020074;
	Thu, 18 Jun 2026 06:28:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172abrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:28:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6S6cb59638132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:28:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CADA620043;
	Thu, 18 Jun 2026 06:28:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9503420040;
	Thu, 18 Jun 2026 06:28:06 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:28:06 +0000 (GMT)
Message-ID: <b2dd136a-828a-4771-9f9d-5da8a4f6634e@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/17] docs/s390: Document CPACF instructions support
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-16-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-16-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX0D+gk7VJxH2t
 99wIZDXLdOTvVqTrLi01IJDL0qZd9r8rINb2PjvYs73dP17RpxhVGaIgK2xzIEY/av+rtXRdUaR
 nyczJgvTZGt/IeHgHhfuUyKwKNgaJ7yxsp4yWIpio7FOdFMoAYQWECcpPWPI+fX9DQENSSPKiQY
 aGYxRYVKF0Ir+6NTRVMlQ2M719GIGNoChTNScqiKr0106L7Y0rXLTTAUm66IYUvH8ooRkLA4RTB
 6la0txp3qbjy2+CAlgYAIBNDGbdCuZl46D3ie5DHebIXVyNvHOHsUd4tV2Ple/N+1JAyKRml6Ec
 WOhL74gU9rXk6ocABIYg5744jdHRJx1Wzht39go9mhLvKtLT7SwyUiA//M3Etk/4JWEpqraA+fF
 j0g/y5ZaTDTzfhMJB+v6jpzMd7ZX2A1loT6Yt+mJbbCIE4Q98HTlpV59Auu4qXMrCd/Ip59CZs7
 waTjINTcNzIUyYU9xbw==
X-Proofpoint-GUID: 93uiwBjKKmUOS4kPE2J3EJhdIHkMSokR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfXwDxu/QVtk2J+
 Ty/zkCQebTiTKssoYCViEFmd+ZZNkVnwSccUznHR0Yg2clT7ADhKZDW7dmCxD7B/J35Nuzbv+Zu
 K9Xf/eDj1gRtEU5mVEhcDlZtQ1oG3iE=
X-Proofpoint-ORIG-GUID: 93uiwBjKKmUOS4kPE2J3EJhdIHkMSokR
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338ffb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=h0_FONfBT_q5NLk2AVkA:9 a=5wi_FRADO1KgGG3s:21 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055



On 17.06.26 11:48, Harald Freudenberger wrote:
> Add a first document covering the Qemu s390 CPACF instructions
> and functions supported.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the one comment applied:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   docs/system/s390x/cpacf.rst  | 116 +++++++++++++++++++++++++++++++++++
>   docs/system/target-s390x.rst |   1 +
>   2 files changed, 117 insertions(+)
>   create mode 100644 docs/system/s390x/cpacf.rst
> 
> diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
> new file mode 100644
> index 0000000000..85f35b4e9c
> --- /dev/null
> +++ b/docs/system/s390x/cpacf.rst
> @@ -0,0 +1,116 @@
> +CPACF Support
> +=============
> +
> +CPACF
> +-----
> +
> +CP Assist for Cryptographic Function (CPACF) is a hardware-integrated
> +coprocessor feature built into every  processor core of IBM Z and
> +LinuxONE mainframes (s390x architecture). It provides high-speed,
> +hardware-accelerated encryption and hashing directly on the CPU.
> +
> +CPACF provides a set of z/Architecture instructions (known as Message
> +Security Assist or MSA) that execute cryptographic operations
> +synchronously with the main processor.
> +
> +- Symmetric Encryption: Support for AES (128, 192, 256-bit), DES, and
> +  Triple-DES (TDES).
> +- Hashing: Acceleration for SHA-1, SHA-2 (up to SHA-512), SHA-3 and
> +  SHAKE.
> +- Random Number Generation: Pseudo Random Number Generator (PRNG) and
> +  a hardware-based True Random Number Generator (TRNG).
> +- Asymmetric Support: Elliptic Curve Cryptography (ECC) primitives
> +  P-256, P-384, P-521, Montgomery/Edwards curves (e.g., Ed25519).
> +
> +Documentation about CPACF instructions is public available and
> +can be found in the "z/Architecture Principles of Operation"
> +accessible at the IBM documentation hub https://www.ibm.com/docs/en.
> +For example the latest version as a pdf is available here:
> +https://www.ibm.com/support/pages/zvm/library/other/22783214.pdf
> +
> +
> +CPACF instructions
> +------------------
> +
> +Here is a list of implemented CPACF instructions and the supported
> +functions for each instruction:
> +
> +KDSA (COMPUTE DIGITAL SIGNATURE AUTHENTICATION)
> +- Function code 0x00 - Function Query
> +
> +KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
> +- Function code 0x00 - Function Query
> +- Function code 0x02 - CPACF_KIMD_SHA_256
> +- Function code 0x03 - CPACF_KIMD_SHA_512
> +
> +KLMD (COMPUTE LAST MESSAGE DIGEST)
> +- Function code 0x00 - Function Query
> +- Function code 0x02 - CPACF_KLMD_SHA_256
> +- Function code 0x03 - CPACF_KLMD_SHA_512
> +
> +KM (CIPHER MESSAGE)
> +- Function code 0x00 - Function Query
> +- Function code 0x12 - CPACF_KM_AES_128
> +- Function code 0x13 - CPACF_KM_AES_192
> +- Function code 0x14 - CPACF_KM_AES_256
> +- Function code 0x1a - CPACF_KM_PAES_128
> +- Function code 0x1b - CPACF_KM_PAES_192
> +- Function code 0x1c - CPACF_KM_PAES_256
> +- Function code 0x32 - CPACF_KM_XTS_128
> +- Function code 0x34 - CPACF_KM_XTS_256
> +- Function code 0x3a - CPACF_KM_PXTS_128
> +- Function code 0x3c - CPACF_KM_PXTS_256
> +
> +KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
> +- Function code 0x00 - Function Query
> +
> +KMC (CIPHER MESSAGE WITH CHAINING)
> +- Function code 0x00 - Function Query
> +- Function code 0x12 - CPACF_KMC_AES_128
> +- Function code 0x13 - CPACF_KMC_AES_192
> +- Function code 0x14 - CPACF_KMC_AES_256
> +- Function code 0x1a - CPACF_KMC_PAES_128
> +- Function code 0x1b - CPACF_KMC_PAES_192
> +- Function code 0x1c - CPACF_KMC_PAES_256
> +
> +KMCTR (CIPHER MESSAGE WITH COUNTER)
> +- Function code 0x00 - Function Query
> +- Function code 0x12 - CPACF_KMCTR_AES_128
> +- Function code 0x13 - CPACF_KMCTR_AES_192
> +- Function code 0x14 - CPACF_KMCTR_AES_256
> +- Function code 0x1a - CPACF_KMCTR_PAES_128
> +- Function code 0x1b - CPACF_KMCTR_PAES_192
> +- Function code 0x1c - CPACF_KMCTR_PAES_256
> +
> +KMF (CIPHER MESSAGE WITH CIPHER FEEDBACK)
> +- not supported
> +
> +KMO (CIPHER MESSAGE WITH OUTPUT FEEDBACK)
> +- not supported

You list these as unsupported but KMA is missing completely. At least 
mention it as unsupported as well as you do so for KMO and KMF or leave 
the unsupported ones out completely.

> +
> +PCC (PERFORM CRYPTOGRAPHIC COMPUTATION)
> +- Function code 0x00 - Function Query
> +- Function code 0x32 - compute XTS param AES-128
> +- Function code 0x34 - compute XTS param AES-256
> +- Function code 0x3a - compute XTS param Encrypted AES-128
> +- Function code 0x3c - compute XTS param Encrypted AES-256
> +
> +PCKMO (PERFORM CRYPTOGRAPHIC KEY MANAGEMENT OPERATION)
> +- Function code 0x00 - Function Query
> +- Function code 0x12 - CPACF_PCKMO_ENC_AES_128_KEY
> +- Function code 0x13 - CPACF_PCKMO_ENC_AES_192_KEY
> +- Function code 0x14 - CPACF_PCKMO_ENC_AES_256_KEY
> +
> +PRNO (PERFORM RANDOM NUMBER OPERATION)
> +- Function code 0x00 - Function Query
> +- Function code 0x72 - CPACF_PRNO_TRNG
> +
> +Note that the use of a not supported CPACF instruction (KMF and KMO)
> +or invocation of a not listed function will result in a Specification
> +Exception.
> +
> +Not listed CPACF instructions (KMF, KMO) cause an Operation Exception
> +when used. Not listed functions cause a Specification Exception when
> +called. If only the query function is listed (KDSA), then the query
> +function will return a function status word with all but the query
> +function bit set to 0.
> diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
> index 94c981e732..49159826eb 100644
> --- a/docs/system/target-s390x.rst
> +++ b/docs/system/target-s390x.rst
> @@ -35,3 +35,4 @@ Architectural features
>      s390x/bootdevices
>      s390x/protvirt
>      s390x/cpu-topology
> +   s390x/cpacf

