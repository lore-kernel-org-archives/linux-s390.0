Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9253E1CF4;
	Tue, 15 Sep 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485210; cv=none; b=TYUOM0wyjwNnZ6D66OCgTRm+jyJnR5xnZSSLRwzqYENtuAujG0Z5y9MD+DGAuXQVSxz9kpy4BvBHHEBGowJSA7dHnbaa/ExyYYAbdq70wueqtQHE/sgfiBz8wjUzVnSmnPn8yte9bziXijDxIkm3Z4lm45hF+lETlCGwFYdYhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485210; c=relaxed/simple;
	bh=Z0ilRAejsrULYaen2uKaLqJsj+xhnO9e45l9vLPeLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZWV5aIDhygTSjdIxow0PRA9ZvjvK+5Zq6mC9ZOHaL9HZXJltVJ5DM6CvICzeMixwdEkJy0ucLIUe+XSaSr5NKMRG5UQYYH8zPKvXPEZXg2I6t8xfG6zJSO1XrR28Z4g28MmPlUSWqFiV8NQSFWbzLllhH+pJlz6YSh09SLmp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvbYy/S5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qvbYy/S5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1mhQ880440;
	Tue, 15 Sep 2026 15:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nClPug
	zImjh8Mtssq8WG/KMUbnzodRBWDDQKur8Ftfk=; b=qvbYy/S5OA2yGvniiKzvsC
	lLVeqSqGBME3/0fzh9C+XZ/vBIEr3alEwyeiBbEPctf/zLqqiY5SCd9MRxNZbvh7
	cLDJCtlCweHzUz8Wpx7qw72FXoSAN289cMgY48YUiuVevRgWAOErQM6vLQX5jPYx
	YhSpUprzNMDF5UPorflfOJeNq0txHjznM2Le9PznlyqeWiX5gm9TCLV44OlUQCu6
	Y8DE94IF6KMWils16XjVrjV/BClKdq3p1ThvULENQTbDvf2+uQGoQf1Y3QnBIfoC
	pK1rdtvSV0iCqi5m6r8yh9MRoC+7oxm8IQ8SJBa2ACIOn+Ro+9Iu5ZNC5yNddOtA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83qt9t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:13:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFAcsj4154552;
	Tue, 15 Sep 2026 15:13:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089hvsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:13:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FFD0J245678908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 15:13:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF332004D;
	Tue, 15 Sep 2026 15:13:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4032620040;
	Tue, 15 Sep 2026 15:13:00 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Sep 2026 15:13:00 +0000 (GMT)
Date: Tue, 15 Sep 2026 17:12:59 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Oliver Upton <oupton@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
Message-ID: <20260915151259.100384-A-seiden@linux.ibm.com>
References: <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com>
 <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com>
 <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com>
 <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
 <apmYPMMPCNzK9ZEA@google.com>
 <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
 <apnfaeWZoZTIsoZS@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apnfaeWZoZTIsoZS@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfX4f1E6lHehcYq
 QbS3Nr3zkvz0gcAkfPBC/a4O677v+VghU602LedLQFjiOPbwtrVQZAyVFy5zJ+BU93f3tU0j2dJ
 WrFO2LiRMjgIzAzIC/CEvs6/eRH/ygV2MTZc4XVOvVdpwergDfEgHlTKpbY9bAUpimqmEwDOdTG
 YN8xukR3hWFWaDYbesBJlwWMfFi3FXXDrC5Nfh7MMS0GgEqG4wLYC3jEaKBEBxw6gcR0XieBODS
 l8m7WnYpzyXkdPsgRdyh5sMtNips+R6SiiGWLYerHLIqtsMH5HsViYw51EddkC5hCBtVW7afHD3
 Nol9pG1bt2gG0PSPL4C32eijuKGBYiL5VJWKnxDDg7J9W4sfuM64CFhdHUSDjU+WFqiXviuQ5ir
 WD6OGYZ0J7YcoofwYF+Oz2pOVEo7nuNiTsy9Z/z/NJdn21aWFWdroKLGykD/Uac5XHSfVNX7lrq
 ErlC14wucXZZ0ge7mAA==
X-Proofpoint-ORIG-GUID: WxCxkDksCEReD1MZ83pDPJ8aGZLh6s4H
X-Proofpoint-GUID: VdCbw-ZydVK0LZUHdk_4CkXIQVYWXiTj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfX+fw4AdfxHG7F
 mDFOev7j9HgEE8VbBYLJx+pOJkYPjaJJXsCjJt5pw1VUBLJZKgIa5qc3YeZiaJJ8T9xVVWSs9aY
 lkPHmCWcEJvBpYMzIv1g2Dgm8Tx6cuM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa96082 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=9S3R2n0Mga1Sd5_YuRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150219

On Thu, Sep 03, 2026 at 01:58:17PM -0700, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> > On Thu, Sep 3, 2026 at 5:54 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > I don't want KVM to be the. one that does things differently *once more*.
> > >
> > > Too late :-D
> > >
> > > arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
> > > arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y := -D__KVM_VHE_HYPERVISOR__
> > 
> > Sure, VHE/nVHE is fair game because the nVHE case is in the same boat
> > as vDSO, arch/*/boot, and so on.
> > 
> > Looking at a grep for (cflags|CFLAGS).*\-D most are -DDEBUG,
> > -DDISABLE_BRANCH_PROFILING, -DDEFAULT_SYMBOL_NAMESPACE, etc. and in
> > most cases they seem like a bad idea. Don't do it for KVM please;
> > requiring -D for all architectures and for random pieces of config,
> > when you can put it in asm/kvm_host.h, is just as bad if not worse.
> 
> Boo, it's never fun when a parent shows up and takes away your toys :-D

:) 

I will then create a new patch:

I will move config options to asm/kvm_host.h
It makes more sense to me as well to do this in the header.

Shean identified: 

KVM_MMU_LOCKLESS_AGING
KVM_GENERIC_PRE_FAULT_MEMORY
HAVE_KVM_MSI
HAVE_KVM_READONLY_MEM
HAVE_KVM_NO_POLL
HAVE_KVM_INVALID_WAKEUPS

I will check the Kconfig files if I find more.

Similary to Kconfig I want to implement them as opt-in.

While I am at it I would streamline the naming and remove the HAVE_
prefix.

<arch>/include/asm/kvm_host.h

#define KVM_GENERIC_PRE_FAULT_MEMORY
#define KVM_INVALID_WAKEUPS
#define KVM_MMU_LOCKLESS_AGING
#define KVM_MSI
#define KVM_NO_POLL
#define KVM_READONLY_MEM

(similar to the MMIO patch)

Any objections for doing this in one patch?

The patch changes the Kconfigs, asm/kvm_host.h and removes the
CONFIG_ prefixes of the configs in the code.

I would handle MMIO in a different patch as this is the only config that
also modifies the Makefile but I am defenitle not aggainst merging it
into the new conversion patch.


If there are no objections I will use the Makefilevariable approach for
KVM_DEV_NAME and KVM_DEV_MINOR. It feels wrong for me to define those in
a header. But defenitely, the devname and minor should be defined at
compile time. 

	Steffen
