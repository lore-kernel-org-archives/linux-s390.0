Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25750AC1D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469116; cv=none; b=Erf/aK6A7xVLls7WRCgdK+RI48vXEVZT1sK80HH8Q57BB7l9DsqIdgOSF+2TiR4DGSvZqD3sYAapziOTBqMtsiJwmHK68cmSP0oPKMHAge1QVwJ2W73zfPWfTxx49c3w5RTbMLMRTBVDFORcffNHowqMtruxXx9U5JGb7Zjmkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469116; c=relaxed/simple;
	bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7fuLoSE4tuHmBDTEmbD0hzZzwgAvc+xVSsRJfU0CIqln735cYU4D1RLheY6LBCh+pIk034xpZVdPvNBmHPCyVqHzd8wLRbFjF5Gz+8lbpOg7tQQBzQkQmhe7vaZSj2YIGg3tHDpo4wmMeTvRWt7A98xB5uyKyrl/VAyTb4EDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he+U4lTE; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he+U4lTE"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso3539275ad.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788469098; x=1789073898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
        b=he+U4lTEFW1nfhPoTjVFtT5mzyjVaVDpSH1VJvB+UwX/8JSFkxwuRAjgiw6uew91Dj
         pYFrL580qkDPzEgnexsG++7rXXPa2VD+0fqcicIsX6x5HERKVyiSlS++LwxNypErQyqc
         uTn2aaas583NiVIAKiLSAjvSFaFe/5/NR5bMGQrawz+L7jbTI3BQPbpYC+Gtx570CMus
         xt12f6ugC5mFhgj7ebZz5gGtHdmqbNgjPg42jHsqvFOwECgv+rNDAOBlFWLg/k/tI4km
         OEwjmtXgbK/yr3kfv6vWWpo+RLzDSoAb/15S/w0R7vMfvi1mCXLccSqjlXAr74erlYLE
         w5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469098; x=1789073898;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
        b=Ud9gsgLQ/Kpzqsi3dn051Nu5VZiF3vzU/nuwlNmkFnd/bDjjhB6pc/gM+cPX2qSNvJ
         6crX4PbHqqYju0Jeml7gm7vXZXObOigAkiDbHpEA5tAWOH9+y6O+gYVXXDYr+HRCQS+9
         6up5ykO1qeM9lpMN489IXIy9Hyx4gcyETdifkjJ4FxZy5mh3oiaOh7fIsdYgjInJ95fj
         UdhPD4TLuSzIhOBtUkfNfxkoIWoc2rw3yKpw2W4bLECmjVaNr4fFezyp1mR9Z7n3Gx7Z
         XbJgksugIGj/70uw7lX7R2ZbOhRGf9lXJdEPzSWsE9PPj9vKZ9ffiqo9z25IWSx2CnOu
         gx0A==
X-Forwarded-Encrypted: i=1; AKwUvBwziRcBN+n1fjoKnn1In5NWd8ZK8VIr1wXBqKb3jKY2TCdv8JvpFs+3yjDZ0bNAFEmD3gPcAb+8FxTH@vger.kernel.org
X-Gm-Message-State: AFuF++kKmk981mP6uVWTlM3jv4ePkttnbV4Mkb1sALLfRy0moNKw8O+w
	YhKAGBwCX9W4FWAJbAZHs3KmuU/O6fPepDRSkLLA/IfaGH9yFgVHyCcEJer0hg572xJhrGXCxAO
	T2rdNMQ==
X-Received: from plxj7.prod.google.com ([2002:a17:902:da87:b0:2d9:1c43:7134])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120d:b0:2d8:d4cc:be65
 with SMTP id d9443c01a7336-2db12873c1fmr17910145ad.18.1788469097697; Thu, 03
 Sep 2026 13:58:17 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:58:17 -0700
In-Reply-To: <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com> <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com> <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
 <apmYPMMPCNzK9ZEA@google.com> <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Message-ID: <apnfaeWZoZTIsoZS@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
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
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> On Thu, Sep 3, 2026 at 5:54=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > I don't want KVM to be the. one that does things differently *once mo=
re*.
> >
> > Too late :-D
> >
> > arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y :=3D -D__KVM_NVHE_HYPERVISOR=
__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
> > arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y :=3D -D__KVM_VHE_HYPERVISOR__
>=20
> Sure, VHE/nVHE is fair game because the nVHE case is in the same boat
> as vDSO, arch/*/boot, and so on.
>=20
> Looking at a grep for (cflags|CFLAGS).*\-D most are -DDEBUG,
> -DDISABLE_BRANCH_PROFILING, -DDEFAULT_SYMBOL_NAMESPACE, etc. and in
> most cases they seem like a bad idea. Don't do it for KVM please;
> requiring -D for all architectures and for random pieces of config,
> when you can put it in asm/kvm_host.h, is just as bad if not worse.

Boo, it's never fun when a parent shows up and takes away your toys :-D
