Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584493A6F19
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295687; cv=none; b=gu+IcgVtSGRFyrpCF/M5ObSc0Nm/hJtla8qwxZvzyMnYauIW73ylvuW7SiQPS8/gOjEr4BVx59f9h4e2te1PJHqqorbG0iS+BD6elDeqPr0ZF1hwethKvcV7YVsJWX6kDJ2vxcEcbj4y5zLbGCPFE46IsxkLkOnudKge7AdgcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295687; c=relaxed/simple;
	bh=Mx5nZ3Gu9NyjMZf0s85fTiSIxh4+Fa6uURUL1kY3Vus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRTbDZ59L/qvVnnQK+VU2bgcYWvBpL8qonW6XfWc7h6Ef4s0jVpsBbao++uI7XGnAcFStqdVg6jIjuJxaI79CkFPT1zzNSTiuiEwuex2lpNj9FhBk4MIXls29Vk+hEQo2r3A0o3xYS14hTeFIKMcYI28MKm9QCDkvF3ylaqFQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLmQI50T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J5n/Sjea; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLmQI50T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J5n/Sjea"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5ttYB2522401
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=; b=cLmQI50TVfXms40J
	0xWm5HMbAmptufeRYStw80DEt7Sp5fWLZnlpfXeFN+Jc0mBHLjAv8wMAV8J2OWuv
	6UE1VgFBkwKiQinRQ7xvskZMS+XTWfRXOcS21P2Ix2Q8TVizqhfxys0A4VaqMOpK
	iaB5jm3cWkE/X9uJz3bIbChd7VCRar5MFu/XUO6AYj4X8/JSrMilxk9AAblqMbGM
	4TM6DNrUF1XIqrxNI668CeTSS8C8jaNdA/2UuCVLaW3HRZYmjLahsnhNRoqQzl9O
	VoYYduPnw52QMbYyn2xjbapqsxg0psTwwgJzuIEPO3aUd28Rqk6YdKkwcSmz/vmK
	1hLW/g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajhrmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:08:01 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6cf37fe12faso287924137.0
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782295681; x=1782900481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=;
        b=J5n/SjeaAvYX9S84mr0hO3RiXntmQH8YCnbMHGHr/6ZIyNsR2hmAkG1OPb24Cm3VKL
         fkZUDrwPcxxZT79hPeDlLuCuoy8Y2XTSz7UCU1hWCMCcxwxDrQaIkVgYFF8bBzNPADv8
         GDJVJw1e7N6WWDNeJ1b2bHzvvp0PI9CWijMkV6b7Uy6pKx5IlHDE/J3s1gecX5E6hppk
         4xQho5JEAnzNbLidxQTy+t08KeDMoutB+kp9KlGt1VtifyS2KPv4pKQ0NLMmRZHsqVbm
         VDlnSmdYJ5md3eTJpPspopvkUEJco2/6jOPMU3pJUnL81m3kUxrHeIC40JJJBpnzWC9w
         u7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295681; x=1782900481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS86Q9zl5w3F/Dbrskx8syzVjJ8m09D5cDruPFZmRu0=;
        b=ey44L/P8nAqI14xHnVwY+czmQ4vjN9flkjoaO1egIx8L2anW2LtHcCdfybhquavJ2i
         ttO4O2/Z/tSOPXqhpr9ukjUCOJHkhOSocnWECwttBHIa+ojTx/iSad9QkTXZmDTCFAZq
         foJedvRwHSJ5okqEg6inJ34bM70aQyWq4/r6mqFvwPJDK+7/ug7mxtySuYg5JWQwdKRB
         wsBXJCn/NMlZIPDzDmUjIMC0zB0TI6bZCm0PCv4GxpRiHW8mpnqVGAyeuigo6k3waUkR
         1QE4pabmaidVO14v6iHKng+pB3Ti8VxE1wiL7lc0c5j8r06inK6Q1oK/4iQH4zx4SZuU
         5x/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JgixrXMs9OMT2K28fpqoeta0oxOYtvHpUIGDbXqqiVJ5Wu9lw8Reu2hn5Tpo1NW9qgfyOjeP6DXTp@vger.kernel.org
X-Gm-Message-State: AOJu0YxCK7HgwASOufowxV5Ne95TuqTrGKM1kgwW5ZMDux1ZVOAfScul
	YM7fZ9+pjuJXP+BtZ4KsXd4BM/gbSdDYPbhwFOrty1Psm6XiHmF12FxkYThJB+0pqo3fCHfVRdM
	BwjhPl93JknHsccxvccizOGVMjSCnFqjEdfBrK+su+8oq4IIZ0ns/kWJL3KXE0Bkx
X-Gm-Gg: AfdE7clN1CdwW1Q26JEMgOek1xEyeN9mgl+RcVoomjeqFGIcWxyXS6BaF9XI4WBtinA
	vJvnMIcKuedVSXHdIdJZIStc3UUAQ9wHnL9Q1lT7/P65DBuLmaTfk0DBqh6dBG0Uj3qkHIr+BVB
	pnLLALbKG83ioZK1RJeWcUpcJz3oOL3rdBXqCI+eOD9Q2Clk77rkjnFA3O1n6vhnW+oi94zqaOr
	0TCwRLxJvLgAdExlqNgMwyKPFz2fuAy1JI9rhUPufn3IrGzwXlRz4XSm7xdIxfIXOdqZTyYiuuZ
	yoadz8XUl38/MToddzWSrbUOwgONvUaSpWt5S7TmTQi5E8b3KrPZtHAk633fSZcqUFvjPX51ZVa
	Q1SH0s9n6CYAjCxT7Z20x9XVBx35kAYbS3T5SXbitPzWiTG7CkeZs8m7nmGk5zg==
X-Received: by 2002:a05:6102:94c:b0:726:e608:6658 with SMTP id ada2fe7eead31-731133d342bmr1006879137.11.1782295680902;
        Wed, 24 Jun 2026 03:08:00 -0700 (PDT)
X-Received: by 2002:a05:6102:94c:b0:726:e608:6658 with SMTP id ada2fe7eead31-731133d342bmr1006869137.11.1782295680523;
        Wed, 24 Jun 2026 03:08:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd36adsm869091a12.27.2026.06.24.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:07:59 -0700 (PDT)
Message-ID: <e7f9a860-56b5-4e7f-ba62-82133ad8aebf@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] target/s390x: Move cpacf sha512 code into a new
 file
Content-Language: en-US
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-4-freude@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624081029.23815-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX8kGaTtoBR2dc
 ln5NyOdV000cXh2y9xNY078SQWNJkpF0bUz4ZvhZTjEIjJ2JsDLguWY09hxeth5BArWWZUvUiW0
 KjDqYVAGgFfVmvmUVWWxSdH4Uaw3bjA=
X-Proofpoint-GUID: _X_Vw7VRd2DcltNV_IXDsugmATaAFZ3m
X-Proofpoint-ORIG-GUID: _X_Vw7VRd2DcltNV_IXDsugmATaAFZ3m
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3bac81 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VnNF1IyMAAAA:8 a=WjaQ4H5Iy4oAvfDZsE8A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX4AT5qp0es4hG
 KER0gePPkCICP3MJvBmZkGLTC6DmHqXSebR6ZQSzNz+hjU88iKnG2B+PUf+nh0+DqYGAtvjBhD+
 Nztdoe+ZG4BSEUp/7Zi9tJq3eofAntmww5YVmsJJfnS+AOVx8Mfq0llglc7kkcxrIjbN+pH3bMN
 4iR34zPljV5bUqpIEkeiRqt6fxXhmRpAhl2eFlkwez3519XszxSeKSyrj3fgfEf3KFyEWQ0H/mo
 42TIuXNgV0Ah4qXmIuHgKkFnt0S9tXNszH0/o+sbO+TzduqMDYhzxGW5oUEpgouXEw3U8AlGdTB
 uY850wZUQLawEIGdaGdffprK56LdsGtD7cr3u9137H8MSfvtqC+il7lCy0EeHs0fkDEYWoavlO2
 eLS8ZiBCI3oM3mvpqpaiL+KOCloq/edULi+ImvIX9qo4Mv3uCpl4wkf7gK/nG8WpA/1PtsWvr7w
 SfC8X5xIpr+ZQSTswwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240083

On 24/6/26 10:10, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and add a
> new header file cpacf.h containing the prototypes for the
> s390 cpacf stuff.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h         |  19 +++
>   target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 227 +---------------------------
>   target/s390x/tcg/meson.build     |   1 +
>   4 files changed, 266 insertions(+), 226 deletions(-)
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> new file mode 100644
> index 0000000000..a6e68f17c3
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf.h
> @@ -0,0 +1,19 @@
> +/*
> + * s390x cpacf
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef S390X_CPACF_H
> +#define S390X_CPACF_H
> +
> +#include "cpu.h"
> +#include <stdint.h>

<stdint.h> is already provided by "qemu/osdep.h", which all C source
files include.

> +
> +/* from cpacf_sha512.c */
> +int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> +                 uint32_t type);
> +
> +#endif


> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index f5189ce1c5..d731fc6c2a 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -19,232 +19,7 @@
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst-common.h"
>   #include "accel/tcg/cpu-mmu-index.h"

> +#include "cpacf.h"

target/s390x/tcg/cpacf.h ?

