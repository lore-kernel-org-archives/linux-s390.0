Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4144A3F20
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453218; cv=none; b=stkAfTdTN4WKd+XceFZ1scVvpW78WwpURIowUPruvTpt1iIw8wXBJTu9TeKl90u06pNyvK39Bu3Q5urehRoLqJxEn9ltG9d9hwvcczkm8p8coD6TyiFT6dbyU42hMGcTpMBTvyHL2rq98zCalOTDgS5mJJBg/gJ0MhxjevkXNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453218; c=relaxed/simple;
	bh=J9DTYWyQiUh6lX22wglRoT5QWIUixAxZgYaHJuhSa4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EFPQWuqXfwx5LpYHmdE9Ebbl5JgePaWV2AJv+8lcus+l0iDTcsQyevR+o+FRpcU4mYjobSNuVdLyN5su6o/uMPCIxflh3iNc7xbFsNXltXwRO3+fMXYrsI+R+MDwr/Wu2rrdO9znI+x8hFED65pQfhP8vd3gWW5VTluYixtqJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfkDCCKV; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfkDCCKV"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7151120d6so19085ad.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788453216; x=1789058016; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yud1zWjg0T0unucnpCnDX+16TCQDlpqp9KH31E+tKFs=;
        b=tfkDCCKVclbpyW+qt0I0wNtovxpVolfyEf2Dpx+iMpUDnK5ur8CbzWEtxvv24omyLG
         N/icn/ilGhiOwHUsbgSZnlpiCc3cMDQNy+r2KJoDyE2uTx1HiK8Y0A4fum2AC/SlaELy
         qkhO87ECAfzx4IwYNdZTJDq7ZPgQRxVTAC5ukJ57AKkYZoXThWwAxX7hjePlq79PFseC
         VQ/hkaXHMFe4U2kSFoRPD20VAG3/a4QVeZfiTcMRICE60OvuXdpg6qrCoUORGy61xnhq
         lSy1GpmRS+Vi776JdCLpa6J798nh0+3uxC4coaZmsgUpsrF/BeW9BL5kcmmVQDmFSjtD
         Lf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453216; x=1789058016;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yud1zWjg0T0unucnpCnDX+16TCQDlpqp9KH31E+tKFs=;
        b=A4Lr60bJOJhhVSDwvdUdE/pHO8vi5zBEYSxyRE5vB6HPTQFM2GBFC7FFzEqcqsNDHC
         FEd7BaP5i67CmqKL6gT2rD+wrayZpBnEpWiIYMrTEbzqhk0Y5SLMmRZeMib6PcjfAI2h
         E6GmbbrwNEcPzeXBx42Yq7xM3VohoxfpRrejYDXpSSkzwwSh5UCHA1XVvqZOyts9D173
         yZLS7+ExPIFDwhtfLARNNiXdT7cpA5IeE92gZ3H7M5E7GIpHTv2mR6POIushrgXsx/v0
         x6DoMds+6xycvxx0Wch2NMmEoBdVUWGjY8mBTsyehsT4GRcPz1QCGO64qn1InC8V7BqM
         7Btg==
X-Forwarded-Encrypted: i=1; AKwUvByfOPEN7uBDqW60+TbAX/BZbD+33WH2VOPSmR+1wvL++OSgT1TGBtJJ7aqyjERIdJ8emAZPJGQXd7cE@vger.kernel.org
X-Gm-Message-State: AFuF++kOcybSy/PgsrLk99n5PxZQShwsZBCaeb26/LnBYgyo2dRNsuab
	qJt7sOtJaGm8dq3VeV94n+C80DA7sVve4PgBL6hsUkWJ8YsJNXwpsnzkRfYwxKWiHQmLGtqX5Av
	86D1ceA==
X-Received: from plcl4.prod.google.com ([2002:a17:902:e2c4:b0:2ca:ceab:34a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:9cf:b0:2d8:d4d1:313a
 with SMTP id d9443c01a7336-2db12634535mr3213635ad.17.1788453215940; Thu, 03
 Sep 2026 09:33:35 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:33:35 -0700
In-Reply-To: <20260903154317.246414-A-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com> <20260903083857.33034-B-seiden@linux.ibm.com>
 <apmHrnxRLl9BuVhn@google.com> <20260903154317.246414-A-seiden@linux.ibm.com>
Message-ID: <apmhX8H-WUc3U4_N@google.com>
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
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

On Thu, Sep 03, 2026, Steffen Eiden wrote:
> On Thu, Sep 03, 2026 at 07:43:58AM -0700, Sean Christopherson wrote:
> > And FWIW, while it might seem daunting, from my perspective it's not actually that
> > much churn to do things "right".  Provide KVM_S390_NATIVE, and then have KVM reflect
> > the "weakest" of S390_NATIVE vs. S390_ARCH.  I.e. make KVM=m if either of the "real"
> > KVMs will be a module.  That requires some creative shenanigans, but it's not hard,
> > just weird.
> 
> FYI the first versions of this series had a 3 configs approach very
> similar to yours. 
> 
> IIRC it was not so much the churn we have in (upstream) kernel code but
> more on the distro side and to everyone building the kernel in their
> favourite architecture (s390 :))

How many people are running distro kernels on s390 hardware?  And how many distros
actually change the default KVM settings, e.g. to build KVM as a module instead of
baking it into the kernel?  My guess is "not many" and "almost none", i.e. the
actual impact on downstream users is likely miniscule.

> Suddenly the KVM config changed its behaviour (effectively becoming a noop)

Not really, because "KVM" itself is inaccessible (well, unless someone is hand-
editing .configs or generating them by script, but that's their own fault).
E.g. upgrading to a new kernel will explicitly prompt the user to choose for both
KVM_S390_NATIVE and KVM_S390_ARM64 (or whatever they get called).

> I am starting to think that having no separate config option for arm on
> s390 might be the easisest way. Just KVM and guard both modules behind
> it. It reduces the config space bloat and I do not see a reason why somoeone
> should only compile one KVM module but not the other. kvm-arm64 won't
> load if you do not have the hardware anyways.

Because there may be an unforseen need down the road?  Smushing things together
after the fact is generally easy, pulling things apart without breaking everything
is usually much, much harder.

> But I am not opposed to the x86 approach. Just thinking loud.
> 
> Anyways, I am off for vacation expect a reduced reply frequency from my
> side :) 

Enjoy your holiday!
