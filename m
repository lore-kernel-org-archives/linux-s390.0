Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E069357CFC;
	Wed, 12 Aug 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556165; cv=none; b=XJLUTCTeGHDpJDeliEJg3VVUvjqm2Ap+HwwnTXhqEg5qdrgSjzWZ5esBGWFWWcbi1L6Dv/iUetgpGdMu5EqtV4dvoKwa0Iac9MdkB7gsZ6ReoZlV9ahm2tUoy5cqdIbvLAAKBniqYjhkts4KM+Kw1McQdl90fbm9j+zaTkw+HY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556165; c=relaxed/simple;
	bh=fUkHX8obqGzGLokba8aHQmNCbNxuZDYvF5fQeFTjI2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxFZicmQOFO0w8GuYhAHvhhpmzNQT6O8r5pxMWZciErE6Kx/3IHmRjH1XAjrF3oTf8gsueTHhqtupbik+wPKZ/qSc7TTQw/TuomBbdfu/KXBLlB6w+sekYhY48QSQSdd8yHMIUq5x+kXEnMDN+f/vglbP45F7o0MbFGexaYW1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RGQrpm6u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RGQrpm6u"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1QJn4040620;
	Wed, 12 Aug 2026 17:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K6jnit
	X0nDAuyCSg5CVk36430EJwiSfAr3dbso4/l+w=; b=RGQrpm6uyGHUdp+DwoVrP2
	5XhzOXKLazcRiKjCqaSdqjgv7dFZhFBlTenPOLbiyyaAunXchX2WDHdZgQuZGkwG
	me+AjbR8PI2KUxyoZu3uBHAxT3DAVEJ+NfQjz3n6QSOrrkgcGEJJoCU5Isweep+C
	dYBg9p5H5+2rsy8Bt7rNQQ5BT/9hed7HJxcDFQgRwizzF3+uW2JV0LU/Dd+xJobK
	12DF5g1A/WpAYZpL67+UvZ6XYPl+AcWxOta8VryAfyYdIRjuLDOlLtND2z2B8lkq
	84J9oSnjiWHxanySWCo9HCzuCt/y2QVMoyysQgIOgX3+82iC+pV1tU2KbZegxlzg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9ks40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:35:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHQMex027502;
	Wed, 12 Aug 2026 17:35:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w7avq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:35:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CHZNWf33620294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:35:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A385820043;
	Wed, 12 Aug 2026 17:35:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFEF2004B;
	Wed, 12 Aug 2026 17:35:21 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:35:21 +0000 (GMT)
Message-ID: <3bd56e81-315e-4309-9e53-a6fb8390005e@linux.ibm.com>
Date: Wed, 12 Aug 2026 19:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/33] KVM: s390: Prepare include guards for a new
 location
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-14-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QQzL5z4aNjTJ9drbKsD67if7rH-Q88it
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7caee1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=RlKP9iUEHLkrO4DPn1EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX/qCciTY+v8Rg
 pI/tWj/64CcjSMdZBA3Lb1Kuxuu9g/ulOtPbeP9+yeNZRVbc885le9ix5vujxnjyJnTjxk7I3Mz
 lwkax2dckVxliDKq9FUNXQRnn4Ti3f3XY9OI5Vcv4guXuGDl7hykpXys2UUlScPriG9fLxNrudY
 KPwQZC813MDmlP/Lp5zVZs3G/claimGdR9fKbc1ZvFe4FQT7QvutgeRQ8obHxqaBxCwvzciuu8A
 bRCnyrX8BCb4K5KUH/q2BAImko/VqfU4lS25YIw+Ix5OLWU8b8FT02lJxwV55bp5lwvTqTGBSM7
 eL0Ly9ADTiJgErolcPsWdnI7JX6qiewM4PBvzgztIv6E2itlJw4XRux5bvPfGycyKYKdzZF+KT6
 Iiw+ZcXIB+PAYkurz1Oq70si6qLHHW23FTxreyrLk1dxHAygbkVwlK2+EflQ7NVc1LOv+Ry2Z/c
 F8TKccleNUdF4gNKzEw==
X-Proofpoint-ORIG-GUID: mGjTiZKsr2wl0OOSbk6CtiX6CXubcnwg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfXyS+KkYcHubvI
 RkBuwZFBw5ObXZ7lLjwuioZgqDbSHiECBlKcjyHdG+mFmJx3vIJ3ft2HtZ4NX7e5chqUlwpi2np
 YgtNVjsYxyHnrP01Ka/Yj9GOVECxrg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120142



Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Update include guard names in dat.h, faultin.h, and gmap.h to
> ARCH_KVM_GMAP_* to reflect their upcoming relocation to a shared gmap
> directory.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>


Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/dat.h     | 6 +++---
>   arch/s390/kvm/faultin.h | 6 +++---
>   arch/s390/kvm/gmap.h    | 6 +++---
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
> index 141ee7b9f019..87108f51228e 100644
> --- a/arch/s390/kvm/dat.h
> +++ b/arch/s390/kvm/dat.h
> @@ -6,8 +6,8 @@
>    *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
>    */
>   
> -#ifndef __KVM_S390_DAT_H
> -#define __KVM_S390_DAT_H
> +#ifndef ARCH_KVM_GMAP_DAT_H
> +#define ARCH_KVM_GMAP_DAT_H
>   
>   #include <linux/radix-tree.h>
>   #include <linux/refcount.h>
> @@ -975,4 +975,4 @@ static inline bool crste_is_ucas(union crste crste)
>   	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
>   }
>   
> -#endif /* __KVM_S390_DAT_H */
> +#endif /* ARCH_KVM_GMAP_DAT_H */
> diff --git a/arch/s390/kvm/faultin.h b/arch/s390/kvm/faultin.h
> index f86176d2769c..f343b6fb6f16 100644
> --- a/arch/s390/kvm/faultin.h
> +++ b/arch/s390/kvm/faultin.h
> @@ -6,8 +6,8 @@
>    *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
>    */
>   
> -#ifndef __KVM_S390_FAULTIN_H
> -#define __KVM_S390_FAULTIN_H
> +#ifndef ARCH_KVM_GMAP_FAULTIN_H
> +#define ARCH_KVM_GMAP_FAULTIN_H
>   
>   #include <linux/kvm_host.h>
>   
> @@ -89,4 +89,4 @@ static inline int kvm_s390_get_guest_pages(struct kvm *kvm, struct guest_fault *
>   #define kvm_s390_array_needs_retry_safe(kvm, seq, array) \
>   	kvm_s390_multiple_faults_need_retry(kvm, seq, array, ARRAY_SIZE(array), false)
>   
> -#endif /* __KVM_S390_FAULTIN_H */
> +#endif /* ARCH_KVM_GMAP_FAULTIN_H */
> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
> index 39938d363ec9..c54c35e47d6d 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
> @@ -7,8 +7,8 @@
>    *               Claudio Imbrenda <imbrenda@linux.ibm.com>
>    */
>   
> -#ifndef ARCH_KVM_S390_GMAP_H
> -#define ARCH_KVM_S390_GMAP_H
> +#ifndef ARCH_KVM_GMAP_GMAP_H
> +#define ARCH_KVM_GMAP_GMAP_H
>   
>   #include "dat.h"
>   
> @@ -330,4 +330,4 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
>   	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
>   }
>   
> -#endif /* ARCH_KVM_S390_GMAP_H */
> +#endif /* ARCH_KVM_GMAP_GMAP_H */

