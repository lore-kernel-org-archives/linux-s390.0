Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669A322A1F
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210096; cv=none; b=EMCCGihO5nnaMn2g5GMyW0OWYAL1ixXJvuwj1oLaxms3IEMgS1QFgd3MRDLNx1Au/GQR6dutrVcfCr2CpU8K+opcHL9mx/MZIYrCRM15lDmJBxn7P/IVieSR8O4M6ced1HfXltj/zkUT60UxRpZQ1/in3CyoB3C8M5+SP816fH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210096; c=relaxed/simple;
	bh=iVeIG0h7n3P2rGEmrJDmWjRK/vnwVF0SnpjZFa2iN6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4cG9csz/DSBFizjqze5V05osBdNFK+KQtv5GloI81ki+5iKrrVFtnbTFJ/wPWlZdDzE2BYRvbqjftbtxZBxO6w9HHcN8YuQdltu0ADZuuB19WavyR26P0fGG6RuVj3e5vkq5vAQNTK7UOD6CU92VMfbtdjD2MDloGvgrDbkSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wm0AKunS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wm0AKunS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfgRS1469841;
	Thu, 16 Jul 2026 13:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V6uFoj
	vM4zr5zCdUb4O5iQuVgE+kVe9me2sV3lRFtyk=; b=Wm0AKunSAzru7wYK1chTuC
	gNIME/LO/hJ15VxJkhqUlvlkkhRxIUhYsgfmlUzMu+bFAwXaU8R2/BWxlw7ehbzq
	T1L8SsmZ3LyxgH+USyzd5zs/VhUvwQrwAlWK432IeHMFcJrH763xVImQgZbKMSLS
	qjTEhihNZuPKS9lZBABvxYjjwh5DrdMfyAfWzX/ZXVRGuzii+0jMTC7tXOSnQbtv
	QeX38/vruvH54z5vK2CLM8Cp1mRvkauAbwkHzm87jlZDpd1hpoyK+OROb8X2qHRS
	YvDylDHIAuO7ujuv4+PgaGfxFxdlhwBiXi0wXO6O4Xk3knhtQikewRdgTfzcPuBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33hpgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:54:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDYfPW017584;
	Thu, 16 Jul 2026 13:54:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdf8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 13:54:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GDsfW344892642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 13:54:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40AD020043;
	Thu, 16 Jul 2026 13:54:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCCFD20040;
	Thu, 16 Jul 2026 13:54:40 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.134.210])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 13:54:40 +0000 (GMT)
Message-ID: <6b6eab2e-8324-4173-9896-89f13127d042@linux.ibm.com>
Date: Thu, 16 Jul 2026 15:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [boqun:rust-rcu 14/27] rust/helpers/interrupt.c:17:9: warning:
 static function 'arch_local_save_flags' is used in an inline function with
 external linkage
To: Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Lyude Paul <lyude@redhat.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <202607131219.euJHPSJ5-lkp@intel.com>
 <alfbtUKkXANyGyYf@tardis.local> <20260716115652.25491C83-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260716115652.25491C83-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX83oHPeftlP27
 EMIaRAiqt3nmBZbMwm9mO7eDaCdx/zir+zf3pxdx+jKKQxbszk9q08yA4ql8ve7tHSMOKcMxg1t
 H2ggv0xNPjzje0gCqU+6/sLpnaQOBS0=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58e2a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=yDg0MXncU-FSiYKy0mAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zkEpa3DXTOxGIm-_RXiAQBMxHcR4AqR9
X-Proofpoint-ORIG-GUID: zkEpa3DXTOxGIm-_RXiAQBMxHcR4AqR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX2aGN3ji6Ah8P
 Uth9zLTPR2ToRNYZQ6FAUXPjiNI4bmObNrvm185OxjS85qNebtWEQMcvmZmyKcAIlK62Mho5OWK
 Y6ERi37GcodNgkj4bmtuzKGG/g8IpnQD/ICER16LxMm4CALQR0Y8vhJ8wO3cKnfcvCmMMInDPXq
 KN/7YmYpNjPIb7aEeTSa6IbtLglXv9GBeO0NjPUs2cKcpAZ7EilZNk6iaKFztY1qwHq5PT2Wp8w
 mVtcUBhv9lSaFKcPuU/kbbXCueS5WTH+2dUgrO4aZdNJ5t1dLzKQN5/kgFuQxWJVrXnzpV1pZF6
 XgWA5rMemVEn3tbTrOH0DJi+Bl16Cx8ITab+Ytdf3I2HFItPGZF/p0cqmLEzmAPH8lo+H9JpmMz
 2LykZj7kDNtwLt0PBb/1q3/TQ9aEz4UCCvcZAf9kkyX8e2EIgnkmf75f6/xsPxMmp+KHRCgrAEO
 Yo/m5dKLH+xuoiGcbzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141



On 7/16/26 13:56, Heiko Carstens wrote:
> On Wed, Jul 15, 2026 at 12:12:53PM -0700, Boqun Feng wrote:
>> [Cc s390]
>>>     In file included from rust/helpers/helpers.c:68:
>>>>> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
>>>     17 |         return irqs_disabled();
>>>     |                ^
>>>     include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
>>>     256 |                 raw_local_save_flags(_flags);           \
>>>     |                 ^
>>>     include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
>>>     184 |                 flags = arch_local_save_flags();        \
>>>     |                         ^
>>>     rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
>>>     15 | __rust_helper bool rust_helper_irqs_disabled(void)
>>>     | ^
>>>     | static
>>>     rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
>>>     38 | #define __rust_helper __always_inline
>>>     |                       ^
>>>     include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
>>>     55 | #define __always_inline                 inline __attribute__((__always_inline__))
>>>     |                                         ^
>>>     include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
>>>     235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
>>>     |                ^
>>>     arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
>>>     46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
>>>     |                                                ^
>>>     1 warning generated.
>>>     warning: 1 warning emitted
>>>
>>
>> This seems not a Rust-only issue to me, basically you got the warning
>> whenever you have an inline function calling irqs_disabled(). I'm a bit
>> curious why 1b301f5f28ba ("s390/irqflags: do not instrument
>> arch_local_irq_*() with KMSAN") wanted to add noinline when KMSAN=y, all
>> you need is noinstr, no?
> 
> While the combination of __always_inline and noinstr _seems_ to work
> with clang, this looks just wrong to me. I guess we really would need
> a (single) out-of-line variant of the affected functions in question
> for KMSAN.
> 
> Ilya, since that was your commit, does that sound sane?

Hi, sure, making them out-of-line would make life easier.
I will look into it.
