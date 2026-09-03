Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CA4BA9E1
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445974; cv=none; b=D6Q9Lub/VUGUzYNmtGEvN8ebepUAX3314jz72y4TCt94yUnuo77mnebDlovlArajKnRu/RXlWBVs/go0vIh40ECeVueBgesoCFFeWUKDTzd4k4pb73Rl17tv9GSmCcF8S1Lz46F2ak417vVUsIbVfyIpbalwYKNxWDvgM50s8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445974; c=relaxed/simple;
	bh=NevMf3nDQq4VIBy/kjYGDtq3lURnltfIiR+R0CkPfUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k859eVUT0cnVdvtK/j6zuDrezk6xiJly8tTn5ifEBd3Yrh/NphTMVpVDdcnaytaNSR/yJubX02lJi4O6PyFO562hl59b/TlyVAk3oMX4jw8ivUSB+qEUE1TEQnJm3GMUxRWp6FXiDeM64Q+i9YEyKhlL4Pa5eLeh8PtcQx2h/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDBz3hfl; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDBz3hfl"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso3382640a12.1
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788445963; x=1789050763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jepDX0FobScpvhoQHC25avp5Il/0jZZ+6SCAUX+k/50=;
        b=kDBz3hflcTDSfbc/9VpRv4ojK1eIUqj78wMfcm68X1EekfGhdcydNIlx9imMBAZ13C
         JWHjwLjVmEmsV/ABUnOvkhR/4EKxeTzExWRB5iDxyxp6zyIKzjvXbIYnCt75VL4erBRQ
         RgI+KLZpuQ7yFgTGjrT2DceBX5spQOW0U9Up1UAJLgA60m9nUVE7cTvDM941MAdQ+Kc0
         L80484umf40fU1B7NHoR6QPcV5rBb6bkWDKD0Sdm/Kzf8PIdTxks3wh1tG0Nm7vHuunf
         MQakjLY+rCGiQrTiF/S18HOF73mMxjAPYSLAynBBCh1gmCgY3ihDktbFjgJF7j6yD2T2
         SwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445963; x=1789050763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jepDX0FobScpvhoQHC25avp5Il/0jZZ+6SCAUX+k/50=;
        b=f1ncC1nGzbjVgL2iznDxmNlNmttGHgm+abFxpOaDOIL40/CDtr3Xar/tOuDb3+89bP
         d04OJy8It/xNaVpp4KW/DBLZRNzcqZIdhfhPiKklo1PWKWd4FQN9rwhu7g8JibSdsax4
         j6on4k3dOm2F4d/Y5CXWvhvCcXWrNpIUaMzNA0NptHw6qYA57pkElGzxTksAtVZHWL9O
         F6OQpxSI0zeABGWTnxpwsvbRu+pVDgKNabuhjCL6T4PHspdnBpXriw0vazwhQqaEgPYk
         agqLjIUCAi/f/2XwTBwISQtftLl8ll4hgXWVDx3YOFbZIYxOCwNKN2SBGi19HXQNj6pD
         f9QQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6GkT3m9cxYsj9pbKWF6aGCPfg3b9/rErZLh2LNWhUVUVKXbOyNJeEnbqApjT7ffFHU5G9HM7/9VrZ@vger.kernel.org
X-Gm-Message-State: AFuF++k2Av7lP8c/6WYnBIVVKmQgXCfCnKIwvtIPmmqE2c+R8icj8fzE
	lSR+B4FP4tISv8wm5FfA9UhH9LWfmAW8eSkSn/d9Yn51++itYauVsOrlrvf6I/4fUA6RG0fLko8
	3FuQ6fA==
X-Received: from pgac2.prod.google.com ([2002:a05:6a02:2942:b0:cc4:37bf:2cab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a8:b0:3d0:6c90:5a33
 with SMTP id adf61e73a8af0-3d9ad9a2a0bmr20468355637.4.1788445963198; Thu, 03
 Sep 2026 07:32:43 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:32:42 -0700
In-Reply-To: <apmEi1NmOUvmUBFP@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com> <apmEi1NmOUvmUBFP@google.com>
Message-ID: <apmFClPZ2WcDINmT@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
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

On Thu, Sep 03, 2026, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, Steffen Eiden wrote:
> > On Wed, Sep 02, 2026 at 09:14:21AM -0700, Sean Christopherson wrote:
> > > And taking things a few steps further, we can solve the MMIO issue in a more
> > > elegant way, and eliminate the runtime string building in this patch (after looking
> > > more closely, that code needs to be jettisoned no matter what, there's simply no
> > > reason to specify the names at runtime since they're separate compilation units).
> > > 
> > > Rather than splatter #defines throughout header files, deal with the bulk of the
> > > pain in Makefile.kvm.  By feeding conditionals into Makefile.kvm, the s390+arm64
> > > build can easily omit coalesced_mmio.o and async_pf.o, define __KVM_HAVE_ARCH_MMIO
> > > programatically without having to change other architectures, and solve the naming
> > > stuff.
> > 
> > Yes, this is a great idea. Thank you. I second you, this looks more clean
> > and stable than the stuff we came up with :) 
> 
> Looking more at arch/s390/kvm/Kconfig and virt/kvm/Kconfig, we might need/want to
> to build out infrastructure to handle this sort of thing in a more generic fashion?
> 
> Which probably isn't that much infrastructure?  It's more just changing how arch
> code communicates with common KVM?  I.e. instead of providing boolean configs in
> virt/kvm/Kconfig, formalize communicating HAVE-type macros through the Makefile.
> That might even be a net positive in the long run, as it will make it easier to
> provide defaults for the common cases.
> 
> I say that because unless there's magic I'm unaware of these Kconfigs also needs
> to be configured per-KVM, not per-kernel:
> 
>   - KVM_MMU_LOCKLESS_AGING, otherwise aging on arm64 will unintentionally be done
>     outside of mmu_lock.
> 
>   - KVM_GENERIC_PRE_FAULT_MEMORY, so that arm64 doesn't need to provide a stub
>     for something it doesn't support
> 
>   - HAVE_KVM_MSI, because presumably it's needed for arm64 support.
> 
>   - HAVE_KVM_READONLY_MEM, same story as HAVE_KVM_MSI.

And in the opposite direction, HAVE_KVM_VCPU_RUN_PID_CHANGE also falls into this
category.  That one is probably better handled as a #define in header files?

> Which isn't _that_ many knobs, but add in KVM_MMIO, KVM_ASYNC_PF, and
> KVM_ASYNC_PF_SYNC, and it's enough that I think we should think about the big
> picture and not play whack-a-mole.
> 
> Actually, thinking about this more, what I've proposed here, plus the pattern of
> #define-ing macros in arch-specific kvm_host.h files, should suffice.  For things
> like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #define the macro in
> kvm_host.h since it's very directly tied to an arch callback.  Whereas with KVM_MIO
> and KVM_ASYNC_PF, because they enable compilation of C files, it makes sense to
> define them in Makefiles.
> 
> So I think the "gap" is purely that the four knobs listed above need handling
> (and arguably KVM_MMU_LOCKLESS_AGING is ok as-proposed).  But I do think we should
> try our best to be more thoughtful than we usually are when deciding how to enable
> common code, because obviously s390+arm64 is adding wrinkles no one has had to deal
> with before.
> 
