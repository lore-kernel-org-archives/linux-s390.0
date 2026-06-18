Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB712DA768
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760941; cv=none; b=b0xt3f792lcULBWq2fAZZfAQ+lBro+WZrOb4wVYXoOGKfsUTpZte9PYny4fXvdQEERIvMUTMskXkM3NzdJ757lhmwuJmiyRXNZvy4zuGqHtazm1IKdVQVOaLySrBD7afTVDC1GjN2oRLdTUN3+fqdRb/wJNcvEsYlJlG1SbvUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760941; c=relaxed/simple;
	bh=w/JvKRmudBTlMshTaMjya4QPrYFCkm3YxSDf6AG/ltM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/KCazfoQrsmQLYYGEkpTwRPgxwzSp6J5cF7OvOT7ZMotUvxXwZ9MnURff588S6Fb0yKpJKfZKpWMZbakUq7a5jjxnTEeBxJ3Zse8AjyezgEGEHTQIkpdbQq0PX3itFuVuNdl0Sy8nlGNq6/q87ZSk1CXZirSvSyps675Zp2jJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I9xQxzZE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I9xQxzZE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmR3Y1000542;
	Thu, 18 Jun 2026 05:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mvgJIa
	cuA2UB6tlhwdrfWanP64QgbcYF1gzxM/n5qEA=; b=I9xQxzZE60be5t39tx1h2T
	MVCOj30q4iuvZWS/h7+mec2GtUCrXrUHjtzmJ5Exzzj6J7Lsi2JGgmY0ipuEiJWq
	WslANQ/mOaA1ruEkCiL/zNfseXHOrmN5asUJiWJZNV2k0NYPib6IDZajCtXJwMZB
	wQbyKnqr/bv4ouFT4XjzRJd+lf9EObsiPYOE6bqukYg9iBIA5opEEgS8oBLC9I7c
	j0DIO3IulIBYkqD3sUVfQtTGV/ylgtHWom1ToaUowHRkC1r47VjlrFmVtpVm+3fg
	YOzR2iGFU7YJ7obSi8zAyThNX4GUH2Bhf6AJyNJu1auYjRZzd6uHA15KXm5lvcvA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6ds1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:35:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5Ydet004400;
	Thu, 18 Jun 2026 05:35:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a5qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:35:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5ZS1g51183970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:35:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C28E620040;
	Thu, 18 Jun 2026 05:35:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E6F02004B;
	Thu, 18 Jun 2026 05:35:28 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:35:28 +0000 (GMT)
Message-ID: <797ee6a1-64c6-490b-9946-2777b65dc603@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:35:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] target/s390x: Minimal AES XTS support for cpacf
 pcc instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-8-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX9mDr/NbJXxrU
 U17l6Yg9R1GNWmfQvjz/IX4FzWUneCw6b7NJ+w4ezBeWknBjpHOZ9sBHtAgD+4Kav3LOxXQYvWT
 9qkfZZoU+IArZQq/ofpoxsux3ze2OOgHiqqc8pcNrbVWk4ySWJLcXJDBNlNMr1CuLd5qiVSKAz4
 s1UpVTwLNEaz8GOXrsAbCIZ9dMg68MYrm3IXbP+uutQlp6iQcUmxDKLh3bRVXsD5jG9woSpmsr9
 48lWjNgTDMDgUtJ7dpgLSyXrr+VE9n+vtwJ48PFtG7d/NB/rrZKis2X5sEMaSnnUJOg2Oog5eie
 m0Xr0AGFQYjaE8/RtdofD3pMIqu7aOe7le7CmtIDC7P3o+qZjERXqUjoYHbYPP0ygn+Dlw3rqGz
 VY2zHrqsq+L9/qbXK90pY0dZ7lZv2PFP1qSAVtk8O5jy7gvSBkPOJjUNwVZXUR6UGieABeFDq3U
 hs/Uqkwf9cQIZWT/6UQ==
X-Proofpoint-GUID: 6JHyys_ydyCY2ISKy5V4txREKpC6rHDx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX0aQ8sD9AxRyR
 HbLP7L0TzH9H/9pEMi6o7tl96onWHYJFPYphl58Jx5JCBWbO5RyKGSjvKrx4nLG/BqpyPRnfjbB
 EtWWVuJ0Twa2DsZb09PoQWWJjs6SgqU=
X-Proofpoint-ORIG-GUID: 6JHyys_ydyCY2ISKy5V4txREKpC6rHDx
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3383a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=yHa2Su-JMyxwcTxsS2QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
> and PCC-Compute-XTS-Parameter-AES-128 but only for the special
> case block sequential number is 0. However, this covers the s390
> AES XTS implementation in the Linux kernel and Libica and thus
> also Opencryptoki clear key via Libica.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 71 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 20 +++++++++
>   4 files changed, 95 insertions(+)

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index e200a9a87a..43c556f31b 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -16,6 +16,13 @@
>   #include "crypto/aes.h"
>   #include "cpacf.h"
>   
> +/* #define DEBUG_HELPER */
> +#ifdef DEBUG_HELPER
> +#define HELPER_LOG(x...) qemu_log(x)
> +#else
> +#define HELPER_LOG(x...)
> +#endif
> +

You never use this... Seems to be unrelated to this commit so put this 
in its own commit if you need it later.

>   static void aes_read_block(CPUS390XState *env, const int mmu_idx,
>                              uint64_t addr, uint8_t *a, uintptr_t ra)
>   {
[ snip ]
