Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA274BD0ED
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447339; cv=none; b=cTIwLS6qDIdMk0kOpJDLeeSXZfZot8olGjP6m5gcXRPTd0gJd5Qk3j/1zpzL/nZEx6Wf19f+5VmSNPI46UbK2QIJ0+VpeuKcMK8k4TzY30+DdLkyIS9t6PDyMsFvbsNICw08Lvy3aRk0/Lggte19M2bUrtTM0X6ThMEiaGk71R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447339; c=relaxed/simple;
	bh=/LH2B4tdPoyKBq5EQsRZM/0jO8hDJQlMqwUSOQZODEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdZ8I/CZ9snjecVX8ddrlzpO8+qwHbf6EByjYCssPYMM9aDCNAliIoJ4xxI5ZRchcr6I7b44W/o/vEX7J0caH3WvREz+rVDiu94SOKqtjBHSOYmOnzGiyjmlMw6tQUWpbCTf2HROkOwqm6Kq2Rky2OrMZ8/NVSo3DsCj0n6N3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw3NEcf0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw3NEcf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788447337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8U+otGqZ4X4lHVqvG0g0N4yJExgb42yXgS3ZaxTrOlE=;
	b=Sw3NEcf0xJN0pNXa7O+vK0GRbxJcziF01cztIKIIxDi/U3ddrO4QSAX8adbclqLrRp9IAo
	UioudroS9VjEcslOhNolZF8ZR+A60Xorfgorl/1spQNkwwi4Rffzh4N6F7ylyaXruUf9pb
	FoqTMZD2wUYNmq7jCK0xRgpbajW/Jfo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-SizS3z2WMpmA6MXGV8OdaA-1; Thu,
 03 Sep 2026 10:55:30 -0400
X-MC-Unique: SizS3z2WMpmA6MXGV8OdaA-1
X-Mimecast-MFC-AGG-ID: SizS3z2WMpmA6MXGV8OdaA_1788447327
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92F3B195FDD0;
	Thu,  3 Sep 2026 14:55:25 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F3227D7;
	Thu,  3 Sep 2026 14:55:15 +0000 (UTC)
Message-ID: <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
Date: Thu, 3 Sep 2026 16:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
To: Sean Christopherson <seanjc@google.com>,
 Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
 Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
 Nico Boehr <nrb@linux.ibm.com>,
 Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 Oliver Upton <oupton@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-3-seiden@linux.ibm.com> <apdweRfqt4dTxcU9@google.com>
 <20260902075028.231001-D-seiden@linux.ibm.com> <aphLXQL1H2zYZgTi@google.com>
 <20260903114241.33034-C-seiden@linux.ibm.com> <apmEi1NmOUvmUBFP@google.com>
 <apmFClPZ2WcDINmT@google.com> <apmIGgMEN8w-kQAm@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <apmIGgMEN8w-kQAm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 9/3/26 16:45, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Sean Christopherson wrote:
>> On Thu, Sep 03, 2026, Sean Christopherson wrote:
>>> On Thu, Sep 03, 2026, Steffen Eiden wrote:
>>>> On Wed, Sep 02, 2026 at 09:14:21AM -0700, Sean Christopherson wrote:
>>>>> And taking things a few steps further, we can solve the MMIO issue in a more
>>>>> elegant way, and eliminate the runtime string building in this patch (after looking
>>>>> more closely, that code needs to be jettisoned no matter what, there's simply no
>>>>> reason to specify the names at runtime since they're separate compilation units).
>>>>>
>>>>> Rather than splatter #defines throughout header files, deal with the bulk of the
>>>>> pain in Makefile.kvm.  By feeding conditionals into Makefile.kvm, the s390+arm64
>>>>> build can easily omit coalesced_mmio.o and async_pf.o, define __KVM_HAVE_ARCH_MMIO
>>>>> programatically without having to change other architectures, and solve the naming
>>>>> stuff.
>>>>
>>>> Yes, this is a great idea. Thank you. I second you, this looks more clean
>>>> and stable than the stuff we came up with :)
>>>
>>> Looking more at arch/s390/kvm/Kconfig and virt/kvm/Kconfig, we might need/want to
>>> to build out infrastructure to handle this sort of thing in a more generic fashion?
>>>
>>> Which probably isn't that much infrastructure?  It's more just changing how arch
>>> code communicates with common KVM?  I.e. instead of providing boolean configs in
>>> virt/kvm/Kconfig, formalize communicating HAVE-type macros through the Makefile.
>>> That might even be a net positive in the long run, as it will make it easier to
>>> provide defaults for the common cases.
>>>
>>> I say that because unless there's magic I'm unaware of these Kconfigs also needs
>>> to be configured per-KVM, not per-kernel:
>>>
>>>    - KVM_MMU_LOCKLESS_AGING, otherwise aging on arm64 will unintentionally be done
>>>      outside of mmu_lock.
>>>
>>>    - KVM_GENERIC_PRE_FAULT_MEMORY, so that arm64 doesn't need to provide a stub
>>>      for something it doesn't support
>>>
>>>    - HAVE_KVM_MSI, because presumably it's needed for arm64 support.
>>>
>>>    - HAVE_KVM_READONLY_MEM, same story as HAVE_KVM_MSI.
>>
>> And in the opposite direction, HAVE_KVM_VCPU_RUN_PID_CHANGE also falls into this
>> category.  That one is probably better handled as a #define in header files?
> 
> Continuing the conversation with myself, add in HAVE_KVM_NO_POLL and
> HAVE_KVM_INVALID_WAKEUPS (which reminds me, valid_wakeup should really be moved
> into s390's kvm_vcpu_arch).

Yes, these three can be handled in a similar way as this in 
arch/x86/include/asm/atomic64_64.h:

#define arch_atomic64_xchg arch_atomic64_xchg

and then a #ifndef replaces the "#ifdef CONFIG_*".  Do this, and moving 
vcpu->valid_wakeup to vcpu->arch comes almost for free.

>>> Actually, thinking about this more, what I've proposed here, plus the pattern of
>>> #define-ing macros in arch-specific kvm_host.h files, should suffice.  For things
>>> like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #define the macro in
>>> kvm_host.h since it's very directly tied to an arch callback.  Whereas with KVM_MIO
>>> and KVM_ASYNC_PF, because they enable compilation of C files, it makes sense to
>>> define them in Makefiles.
Ugh, defining CONFIG symbols in Makefiles sucks.  I don't want KVM to be 
the one that does things differently *once more*.  I'd prefer to stub 
out the contents of the .c files instead.

Paolo

