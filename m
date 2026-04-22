Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88663C7E1B;
	Wed, 22 Apr 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862944; cv=none; b=pEiL0PSFKOSw6MXKRR4PlDuVwXjZCgl9HogARSFaSevg/vPPWLU7eBjxF1ddp0CECfxJO+vJv2Qd3aMdWY6CvcZRKBPkSzCsy/Zdgg5fZxUjoC36HYPhVqgAGs4JRTU53pkfuFCnWzLyHQBQi8rUDgG/G+U5ZphUtTeNpY7noLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862944; c=relaxed/simple;
	bh=K7ayVR7+pnOqpBwHBQKatfwfRBkINA133GaK8PooW5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1RqWS6DqWBBV8HwhR/kH0ilOP/Hmw8TGhFxygKBJ8wtlMcikQh7fdfxNKnrxhrIhMLy+UvK3cwa17VpnnFfslK0haF4W30n1sGlG1Co+eJX/DQT+n2Y00iOE1jqNJXToJyN87nbAK13e3kR/VGBjtA407J6ZgZ9OSOsUS4Swqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WXq0xjB8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WXq0xjB8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MC1JxN679751;
	Wed, 22 Apr 2026 13:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IAk+oA
	ra9BBwDoLPQU4kbPUsuc9NfHQMhIZIqbxtRr4=; b=WXq0xjB8zjKF3OiKf0Onve
	Rb7nTICvZFwHY+ksBx8PW7APb9tNNtY4s4QaIigKhFJFCe0haamaVHbV2HVKSpFa
	gA4MApjfG1MQmreF4bL8FKeJKJBZJt4mfXMae35yGS0w7nzCLJPpxVi6QK6YeWWo
	RjlNUIeYqn4ljYa6KQ4AFWK6H/zZSZAVh+0cAKVdcvDetcVq68X/p9meRI9Er67f
	TI7TAz2eAI0QyTnDmlzGD8CveVVOcpQWn0yOjBtS99ikjLLYNnvK6xdDqCGXXnn9
	hynT/lj32Qwl/ZakpFqCyzMLtcjby++UiqsVRjs5X531x/qy6O6GsO26tMhVUHzQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7k9xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 13:02:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCoJp9013995;
	Wed, 22 Apr 2026 13:02:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya9sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 13:02:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MD2FAo31261336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 13:02:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 172B62004B;
	Wed, 22 Apr 2026 13:02:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858A720043;
	Wed, 22 Apr 2026 13:02:14 +0000 (GMT)
Received: from [9.111.42.51] (unknown [9.111.42.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 13:02:14 +0000 (GMT)
Message-ID: <6a045fc5-e673-4b1a-945a-898a086026ed@linux.ibm.com>
Date: Wed, 22 Apr 2026 15:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
To: Christoph Schlameuss <schlameuss@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260226-vsie-alter-stfle-fac-v2-0-914974cb922c@linux.ibm.com>
 <20260226-vsie-alter-stfle-fac-v2-4-914974cb922c@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260226-vsie-alter-stfle-fac-v2-4-914974cb922c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9FVGfurs_AzZ5pQfCz5Kignl8Ji01BYa
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69e8c6db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=kPgyvtw9x8oKl6yeoNMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9FVGfurs_AzZ5pQfCz5Kignl8Ji01BYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyMyBTYWx0ZWRfX3BBXNEi69E2u
 MmaAlSUNS+FHzjAl2ZZxcVUboapvL3AaC/W8qW41Dy+w8U8syAzOBld1gNrRkqe/fhRzSJIn3Cq
 pi5rBQTdD3SwVQQ97dj6P2oHq+O6TGkvTvEOS7DzmMj2FSR0K81YbIWib52T2PJqAg+hDYhTtoT
 QAzIS+dIDEs8F9Mj7DNKCv6vUKCtcYktPufNDbXrfrQwIXTq5XgiJ/VLNqYd5K0beUXCrwH0SbZ
 qmbRs432P5bs6Mu9qtuUyufnprRxqJKQdOoxnw2cZJe2cBAgPz0iEwrr9xhIwhR5Noy7uOroczd
 xzGIwGBCECqVmnE8WGAzWMemQGSfUX6rgpQCppAfEkc5ynvHMAisYCGEnEAsYidFnROpL0EfMcb
 3yJF++Hbf7P7atRzGIzYHx7UqfWypwE4UTXs17pesxaMAXOoCWWnK4+tmVvm6GrmVSQ6R6hKCjk
 I6/kEXUUbbc5WPMNW8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220123

On 2/26/26 13:49, Christoph Schlameuss wrote:
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> Implement shadowing of format-2 facility list when running in VSIE.
> 
> ASTFLEIE2 is available since IBM z16.
> To function G1 has to run this KVM code and G1 and G2 have to run QEMU
> with ASTFLEIE2 support.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  7 +++++++
>   arch/s390/kvm/kvm-s390.c         |  2 ++
>   arch/s390/kvm/vsie.c             | 34 ++++++++++++++++++++++++++++++----
>   3 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 23d17700319a5ef2031eabcad34b6191d1ef9b21..89a797e436336b9671119d93b02f3b39b0ed45e6 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -506,6 +506,13 @@ struct kvm_s390_cpu_model {
>   	struct kvm_s390_vm_cpu_uv_feat uv_feat_guest;
>   };
>   
> +#define S390_ARCH_FAC_FORMAT_2 2
> +struct kvm_s390_f2_flcb {

Time to bikeshed.
I think the format should be at the end and we should name it like we 
named the apcbs.

kvm_s390_flcb2


[...]

>   static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
> @@ -999,6 +999,28 @@ static int handle_stfle_0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
>   	return 0;
>   }
>   
> +static int handle_stfle_2(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, u32 fac_list_origin)
> +{
> +	struct kvm_s390_f2_flcb *flcb_s = (struct kvm_s390_f2_flcb *)vsie_page->fac;
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +	u64 len;
> +
> +	if (read_guest_real(vcpu, fac_list_origin, &len, sizeof(len)))
> +		return set_validity_icpt(scb_s, 0x1090U);
> +
> +	/* discard reserved bits */
> +	len = (len & U8_MAX);

Was that the reason why we needed to include stddef.h?

I don't see functional problems.

