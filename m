Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3975335BDB
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762775; cv=none; b=LqsCQ428ImB/kTCCH5rsH1hIaxs6FH0qyZgedcPJEz6y/9TuF2V9quUPlZrrNMbh2n5Bd4uZ7DTA58N7aLWE68MjKyRI8ZrQOoFpDGVC/opeBbQSzkIhZzTewxKByocNsuT5f+ukk1DxPITj9JsJbvV65FeCQIaw1N5W89JPVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762775; c=relaxed/simple;
	bh=oSoTUmZRCYNW9P65zcaMwDfnWx+1qnDiCU6ySsU1CzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxZVrR8HwW9Wooa+OYsOfLb5Llqg0PC8QiVGf/4PiIJTxsjO89LdCcaO8JZusFeMOhrUR1pZzJ+D8Jv+GvKExxLC5Lt5TS3/kBthPkcBLQvuXKQWy3qvBt5ndDZCuhEDDKJrAkvG9IfhzylEmMnejLeT6nUB6qbytPv8mtIwRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LAC7PFtM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LAC7PFtM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmKw71106769;
	Thu, 18 Jun 2026 06:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6AHTXr
	rq0J++bnEz3FywCoHFa/QS0ggCerGPeqEPWmM=; b=LAC7PFtM5tNZf4ZZ0Ioipf
	tUsapuBnEBfD5jqmNcb7x/b0fS6Fe27ylR1SNc4cY2Ky/tkV6GLZ7hlw/UyZjCxH
	8a+dXgxQ3HPyCZPQhb6SYgDt8yiTaJ5JiCfu+PVmXRABmmC8AaUAcmTjUEWBkRPH
	fhgff1SxMG/qZSYAnWHwAbiasyNsQQVO36nfZQLthA6399gTID1fkzlrMVckoerQ
	bzgHNuVTxoV9ZKpflGKml9sT8VUpI53I/ynhEsgFZMxhnb3Ggw7Or5ckKv2LGsDy
	URnUIfoBmvPFY6EYkEr2xTQuAXCTgf6BO3i4PgppEGbUWY1ouzcO3mbELrcce57A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtpm8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:06:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64aHt003798;
	Thu, 18 Jun 2026 06:06:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a9g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:06:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I65xI635455352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:06:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE20C2004B;
	Thu, 18 Jun 2026 06:05:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABB5020040;
	Thu, 18 Jun 2026 06:05:59 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:05:59 +0000 (GMT)
Message-ID: <7b9de533-5755-4c58-8ea8-4be47fbfc7a3@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-11-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-11-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zshwiS0qs2PqQq6Gbhm2eYjCu5nd9wp2
X-Proofpoint-GUID: zshwiS0qs2PqQq6Gbhm2eYjCu5nd9wp2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX7sU7OdaDd5ki
 6s2+dUc11hACYji76GZMshXDpPzAdeKmun+XDANisKRDYpzOyXeUNfpBdDdV7ImXM0HwyGw/YNL
 0bJpxo8IaleY0C0hDSBfr7I2i7hZWvUcIuGaQ28jX0N7UCwgHvDtqfPfTGhdTEapBeKZpLZaCw8
 im9l/AR8dKHaFprsV3J0jBNw2ME5n7jZ2O0lmFQDqWL6Ao/YCta34GdZNBRf7Pvt9C2rVmHECLq
 BWxKW6REXNB3KYV05ZUVy2O4yBRb8/HR7OtOXT5n0R/LfVTJPGlGpmgNeB3gxpUXRDDLjTO3th5
 SxnS/V4o4P9beiyAc4+qXaiGuNOJXKApNFfLqDrcoeXnLPOEZBQyfThCy7lc6Opjs/MxRJXQfAA
 gilvuheyv7wc1pG9/LM5AjKHGP2tPA5z4PQk9gBjhcpF+/iCFAxD81/dQAyRe9+3wdq3EwVpmQ0
 d8tQf6ue7zVfBw/fQ7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX8lnzv3rGtKAM
 XPJD8bSGZDsNBplY8vMjWGeY2B1MrSjWCuC/uNimf8i7chZ1e0wQhL1bE0DwM9rIqEOxGCIpVK6
 e+AG6Sf25fO2C2AATOsuSRY/OqqwwgU=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a338acd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Y2BTm9I2MgqwPNFSU7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180051



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
> and CPACF_KM_PAES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 87 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 101 insertions(+)

[ snip ]

> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index e1952ae4bc..988226338d 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -103,6 +103,13 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                              &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
>                              S390_FEAT_TYPE_KM, fc, mod);
>           break;
> +    case 0x1a: /* CPACF_KM_PAES_128 */
> +    case 0x1b: /* CPACF_KM_PAES_192 */
> +    case 0x1c: /* CPACF_KM_PAES_256 */

please order these correctly in the switch. For the switch statement it 
doesn't matter but it improves readability. 0x1a is greater than 0x34.

> +        rc = cpacf_paes_ecb(env, mmu_idx, ra, env->regs[1],
> +                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
> +                            S390_FEAT_TYPE_KM, fc, mod);
> +        break;
>       case 0x32: /* CPACF_KM_XTS_128 */
>       case 0x34: /* CPACF_KM_XTS_256 */
>           rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],

