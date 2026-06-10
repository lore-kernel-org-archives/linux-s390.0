Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FF213E9C;
	Wed, 10 Jun 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081777; cv=none; b=rHzLVei7xmiv2YBkpyga6if/Xw9LC6zlRd6f/nTJ3IuNZVwUX5eCLbtoaubpizbbsp7VYqarlJwyPx5gzHnNqXcMVhJLd4KW0Vwy3S/hMQJZmx6FIRmSXuzGcIPwcHQ2ufW90HyMUj0vh3RHdA4PwtVxHym4PUNvDLppJOywzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081777; c=relaxed/simple;
	bh=xQV2M8oQbfZDLyUs1ygzwzdgR63Jc+u+jdQtoQD9qLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU2wZ8DHOxZvUsXTzI5JjDMT8mtkUyqofYTEWEFErO3D0FmXgF3n1fjmXZGR2xKUauMCTs9of7tqbjdclbRWD8aq8kTdVtchjjs8MrvPAkPfdLq0KNZRW/iJmDCm3BeAUTUz/zhYULtfYs6TqZpFwmBx6Tfwh3yPsEEmtOS7eTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QdkUPCvw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QdkUPCvw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659HZ9iI3019572;
	Wed, 10 Jun 2026 08:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0cmI0N
	YGBYOXzRBXqMx+l5aqqYfaSzz5pALu8SyC5VM=; b=QdkUPCvwXNIxCD87tMSFJW
	V6JpnQGoYqrqo7m1vAdxSBx7pDp+sEmqjTappqcKBljU69Al+zJbTGiMw9Chdzfi
	Miuo3xVddSk4gntJgeoPr2syHB7huVsG5CmfAILtepI1tmL5zQGEoGW85LPXCT20
	Pa3t03uUbhDwvAhObvHz3uWgLLikJPfEweq62grG9w3OBlG9dnxf/TFNHPaxDZtv
	aDKjo9fgwKLu0DYDMLqV43i8Gr28PnNrflsPqy3m5Umz4s/+YB/WBDdXx2WEnI+s
	yCysk7BHB3plow8SY4/BZe8vk5Vr5JP3z2ZJhbesdBndUSO4iEh6CmouvATRM5Zw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qr9mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:55:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8nd5G021647;
	Wed, 10 Jun 2026 08:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g5qm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A8tVbJ45023738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 08:55:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A30520043;
	Wed, 10 Jun 2026 08:55:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32A302004D;
	Wed, 10 Jun 2026 08:55:30 +0000 (GMT)
Received: from [9.111.52.177] (unknown [9.111.52.177])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 08:55:30 +0000 (GMT)
Message-ID: <8280da18-b0db-46c9-b6a7-5864fd945144@linux.ibm.com>
Date: Wed, 10 Jun 2026 10:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/26] s390: Introduce read/write ARM sysreg
 instructions
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-14-seiden@linux.ibm.com>
 <2d73aca5-1858-4a7a-a304-0971e4789dc1@linux.ibm.com>
 <20260610083054.151573-A-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260610083054.151573-A-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a29268b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=gP38sU8B_-xW9SrUZJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AGYVd7PxwhujTjbFY4JicdBUrg3CLnTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MSBTYWx0ZWRfXySJu93HLwnzH
 I01zxkJjq1NQhKkifu+j4cN+yd5mXofIrWct5CdpozPcRCkWpDsQPhqo50T4U+Pyci/+U7hQmIe
 7IQlw0zWWTsiUAyM+UWf9Md5RDDoTvVCZ2quuc3BUFB3ssx1lSmhNCgtd+r5ce/xx/DaYXGZ94L
 10lktSz0Rxjia7CKhMZKL7pN33rQHOcF0AOlSIjr/WRN3eUQbT6WlQp+yg9DSuDC4OF/PXaW0/w
 Eus/8M9FNfVL9Vo7QDIWMR00BC4H7lh+PSw5NupuhB4FTkeK1INIhnOVJlKCP198ixRvs0HBV3d
 G8dFzzsYX5jC3Y+dH1SNHlevZ6LbBMVf897rE9hBIO5bWdiiZd+8t66KQveUItGWEMV+njT/zMh
 9DdI6yLg2KB7FULz4Q6EX4GwGZWkihkVb3DhIWvn9aoLL0I+KiJqOA66F2x/VEefz+ycSgCvA1r
 44a4P7ZqvYE3rxpu+vQ==
X-Proofpoint-ORIG-GUID: AGYVd7PxwhujTjbFY4JicdBUrg3CLnTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100081

On 6/10/26 10:30, Steffen Eiden wrote:
> On Tue, Jun 09, 2026 at 05:04:10PM +0200, Janosch Frank wrote:
>> On 5/29/26 17:55, Steffen Eiden wrote:
>>> Introduce Extract Arm System Register and Store Arm System Register to
>>> enable s390 hosts to read and write system registers for arm64 guests.
>>> The new instructions use the new RIE_H instruction format. Add assembler
>>> macros to create instructions in RIE_H format manually. Add Support for
>>> disassembling the new instructions.
>>>
>>> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
>>> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
>>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>>> ---
>>>    arch/s390/include/asm/sae-asm.h | 48 +++++++++++++++++++++++++++
>>>    arch/s390/include/asm/sae.h     | 58 +++++++++++++++++++++++++++++++++
>>>    arch/s390/kernel/dis.c          |  1 +
>>>    arch/s390/tools/opcodes.txt     |  2 ++
>>>    4 files changed, 109 insertions(+)
>>>    create mode 100644 arch/s390/include/asm/sae-asm.h
>>>
> 

[...]

>>> + * sasr() - Set Arm System Register
>>> + * @arm_reg: ARM system register identifier; compile-time constant
>>> + * @val: Value to set
>>> + * @save_area: Pointer to SAE save area
>>> + * @flags: Operation flags; compile-time constant
>>> + *
>>> + * Sets an ARM system register value.
>>> + */
>>> +static __always_inline void sasr(unsigned int arm_reg, u64 val,
>>> +				 struct kvm_sae_save_area *save_area,
>>> +				 u64 flags)
>>
>> m4 is 4 bits in length, any reason why we use a u64 here?
>> Same for easr.
>>
> 
> No real reason beside my preference of using u64 by default.
> 
> Do you want me to change it to u8?

Yes, that makes the potential problem a bit smaller but also:

Since we go through our macro magic I'm not sure if the compiler would 
complain about values over 4 bits. Did you check for that and if not 
please do check now.

If it does not complain we need a compile time check. Well maybe we 
should have one either way until the instruction format is available in 
compilers just to be safe.

@Christian: Thoughts?
