Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB954F7CA6
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415791; cv=pass; b=U8BZTbzFeiPOxC4tGenrxoUNUfj868U2Kn8f7fqYUJFtCKboakhscUa1lvKwbp49CNwtFXvkYj+tABHzOyfIF7HhlnXFCTy66AsnCcowJp35FG9sG0S4rjSFb5FQc2EJ7FqO7AWKI3PUdW6m0/Q0HfX4eQRYxP3sEcci4ipZGPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415791; c=relaxed/simple;
	bh=U4Na9/OiaM5rlZK71twM/zPx8zOQve5CjrR7UMSuXK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5n/KMbEnQJ7ZEyGDCI/7JRjsSRuVUbj7da5RFwpn3qvfCUIjC7GEnhAAvcE66u525P1sUSfV7s0uLUPh5y8LNrJnCXM+5WeA1cUElCMwG2wlDUwDNfCqcKphR+vaynKyDUE8AVEcdlH+LvBICdhmQey6t0nAkeSa/hHlGN33BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iefEvASj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RELat6S0; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iefEvASj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RELat6S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
	b=iefEvASjRlgURviJxk8YEY9p5DnfhcL1fIe70o1QCUtoTJhZyr+gfP/PYdkJjErIDYmDQX
	X1sySjEw7mbu560TrHmxUWfzwWvGBDCKHaJLbldHBHZmKhT7SyRwLdYt0hmtTQQelkU+Db
	WcQ4nGcW9MWjbiMJ/cMD/C90J3K3azY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Fj7B99_qPXSluU9sI8Pbnw-1; Mon, 19 Oct 2026 13:16:27 +0000
X-MC-Unique: Fj7B99_qPXSluU9sI8Pbnw-1
X-Mimecast-MFC-AGG-ID: Fj7B99_qPXSluU9sI8Pbnw_1792415787
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48afcecb035so686434f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 06:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415787; cv=none;
        d=google.com; s=arc-20260327;
        b=hzL02wHihutz3k36le/opjktJiDeoXTJpCFOx2CBD0Ag0/9iRGHhTewaRT4x7UoJ8C
         BXqUauSame3fncsLbGCasgs0aFnrTl4He4cEEj9Z/kgkVXLt1EygaOcuFtnfSgvrrOyc
         hnWTqtnmv6QIKqg2zd2nIlZGXPGIfkzt2Yj1l25ixtu66JO7BvzJtLqXX9I4EUwDKaGK
         /HiUeQsXL+hQRg+OYhvSDt2vGQ3cI0+k0HsSezZFh6HTPshfuh1T4BytD92EGVfudYsV
         kbdkDEF7OIJCn+bGmrBzDT4YIyzA9qFordBKFQPEzLPd8Q79mwxpjln36yVD7AmLXF33
         4AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        fh=34S0WTozL/bWtkg9XlRDyAOCW9pspVuaunGh5Yfz2AU=;
        b=aNQNz6uaIjfTJevuiRXw3HSNSJq+a81BjbMgl70C+INvevN9ufivlAOgEhiKKSFxBM
         VVTpW29JACW4B0+/YhjTS2zmALTgkjxNo7sUxy/0xrvfMix+qLxGf4epxGQaEkGkpQYs
         KCesGVEXwttmcD5h0vlmRYGtSSD+hDhcXVXNkjHL9b2mPoV+SwCsnNq/q+RgSDaZ0bkv
         AXZc7hBx2TzTF5VqourlH+iPHmGn6dEeDl+0e8fGbbvqtB4SDnZRJSnSgKE7WenE5BJW
         VFTi6TMswUdiUHnUm43Ke3Hzd8/IyrAtJ9xI9IbnDrjXYQN5e7g0CA9P0LwQaGiB6WIt
         76eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792415787; x=1793020587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        b=RELat6S0kucO+mfC52Cc3dr+xvlf+H2sNczMqCflYUXzoWzJN4GWT/xr8n3ubobzdg
         kiAhyVxYdaqDz2wZnE4GGCz4mYh5R+GgcXsq50JESSLJ0ySb52BjIBqtUOSi0z8bGcyz
         2nzJjHeEZwU3W4ka1yoQReagRcGuEsfCN9xBRvo8W090nHHyqObeetgG7Vz49lH6xafl
         3Wvxj8mbhfAwvpTaJm5voDstmZ44WM5YvglGIWM1anwPl3B36hwaigZDhKX778Xjcd0A
         td15ReDhjZU6x/I+2pH+cawuVYxj8q1yPyXw4IbrJ22SdiTsqrxxQ491MjEWrluyeJoP
         4ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415787; x=1793020587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        b=eRzYucDHAdZdDLxFf4BMxiGNXEfPtAMM+f7irPOdJA+1apOxiteVxUymiew5qGhytb
         61oSU5LGpEw4a9jGnxmJw5oKgjT6UerfDIndAhWKoL7+upyBcZWFPibEbo8GV9VZPDgl
         biq+p6FGvQrOyBX5Bk77MC1Zy/FcGM/zEOealgqRC7AkMSZL3tAPzEhQLTNvF/cgIGVt
         UYofTWm/xuZvx89k90okTJoNFRsJlygFAkQWHKZjWULfe4yeJvLskTBeZ7VOP+phMZJ5
         oZNa+fcQCIkndka0AV7zLkoaYhLG2yS54HwWxYoC84Gr3/rlnWrQOEjLOIomsA192MOH
         lqug==
X-Forwarded-Encrypted: i=1; AKwUvBy2X9sFOj7v+Wvz06mqizKBx+iPfLMKfSOgLTkWKJubOaZRfa11Oqdl/faW9/lrCdOlOlI9KjXgiN0t@vger.kernel.org
X-Gm-Message-State: AFq9FYLidukk4JpsD12dVhqF/Ma77qoiCaPUkX9MubJWUQ2WsZ2PU86V
	dgphauGPsybehAqridY0HfZeSsEdiU+h1/8nOWDlnCQ4S8AXdctx6yN9cw3MzkOhWIXIpMiSP0b
	mXYd9vUHaw/jCfTGMhZrJANRtosJpQFKCMQvGX8tmvDWIiOTJVQ3NzsZWOSQPIUfPnPt/G03tqL
	l1Ykx5UG4X6kOADxsfwqEMlqZOjjb3f2SGn+MANg==
X-Gm-Gg: AYBFou0igYum2ICeoheC5PF7a2hglYeQFHkgrCHHy/vaZ5Cl68eR+yztNPSqBRFiAHK
	kZIcsrBNPWLw7eahqzK4ZiPtbaNpqZuenpCU62xONLzNprd6mEInxnclWS1MvV7ZuIE+OO63VmK
	EQ9fkGcQ8elNHb1sjwVRzVzueUysGoL4z/xQ9OVxRz8fbniU1Ky1BfZGyK/rXmhAkg5AfpVnEVS
	MVWFgsrxdf0HQ5XxtSHaBHvEXCkdsGQjXHpeL1qPFGm2jhzCQ9ahc3Kx2IZRQ==
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr26103717f8f.31.1792415786507;
        Mon, 19 Oct 2026 06:16:26 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id
 ffacd0b85a97d-48dfaea3908mr26103660f8f.31.1792415786039; Mon, 19 Oct 2026
 06:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015171140.262334-1-borntraeger@de.ibm.com>
In-Reply-To: <20261015171140.262334-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 19 Oct 2026 15:16:14 +0200
X-Gm-Features: AclHuK_4Ll6JOpljIfXvvXJWmctQUuadLrN7i7MvIFCuMBzlZiVOI0tMzhaLmho
Message-ID: <CABgObfbdTsAMHC0hqdV6kC4V6kgfVQ4eSyJV3xCeLuPdEVcm=g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: s390: Changes for 7.4 including arm on s390
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gabriella Seifert <gseifert@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Christoph Schlameuss <schlameuss@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:12=E2=80=AFPM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> Paolo,
>
> The following changes since commit 439d8f9cb01cb04f9b31910efd0ae8dbdfa4ad=
97:
>
>   Merge tag 'kvmarm-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git=
/kvmarm/kvmarm into HEAD (2026-10-14 18:26:28 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.4-2
>
> for you to fetch changes up to e93fb70b748982fda5e6d97721df35194cacfc4a:
>
>   arm64: Use proper include variant (2026-10-15 13:38:43 +0200)
>
> The last one line patch is in fact a cherry-pick of b64f41a7ace1
> ("arm64: Use proper include variant") from the arm tree, but necessary
> to build.
>
> With that we have the initial arm on s390 support.

Pulled (to kvm/queue for now, will be in kvm/next as soon as my x86
tests finish).

Paolo

> ----------------------------------------------------------------
> KVM: s390: Changes for 7.4
>
> - rework page allocation for secure guest variable storage
> - selftests
> - documentation
> - replace get_zeroed_page with kzalloc
> - fix floating interrupt inject for corner cases
> - initial arm64 on s390 support
>
> This also contains the patch
> "arm64: Use proper include variant"
> as a build fix. It is also part of the arm tree.
>
> ----------------------------------------------------------------
> Eric Farman (1):
>       Documentation: Add missing KVM s390 crypto attributes
>
> Gabriella Seifert (1):
>       KVM: s390: selftests: Add IRQ injection selftests
>
> Heiko Carstens (1):
>       s390/uv: Rework page allocation for guest variable storage area
>
> Hendrik Brueckner (1):
>       s390/hwcaps: Report SAE support as hwcap
>
> Janosch Frank (2):
>       KVM: s390: Improve floating IRQ injection behavior
>       KVM: s390: Kick PV cpus at the right time for service irqs
>
> Mike Rapoport (Microsoft) (4):
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 a=
nd CMMA
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI bu=
ffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI b=
uffer
>
> Steffen Eiden (14):
>       s390/Kconfig: remove PCI dependency from HAS_IOMEM
>       KVM: s390: Use dedicated function for migration mode
>       s390/tools: Use arm64 headers
>       KVM: s390: Use arm64 code
>       s390: Introduce Start Arm Execution instruction
>       KVM: s390: arm64: Introduce host definitions
>       KVM: s390: Add basic arm64 kvm module
>       KVM: s390: arm64: Implement required functions
>       KVM: s390: arm64: Implement vm/vcpu create destroy
>       KVM: s390: arm64: Implement vCPU IOCTLs
>       KVM: s390: arm64: Implement basic page fault handler
>       KVM: s390: arm64: Integrate arm on s390
>       MAINTAINERS: Add entry for ARM on s390 KVM
>       arm64: Use proper include variant
>
>  Documentation/virt/kvm/devices/vm.rst            |  18 +
>  MAINTAINERS                                      |  17 +
>  arch/arm64/include/asm/sysreg.h                  |   2 +-
>  arch/s390/Kconfig                                |   5 +-
>  arch/s390/include/arm64/kvm_emulate.h            | 130 ++++
>  arch/s390/include/arm64/kvm_nested.h             |  11 +
>  arch/s390/include/arm64/ptrace.h                 |  11 +
>  arch/s390/include/arm64/sysreg.h                 |  13 +
>  arch/s390/include/asm/asm-prototypes.h           |   1 +
>  arch/s390/include/asm/elf.h                      |   2 +
>  arch/s390/include/asm/io.h                       |  12 +-
>  arch/s390/include/asm/kvm.h                      |   6 +
>  arch/s390/include/asm/kvm_host.h                 |   4 +
>  arch/s390/include/asm/kvm_host_arm64.h           | 209 +++++++
>  arch/s390/include/asm/kvm_host_arm64_types.h     | 124 ++++
>  arch/s390/include/asm/kvm_host_types.h           |   4 +
>  arch/s390/include/asm/sae.h                      |  49 ++
>  arch/s390/include/asm/sclp.h                     |   5 +-
>  arch/s390/include/asm/stacktrace.h               |   5 +
>  arch/s390/include/uapi/Kbuild                    |   6 +
>  arch/s390/kernel/asm-offsets.c                   |   1 +
>  arch/s390/kernel/entry.S                         |  22 +
>  arch/s390/kernel/processor.c                     |   3 +
>  arch/s390/kernel/uv.c                            |  41 +-
>  arch/s390/kvm/Kconfig                            |  21 +-
>  arch/s390/kvm/Makefile                           |   1 +
>  arch/s390/kvm/arm64/.gitignore                   |   2 +
>  arch/s390/kvm/arm64/Makefile                     | 110 ++++
>  arch/s390/kvm/arm64/Makefile.gen                 |  28 +
>  arch/s390/kvm/arm64/arm.c                        | 754 +++++++++++++++++=
++++++
>  arch/s390/kvm/arm64/arm.h                        |  58 ++
>  arch/s390/kvm/arm64/copy-arm64c.awk              |  82 +++
>  arch/s390/kvm/arm64/guest.c                      | 135 ++++
>  arch/s390/kvm/arm64/handle_exit.c                | 161 +++++
>  arch/s390/kvm/arm64/handle_exit.h                |   9 +
>  arch/s390/kvm/arm64/inject_fault.c               |  21 +
>  arch/s390/kvm/arm64/mmio.c                       |  15 +
>  arch/s390/kvm/arm64/mmu.c                        | 210 +++++++
>  arch/s390/kvm/arm64/reset.c                      |  71 +++
>  arch/s390/kvm/arm64/trace.h                      | 101 +++
>  arch/s390/kvm/gmap/faultin.c                     |   5 +
>  arch/s390/kvm/gmap/gmap.c                        |   4 +
>  arch/s390/kvm/gmap/kvm_mmu.c                     |   6 +-
>  arch/s390/kvm/gmap/trace_gmap.h                  |  13 +
>  arch/s390/kvm/s390/intercept.c                   |  32 +-
>  arch/s390/kvm/s390/interrupt.c                   | 130 +++-
>  arch/s390/kvm/s390/priv.c                        |  19 +-
>  arch/s390/kvm/s390/s390.c                        |  12 +-
>  arch/s390/kvm/s390/s390.h                        |   1 +
>  arch/s390/tools/Makefile                         |   6 +-
>  arch/s390/tools/Makefile.arm64h                  |  55 ++
>  arch/s390/tools/copy-arm64h-full.awk             |  50 ++
>  arch/s390/tools/copy-arm64h.awk                  |  83 +++
>  arch/s390/tools/opcodes.txt                      |   3 +
>  drivers/s390/char/sclp_early.c                   |   1 +
>  tools/testing/selftests/kvm/Makefile.kvm         |   1 +
>  tools/testing/selftests/kvm/s390/irq_injection.c |  74 +++
>  57 files changed, 2883 insertions(+), 92 deletions(-)
>  create mode 100644 arch/s390/include/arm64/kvm_emulate.h
>  create mode 100644 arch/s390/include/arm64/kvm_nested.h
>  create mode 100644 arch/s390/include/arm64/ptrace.h
>  create mode 100644 arch/s390/include/arm64/sysreg.h
>  create mode 100644 arch/s390/include/asm/kvm.h
>  create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
>  create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
>  create mode 100644 arch/s390/include/asm/sae.h
>  create mode 100644 arch/s390/include/uapi/Kbuild
>  create mode 100644 arch/s390/kvm/arm64/.gitignore
>  create mode 100644 arch/s390/kvm/arm64/Makefile
>  create mode 100644 arch/s390/kvm/arm64/Makefile.gen
>  create mode 100644 arch/s390/kvm/arm64/arm.c
>  create mode 100644 arch/s390/kvm/arm64/arm.h
>  create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
>  create mode 100644 arch/s390/kvm/arm64/guest.c
>  create mode 100644 arch/s390/kvm/arm64/handle_exit.c
>  create mode 100644 arch/s390/kvm/arm64/handle_exit.h
>  create mode 100644 arch/s390/kvm/arm64/inject_fault.c
>  create mode 100644 arch/s390/kvm/arm64/mmio.c
>  create mode 100644 arch/s390/kvm/arm64/mmu.c
>  create mode 100644 arch/s390/kvm/arm64/reset.c
>  create mode 100644 arch/s390/kvm/arm64/trace.h
>  create mode 100644 arch/s390/tools/Makefile.arm64h
>  create mode 100644 arch/s390/tools/copy-arm64h-full.awk
>  create mode 100644 arch/s390/tools/copy-arm64h.awk
>  create mode 100644 tools/testing/selftests/kvm/s390/irq_injection.c
>

