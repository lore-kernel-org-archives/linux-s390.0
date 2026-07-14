Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6323F4102
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029541; cv=none; b=HNyP1dSpGx6KbiCMvDZnxm2OAh1qsE6A2SVI2RrM3A9mI2KmasFQkUwy412ASSCbakGzz+FaLcBUTRrsKAFDIF+zq21qZHXSwnWB0s0ib30Lt0oraT1NTTuTNomO/MdqnfM5GuWGyVQoAJ5/6gz0d8IwmSWTZUooDr5RmhPmwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029541; c=relaxed/simple;
	bh=7KjE4Vmm4HhBtt3W0h44WCR5aooV3E4nQXTFDXZnM0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqQPix9XWZxaA6fcHRWCYeNIku0LncCN9sHz4YmlYFjdFdn5f9FGqwGLbgSrjgO3ZPSIvci9gIKX2yFzxl/GHRGq0rMvPx5BkO6JtSYxVcBYeCbBSpnxz4y2Udn2+sWEzToxakyP7muoYUKT6uA6ymCpOVa2uEnGmM9C5k67VMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=khEM2goh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="khEM2goh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBg6GX1195260;
	Tue, 14 Jul 2026 11:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XRMBds
	E7624obXoG7gQWrrh7YKQrQZXTgOIUys3vZj8=; b=khEM2gohQq5Y3tTWNuiico
	uMNLnisj8ROEuXC5/mZCIfr1sYM+SjQEOcIuKgwQ9pl8pGRG+TYGlTsScCpSRLkQ
	OspObTcTiMKEHne2TGq3gZm4GBC+CAFPhcvRHDRatqXPL56t5DuEtENW64yf2tZp
	g9dRTab7cEa/ux9caJsq5A+/8v6iE5eVF8oRJjLc1ZjoV8r9trS4RIibLo++20nZ
	90iHmRfqvHu98rd7AUAsTMBWrpZiuo34aIV5F0G+Af4TIyMf0u+TWpkT0K7ovQJf
	DGa8DBDkSsmV9KhLWqhdvJANS+tZxSKSmfTaSSn+H0nQZZ0fNebaoWpZyWfX7CmA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnf6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 11:45:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBYtVB028830;
	Tue, 14 Jul 2026 11:45:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgabsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 11:45:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EBjMwm31326610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 11:45:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A68120040;
	Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4018720043;
	Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 11:45:22 +0000 (GMT)
Message-ID: <13fa7159-9757-4858-b824-6507494e0876@linux.ibm.com>
Date: Tue, 14 Jul 2026 13:45:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/17] crypto: Add aes-helpers file to support some
 AES modes
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562157 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=WUVNbM32cKeQYF9Oq8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXzkgvM/ahkiuz
 BJvl5yCKD9msBu/AlHJQEfTVuv/UuuuN5zH1KTISf+w8OocZOohUxLz1cea2DiWjc9hRJn8DEh2
 D/1166VJkdI/+Ebrgt2T7GUyX3Zw/fk+oEWvZOySsuQ5BEKxnWd9HkB8vK5LObRHtdBpqzPxF/T
 AIfDhJTMJyoTsDI/8kl23Y0wZJc8xjbVVC8Vq2AJE+jaKhHKY5Bl/cOqOu4PI2/5lHVLLXaCZcu
 UUIr2825cNbrcsssveAYFFBWgffKhtBsQghIPxsdf8QnzZ1f8agbAHmU3rpLxJKMVmsnE0mBEv8
 hHr2MftFrsNMpyM4HTVG4yj/p98ixIwymL/7hxsKm5QkwTJrOOnzTpyDBNtXwui7YwS800rW/iH
 Qz/jn3Ns6ZZgpeZt33NRTvz8CNcpLow8uiMMK26HyDho2q5++zSVgdoNDtgVEAy2Gprl9yCcsYS
 tNziaXIUBJUWebatFVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfX6ekDmdL2J2bX
 w+3LKhWg2T/lZYv4/fNudJhpn96o1WNkdB5sX1MEX89Lc4oeYgvCcwABZlcsnn+MMBVzUpRh1LX
 EtL6kEVIgV9Jyxdzec4BwMHIQ8Id/kE=
X-Proofpoint-GUID: jHlziirphkBA0ndbKNkzi_KghgiMvy-j
X-Proofpoint-ORIG-GUID: jHlziirphkBA0ndbKNkzi_KghgiMvy-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140122



On 7/10/26 17:28, Harald Freudenberger wrote:
> Add a new file crypto/aes-helpers.c with simple functions
> to support some AES modes:
> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
> - AES ctr: AES_ctr_encrypt()
> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
> and some AES related helpers:
> - AES_xor()
> - AES_xts_prep_next_tweak()
> Add header file include/crypto/aes-helpers.h for these functions
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
>   crypto/meson.build           |   1 +
>   include/crypto/aes-helpers.h | 116 +++++++++++++++++++++++++++++++++++
>   3 files changed, 223 insertions(+)
>   create mode 100644 crypto/aes-helpers.c
>   create mode 100644 include/crypto/aes-helpers.h
> 
> diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
> new file mode 100644
> index 0000000000..ff4aa0a385
> --- /dev/null
> +++ b/crypto/aes-helpers.c

[...]

> +void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *ctr, const AES_KEY *key)
> +{
> +    unsigned char buf[AES_BLOCK_SIZE];
> +
> +    /* encrypt ctr => buf */
> +    AES_encrypt(ctr, buf, key);
> +    /* exor input data with encrypted ctr => out */
> +    AES_xor(in, buf, out);
> +}
> +
> +/*
> + * Tweak calculation for AES XTS.
> + * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
> + * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
> + * This implementation has been verified on litte and big endian.
> + */

Nit: do we need to have this comment twice?
It's already present in the header.

Also typo: litte -> little (but I'm not sure if we even need to state
that in the code).

[...]

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
