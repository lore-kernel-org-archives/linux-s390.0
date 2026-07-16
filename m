Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255C41B8F5
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202193; cv=none; b=qlziGQm8Iwa5EvTVSSnS6ABS1QqZOaDhuEzzy44AuZG1zCxaA+biHCr+qao9aH4JHj/8PJEe5z589FeDrsJiBQDnmknlafm5OXXxef3huYgaFpC0PDDbkL79bguS3LPJ5x2qLtOeh9zR2/afwD75FZwyYE/o6hd93fuidyvCY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202193; c=relaxed/simple;
	bh=0S81DgELIeF+ShytiMTv9Y5IroZqOGN+tnaTEtOJxnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU4imjP6wzsD3MHCc9vOZZhexhxcRKdXljoUZmcdjXRB1hs6z2vgQfv+NU1MgtjuxQahR1N0N6ztFZP+jaCkTurR5tjjz7xTWgcW0FpT5/1z2vpdCcNTw2G3uAk0BXkbpKevzcj5H7YEzDRqzzOc9egqsAJiaVRTJUtUWfEranA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HgigF41p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HgigF41p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GAC7qG1019911;
	Thu, 16 Jul 2026 11:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R5BrWC
	grXc0WCrsF42dXIZqWUpRvrsoK1dIpDj+XdZg=; b=HgigF41pk9ludknoIhXbss
	ZGYGIPBHfzSU46mIg9JwdqmrW+Elt0vqE0O0Pa+fJewzBqzPs1UBZCrOZ5wS2uLG
	5+u3kPlg2ZXuQBIwO1A1z6Qtpi04n4uubNmU1rP8GS9Bs9dq7UWx/TKjAie4A7e3
	vrf+yJDtH4nWQtKCPMZDGq7eNbBVcxnahLbNrNFbe90EAllGC2nii81Tkhb4R/EM
	caxN2YuNyR25letjMOlE2AXadVGBIthgRdF/6xYJ9Kl+VqXvUgNHjoKoGbcqNTiu
	C7R8FsdpZVy92WjC8kPC/s/JtxZ7bL0Lck0yB4GsBoy/A94pNuYdk/kbtfdPCY6g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33h3bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:43:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GBZ4Xa020902;
	Thu, 16 Jul 2026 11:42:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qd09d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 11:42:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GBguHm26149542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 11:42:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC2AD20049;
	Thu, 16 Jul 2026 11:42:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D4220040;
	Thu, 16 Jul 2026 11:42:55 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.134.210])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 11:42:55 +0000 (GMT)
Message-ID: <c31e9b57-bc37-4987-89c4-b449a88bed6b@linux.ibm.com>
Date: Thu, 16 Jul 2026 13:42:54 +0200
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
To: Boqun Feng <boqun@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Lyude Paul <lyude@redhat.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <202607131219.euJHPSJ5-lkp@intel.com>
 <alfbtUKkXANyGyYf@tardis.local>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <alfbtUKkXANyGyYf@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfX6hrMtGhY2JG6
 mvNSKDHvxbRp6Zsd/l+FPmjWFTaWdXohOL9YaHHaol/vfFYFHSjxcunOBPqslj5diC3pfn12DPP
 2ffz5coWiMzsDDWnaTvvvW1uHJeuU1k=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58c3c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=qIyaegihW5ME95EVIzYA:9
 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: GCxuCTGbY-tfJv_Z-H2XIUdZKyVglF0o
X-Proofpoint-ORIG-GUID: GCxuCTGbY-tfJv_Z-H2XIUdZKyVglF0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyMSBTYWx0ZWRfXwDVa1K4qrzb1
 zmuotBmSWEKSUioEGVXHKMzMJEJczn1qdQcTRRnc4duRfBmwlHRyh8lK59NblBWjOIWoEctJAGJ
 rcYurl7Qt0K8mWwOMlVwU5dKAQtlnCSc7jk1XkccIVzwPQIacxmZl4IK5Kov159k/vq/Qs32jGs
 S39UvGWElHUnos9Nsjm/XQCSniVBuCIH5R4uoUOkWVfaKK75BWw7MVbRNxW87ytG0vhRn5tCFob
 FYKkfOqszOZSHEcjxufQug/xOzpYOMEiQ/SWoZoW6nu8oxujOD29u3C0qpyypLQLAPu9VJbX4bd
 DU40tTdwPCpqhtixqfxSwIjXacbdACyshMrPtSnYikBalGYrdWgvrTPa4yxKEKzAsEj7tWTl+Y1
 Wpho7CtNVBzGJMKbREgkdmsiy5DmZl6Z3uj+b7icwDsaedXbusSW9OGmdnXvrCR8ZBSw6cYBlLF
 Bi0rXTFK0LU66xBUQow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160121



On 7/15/26 21:12, Boqun Feng wrote:
> [Cc s390]
> 
> On Mon, Jul 13, 2026 at 12:45:07PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rust-rcu
>> head:   dcecd5f6e71e2437c8abe333ee2426fbe63e6398
>> commit: 27e30521043c39ca18ea3e28f825f9c7bd30b580 [14/27] rust: Introduce interrupt module
>> config: s390-randconfig-002-20260713 (https://download.01.org/0day-ci/archive/20260713/202607131219.euJHPSJ5-lkp@intel.com/config)
>> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
>> rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260713/202607131219.euJHPSJ5-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from rust/helpers/helpers.c:68:
>>>> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
>>        17 |         return irqs_disabled();
>>           |                ^
>>     include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
>>       256 |                 raw_local_save_flags(_flags);           \
>>           |                 ^
>>     include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
>>       184 |                 flags = arch_local_save_flags();        \
>>           |                         ^
>>     rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
>>        15 | __rust_helper bool rust_helper_irqs_disabled(void)
>>           | ^
>>           | static
>>     rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
>>        38 | #define __rust_helper __always_inline
>>           |                       ^
>>     include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
>>        55 | #define __always_inline                 inline __attribute__((__always_inline__))
>>           |                                         ^
>>     include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
>>       235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
>>           |                ^
>>     arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
>>        46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
>>           |                                                ^
>>     1 warning generated.
>> --
>>     In file included from rust/helpers/helpers.c:68:
>>>> rust/helpers/interrupt.c:17:9: warning: static function 'arch_local_save_flags' is used in an inline function with external linkage [-Wstatic-in-inline]
>>     17 |         return irqs_disabled();
>>     |                ^
>>     include/linux/irqflags.h:256:3: note: expanded from macro 'irqs_disabled'
>>     256 |                 raw_local_save_flags(_flags);           \
>>     |                 ^
>>     include/linux/irqflags.h:184:11: note: expanded from macro 'raw_local_save_flags'
>>     184 |                 flags = arch_local_save_flags();        \
>>     |                         ^
>>     rust/helpers/interrupt.c:15:1: note: use 'static' to give inline function 'rust_helper_irqs_disabled' internal linkage
>>     15 | __rust_helper bool rust_helper_irqs_disabled(void)
>>     | ^
>>     | static
>>     rust/helpers/helpers.c:38:23: note: expanded from macro '__rust_helper'
>>     38 | #define __rust_helper __always_inline
>>     |                       ^
>>     include/linux/compiler_attributes.h:55:41: note: expanded from macro '__always_inline'
>>     55 | #define __always_inline                 inline __attribute__((__always_inline__))
>>     |                                         ^
>>     include/linux/compiler_types.h:235:16: note: expanded from macro 'inline'
>>     235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
>>     |                ^
>>     arch/s390/include/asm/irqflags.h:46:48: note: 'arch_local_save_flags' declared here
>>     46 | static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
>>     |                                                ^
>>     1 warning generated.
>>     warning: 1 warning emitted
>>
> 
> This seems not a Rust-only issue to me, basically you got the warning
> whenever you have an inline function calling irqs_disabled(). I'm a bit
> curious why 1b301f5f28ba ("s390/irqflags: do not instrument
> arch_local_irq_*() with KMSAN") wanted to add noinline when KMSAN=y, all
> you need is noinstr, no?

Hi,

Unfortunately if a function is inlined, then noinstr is not honored.
The reason for using noinstr for these functions is interaction of
instrumentation with lockdep, so inlining them into non-noinstr callers
breaks KMSAN in a way that is described in the commit message.

Best regards,
Ilya

> 
> Regards,
> Boqun
> 
>>
>> vim +/arch_local_save_flags +17 rust/helpers/interrupt.c
>>
>>      14	
>>      15	__rust_helper bool rust_helper_irqs_disabled(void)
>>      16	{
>>    > 17		return irqs_disabled();
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki

