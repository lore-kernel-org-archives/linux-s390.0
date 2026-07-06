Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D22EEE7C;
	Mon,  6 Jul 2026 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357583; cv=none; b=mJ3rTUV/Tpi218JfT6LQmxxlVJHzkBxdEc0HJzrLiTU30xQu9Dtlh89rJjYSHNJzsKQczdXIUAcYvwbAscafty5Y/CGDAMNc1qmnYVaCDHC9EjhkCBZdvBntsY5Z0hkp/Sy9VR2zgSG6YXp45Mf6tymtAkKINIp/OWEozmIYzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357583; c=relaxed/simple;
	bh=cxKeQJ+P/1L3sgluX+y3fukL6Icfkv4UiFDzxeuQBvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnTNYIHrWZyY3qbtBHagv0jgusxudzDtR0yhs5+TY4RpTl9lYDOW/NX/P3aiNjBwRHcJ7tyX8onwFUOduPbz7e26ULKqJGa+I1GbkKWUVpnGq/kMzHD+VQEguqUXT9ln8tKtUxU9bKZkPOj7dhbXX40LUpTMQ+JES9zxBmFe+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K6f70AzM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K6f70AzM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIKFQ4049958;
	Mon, 6 Jul 2026 17:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kh+BAc
	25A3zw/GqGuIaf6+61qSG0Si9IBwLBCLlHMT4=; b=K6f70AzMVKFzt/KpmKvMee
	o9CNwyjmXd2guQdcgpvS9LGUYCSg8CYQ2fq7+75NigQQxzODHn5+zoB/BfbTEe+o
	N9I/DKEyPI9MIQRVF8YD+SJvX5XBUGKI7yJ1ez5zRMHgR5lBB5RGXbmIwvkslg1l
	BJzpiR8f3KVSzkLBt4aQ+zL2c48mLkL/9eprIFvZWFLUwJU4151SU+beOU5fXBys
	/QGeUzK4YhT48NpZXN4NDvS81fisZjAadVSF32LuxEJjEbnlQgwtSkMrxUBaGFHf
	i6xxr+4VY3nPsAx6dwLWn8pENBzEeMV5XAhclwuweKLtFic9sDEZyJSoWziIFJ6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsk1xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 17:06:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666H4fiQ011203;
	Mon, 6 Jul 2026 17:06:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfx8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 17:06:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666H6Gic44106232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 17:06:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93CF920049;
	Mon,  6 Jul 2026 17:06:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A2E20040;
	Mon,  6 Jul 2026 17:06:16 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.23.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 17:06:16 +0000 (GMT)
Message-ID: <d3ffd684-73e8-40e8-ae18-f847a6d0691a@linux.ibm.com>
Date: Mon, 6 Jul 2026 19:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/vdso: Use symbolic constants for the PHDR
 permission flags
To: Jens Remus <jremus@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
 <20260706151909.103539-3-jremus@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260706151909.103539-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zSY6bpHreMR3ypbJ6juWhECJqRYkmNA5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX05wYddY8eTK8
 SV7p8YpxzNmjXD/g6h3dzXyZ2vldsIVxpWNxgEuCDsoX2iQNPNei2pgJaVbuQfcyRraXZr8qSTi
 HNCAHbFiwFFRBDkRg4KnKDE2EpPSHL8=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4be08d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=i6-Z7uQ6rm4L9vLOfLkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zSY6bpHreMR3ypbJ6juWhECJqRYkmNA5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX0Z2DrqAPF+BR
 px+7K1MVqXsuQoeNoNOHq4j7dHNyaDar2SC8qF0jDcDu/z/LfNZgVfam8y5i65Gi814ZNLbMLDT
 jhDh+NW1HekpjZKYqdoI9nexsXPtjJMjfyvyP8haaCPecbTGvmQiZcbo90bOMfi06H5UFu8Ah5Z
 chR/FI9nT7AqS/9UlKCvzO/kbINP0Hg+sk4oumaL9J958B0sedKCFVu1v439AgAQ2Y5K/+e96gE
 0M1aHbzKlwk5xSw2Afzfes00Af7Ou9qtzHgRews8/V2WcJ5T29bfX1d/5HrIg+HKCjnMGRn2YL7
 owzvhWbZohuK5xTChrMU0Lv/XRAUKOzOPrERrMhzg79uGMY0upOqCSpoA34nZlFJAGQj/zk7EB9
 jD8ZR98M7231TerUk+b1+Ba41hwZiOZz5MmRvd6+Zxkys5AYGQ6MiXiHCUmXY3e2kylpm28qqsb
 hi0T9ZDzKswcZEGWKGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170



On 7/6/26 17:19, Jens Remus wrote:
> While at it explicitly specify GNU_EH_FRAME PHDR to be read-only.
> 
> Inspired by x86 commit 8717b02b8c03 ("x86/entry/vdso: Include
> GNU_PROPERTY and GNU_STACK PHDRs").
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>   arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
> index 7bec4de0e8e0..35ea7ede06c0 100644
> --- a/arch/s390/kernel/vdso/vdso.lds.S
> +++ b/arch/s390/kernel/vdso/vdso.lds.S
> @@ -82,12 +82,16 @@ SECTIONS
>    * We must supply the ELF program headers explicitly to get just one
>    * PT_LOAD segment, and set the flags explicitly to make segments read-only.
>    */
> +#define PF_R	FLAGS(4)
> +#define PF_RW	FLAGS(6)

PF_RW seems to be unused
Intel uses it for gnu_stack, which we don't seem to have.


Anyway:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
