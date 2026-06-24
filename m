Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E4360EFB
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321210; cv=none; b=o5Jp8T50Uswn6xDGV7UysGMJkAaTPBZGeA3TzJA+OpbguKbKC72A/oMF3IpBeQjBZ3KI8r5HK8MTDwfg1IKj7tJY0qqVIbzooPBWi+RV9lYVe9khjU9hPCrfxK2SOvTbRvu/8iAWIzmCkBIVC9omMXaVewHap5SJQhnonp4J1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321210; c=relaxed/simple;
	bh=146J7CqEr50eGMN7HMr8tspaiiXfhUAGq9qriA5ytNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOwoqZJ6toUescg+1lxVQ4P0KkJzWL+e0jhcx5Nk+/4rTyM5JpBwo2j5r/qxoCioV5eQImTSafrwgqtNMd5hKesFUrcQa4QZdxt3bX5FBkuZy1Mnya3mgPKNROKhlTQEacFJ5odZwNiMRrwqKzvD3apa4QzpggOqQAim7YIGUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CqweEDJr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CqweEDJr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmF9R1276592;
	Wed, 24 Jun 2026 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K3I0hA
	0KfNh94E0dzxyBY0SWSwtmut0shYZrKTSLDgQ=; b=CqweEDJr8daXg09Q45L3l/
	mubpHNSQeHDvAhSpwV1KmsikwgAyLjmEynA0x+CEXqZlPQ9pglvgljClHc6bff/a
	B8ZBmaQCK5Cf7Bkh65oZTBAeYTGN2tq885lX9rbvz9G20YrbLCm6yrjdte7Ilvvy
	Xg6lySZJkSq64+ZL5GkJBh9lF4J90vAuKK448eD5tin3Q6MbX82sm9atUVEII3eb
	bTiHgg6bpPLP1gdEDyaZXABXgJJQ4B/1S6fkmPNRz2s10XaY3G5l2O3VZtzdj2RP
	GHqbV3o/zASRylEs3ueNf5ZktnwVxwIN3oz/rmSGWcTf1VK6rBRvgCUFSSMesaFA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4ngss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:13:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OH4eWF032039;
	Wed, 24 Jun 2026 17:13:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vysfxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:13:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OHDE8F45482368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 17:13:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D3320043;
	Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AD3220040;
	Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.129])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 17:13:14 +0000 (GMT)
Message-ID: <0f77d321-dc84-4a57-8c5c-264973f5dac1@linux.ibm.com>
Date: Wed, 24 Jun 2026 19:13:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/18] target/s390x: Support AES ECB for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-6-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MSBTYWx0ZWRfX/av+JkqB5JYp
 RuUXWtVuqq4ehtMp5oU5xa5h6u8+VukvvlPgl+6sf/89gbtLBYeHq0rhM5+Rf7p/KtS2YBbV89b
 /pc029+R5vKKuGmU2k5A1LAE+68NTcg=
X-Proofpoint-ORIG-GUID: fPbfWlTzJol0Tmw5ItOhglDTN4XR0eIZ
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3c1030 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=QgfHRvl5YYpBVYqF5jIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MSBTYWx0ZWRfX5i1Z668n7Hve
 aF8EFBLHwIQAacgKcJYU1KoHGzVovWmY9iABg3OvkXvVsoC6dwaiAXvnyLJJu13cKtC5dLrhIq7
 L211kMdPBWQSsHak6t+Vlz/CygIxiQpLvNPFrcUgD+aMgKdzcWlx+59cetxTLfgT7dedzK0xiWM
 TQ8gaII+CIT8PtI+6AMU0uCaH1HBdNTvvfBbTpwC/6OCMrEX+XEoc65hLjmktKbWycAdpvPpcXn
 hIF0EIfMOiVZo+WaE1ou435BKuBQefBJ7DC8WvxESOZsrjeI2cK764YjdGF8Z+LcdkVXmdDaGF0
 6VR7ZtL6n614ScyJQ36Ot/BPtZixRFs+jNunOhUA4QMTYihWvWq/esrjY+9F66BQWywV5ir08hq
 8KDzrFH6YILPP8UtaRGZPWhDV0Vx3ruS6Tu/T523oMuIIx8OLt7gzzuE2jhsl+e8Sia4PmYcc8w
 TCigCj1MBoCYNnPY8ig==
X-Proofpoint-GUID: fPbfWlTzJol0Tmw5ItOhglDTN4XR0eIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240141



On 6/24/26 10:10, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   6 ++
>   target/s390x/tcg/cpacf_aes.c     | 113 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 147 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_aes.c

[...]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> new file mode 100644
> index 0000000000..ba836f1473
> --- /dev/null
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -0,0 +1,113 @@
> +/*
> + *  s390 cpacf aes
> + *
> + *  Authors:
> + *   Harald Freudenberger <freude@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "s390x-internal.h"
> +#include "tcg_s390x.h"
> +#include "accel/tcg/cpu-ldst-common.h"
> +#include "accel/tcg/cpu-mmu-index.h"
> +#include "crypto/aes.h"
> +#include "cpacf.h"
> +
> +static void aes_read_block(CPUS390XState *env, const int mmu_idx,
> +                           uint64_t addr, uint8_t *a, uintptr_t ra)
> +{
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +    uint64_t _addr;
> +
> +    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
> +        _addr = wrap_address(env, addr);
> +        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
> +    }
> +}

This is very similar to sha256_read_mbl_be32().
Would it make sense to factor this out as copy_from_guest_wrap() or
something along these lines?

[...]
