Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F11373BEC
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974589; cv=none; b=ZdxppHMHfj259xTMmfmkjyFQj/79OtjQ87EsT8jdUyH22yxBqBPvkeYKryuzUeJAYlctTMHPkld9GHhJHGpoedWeLoLPf9FT+N/RHsVlXwSTm2hAXgPFFWb5QoTYGUDW3PsDKl0V85cEXs+/zM9l/+cNyJAC5PIxqq3QUp3Ekk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974589; c=relaxed/simple;
	bh=yzvxLYq7Q38kB+6lHczvstjByWszec7SZd7Yaz6zm98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcUNErWqeQ0RuNRb4XfEShc38h1GgaPdbT7nkdC6wWKKnq4c6Xahf5+1YVL7Q00Ikym+i5UQG+DKo6QJKp5Eu3v5PQu7t9Wyyk+QnA1wOYYPna9grTvYf/J7UpB25sxXsBcU0HlynYEoe869sMm8HzvmxdSxWb5IUr+1votDnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F+xjUXUI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+xjUXUI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ah5w122562
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2jDaTfQ1fQ4DlIVjiX66DKYQF6xj2k
	7wY1jCgL7tfmI=; b=F+xjUXUIwqRMVB7yXuWbt2eaZjtJ+UlvswPhJ0q2+AueV0
	DL4/lI/QzOHFphUDudu6H0k/aJGKOdqcAtRj/FvVncrcFz3qq+XBxNnIvpx3GPHS
	VAQte9EjdURXb8IvG4PNJt7eNDyDENeFKLq5pkXDFDSjgc6NljchqGiM6sY1zPwT
	h2J/ZzUKQ5Zy4s+/BKPZD1WlbrgzfNxPjJo+ZVxmNj8w6b9aWE6Ka8WgcdrVa3v5
	XFwtMfVJA1vws8yzFNOOL3QlI1qUEFZgEmCVNiPmi29yNSaFZEv/7uNGJJgiaz8v
	ZaqlWK0L+X6QBZ8vqFDi/N6TFYHITWGiD4kS9NMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske173a2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3XWKj603398
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjm76r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L79iQm40239500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 07:09:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24372004E;
	Mon, 21 Sep 2026 07:09:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA2FE20043;
	Mon, 21 Sep 2026 07:09:42 +0000 (GMT)
Received: from osiris (unknown [9.87.139.10])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 07:09:42 +0000 (GMT)
Date: Mon, 21 Sep 2026 09:09:41 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 08/29] KVM: Move architecture capability Kconfigs to
 header defines
Message-ID: <20260921070941.26183-A-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-9-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-9-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bFvOvALnU7lwj3fnn-YuOT0-9vqqC181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX12ybkBRZIbGs
 m6X+RMBGdcfXUaiW1BhNUn4POXc7N/Pti5peU7rItY4qL/SylRU34z5x1Z+snMD4UELQplRRtVE
 6nloxwxVt7DJaCsRNcENNCV5Z5WNuJ/nu9iVrbs4NxOpy4sv6QQMUhUiRWeiqivCQftkQnWKALN
 BQu+gPC2qTCiMMLDDHfdSZHoFC5vCGMMqRWt3AvDsHE6fpTloVkuYnzO/N3qmJAo5JyuSFuWqre
 Pq4dOqtjMQfXQCfBv7kCOlK5FKuhBogug9DcmN/cGwL5uukXiEknJcTIMrvGWXD4/qzBN8z7J1L
 Mbfu4VYAWFE85BnK7cB4jJV0QZhwooxu5fLoM1EvkTuEz5rJrdfTAi2/9df4o5pRk9VrDj8VWwb
 J8xUR8RMIQuOdx2v0kAiAEaVtvCuMSxxlrDw8e0c0ztcDI5dGxoEQSucZZGQMmpiCegqZ6zKY3A
 UpRkOiaWAgthEhQFlQw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab0d83a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=znR89GDvB2Kr2Yv9AEAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX1wyD3vKUa9GR
 rR9jRXA7byUK2UfvO6UogCgQFXItUUBjBEFB9V/bFHPclHm9el35hpAaHSOHpOgZPEBv7bA9h88
 sS3i4ePisBrXqLn2ssJP6sJ+ubVSfQM=
X-Proofpoint-GUID: bFvOvALnU7lwj3fnn-YuOT0-9vqqC181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210100

On Fri, Sep 18, 2026 at 03:30:45PM +0200, Steffen Eiden wrote:
> Historically, KVM feature opt-ins and callbacks (e.g. read-only memory,
> MSI routing, generic pre-fault memory, lockless aging, halt-polling
> controls, and vcpu run PID changes) were configured globally via Kconfig
> symbols (CONFIG_HAVE_KVM_* and CONFIG_KVM_*).
> 
> With s390 hosting multiple independent KVM implementations within the
> same kernel build (native s390 KVM and arm64 on s390), global Kconfig
> selections force both implementations to inherit options that only apply
> to one of them. For instance, selecting KVM_GENERIC_PRE_FAULT_MEMORY for
> native s390 would force arm64 on s390 to provide unused dummy stubs.
> 
> Replace these global Kconfig options with architecture-specific opt-in
> defines in <asm/kvm_host.h> and standardize their naming by dropping the
> HAVE_ prefix:
>   - KVM_GENERIC_PRE_FAULT_MEMORY
>   - KVM_INVALID_WAKEUPS
>   - KVM_MSI               (formerly HAVE_KVM_MSI)
>   - KVM_NO_POLL           (formerly HAVE_KVM_NO_POLL)
>   - KVM_READONLY_MEM      (formerly HAVE_KVM_READONLY_MEM)
>   - KVM_VCPU_RUN_PID_CHANGE (formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)
> 
> This allows each architecture and guest implementation to configure its
> supported capabilities independently in its kvm_host header and eliminates
> unnecessary fallback stubs across different KVM targets.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h     |  3 +++
>  arch/arm64/kvm/Kconfig                |  3 ---
>  arch/loongarch/include/asm/kvm_host.h |  2 ++
>  arch/loongarch/kvm/Kconfig            |  2 --
>  arch/mips/include/asm/kvm_host.h      |  1 +
>  arch/mips/kvm/Kconfig                 |  1 -
>  arch/powerpc/include/asm/kvm_host.h   |  3 +++
>  arch/powerpc/kvm/Kconfig              |  1 -
>  arch/riscv/include/asm/kvm_host.h     |  2 ++
>  arch/riscv/kvm/Kconfig                |  2 --
>  arch/s390/include/asm/kvm_host_s390.h |  4 ++++
>  arch/s390/kvm/Kconfig                 |  3 ---
>  arch/x86/include/asm/kvm_host.h       |  4 ++++
>  arch/x86/kvm/Kconfig                  |  4 ----
>  include/linux/kvm_host.h              | 20 ++++++++++++--------
>  virt/kvm/Kconfig                      | 20 +-------------------
>  virt/kvm/kvm_main.c                   |  8 ++++----
>  17 files changed, 36 insertions(+), 47 deletions(-)
> 

...

> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index c3c0ee253fc7..008b110ebdb7 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -9,7 +9,7 @@ config KVM_COMMON
>         select PREEMPT_NOTIFIERS
>  
>  config HAVE_KVM_PFNCACHE
> -       bool
> +       booCONFIG_ltt

Sorry, that must have sneaked in last minute.
Obviously, this is a mistake.

