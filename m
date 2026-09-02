Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B12DC792
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309536; cv=none; b=Op1Cf4n8Z0bFFWyOak6eC7aXYwHn48jAwFtEhZLOc5fHc7aG2B5K7lqoqSgHitjC2fsXBq5/VPNu50jty39cmR8i/vGtvLveu+PhYtkGp8fhzmH/UKkR+jaOwRJx4fx/jQ2udRtWF2tLXsmocUYRLAsQwygUP/WLaLboW75wLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309536; c=relaxed/simple;
	bh=dM8UMjdfpzrInG7yBCOavPUVK2/x4vlb0fefgS3K6Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SaepJdYIFkmy7gVGaDdHfH5eg5RdeDdZXbb8rbQAtDMmxl+Lzrtpoi3WKV6F4CEPj416d9peS2LRTGFgG/JxwULgPA2uiXAjU3eJRWetghxoUIwsqmUw2+o1JdMHEOzOPpoxcAwdS4hm8So+bSwNpNSBibMj1T2P27cotav9MWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cd9q9TuF; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cd9q9TuF"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso5478945ad.0
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309534; x=1788914334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaTmFFkWvtpI1wxK9lbUH5Q49TqxcdmMs9wtskLlSB4=;
        b=cd9q9TuFdqYqcDrugYPeY/JVeFF8BqYOYNEwpohfGF45vi82FUDlNUcdQLqpSqTvrs
         Rdh1tHhEou14WwmTHxqMp+CSiQ0OSNLH3HkO9yyFpxyu0ZEJUkuYSzgEWr4C/Vcjz1sZ
         2ZXeIhlEiPtKY/n8cwyP1SniE/AFekKN0U2LRmroUF3Ta/3c4owa7QjWp+QBt+iyAWbU
         oO9TfdSBZyyBRbwQXOaHrSoteRS71mHAJmgCdkIJ1HghR1/oTgSsTqSoqIPlvKpyrxAl
         sdO1y6mThMALRjC7ExBGuTIbUtrloROtrVKLTdUQD7nj1d9crFr+nak1zM1e7Umq5y4W
         fkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309534; x=1788914334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaTmFFkWvtpI1wxK9lbUH5Q49TqxcdmMs9wtskLlSB4=;
        b=A61qhqCXcwRYeyQIH3b1e5LdRPfnhPd+3RgDn2yW86ylB3GT+3cSyXVgE/LtmwlW9r
         f1q1itevgZf8/O8QyQVg3CwipohMVzGzDd1UbFQgYvOIM3abNQivuLi08gJhkLFO6G1d
         Hx9D5AqZtKeBiLV1sRUqPRv73VfEK+R4+VY/3z58OGC1UpIN5NHA09V2TtkygWmu6oJG
         53TajDLRH+7QTHyhm30QMWF5hoHS66ZcJeo4zT35jAM3NsT2ZUOtPj1YdgWdI08/SOXF
         9DWv9r3LMDVMUofbpnTWG3LrWXhCSoCC3IqsFgZqvS4XiOOOnoJVmdQx1zelYqc6QzTT
         5uNw==
X-Forwarded-Encrypted: i=1; AKwUvBxkdCr4iaKuDnxoZegM961uVyCT4OIXVqeKFZ2xi3scosfPKGwuQzqbBgAtn40IlZ1+GW7exCajBDND@vger.kernel.org
X-Gm-Message-State: AFuF++lELN21bl3uGpNW+ETVcVetrAHsYyMXWiNfEDdoE67yDp/Oy5dA
	xZKL4aIt+A/qZ8LMe8QyILzrWQLJhtv4z2lQBpB7sV97asOykqSffi1hrUTVoOFxL0LavCYv0jQ
	BTMLgxA==
X-Received: from plgf7.prod.google.com ([2002:a17:902:ce87:b0:2cc:6063:a658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26c6:b0:2d8:d4cc:be67
 with SMTP id d9443c01a7336-2daec73f1d2mr14199535ad.20.1788309534336; Tue, 01
 Sep 2026 17:38:54 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:38:53 -0700
In-Reply-To: <20260831144802.834315-4-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-4-seiden@linux.ibm.com>
Message-ID: <apdwHcdy2iYRTrww@google.com>
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Steffen Eiden wrote:
> Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> where one KVM implements MMIO but others do not. Solve this by
> additionally testing for the non-existence of KVM_NO_MMIO before
> including MMIO code to KVM.

Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
to be annoying to maintain, and will definitely be confusing for non-s390 people.

It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
support, but I'm guessing that won't be at all common for s390 builds.
