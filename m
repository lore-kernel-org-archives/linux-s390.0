Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBNfCEmg"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985810D9
	for <linux-s390@vger.kernel.org>; Wed, 29 Nov 2023 17:07:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db539c987e0so130266276.3
        for <linux-s390@vger.kernel.org>; Wed, 29 Nov 2023 17:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701306466; x=1701911266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0wFvlno3kNCM+277a2S5UNbGmqd2ft4cb10DJm/tw=;
        b=bBNfCEmgFymvjkNLh+IqU66ObGz7TfIu8fnFUyT8fKBdyPRUbGQ0smRkhBSLIzRUYU
         gqrl2h6hyAjQIDjwsSQPKhDr31xAvrXz5/YebxsFUPY+yQbHKMLQDAhuEwIuEzD6j1f9
         q0ex8m+op4ylh5KORZt3QKbd/ylOJ0UqZtc1856ZonBJ5nizG56EzV41lXq9hjxphfCR
         /sjcacs3k0MKftnIUi5hUAy8wXw2B8Ql24oqU8MAm2EfHXTJvdcxYkhmydRJX+azcY7H
         jQgt3mTJiIG5UG5XWuP7ifWmnjFWz3XAMRJBn8x3MZa0RSqnqjWpr1sRRGiNoCBMC7bw
         5i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701306466; x=1701911266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0wFvlno3kNCM+277a2S5UNbGmqd2ft4cb10DJm/tw=;
        b=BRTRdNZ5i9Azi+iyroq2BwJcMz9QKmV99XHsKq5xOYPzx5DWr1Y1jVEk8v3YxOogCS
         bciWA/BnuVUptv03PPpQA/lIxb4jAlyQGTTr9O7iAI1vX9j3524/YYv4UhlEVKfjuaZN
         y+/37CXZp7g4vbateucHWfz3C7ue7OI01o9Luw0JaON06koFdCWXTmRSwtz5s5/MhH/y
         XO6G9m4ooD/loYieFNEpqibsVVT3e867qEOGi6PdUTtI9n4LwEVwTNdxVNzED293+MKh
         HMrUCnYgI5djGcTgNe5KU57fVFgezPXcFo1RrN0a532+St55CHsw/KBqVTi/zcgmCEi1
         I1dw==
X-Gm-Message-State: AOJu0Yy5vynRRs0an7lOaa7gxFnPfKOWk5qBJ6T5GvZlq5OUCu4I3ViH
	tryVMYCcCif9m5nybYU+fXalQh2SywA=
X-Google-Smtp-Source: AGHT+IFI+jDPj/rF774qvoJ2qWoHyFZGCHN96iaq8+b2ScA3/i76IDoNcSAJtId/pe2rL3s2OfV75Y20vgc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ca02:0:b0:db3:fc48:35f0 with SMTP id
 a2-20020a25ca02000000b00db3fc4835f0mr615843ybg.6.1701306466524; Wed, 29 Nov
 2023 17:07:46 -0800 (PST)
Date: Wed, 29 Nov 2023 17:07:45 -0800
In-Reply-To: <875y1k3nm9.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com>
 <87edgy87ig.fsf@mail.lhotse> <ZWagNsu1XQIqk5z9@google.com> <875y1k3nm9.fsf@mail.lhotse>
Message-ID: <ZWfgYdSoJAZqL2Gx@google.com>
Subject: Re: Ping? Re: [PATCH rc] kvm: Prevent compiling virt/kvm/vfio.c
 unless VFIO is selected
From: Sean Christopherson <seanjc@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, James Morse <james.morse@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	x86@kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023, Michael Ellerman wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > On Fri, Nov 10, 2023, Michael Ellerman wrote:
> >> Jason Gunthorpe <jgg@nvidia.com> writes:
> >> > There are a bunch of reported randconfig failures now because of this,
> >> > something like:
> >> >
> >> >>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning: attribute declaration must precede definition [-Wignored-attributes]
> >> >            fn = symbol_get(vfio_file_iommu_group);
> >> >                 ^
> >> >    include/linux/module.h:805:60: note: expanded from macro 'symbol_get'
> >> >    #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
> >> >
> >> > It happens because the arch forces KVM_VFIO without knowing if VFIO is
> >> > even enabled.
> >> 
> >> This is still breaking some builds. Can we get this fix in please?
> >> 
> >> cheers
> >> 
> >> > Split the kconfig so the arch selects the usual HAVE_KVM_ARCH_VFIO and
> >> > then KVM_VFIO is only enabled if the arch wants it and VFIO is turned on.
> >
> > Heh, so I was trying to figure out why things like vfio_file_set_kvm() aren't
> > problematic, i.e. why the existing mess didn't cause failures.  I can't repro the
> > warning (requires clang-16?), but IIUC the reason only the group code is problematic
> > is that vfio.h creates a stub for vfio_file_iommu_group() and thus there's no symbol,
> > whereas vfio.h declares vfio_file_set_kvm() unconditionally.
> 
> That warning I'm unsure about.

Ah, it's the same warning, I just missed the CONFIG_MODULES=n requirement.
