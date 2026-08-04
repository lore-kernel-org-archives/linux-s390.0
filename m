Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A22C032E
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883748; cv=none; b=oUMk9SEAY4SNXSaBzrY2HXCwv6YlKYC9OFS6ot7ImwsENSBW/SwYHYjonaOz8WlltIb+CpndBO67WEYjNNlR/1Cb82w0TTW69yOZOu2IfPNTBoKBcnpNLGfpPBmoWRiOj2vm5IJ8XVAyd2LZpg/95WLKLEnTMwN/TaU6nv4MglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883748; c=relaxed/simple;
	bh=RVM6d1GGo+kUqhzm6znBmHaVBYNU4TaA08l5clOsPGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qi0alVnHC3QtrdGt2Tdqp0cD2BOiENfxdF4wqgP4d5oQrCp24F+851jgbZ8GkkviRKBo+Kp46K0DVhck419pXMhlbqc1XHLeVVfBRM43RyFLwc9dwXIsz2nUNzF27VDzxNPK2JLuBoJpj7G0q+ZXDKZ3eQBj1EZgdkfAYxKc4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WIHg5GbQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WIHg5GbQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jo5YX1859543;
	Tue, 4 Aug 2026 22:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K+t3uI
	jfRkcVHh3i+UAC1VOqZb+h/oXtN/ORqUHMaAE=; b=WIHg5GbQmAK45i9okwTy0r
	b3ysq7oufJPQfdXUEMB39UW3hFcUEEZVTps0SN8z6FEk87W8vpzK8WQyJ5sbHioa
	cD/qwAvg6KtlwaZLWpw6s0nVd5T7pPR7SsqGSWUZ5yZfuS8fxQT+zWnNwuBTU/a/
	4XboHB82AwCVKFhumpYBXe04QjjGe6XoiGgWtUxSYTCR4VJm8ybYUv2KlG73+aWd
	knvzrQREDmGDXHWR7fRzPZ41NtAI+YiMcS6rjQnKw9Uxu8ykr3XXmxa5FBKbpqtK
	GqRQ1NDvk52ZL01WKFniKOK/oihazt/r/pz95T0sW6VLVJ2sbCzX/sLr3CqvRJAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euqsjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:48:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674MQFpU001693;
	Tue, 4 Aug 2026 22:48:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qm6f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:48:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Mmtuk37224714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 22:48:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DE62004B;
	Tue,  4 Aug 2026 22:48:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A4120040;
	Tue,  4 Aug 2026 22:48:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 22:48:54 +0000 (GMT)
Message-ID: <69f53a7c-83dd-46bf-81a1-7941f4b6c5f5@linux.ibm.com>
Date: Wed, 5 Aug 2026 00:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/18] target/s390x: Support protected key AES ECB for
 cpacf km instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-13-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dqCe9d2UbyP-Dx0xVda0LGJcF1u-yn-9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NSBTYWx0ZWRfXz12FxwiFscGK
 64NACJXZxO+KP9TbhMZgAN4nOnpxDCvvzDdHHm7BcPb1G/qJNTDOQqk/aaThylGbB0uGDBnc7E1
 tdrO4Cd25+cfbKXCW+Doc6H1HIUZ07E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NSBTYWx0ZWRfXzsji6TSR2aOA
 lpaeJ8rVqJV2MW8g2mfITJCFdRAqqH8c3+V04ssAWW5UTLBtnStnitLCR0akn8CmktZJGj0GHBQ
 ToxEFOb1yHDmXsOmMcw/iPlLau/jWIysrj1VIyrknbjb0iLpXzdwrIVgWrIL39RwiXlSbX1WzKh
 c3EVH2aqPa/BBU1bo62NvwrjRFZgpoh5mzKrIgWRdsYsYCVgsAN08fEhgh70HdPPBBiZ4Wrxyii
 5g97rfUvtkAKe0mvJfj933rIF/4TBAmPGKd9/R4DPZD55vcN+Gh9XRPzMltbQ2zr3fpfM9GqDrb
 fwMkDfmcl4i1E+akbDllsF+PzeAQp+hZlNowdcblQLL6q6H8RG7fqRHGJKMd+BcPeHYVhVdMFGz
 TY6bNbITZgwjtIRduvftTYkV01Vc42pnMT90mkxhaXW5OKVcj+RVsl0nu8C1B076qgeeXJMmIzI
 ywdLyMQdCR0jCy3Q2sg==
X-Proofpoint-GUID: dqCe9d2UbyP-Dx0xVda0LGJcF1u-yn-9
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a726c5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=W9WUg5CHmUAy3lohqJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040185



On 8/3/26 18:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
> and CPACF_KM_PAES_256 for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 91 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 105 insertions(+)

[...]

> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
> +        if (mod) {
> +            AES_decrypt(in, out, &exkey);
> +        } else {
> +            AES_encrypt(in, out, &exkey);
> +        }
> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
> +        len -= AES_BLOCK_SIZE;
> +        done += AES_BLOCK_SIZE;
> +    }
> +
> +    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
> +                             *src_ptr_reg + done);
> +    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
> +                             *dst_ptr_reg + done);
> +    *src_len_reg -= done;

Should we update registers after each iteration?
Otherwise there may be interesting effects due to swapped out pages when
running in system emulation.
Blocks crossing the page boundary is a similar issue, not sure if it's
that easy to solve.

[...]
