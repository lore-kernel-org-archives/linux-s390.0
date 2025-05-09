Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1F1EF1D;
	Fri,  9 May 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803898; cv=none; b=qdsHMHXq1/Kpt4n86C/WgnPi7mwft3uIsFEhBYi70YCu/H2e1ywFjECe7hu42zcNBSkRaya39GGGCN+ogScr28CMpMnbULQkI8Y0Nc6z/BtUcu2FF52552HvbBwg96IVbICZr8kHMWrawKnZNapLaSh781oTv2Z9VVi2+NMR4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803898; c=relaxed/simple;
	bh=zFs9FyqSYNWTTOl2FSQqB+1KiLEfeO8gmMhFdqfdMjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElRAldNSVGsskPFikqQTnhCV+IriLoyH36rzJGvYZWJvkbq2uDXQv45a7chwUFbTjSTw+2fdBmW8HSJOQN2gf5L0zWJx8+nYl47cCrdjsZe7CZ2vSeqqzXKKOwuW0xqw8eFnVRODsDO3fJH4kQ9xc3yrtkFcf82dwvbeI7sBp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3YILWaW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3YILWaW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549ECOZ7029546;
	Fri, 9 May 2025 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QpyZyZ
	hCsh+6/vpeB1guIScXx44e2BHdQWV0S+AgPE8=; b=D3YILWaWy9L68YHZYMBc2f
	5NbcsEUpxmDZNCKurhTrNURH5VsHcZ3mpMXemvp+LGpk9RY/FqQRnYspBGBMYdox
	x64CMKN2I8fDSM/UK6vlQH0Bou6AAkPFTUyY/xlxh056ZwlwpUg6ZlO72rWXWy8H
	OcOBQk+3vOmbOCCHC4yzzwsRJpSgcCEZURyzHsz2DYJ8RSofQzhf8eZA3p1Qjtsd
	z/VEUKflw9zgBkrwy3hMf1xVFejuooboRUnxruGUtBbstFdQ/2yLgIiERy35r28i
	QvSF8DZ2sNXuhlm/Z2XlNV9YfheN1FKWBSVTN3alBwvCNcstMioMIeCR1WpvDH1Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0m72r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 15:18:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549CvmYv002738;
	Fri, 9 May 2025 15:18:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfpc1p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 15:18:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549FI33L55902552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 15:18:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5FE58066;
	Fri,  9 May 2025 15:18:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FB158062;
	Fri,  9 May 2025 15:18:01 +0000 (GMT)
Received: from [9.87.147.183] (unknown [9.87.147.183])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 15:18:01 +0000 (GMT)
Message-ID: <df805c0e-bf25-4cf6-9601-aac594fa0f45@linux.ibm.com>
Date: Fri, 9 May 2025 17:18:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 10/24] zram: add zlib compression backend support
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
 <20240902105656.1383858-11-senozhatsky@chromium.org>
 <6046d139-2a46-4824-bdfc-687750c1ee5b@linux.ibm.com>
 <gekqwhcpombpm2u3b4xl7zladuyzbxybeq5wcwt47k7tsgo4bh@rfrxaeqwzypi>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <gekqwhcpombpm2u3b4xl7zladuyzbxybeq5wcwt47k7tsgo4bh@rfrxaeqwzypi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YCRMyBXqOj2zZLWo7EFqIn6xcclGi_mQ
X-Proofpoint-ORIG-GUID: YCRMyBXqOj2zZLWo7EFqIn6xcclGi_mQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE0OSBTYWx0ZWRfX3o+vXU8ldk5O RfrWfi3VdML5/kOaKq/Jl+RwwnF7FGvJR3JC4SBm6ckj3tXQfTckEiETcVMIoIaoloxKwfetr8l C2WT0EkHwhegTFcIBDbkE/JuuwhLExwr+24bONX+IRtKTnHvcP2LKTK680peMmQwRYQX+ki7Xzm
 sROU3X0s8q1vbRcyeWWpI9dB6KXUs59WAvjIitBP3O5uGP2bT9woGCAYjnygg2U2q884+zgGlqA O5+rSN2OtT5wbL5Uaz/5EdqlWMmkXp3WqC+RKjx1zh2l7hkdkpJMrA2aZdXyIF49CaYtEXnwPao qvUfZfuWzwPSTXCGSRpc0nCnbQpK8mQ3AcDNLP+ao0TwmUB5AlF8S7sRxmHTzRz9I537YKlLZMu
 axJABUYiKvLm5C0yRFF6lXzciBiMDhZf7pwK0uOfA+djLB8lTkku8XpjMkBMop3lb6K9asGB
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681e1cad cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UTuKZRxF6MC2NIc7D_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090149

Hello,

On 09.05.2025 03:38, Sergey Senozhatsky wrote:
> Hello,
> 
> On (25/05/08 16:19), Zaslonko Mikhail wrote:
> [..]
>>> +#include "backend_deflate.h"
>>> +
>>> +/* Use the same value as crypto API */
>>> +#define DEFLATE_DEF_WINBITS		11
>>> +#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
>>> +
> [..]
>> The comment line says 'Use the same value as crypto API'...
>> could you please clarify here? Are there some memory constraints?
> 
> When zram transitioned from Crypto API (scomp) to custom compression
> API I picked the CryptoAPI deflate DEFLATE_DEF_WINBITS value:
> 
> crypto/deflate.c: DEFLATE_DEF_WINBITS	11
> 
> which is then passed to zlib_deflateInit2() and zlib_inflateInit2().
> 
>> I tried to build the kernel with DEFLATE_DEF_WINBITS set to 15 and
>> verified that s390 hardware deflate acceleration works for zram devices
>> with a deflate compression.
> 
> If we define it as 15 on non-s390 machines, will there be any
> consequences?  Increased memory usage?  By how much?

On s390, setting windowBits to 15 would lead to zlib workarea size
increased by 120K (0x24dc8 -> 0x42dc8) per compression stream,
i.e. per online CPU. 
On non-s390 machine, that impact will be about 115K per stream. 
Increasing window size should improve deflate compression,
although the compression speed might be affected. Couldn't find any
relevant zlib benchmarks though.

Not sure what other consequences might there be for zram. Do you see any?

> 
Thanks,
Mikhail



