Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A897438014;
	Wed, 12 Aug 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557524; cv=none; b=rlaVGwF6KWAcmUf9w6/BS2UOM0N26vatQY5tdHtizsOSBzBKmQNYv8lvnVLe9fDynloqoMp8lyA4RWD9ZhUxmsNNeElT19LcZiem6JL8in4X5zUVztK+s3dD7eVQGJ2Xw4lVinjoNjNZiJB/WnUG9nGxzPOKjhwi8OO2wsyep6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557524; c=relaxed/simple;
	bh=EsXJeMGGsKBG+vxPZTHU2RkLDZMh++T3473KOx9P7x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owmWK0Rj8m6vQ1lhb9A7DmEpXlzj8RTLAnsTc1tyhkobN94zTQF6Onfr52AcVRHdrO+VJPj1b8SG+asqYGSBenmf5JS8h9qvKnKIw14a3QkQxNW2wkJsPblTZftlUjX6sJ4BQq1zhUAcDYE083gtU+v5AJtWGTJQMgkITVoI/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UabF+UYl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UabF+UYl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1bgZ2217958;
	Wed, 12 Aug 2026 17:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fuSr6/
	eeaMrRsHUHHYzlvdoFfyGGwlSHMW89VzkIKtQ=; b=UabF+UYlQd16hM/zI0amP6
	kW09Y8xgrSz51NWzc3Qy81uF5fGWvmzrrkBYRLiEpSShcLQQrwUBiseONYeuiUam
	KDXjEJBdze82BP0S+5GxZThflPXQSfn7KAB5TpHfXLalC3xnZLz2idk+z2VCYqGu
	rTqcOWB669DW1kyOA+WHtiC5Epcv7WJh014aOQz6B2VEtKXz0NnpU1RVntZi9SiT
	dxF67gD2BDAiXIugCs25pXVuQYE6QHvLfF+FJWwIM+7el+U3NAkpXzhwp0BtlnGt
	okyurC/G4wW0E10xx+oHQwwBA9m5eYkWlkrp2mSbbNy9K3h6uew7qlNXIu9Ibg7g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03vqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:58:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHuIrp018316;
	Wed, 12 Aug 2026 17:58:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjy9nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:58:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CHwHRR28115298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:58:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 269EF20049;
	Wed, 12 Aug 2026 17:58:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C13F20040;
	Wed, 12 Aug 2026 17:58:14 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:58:13 +0000 (GMT)
Message-ID: <f8e7aa8a-f3a8-4186-9fd9-95e9885562b2@linux.ibm.com>
Date: Wed, 12 Aug 2026 19:58:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/33] KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
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
 <20260812153631.3376090-15-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX988gdqFD3S3y
 F1yyA+LbQ1Mw3jbCPc+0sTv99OWbTVqCmVYvyl+JbJ0q/vdBUV6vKFRABkraXFUt8YW7HVeEq/t
 R3RLcuJGWHXL4JAEE+mtK8ZOH0nN+ZDaGqblQyMuENz/Tnt1oIoqfDmsTYiXNaaKD25C2imkaId
 xRMmusVeba04UnOr2W7Lepl3usN4+y0UFvebq0aWQjxy9QZPjFHfqD5gCIHB1MMji4yQNUbyBgk
 IpSPlc3g+al5bPb2gCXoOgCicgOwXZ+gbEjbpgzc9xXa9l1+sP5+RhInvLKYk6yeswa+clYj1Vt
 z0SWz6Auf8Km7O0TaRMQM1ctuxBTpf/wzvvW0E37Wbw4RQQrORQe2ziNgo8qUDEeOOM+Dn1eLT+
 he3PPPa2ZeMQBC086GU+BW+KLvpIvv/r4IqOHKhupxlyiOH41yaBZaj0pJ01B9yfg4tDIYAY/vG
 YhoUSaHA8ec1FLZXeBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfXzEASJRj0p3r8
 JkmnsqVffsMKPpC8OcJgUQCKdgou82HP+FDWNvfomoOEoTJckLnyJfir++2Vqaj5Qc+Ah5YCYGV
 tF6No84ioHdS7qzASWM/jQoGL/agxtI=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7cb43f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hk9PhALmR_EFMQ00aDgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xv4SAS-1CFtckbb9ZIxJxCBX1BhuOECA
X-Proofpoint-ORIG-GUID: cEAZkxjNuz8FmAAGSbsgFJS4UGxP5pHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120142

Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Rename kvm-s390.c to s390.c and kvm-s390.h to s390.h for consistency
> with the new directory structure. Update all include statements and
> simplify Makefile ccflags from explicit paths to -I$(src).
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/Makefile               | 4 ++--
>   arch/s390/kvm/diag.c                 | 2 +-
>   arch/s390/kvm/gaccess.c              | 2 +-
>   arch/s390/kvm/gaccess.h              | 2 +-
>   arch/s390/kvm/gmap.c                 | 2 +-
>   arch/s390/kvm/guestdbg.c             | 2 +-
>   arch/s390/kvm/intercept.c            | 2 +-
>   arch/s390/kvm/interrupt.c            | 2 +-
>   arch/s390/kvm/pci.c                  | 2 +-
>   arch/s390/kvm/priv.c                 | 2 +-
>   arch/s390/kvm/pv.c                   | 2 +-
>   arch/s390/kvm/{kvm-s390.c => s390.c} | 2 +-
>   arch/s390/kvm/{kvm-s390.h => s390.h} | 2 +-
>   arch/s390/kvm/sigp.c                 | 2 +-
>   arch/s390/kvm/vsie.c                 | 2 +-
>   15 files changed, 16 insertions(+), 16 deletions(-)
>   rename arch/s390/kvm/{kvm-s390.c => s390.c} (99%)
>   rename arch/s390/kvm/{kvm-s390.h => s390.h} (99%)
> 
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index dac9d53b23d8..961de97b8e80 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -5,9 +5,9 @@
>   
>   include $(srctree)/virt/kvm/Makefile.kvm
>   
> -ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> +ccflags-y := -I$(src)
>   
> -kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
> +kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
>   kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
>   kvm-y += dat.o gmap.o faultin.o
>   
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 031ab6e5d6c4..09033c8ff1bb 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -12,7 +12,7 @@
>   #include <linux/kvm_host.h>
>   #include <asm/gmap_helpers.h>
>   #include <asm/virtio-ccw.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "trace.h"
>   #include "trace-s390.h"
>   #include "gaccess.h"
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0d389a302a70..e5c064f263df 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -17,7 +17,7 @@
>   #include <asm/access-regs.h>
>   #include <asm/fault.h>
>   #include <asm/dat-bits.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "dat.h"
>   #include "gmap.h"
>   #include "gaccess.h"
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index b5385cec60f4..ef922b3b4990 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -14,7 +14,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/uaccess.h>
>   #include <linux/ptrace.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   
>   /**
>    * kvm_s390_real_to_abs - convert guest real address to guest absolute address
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 3758e4009709..b5b920392378 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -21,7 +21,7 @@
>   
>   #include "dat.h"
>   #include "gmap.h"
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "faultin.h"
>   
>   static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 9a6149e310bb..1bf7e91b7e61 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -8,7 +8,7 @@
>    */
>   #include <linux/kvm_host.h>
>   #include <linux/errno.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "gaccess.h"
>   
>   /*
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 1980df61ef30..ca1205dfac8b 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -17,7 +17,7 @@
>   #include <asm/sysinfo.h>
>   #include <asm/uv.h>
>   
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "gaccess.h"
>   #include "trace.h"
>   #include "trace-s390.h"
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 0d9fbe75dc66..9aa786952718 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -29,7 +29,7 @@
>   #include <asm/nmi.h>
>   #include <asm/airq.h>
>   #include <asm/tpi.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "gaccess.h"
>   #include "trace-s390.h"
>   #include "pci.h"
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 50f5ec79600e..82892e1e03d9 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -14,7 +14,7 @@
>   #include <asm/pci_io.h>
>   #include <asm/sclp.h>
>   #include "pci.h"
> -#include "kvm-s390.h"
> +#include "s390.h"
>   
>   struct zpci_aift *aift;
>   
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index b1ba24c346ef..b3cb2c2c3aa7 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -26,7 +26,7 @@
>   #include <asm/ap.h>
>   #include <asm/gmap_helpers.h>
>   #include "gaccess.h"
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "trace.h"
>   #include "gmap.h"
>   
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index f549b161b972..7adfdc9b62be 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -18,7 +18,7 @@
>   #include <linux/sched/mm.h>
>   #include <linux/mmu_notifier.h>
>   #include <asm/gmap_helpers.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "dat.h"
>   #include "gaccess.h"
>   #include "gmap.h"
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/s390.c
> similarity index 99%
> rename from arch/s390/kvm/kvm-s390.c
> rename to arch/s390/kvm/s390.c
> index 4faff6625da3..ff09ffc10f0d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/s390.c
> @@ -50,7 +50,7 @@
>   #include <asm/fpu.h>
>   #include <asm/ap.h>
>   #include <asm/uv.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "gaccess.h"
>   #include "gmap.h"
>   #include "faultin.h"
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/s390.h
> similarity index 99%
> rename from arch/s390/kvm/kvm-s390.h
> rename to arch/s390/kvm/s390.h
> index 6d2842fb71a3..e144ca2e6d5e 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/s390.h
> @@ -452,7 +452,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm);
>   int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
>   int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
>   
> -/* implemented in kvm-s390.c */
> +/* implemented in s390.c */
>   int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
>   int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
>   int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index 55c34cb35428..131b3371ef4f 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -14,7 +14,7 @@
>   #include <linux/slab.h>
>   #include <asm/sigp.h>
>   #include "gaccess.h"
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "trace.h"
>   
>   static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index f546239d8ff8..cc94ede0621f 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -23,7 +23,7 @@
>   #include <asm/nmi.h>
>   #include <asm/dis.h>
>   #include <asm/facility.h>
> -#include "kvm-s390.h"
> +#include "s390.h"
>   #include "gaccess.h"
>   #include "gmap.h"
>   

