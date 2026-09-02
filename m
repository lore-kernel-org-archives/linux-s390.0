Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BD4A92EF
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364245; cv=none; b=sUMU2IeWf5jWcGL03AY6rLBV3AZgbgvVMGmOTToBH36ezq5AOBrk4/IalGgjfJgjKfMw9lSuhHqsT06zM1BLFK7PVBWjiW1bXi2QEBBkAPqlO2JW9J01BjVIQ/fR57U/joayerHsRXv2nkXgoVkG8rhvLDeoZjVblzsXr3KUfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364245; c=relaxed/simple;
	bh=x/aSspVi1izw2ohQt29OQIs4Z647EroW5SPSwlyZz80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhKtlUSyhKBEgenvuT/y6X/c+ZRjaJdnvNqOdAROxW9vtBXBNXzpRstfzNcAtwWmP8biRfWU2SLH5MIKkxA7uUsyBBxHbx7S0fkirO9Uv6wAoNWlAyVsHunNfzbm20mUIIvJjEzBIhSJtC+0YjmM83MNHLW4pzpI9zsCiRcc418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyZC6T/L; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyZC6T/L"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso3042650b3a.1
        for <linux-s390@vger.kernel.org>; Wed, 02 Sep 2026 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788364242; x=1788969042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2atBUez5/3AnWCQ3IY6Ohn5PAS7hQON2CkUYdFYqUoU=;
        b=PyZC6T/LQtiadLBf3zv8wSlRiingp+XWfEoQTB5Ct0FiAEYY21mNcg2a9nb1QrVVww
         dXYQg2SKiKYFEoBeVxLVhlaHBgNiYdEcLe4RK5mZFQNW0te78CvsndhPQ/eOAktA9lrZ
         vfzDe+rhHDt50oUagkKTXegnv4+Z8AN4IyV6x+t365miWB3Gv+U94Y/4Mp/EdsQIemiS
         j2A/n2cTlTBcesT1+r2CGy43t9pyE5R+Gc0UFygeGiXRg6FX1I743wjRPI1ImVf05E+9
         e3K2g/9Yl79P0GxEauN41BVa2BQ2xy9SB8cVq7X/g9rrGzDFKRgJMpUzLvrQZNDgp7TY
         14Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364242; x=1788969042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2atBUez5/3AnWCQ3IY6Ohn5PAS7hQON2CkUYdFYqUoU=;
        b=UH6zSJVo1ykxbSU5ihuxmD2A/zWOCbZ94WaXy4fdL1fJH6zh8969nFhlUDf1FSP5GA
         ysQGqz0vbzvmIqSvxyPHPlnRMZxgab38FQ3rQvRtDEslF7D9eLj+rcN/nnNR7foUTKQr
         on8BEU1OVtFVQScyo9QSg5/PuAYa+kDMJmaXco2z4zArcvwekhSuN4lkYGv6tsLoF1SN
         qzbH3U8JgFcB6ueDhl8145b6/MrFdY0P0dgCkoR6Aj1RpwNgRneFFNbZl4Blf7eLFo4X
         CD6yPgpk1pa+Wh+t9BuEuQvRyi8JZqb0eXtkOkmbUmdW208jGa2BmggEmlzgtMInakFr
         yQYQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6iXNreHmy+0pR/VoMyPFZ1vpuEpHcSOb6t7dmK/uKYNWfi/uYR2QPfCjA5iYwGyIvvTCDLisAw/3m@vger.kernel.org
X-Gm-Message-State: AFuF++mK3S24V7NNrwYjHRg6iNNRHBpxUwnXWGQvIx7aNgLzAyxUe9yq
	4xjXJcMGdtsjvDzRckNVVIA/9y7Ai3tjKyXwwE8gXKpsBjGwcuknX/CFZSsIJvZtv0UQYxKmUHZ
	8LOcMxg==
X-Received: from pgp19-n2.prod.google.com ([2002:a05:6a02:62d3:20b0:cc4:337d:af34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1449:b0:3d3:aed2:6f29
 with SMTP id adf61e73a8af0-3da2168db67mr89360637.29.1788364242090; Wed, 02
 Sep 2026 08:50:42 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:50:41 -0700
In-Reply-To: <apgeAJKF--dZvKvF@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-4-seiden@linux.ibm.com>
 <apdwHcdy2iYRTrww@google.com> <87ik4om4x2.wl-maz@kernel.org>
 <20260902091351.438647-B-seiden@linux.ibm.com> <apgeAJKF--dZvKvF@google.com>
Message-ID: <aphF0ewDGuZxsrJz@google.com>
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Sean Christopherson wrote:
> On Wed, Sep 02, 2026, Steffen Eiden wrote:
> > On Wed, Sep 02, 2026 at 09:30:17AM +0100, Marc Zyngier wrote:
> > > On Wed, 02 Sep 2026 01:38:53 +0100,
> > > Sean Christopherson <seanjc@google.com> wrote:
> > > > 
> > > > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > > > Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> > > > > where one KVM implements MMIO but others do not. Solve this by
> > > > > additionally testing for the non-existence of KVM_NO_MMIO before
> > > > > including MMIO code to KVM.
> > > > 
> > > > Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
> > > > KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
> > > > strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
> > > > a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
> > > > to be annoying to maintain, and will definitely be confusing for non-s390 people.
> > > > 
> > > > It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
> > > > support, but I'm guessing that won't be at all common for s390 builds.
> > > > 
> > > 
> > > I ended-up doing something very similar locally, because I couldn't
> > > really make head or tail of the logic while being in holiday mode
> > > (which doesn't help). However, I kept the negative logic, so that we
> > > don't need to add anything to any architecture but S390 (they are the
> > > odd one out here).
> > negative makes sense. 
> 
> Ya, an opt-out for s390 works for me.

Actually, I have a better idea.  I'll explain more in the subthread about tracepoints.
