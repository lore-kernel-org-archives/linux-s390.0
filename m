Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072921ADA7
	for <linux-s390@vger.kernel.org>; Wed, 11 Feb 2026 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832582; cv=pass; b=rF1iq9iuUkvh6Ede+aGFoYo+NM3jfQ0wAYdfwH/Sa4PqhI6zQ2ocAVeEjDK9tXJjXK0cMwZyEXnmxGZcG6dfN99IoQTYPcOgdfdjmQc85fiN7b1t/YD+976KpGrP6Tb4mmjAsOlpSUyYsgXBpE5+F2Vz9LqyGMimu9RsYUbBmOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832582; c=relaxed/simple;
	bh=tdnSHppX8fKny9j+IheuQlJfOXx1xSVuDy+wyCpiR0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W53sSnL3BJg6kXTt4FXkZfNroM1EYeX8PPn/z8OMLbMjh7/4X2H3kgTTymTUxTwHyXBeSvFA3K+kA0QO0r5TQeIVWvM8mtY8DYK+abOJDll2EZbRXpQ1EcDtd81x0QLiW1/mBfh05Ij6u9OGo6Kc6S5OCSX9BWRgeyRQRpVXih0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZESx+EJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bm19n/Bc; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZESx+EJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bm19n/Bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770832579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBepvMDI86eMqlHW2ZOYJH4TD+aKg4qs5KHoUc8nhYA=;
	b=WZESx+EJqtYoz7oOsajNYWiNfB02fIcTZVyK27WVTeiIQd04v5/WnMm1bhAGIUUmeLAf7k
	Tb19UjvMdGoE7Mg9jLZktYLS1ISVZX4Gz6swQ41sMgYTUXnMdrvFATa/Aq1cr4DcNxPsym
	XUJMkSIrteks6+g7s+WKfuoZPxEl9kc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-0rp4fuV5NlWJxAlY5V33cQ-1; Wed, 11 Feb 2026 12:56:18 -0500
X-MC-Unique: 0rp4fuV5NlWJxAlY5V33cQ-1
X-Mimecast-MFC-AGG-ID: 0rp4fuV5NlWJxAlY5V33cQ_1770832577
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43624564fc9so4524821f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 11 Feb 2026 09:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770832577; cv=none;
        d=google.com; s=arc-20240605;
        b=bXpL0e+6iQ6+FmMFpcELVpZWSo4/z2uzfelcaEG4Hy8oPuuQxKDH7RAyce0apVSjD6
         wn9IgSKdrmPNcrRlI6kB/mx31K6fB/ny8x6txN1Hiq1aneTeMLiOMt84sOIHqwWQHdp6
         QbFa/2QuOp03k5CvL8EeDvwsNNpm0/pb/luzEicoVveWTmFr9pHmsQXceiAv1GrBcBSf
         Wn+jY2Kt5iwRoum/VNuFIq4YvzyIvED4L2HdFPvzPPUE/AL7OBX1+A8Kt6L+9uyJdJYB
         ULdyvJ3iUWS/l/JP6oZdCluFy236uiwK+mCfdrHj4vY7VZXpFROxqPZucrqFEuewi+s+
         oIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SBepvMDI86eMqlHW2ZOYJH4TD+aKg4qs5KHoUc8nhYA=;
        fh=u6+w/WbWA5YP0s8s6yWS8LcVWVr2fc8CDk5yacuvu7g=;
        b=RwuSgHdwaOBnoX54UB6nCjVTlLWwLovvC8zvwwrC74CETcKpYjuDSCKvosPuRsPQua
         IabKmG4MDUnBoGhb47DF7wXxQweHUDVbWzvRYRDRAKyvqeUFs14OUyKaDxNLIT1RlMoV
         vKryS/V+HXDx4TWcx31uz6awJ6TKQRLxSHz+aUzsudVJyaDAzG5k0sAjYqHEfTmJ3RVh
         BSdh4zdqJXit9O2OpSGpIHlROf7WHPuBb7haZ3QjHsdnu+DrU+tTgfTjzKO6gS5r8928
         z93zyMHAhZ95gSMgMexibbSQ4epc7iafgAhLv/pIB2kLKsiGujLdnfOLIlbAM51IVnMf
         8YHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770832577; x=1771437377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBepvMDI86eMqlHW2ZOYJH4TD+aKg4qs5KHoUc8nhYA=;
        b=bm19n/BcG4aPBE3KRKl08ZeFWjdU8jQuaMRHSuq6bB7nb0sUQiFo4m3/JH6tTcwQM0
         fcz8sjzMYm+8pbGkS2OFHRLMgnhg4AVFIB+LmdmILsod2A0UbiupR0g0h+Ayn1CB5mvn
         i8uz5Ga8kN22x2QT8S2ODGbuizLuhvy1im85pPxMmSuuzlsoF2PukmElY3cQKLH63V9t
         TLbuRVoZG74AMF5kXGzhIgOoav+pyVfgurc3FGJcXwKqEJRecHARfmERvkrRHhpxUrZf
         3MXUydBidHuJITamyaY2PkM6foMIvwmaeFDcOGxhY2mdx0Yg6GJlLRJaTEo8gLr9bEq7
         6idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832577; x=1771437377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBepvMDI86eMqlHW2ZOYJH4TD+aKg4qs5KHoUc8nhYA=;
        b=aviA9iTw7JR2k+bJ8Am8Hf+yz6YzSB6DbxGjstgJtAI7O9Vb9QbBgBb+Lj1wgNgqlM
         1DxERprfR9/tGUefY3breGxv/ikWACyb4a3qxn0CLqMrrP18NZDlWRNNDYZ+OpvWbabm
         aIt2eDxjBvrWCijgfpfnoDWl8JvvZTT1bbTC2HHkbz6SecNXsezmVVnz6RlxXYvT+LuL
         GSD6G5AOPUBxhjW70HBAAsp6zMGMRJjkfJLh0LjWeQZMvW+rVh2qUZ893Ky43rDXMHKJ
         JmpKnWXHvt+ASEfTVSpRn/LkDCUm/qJ2da07x3LVp0k9wEKswDNF6HV5Zv2S2rVZvoSG
         oglQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXFtaWOpgj4Wy3p3BCuer6F2jduVFTMToZm3Pwwc59836KzEnzSCjaZMDiraVZJ2iE1ZFKglc6Quft@vger.kernel.org
X-Gm-Message-State: AOJu0YwpR1Ij9RGmD9L/uvnHrSGUDU+DeuwBZDErIxCtI5lUlpUksyov
	8V90WwQSXm/0OUAhxD1XNzDUTxKtxAxJfe821bZppXU+ctVMUkLqlvit2W+ifNRhPBwlnhEVkye
	OYqUud3bhq+FwJpYNAGSFUsIxbsFIJnPpxmdu7sr8cdKzuaK3M9HD6pu/+C4k0b2ROE7Ylil+ey
	4klGd65XeBYl3ceJZ3ne/RTHhhK2YvhBGWyrFdHA==
X-Gm-Gg: AZuq6aJVdk5bc/HhNu4PmsDiTAJYFji6yC8tV7ho5/ILBHfAlUsSVoKanejRm6tppMa
	M791RzACoOf9PbzN4w+hzXMUI29JssncbYxZMd/YDqaVG9RLdYVW+juP8+kRjRy5oFLz8cyBEaG
	UjfKVCTRH5Gth4PyS2KRLksC+lltitL2ztD+dMO1NmM/lhC+vfWUFw7+4kEZdxghPd4XB/1VdlP
	Q/Eua1SUu71MMN7MHAs1Y6lUgJ1xOF8N+8ymu2Lh0O01p0AsYsGtCCa9BUSMRtZDfMCbWGbAhwt
	MQi6Eg==
X-Received: by 2002:a5d:5f84:0:b0:436:1707:2884 with SMTP id ffacd0b85a97d-4378acb1963mr495515f8f.56.1770832576932;
        Wed, 11 Feb 2026 09:56:16 -0800 (PST)
X-Received: by 2002:a5d:5f84:0:b0:436:1707:2884 with SMTP id
 ffacd0b85a97d-4378acb1963mr495478f8f.56.1770832576472; Wed, 11 Feb 2026
 09:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210153417.77403-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260210153417.77403-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Feb 2026 18:56:04 +0100
X-Gm-Features: AZwV_QjgpeaKV1waGQm6gTDtTrSf0wgO6f0d0IIYD1zOBnHUXjifKG5D1BMpCHs
Message-ID: <CABgObfZquLMMZ6vHc2JcrjrQuY03pbj5vNc8v+PNW8_t5Dpo5w@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/36] KVM/s390: Three small patches, and a huge series
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com, david@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 4:34=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> Today's pull request is rather large, as it (finally!) contains the gmap
> rewrite.

Yay! Next, KVM_GENERIC_DIRTYLOG_READ_PROTECT? :)

Thanks,

Paolo

> It also contains 3 small items:
> * vSIE performance improvement
> * maintainership update for s390 vfio-pci
> * small (but important) quality of life improvement for protected guests
>
>
> The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c95=
78:
>
>   Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-7.0-1
>
> for you to fetch changes up to e3372ffb5f9e2dda3da259b768aab6271672b90d:
>
>   KVM: s390: Increase permitted SE header size to 1 MiB (2026-02-10 12:21=
:30 +0100)
>
> ----------------------------------------------------------------
> - gmap rewrite: completely new memory management for kvm/s390
> - vSIE improvement
> - maintainership change for s390 vfio-pci
> - small quality of life improvement for protected guests
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       KVM: s390: Add explicit padding to struct kvm_s390_keyop
>
> Claudio Imbrenda (32):
>       KVM: s390: Refactor pgste lock and unlock functions
>       KVM: s390: Add P bit in table entry bitfields, move union vaddress
>       s390: Make UV folio operations work on whole folio
>       s390: Move sske_frame() to a header
>       KVM: s390: Add gmap_helper_set_unused()
>       KVM: s390: Introduce import_lock
>       KVM: s390: Export two functions
>       s390/mm: Warn if uv_convert_from_secure_pte() fails
>       KVM: s390: vsie: Pass gmap explicitly as parameter
>       KVM: s390: Enable KVM_GENERIC_MMU_NOTIFIER
>       KVM: s390: Rename some functions in gaccess.c
>       KVM: s390: KVM-specific bitfields and helper functions
>       KVM: s390: KVM page table management functions: allocation
>       KVM: s390: KVM page table management functions: clear and replace
>       KVM: s390: KVM page table management functions: walks
>       KVM: s390: KVM page table management functions: storage keys
>       KVM: s390: KVM page table management functions: lifecycle managemen=
t
>       KVM: s390: KVM page table management functions: CMMA
>       KVM: s390: New gmap code
>       KVM: s390: Add helper functions for fault handling
>       KVM: s390: Add some helper functions needed for vSIE
>       KVM: s390: Stop using CONFIG_PGSTE
>       KVM: s390: Storage key functions refactoring
>       KVM: s390: Switch to new gmap
>       KVM: s390: Remove gmap from s390/mm
>       KVM: S390: Remove PGSTE code from linux/s390 mm
>       KVM: s390: Enable 1M pages for gmap
>       KVM: s390: Storage key manipulation IOCTL
>       KVM: s390: selftests: Add selftest for the KVM_S390_KEYOP ioctl
>       KVM: s390: Use guest address to mark guest page dirty
>       KVM: s390: vsie: Fix race in walk_guest_tables()
>       KVM: s390: vsie: Fix race in acquire_gmap_shadow()
>
> Eric Farman (2):
>       KVM: s390: vsie: retry SIE when unable to get vsie_page
>       MAINTAINERS: Replace backup for s390 vfio-pci
>
> Steffen Eiden (1):
>       KVM: s390: Increase permitted SE header size to 1 MiB
>
>  Documentation/virt/kvm/api.rst           |   42 +
>  MAINTAINERS                              |    5 +-
>  arch/s390/Kconfig                        |    3 -
>  arch/s390/include/asm/dat-bits.h         |   32 +-
>  arch/s390/include/asm/gmap.h             |  174 ---
>  arch/s390/include/asm/gmap_helpers.h     |    1 +
>  arch/s390/include/asm/hugetlb.h          |    6 -
>  arch/s390/include/asm/kvm_host.h         |    7 +
>  arch/s390/include/asm/mmu.h              |   13 -
>  arch/s390/include/asm/mmu_context.h      |    6 +-
>  arch/s390/include/asm/page.h             |    4 -
>  arch/s390/include/asm/pgalloc.h          |    4 -
>  arch/s390/include/asm/pgtable.h          |  171 +--
>  arch/s390/include/asm/tlb.h              |    3 -
>  arch/s390/include/asm/uaccess.h          |   70 +-
>  arch/s390/include/asm/uv.h               |    3 +-
>  arch/s390/kernel/uv.c                    |  142 +-
>  arch/s390/kvm/Kconfig                    |    2 +
>  arch/s390/kvm/Makefile                   |    3 +-
>  arch/s390/kvm/dat.c                      | 1391 +++++++++++++++++
>  arch/s390/kvm/dat.h                      |  970 ++++++++++++
>  arch/s390/kvm/diag.c                     |    2 +-
>  arch/s390/kvm/faultin.c                  |  148 ++
>  arch/s390/kvm/faultin.h                  |   92 ++
>  arch/s390/kvm/gaccess.c                  |  961 +++++++-----
>  arch/s390/kvm/gaccess.h                  |   20 +-
>  arch/s390/kvm/gmap-vsie.c                |  141 --
>  arch/s390/kvm/gmap.c                     | 1244 +++++++++++++++
>  arch/s390/kvm/gmap.h                     |  244 +++
>  arch/s390/kvm/intercept.c                |   15 +-
>  arch/s390/kvm/interrupt.c                |   12 +-
>  arch/s390/kvm/kvm-s390.c                 |  958 +++++-------
>  arch/s390/kvm/kvm-s390.h                 |   27 +-
>  arch/s390/kvm/priv.c                     |  213 +--
>  arch/s390/kvm/pv.c                       |  177 ++-
>  arch/s390/kvm/vsie.c                     |  202 +--
>  arch/s390/lib/uaccess.c                  |  184 +--
>  arch/s390/mm/Makefile                    |    1 -
>  arch/s390/mm/fault.c                     |    4 +-
>  arch/s390/mm/gmap.c                      | 2436 ------------------------=
------
>  arch/s390/mm/gmap_helpers.c              |   96 +-
>  arch/s390/mm/hugetlbpage.c               |   24 -
>  arch/s390/mm/page-states.c               |    1 +
>  arch/s390/mm/pageattr.c                  |    7 -
>  arch/s390/mm/pgalloc.c                   |   24 -
>  arch/s390/mm/pgtable.c                   |  814 +---------
>  include/linux/kvm_host.h                 |    2 +
>  include/uapi/linux/kvm.h                 |   12 +
>  mm/khugepaged.c                          |    9 -
>  tools/testing/selftests/kvm/Makefile.kvm |    1 +
>  tools/testing/selftests/kvm/s390/keyop.c |  299 ++++
>  51 files changed, 5920 insertions(+), 5502 deletions(-)
>  delete mode 100644 arch/s390/include/asm/gmap.h
>  create mode 100644 arch/s390/kvm/dat.c
>  create mode 100644 arch/s390/kvm/dat.h
>  create mode 100644 arch/s390/kvm/faultin.c
>  create mode 100644 arch/s390/kvm/faultin.h
>  delete mode 100644 arch/s390/kvm/gmap-vsie.c
>  create mode 100644 arch/s390/kvm/gmap.c
>  create mode 100644 arch/s390/kvm/gmap.h
>  delete mode 100644 arch/s390/mm/gmap.c
>  create mode 100644 tools/testing/selftests/kvm/s390/keyop.c
>

