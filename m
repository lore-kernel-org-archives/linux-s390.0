Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85A38229A;
	Wed, 12 Aug 2026 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554853; cv=none; b=cAcpUgol2ct4mj1zvgMPPhIsjGfddY1+H4Dm7TskP8LrYBbf8jHnk3MPrVP3MvvDnnYMAs0Q1eFQQ6ssVtnCwfQ6Pwahk52b0d17Lo7z67hI4jrk2lozB6ngRDhSZ6bydjF5rXGu9WZb+zmyCg3xUhZNv4nid9yCRovYtgWBzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554853; c=relaxed/simple;
	bh=15cpDGHpVUZpvoO33H9U1AA2h29xJ0ECrarUK5QCibI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As5O5VEY35kWuwb7cDQrsiJPymHGSgFf+YQDcQfreUs8Bbsssf+kR7E1aaOykGVulu4Uz1zJno55C/DGawqSTLsjA1IWkQJsOgwWlCecvcned6rq4gacoKycv+0RxedHhrjBYaJTNt+RlnDIqENuygiS2CQeqrDzabBwy2NURKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ujm0rMUr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ujm0rMUr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1h3o2218045;
	Wed, 12 Aug 2026 17:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vtGhBI
	H6rBiQb6jAGz2MNon2CVl6n919ow/5bNoh5e8=; b=Ujm0rMUr8QiUCxLoOKm5tx
	L6rcAZD5yYYmeL0jkDSwK/9tLoC16QeexXC7ADmInrEtUttmYhmapiD7IYSwoPwu
	pVmT/F/EPFAWRFZ1Ve/cmgskFKWxLs28YNc33i2wSNk8WRg0iUdvDlXIujT+uHQ9
	5tEu8HR+KsBM1tQ/YRgTVjBUhAxCj3Xa2Ux5Fef2dq++WzPhPESYcwCuAzYlKGda
	SnFZHDUDQzyNWV4qniNSFt8OQREHielEQ00VaVsT5F9m9S5VejHxYxkuVw1k+ITM
	/VnrIuP1ly6oL0+8iumSE4mhxI314hZGk2MYBuGePrT33kWTazcOnrmnfBXThv8Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03pn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:13:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBQuu028259;
	Wed, 12 Aug 2026 17:13:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjy46w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:13:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CHDmlW39780696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:13:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1092720040;
	Wed, 12 Aug 2026 17:13:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A75620043;
	Wed, 12 Aug 2026 17:13:45 +0000 (GMT)
Received: from [9.111.47.51] (unknown [9.111.47.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:13:45 +0000 (GMT)
Message-ID: <c4c6e007-b6b8-4c6d-adda-1d9cb2cb06fa@linux.ibm.com>
Date: Wed, 12 Aug 2026 19:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/33] KVM: s390: Extract gmap tracing to a separate
 header
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
 <20260812153631.3376090-13-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXyJJKj2LKb6We
 o4N9biqjZvpXXw8Yw4+v/gKHeqImGQQGstIihglG6g4H7WCNln76fEl1fyXzStOfVxKSNHG53pk
 kF7/QiIi2Hetc+aL81rFr8X8BsFePOKFFNgshrTXHnkJ2l2QZGqqe7wMsuo9vWXfu2/Cb26XAgH
 8ZYPQgVYiW0tW+P4pRrCezg1UA1vCV6Tr/oCdPgUIWjRTK/CDYkzSjlz/IsKmM3nKCz2EuwuuSW
 ys2n+2L4J1CwiWwpcSK0Vd2K0Bd9xdgrqxUtGUCqhNIOQ0vgfYhQVWxmt4GWuyQ9WDrgsEtLi83
 fGDHX9qVshbNMIzmrTjYI/6lltVKXlTEGoEmA6kIglfkYcFZRAf5EKSfAYLPK1rAbFRA17lR/hU
 5xNOyO2oWRgjQZO9orxArvYjw7NXkbdFECj197SzLSRA14C+HuxlpL9ImHoSyG10KY7TwhjL6AA
 LoOXkbmYzam3z6fcC/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX8A2GiiyzOeze
 2WXNVIBk9XvXLKyElb8lMTXWX8eQcf2M6l+Ie2csDnk/rZ0EdftSn7JRG5vED9s7pxcd4UYoD1K
 OKlutzfD18rKIeLGxb/HYqHIZaThMRQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ca9d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=yzJRou8Qdc9NfXe1HyYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BnQ2_1V_LArLz89TSAuwglc3jzb5nbJL
X-Proofpoint-ORIG-GUID: YNJaABLtzoFps6WA75Y1q49bgrbDj74z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138



Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Move the kvm_s390_major_guest_pfault trace event from trace.h to a new
> trace_gmap.h header. This separates gmap-specific tracing from general
> KVM/s390 tracing, preparing for code sharing between multiple KVM
> implementations.
> 
> The trace event definition is updated to use local defines for
> parameters so that they can be replaced later with ease for when another
> KVM implementation uses these traces.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/faultin.c    |  3 ++-
>   arch/s390/kvm/trace.h      | 14 ------------
>   arch/s390/kvm/trace_gmap.h | 47 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 15 deletions(-)
>   create mode 100644 arch/s390/kvm/trace_gmap.h
> 
> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index 3cc45f7f5b2d..1dc79807012c 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c
> @@ -9,10 +9,11 @@
>   #include <linux/kvm_host.h>
>   
>   #include "gmap.h"
> -#include "trace.h"
>   #include "faultin.h"
>   
>   bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
> +#define CREATE_TRACE_POINTS
> +#include "trace_gmap.h"
>   
>   /*
>    * kvm_s390_faultin_gfn() - handle a dat fault.
> diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
> index dd2685c7df5b..3d2fffb1555a 100644
> --- a/arch/s390/kvm/trace.h
> +++ b/arch/s390/kvm/trace.h
> @@ -45,20 +45,6 @@ TRACE_EVENT(kvm_s390_skey_related_inst,
>   	    VCPU_TP_PRINTK("%s", "storage key related instruction")
>   	);
>   
> -TRACE_EVENT(kvm_s390_major_guest_pfault,
> -	    TP_PROTO(VCPU_PROTO_COMMON),
> -	    TP_ARGS(VCPU_ARGS_COMMON),
> -
> -	    TP_STRUCT__entry(
> -		    VCPU_FIELD_COMMON
> -		    ),
> -
> -	    TP_fast_assign(
> -		    VCPU_ASSIGN_COMMON
> -		    ),
> -	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
> -	);
> -
>   TRACE_EVENT(kvm_s390_pfault_init,
>   	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
>   	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
> diff --git a/arch/s390/kvm/trace_gmap.h b/arch/s390/kvm/trace_gmap.h
> new file mode 100644
> index 000000000000..a3cad705021b
> --- /dev/null
> +++ b/arch/s390/kvm/trace_gmap.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(GMAP_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define GMAP_TRACE_KVM_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM kvm
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace_gmap
> +
> +#define __KVM_FIELDS \
> +	__field(unsigned long, pswmask) \
> +	__field(unsigned long, pswaddr)
> +#define __KVM_ASSIGN ({\
> +	__entry->pswmask = vcpu->arch.sie_block->gpsw.mask; \
> +	__entry->pswaddr = vcpu->arch.sie_block->gpsw.addr; \
> +	})
> +#define __KVM_PRINT \
> +	__entry->pswmask,\
> +	__entry->pswaddr
> +
> +TRACE_EVENT(kvm_s390_major_guest_pfault,
> +	    TP_PROTO(struct kvm_vcpu *vcpu),
> +	    TP_ARGS(vcpu),
> +
> +	    TP_STRUCT__entry(
> +		__field(int, id)
> +		__KVM_FIELDS
> +		),
> +
> +	    TP_fast_assign(
> +		__entry->id = vcpu->vcpu_id;
> +		__KVM_ASSIGN
> +		),
> +	    TP_printk("%02d[%016lx-%016lx]: major fault, maybe applicable for pfault",
> +		__entry->id,
> +		__KVM_PRINT
> +		)
> +	    );
> +
> +#endif /* GMAP_TRACE_KVM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

