Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701A3EFD1F
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882214; cv=none; b=r134hLeDaIj5RwMFB5fvUYkjSWWEiGMrJAiOguJrNoC5AM+yDPqUHyFpW5InHczNO7k3nPyMoEWgklDvHYax+LqhBfTCu49xxuZ1kNmxbEC9KLJFYJyJjElRKzt240c8qcrMW4Mea/8ldRAAaggB8AF+6k97VbViALrvbSZWGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882214; c=relaxed/simple;
	bh=XcdVo8XlBdahEKOzqFUkzTCKK9VZL8qxbZO35MTES2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEb7VM8Qqj2O+7rEwmVcSUI4K++1CaTKMNUysOTXrzIWQNVfa6IrqF7xQaZGNTWPbOpSQVPQJTA5Q5U1S4lQqlLiKkv9UYyE3nG0K9RD5t/2exILJxX1OWF5vDJBuXQ2/cf0/RNEFSH4+9B4DIVT2JFQm2dQOCS2s+dN8JS8zZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ri5hFPYt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ri5hFPYt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jn7Wt1708146;
	Tue, 4 Aug 2026 22:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tYsYiL
	D1OthBIi6eT9RWOOdllYw2SxGuOcNW+0kYnec=; b=ri5hFPYtqYeXQggQTrS7Sc
	KkILCxVbwAtN3j+Y+LGQPEzI0gVWnYnHXi5ZXXY3kTMgcSM83U8ikFVD45RWnHmJ
	uqRqrnMiBGDm/iff/RjKDH7H3EdPC+dwjLqAQxmpUru8njykhInwozCiUi10yT2A
	t/tUcTiz144vHwxpEVORpJACa8yDgqqaukHDyTJk6bDAq92entQu/glxlzBtp4lU
	cqkyoDiGXluMZjZgtFcEp0HffdSYjL3K9SxKLnZWui6NLEbCAFwW9nnCKaUG4XIu
	Fv7p/vw2A6Q8X+1GpCh5MtNTFGCfMngP5xx4hxmWo0M/VzVS14Hyx09lLuw7RXlQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hr1bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:23:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674MBM2e000845;
	Tue, 4 Aug 2026 22:23:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhbw6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:23:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674MNK5l30867734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 22:23:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7C182004B;
	Tue,  4 Aug 2026 22:23:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278C520043;
	Tue,  4 Aug 2026 22:23:20 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 22:23:20 +0000 (GMT)
Message-ID: <59cb2b9b-06ed-49a9-bf54-0921e25d275a@linux.ibm.com>
Date: Wed, 5 Aug 2026 00:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/18] target/s390x: Rework s390 cpacf implementations
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-2-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4MSBTYWx0ZWRfX4VwSl0vb2man
 88pXWr5g5H6AQXN8KJ3YEJxXcQ/U+g4bhKO9HpMyxyM7dli38Qy3iEje5ta8iqeIEbMuuKt8NE1
 lbJojzyLgaidWjQNYx7wbbac/+7SBHw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72665d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=eMolCyZ68feebDpyvCYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4MSBTYWx0ZWRfX4l241V1y89Qg
 9Rd+oOzghbLUoNWShZDmGR3X8riceGK/sNgB93e+jjD5WUeD5PwgC2ETpF8L2apdCw7zsp63hi9
 NB8OAnL1kdAHKjJjV9wwyGI35/xkXsyGFDAmryNR/tPNTZjSAQkpB8X01cQXhg4Zlg/Cy2yytBG
 GhsVHRaJEOytZuF8dqiVDUn0USjFcvqz/+x+yf/dKe3WY4X5hsgZWOWJc/3EFCfvwdHrYPNPo6V
 t/M+7tNjx3Ahta+WSMycJ+kp/+2ZlzwA7S3koLRMo9Tef9sZWmjZ2ee+YYPoHs/JO8vCCA2mQLX
 NXDfV2ztVMOf/MA4ME8FWb+TIFEf3JJrGP/LImAFOZ5Jawq1gNiEAh0zwiaBnhw0ZrQaz1vQ+7Z
 h4d/l5Ibf/OBvpW7sc85TZjch2B2r/w5lDPOPBuMG7vUP8Tno9b+n8W2Qh/vTFl4liMNe53Dy19
 BvoJRxlfn54hpoLz9tA==
X-Proofpoint-ORIG-GUID: DWX8gXV17PKryl07uaRmkKSPEgHc3gIP
X-Proofpoint-GUID: DWX8gXV17PKryl07uaRmkKSPEgHc3gIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040181



On 8/3/26 18:12, Harald Freudenberger wrote:
> Fix missing parts for MSA 9 kdsa and rework the cpacf handling code
> so that further extensions can be made in a clean and structured way.
> 
> Introduce a new header file to hold defines, structs and function
> prototypes around s390 cpacf. Use the cpcaf function defines in the
> existing code.
> 
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h         | 226 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  90 ++++++++++--
>   target/s390x/tcg/insn-data.h.inc |   1 +
>   target/s390x/tcg/translate.c     |   2 +
>   4 files changed, 306 insertions(+), 13 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> new file mode 100644
> index 0000000000..49496d39ed
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf.h

[...]

> +/*
> + * Function codes for the PCKMO instruction
> + */
> +#define CPACF_PCKMO_QUERY                      0x00
> +#define CPACF_PCKMO_ENC_DES_KEY                0x01
> +#define CPACF_PCKMO_ENC_TDES_128_KEY           0x02
> +#define CPACF_PCKMO_ENC_TDES_192_KEY           0x03
> +#define CPACF_PCKMO_ENC_AES_128_KEY            0x12
> +#define CPACF_PCKMO_ENC_AES_192_KEY            0x13
> +#define CPACF_PCKMO_ENC_AES_256_KEY            0x14
> +#define CPACF_PCKMO_ENC_AES_XTS_128_DOUBLE_KEY 0x14

0x14 repeats twice, should it be 0x15?

[...]
