Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD923F0770;
	Thu,  6 Aug 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011471; cv=none; b=RoeaIsgCR6AjFpKFqD+gXyVgXSuUDoBdk3G8pWEIMkLPqnyE/3k4OfsGzLD/OLSQjWbH8UjO5urIgnFdi3OxgQbcO5u946rUlHP9T3sL6K4EZPMOYTRFibc2a1PSY8wkUfhZgcLodM3aaip9UU64gMMCIkfi2lNTiOVPquX2vRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011471; c=relaxed/simple;
	bh=/+SN0Dax9jFbdo8tebbAxOefbjYBOn72BZ366GoHSr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/PIkbcqWpQw+EC8jlu/GpFZVsDTp3D/1Rxj35RoGLmGjR0KANWk3Ert57dt88/X3IZl3J6Jw5ATV+T7xTjKmUMzNhMrLbQWLFVf8SDW2guNHdXLvKMsj6WWneVDL8rA83rmtj9zA+T0Uy32B9uqcWBYctEZ+rd7jDLPuGbui7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhLrrOWF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhLrrOWF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NledO1066097;
	Thu, 6 Aug 2026 10:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xWQsUuKDSPb9DWbLq+sdaPZdpNexvu
	fPZrU6rXmQKAU=; b=bhLrrOWFdDiqnJeCnQVznlYbiES4P8sLB34S7XvNEnsu8M
	4yDHN3Zl8cn+ucJi7qCbeMb5dS8sUeQtKG4cLlBO3NrexXFUEOpPD3eIEwKeCj9P
	+UQV4VaMJHiL/pA0WtIMSuDjmJHfSFrYKYuVFZrwliOgh1Hffidq/96iZlVbXAOy
	RWNa+p4UayhfcRRMbXRS52e3OwBt1LgLdF/05eXFgSNIGHDZEbdPGlw29w3XvOoI
	5cJFxuNTTS0d2cbN5S2NaLK2WO78NEtTg1OAFdKVtOC7X+IYmU4l37tG9kIkeKZt
	JEArziUY4SY6DOQVN0ddLAVbIQg2Xb15EkpYHTVA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a47ksb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 10:17:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6769uIPo010881;
	Thu, 6 Aug 2026 10:17:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhjnpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 10:17:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676AHgLA36110692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 10:17:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54BCF2004E;
	Thu,  6 Aug 2026 10:17:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047D520043;
	Thu,  6 Aug 2026 10:17:42 +0000 (GMT)
Received: from osiris (unknown [9.111.55.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 10:17:41 +0000 (GMT)
Date: Thu, 6 Aug 2026 12:17:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] s390/irqflags: add out-of-line definitions of
 arch_local_irq_*() for KMSAN
Message-ID: <20260806101740.15764C97-hca@linux.ibm.com>
References: <20260806100038.3163298-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806100038.3163298-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a745f4c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=Dgj9qDPHEj2U15jq-kMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: daEQwDc-UGJbO4GcXxCJ0UavI8_uabc0
X-Proofpoint-GUID: jJH7huY3amt8_BPsWNrwsiq6afkEMSPM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX7pqZiXem5eOW
 4idFSoneqlbZ9vz9UVmiOtff9hRjAXlfseAB+B6cohXOkxVrgcIu8Oh+MVXbffW2AY69ox7me/K
 jIT89KQ/XAcMeFKLoT/ZrH2GTFCBPbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX08rTjLSDVldG
 X69nnfTM548FqzDl4e67kgeDY8liykQLl9PSCMry43OnNiqifouel7OL8t4glWG2KEKbsiXRW0g
 axdeW1aoDZ0pqJ3dJ+FIhf7AqgVOwmi3DUzWkTH+PC4D7eDQnI4O9cg+yF4fNhcybOqc96Hpmak
 /eGQgPJhRT550LghplSpmbsmiSqQC5eUlkugLFkX+JDMBas0mZEZVxTWayBLvw6pUWdIOYr+O5q
 8hpBX6LhIcdL7x4BJJUss8kDK8XCTQvKZAcWOgAypFt8b6q+YMoYoMJpuIfVHG4kFdVQ5lv9OgU
 t64FwOA+MV98xK+bY6BIwNHPwCw70gZCLfEXQNIFm4N6lJAxt/qAgj9SiWVVLs552vpsAHIJNNN
 x7FrKQSj8bd9cYEIGFBoZSBJr3eGzDl2YvlI/mndZZZrTGsuK21ra7BAKizbDKRXKXxDvKDK0Hr
 XobFUSXFB7a+Bq9VWuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060080

On Thu, Aug 06, 2026 at 12:00:19PM +0200, Ilya Leoshkevich wrote:
> Inline KMSAN arch_local_irq_*() definitions run afoul of
> -Wstatic-in-inline. Move them out-of-line. Decompressor is not
> instrumented, so make sure it keeps using inline definitions.
> Make sure non-GPL modules see the out-of-line definitions.
> 
> Cc: Boqun Feng <boqun@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*() with KMSAN")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/irqflags.h | 20 +++++++++++++-------
>  arch/s390/kernel/Makefile        |  1 +
>  arch/s390/kernel/irqflags.c      | 27 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 7 deletions(-)
>  create mode 100644 arch/s390/kernel/irqflags.c

Don't we have the very same problem in arch/s390/include/asm/uaccess.h
with uaccess_kmsan_or_inline too?

> -#ifdef CONFIG_KMSAN
> -#define arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
> +#if defined(CONFIG_KMSAN) && !defined(__DECOMPRESSOR)
> +extern unsigned long arch_local_save_flags(void);
> +extern unsigned long arch_local_irq_save(void);
> +extern void arch_local_irq_enable_external(void);
> +extern void arch_local_irq_enable(void);

FWIW, we go without "extern" for function prototypes.

>  #else
> -#define arch_local_irq_attributes __always_inline
> +#define arch_local_save_flags __arch_local_save_flags
> +#define arch_local_irq_save __arch_local_irq_save
> +#define arch_local_irq_enable_external __arch_local_irq_enable_external
> +#define arch_local_irq_enable __arch_local_irq_enable
>  #endif

For the sake of readability: could you adjust all of them with tabs?
Like e.g.:

#define arch_local_save_flags		__arch_local_save_flags
#define arch_local_irq_save		__arch_local_irq_save
#define arch_local_irq_enable_external	__arch_local_irq_enable_external
#define arch_local_irq_enable		__arch_local_irq_enable

And just to annoy you: the patch subject needs to be adjusted to:

s390/irqflags: add out-of-line definitions of arch_local_irq_*() for KMSAN
               ^

In the meantime we require always an upper case letter following the
component.

> +++ b/arch/s390/kernel/irqflags.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/irqflags.h>
> +#include <linux/export.h>

Please add an empty line before the first include, and also change the order
of includes - "linux" should always come before "asm".
