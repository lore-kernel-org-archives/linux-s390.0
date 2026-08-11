Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492043B3CC;
	Tue, 11 Aug 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469216; cv=none; b=o+PtcWL/M4CbeM6swbrqBM8hk3xmQ/zaEaZlYzvomXBjQFeM+muiIDAB2CsXcLvyr1yvA22ML3YFyWrguW63xfUII5wHj+ChUbqM9nG2pvboDe+mXfQP+3w9Yqxzf7CevmXqqjTlrD59ka19HbdpuASg09Y2Kte+Po9XA2XX2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469216; c=relaxed/simple;
	bh=OXs8A6IEUdh5f1zdVIJ2OZ/6mklZnyy4NoWKugnXkWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYhbsuX++qfuwtQTku2Z32eBk5OZDm1jGfmUyfOdaZzK2+HwllsNfrsoQyC3RK590CQHFNpWkQgPBnpRybbUca9jkDzpFJNNVnE7bLJf1si3E6rY7VZ0ODyET/b1oV7T3GzEAiGpqCPzWIK/IonnIl69QRsjaS0eAZxi3AtX0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vj+zN1Wl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vj+zN1Wl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVdd3964205;
	Tue, 11 Aug 2026 17:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H4f/fg
	ixoM2QbL6oxJwzSa0M9zyxDv6IgZti4/G6ETg=; b=Vj+zN1WllyYvO+Io2FJvnT
	U2dvrvsSGDqfePdEuICE7YXM6BH0aFGTSNEH+PahkTi3Vmr1S/MnM0qjWAXQcIWx
	uRjx37Lb4Id/K6Zq7fTBm8o42MN7DQlzZOEXpK3Gf7Mt+j/kg9ZEYL+9UY/Bdlep
	Tf3GVtyM7VK2LNHifaKGQPNBQASZpwVgVsEXoE9CCo2SadaqNE5vT4y1i9QZ3Ib+
	R/Jpila8ACqt9fhCeg5z55YhhQwMiilmS8W/x0NmyOmD6RpwU0dUZv5UAgPxKy/U
	x6vdjU4aWZVfp6IcnAcs63vwDASXMjyMrggMYIVZ0oO2qiiG9EnTo4Y87wJNVOtg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5h0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:26:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHQFo9000639;
	Tue, 11 Aug 2026 17:26:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1ru3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:26:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BHQh1V43778338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 17:26:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D511E2004D;
	Tue, 11 Aug 2026 17:26:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A00620040;
	Tue, 11 Aug 2026 17:26:43 +0000 (GMT)
Received: from [9.111.66.26] (unknown [9.111.66.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 17:26:43 +0000 (GMT)
Message-ID: <c1816927-d455-4164-8ae1-d0ccbac5aa9a@de.ibm.com>
Date: Tue, 11 Aug 2026 19:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] KVM: s390: Use srcu in
 kvm_arch_vcpu_unlocked_ioctl()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-3-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b5b58 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pG9oRMbJIAFsXvPiO7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T-1EEVw0mK3I5Q9Wfg_ILvrBf4Naq0wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfXxG1YNmbiaOlc
 3h7QunlA9Cx/iCw7jYKpSy9BKdxAkALYFOS/cN11OCEzmA61ujVwCyKWjZGM7w4w+tDJcG8Zpdn
 lXBqW8jOhxPTBEdU6b1H5NN1iwsOVCSYE9lD1046XUxZlUp4A+fe6AQFV00DScMIjgDK3nRpIlH
 8Q8FQfd0Sx3BtGgN1rQVzfillQ8SUcsU0znl5beV7t68cY3M4mocL7tNyMh/YMZVSQjIfCgVhck
 CS+hwPvyz1G8DRVt8wkIhjgIY3h3K3tKMJyCfbp+vIKnewIlEZqIi7WAqs6EjjMJADMQZckWnew
 gx+/YkMIcpsR0Ko5CChUeyoa+BRcD7Rn93slMKjDH02QwCTGgiX0/lT3+xi9+34rkQaWttPrxcB
 CTWm/6qXS05x8Hxv5uWMNuFdU94hxJjmITOl9B3WMA51xbdL2lkHOT/3bcZrHzl9trzATXWhlKt
 KXoXECbNYr+8SKtadVg==
X-Proofpoint-ORIG-GUID: T-1EEVw0mK3I5Q9Wfg_ILvrBf4Naq0wb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX57mcyzfpMFaN
 J746tUAv+cEfPlnepSoePD31NAxP1GY2rQGtIFjM/cw6n9FZrGxos1mRnqCoq9ESrjumWzseZuN
 ryxd2HbAhSCSACZli4OvfjYTbIrQTcU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142



Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
> kvm_s390_inject_vcpu(), which is called from there, needs either the
> kvm->srcu or the slots lock.
> 
> Fix by taking the kvm->srcu in kvm_arch_vcpu_unlocked_ioctl().
> 
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85..02c5428ba239 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5444,6 +5444,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
>   	void __user *argp = (void __user *)arg;
>   	int rc;
>   
> +	guard(srcu)(&vcpu->kvm->srcu);
> +

not a bug, but just having srcu around both inject would avoid having holding srcu on the
argument usercopy. This is not forbidden but might just take a while when paging.

  scoped_guard(srcu)(&vcpu->kvm->srcu)
                       rc = kvm_s390_inject_vcpu(vcpu, &s390irq);

in any way, no objection to your variant and a real fix.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


>   	switch (ioctl) {
>   	case KVM_S390_IRQ: {
>   		struct kvm_s390_irq s390irq;

