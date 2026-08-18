Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A535E1A8
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051326; cv=pass; b=CnSfhLefng+hvpsV3A3GHB8xKbCTA9QKqgyh8IO9v9JslehtSAtxFtdKfLQ7VouUD12sUi7uLUCYN4d5E7nGLL2ZXNQRJI8B2T6y6aevB4pKbPUs97IxNv6vHFMO4mQyIOR/xd4k30Ug9jl3vX5NWCz3hslq0ovbiF2urttLT9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051326; c=relaxed/simple;
	bh=4viULYK9ISV3X3SGFs5KlxbLfvgF7cUDdXdoRuYAG1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvbX9K5be0GcQEl/yVdSnwnSLK4yIKTmWLG8da40C4lQXY8XTwnRNLxkW4UHd5wOKdaGWxTYc9JqZuBzC1320FEW0Dv7nBmOzzXt4Z953RgH+HmsPjBE9HbTLVYsRLoT5qejK5xEmmkp0WspMAG3CjL546fRzTCjyJf8s4DxEo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbF11/AS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=njtrrJ1l; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbF11/AS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="njtrrJ1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
	b=gbF11/ASf5bc6XtyW/BjL8RYNwVkmIcUiTWUJRVc3AaxG4vI0oHLlYyVJeyFhfHmcy9F4x
	uKgxnskI20mhmYMhI83Pjf6DGKwSKCo/Upzl97DXDzK1GZJlcr6r8QzDdBYSpN2vNPbKRo
	PnHgaW+RlG9Ki0/iwZOw2yTYYJQ3cm4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-fMBrSmOKPqS8wE6PvxCJkQ-1; Tue, 18 Aug 2026 07:08:36 -0400
X-MC-Unique: fMBrSmOKPqS8wE6PvxCJkQ-1
X-Mimecast-MFC-AGG-ID: fMBrSmOKPqS8wE6PvxCJkQ_1787051315
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so2156928f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051315; cv=none;
        d=google.com; s=arc-20260327;
        b=XFpQ6III53O6uyaA8l+Q5IHywpgKVzFYTidO4z1DR510HIzvy/Kj+ZqVD667MJqqu7
         9ITy3aGTCVm8WOORoivZ9Cgt6TlOaD89UAfBMUSf1sJdK3tvLfqCXDx7xVu8lzTu1vy3
         vOlTzJNTcFRgOt6ktUyW0UJAIPqbmOQeuawXzuk3kQ15RakMxlrRKMUEpTx/I1Fh2BQ3
         u8ISMfxY4EbGPEQdHmCvmx6DlDAaQ5yVqj3ZVcgEs2Tt5Nq9Z7JgV8L95MMPYaKH5q+S
         c7bS4mJ+1KHgGvCt8GHkoYzP3iX5F31+uw+PwX1pe49rAL58nPENsjVNKnHdFXu9wgJd
         QqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        fh=rMKX/RX/5UxgctX6tWWvXBl9ofCUVi3DnEHuogcKNO4=;
        b=dwzWLx7Y9LChTjuRBcJuuMvfkSzgX9NOF3Oi4ip2J0wSzPd4Mbg69Wf8iKqyDx3wM3
         LpJ9ZM/0PGKnXT84SzWeIRxHIMQujToxySjnIdTkfTe0XNe59j7IBZ2XdR0Rin9Wtrue
         Yrz4OdZklyHIJL9SWLGS0jOV5xOFEJAKFu9d4KJWJAmCAbqLj/Fomg+nR8n1YSETjzOM
         kUNZI2CqW3Aq4cbR/ea5HKPkXGomWd5pLny1QUWwhUVZW581vv6vOmVHYVMon5hSkXCh
         lN7YBsfEcOYuIlDohyEC2UAWlZrED0FL+Y2NP+0qr/IWARUmw0uhUDCpgkV+BKa1YDya
         8FtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051315; x=1787656115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        b=njtrrJ1lQ2HZV8eKhZIfdfOMU2hucSWZIiAeKrWDsm9yOAmy3ye1JY0aIFkf/gHa38
         ZQdgxAlkwUisZjALMhrP69f57Jt1IL+cFcwFfni1XyqM9OVfutrD2Q+VdvyREwyRJ5RW
         ODIvfSPz63NUAH+PTsOqtIh13gVRUolcPeTosuWT0pq8vekKo2hKYEcffYp6mb/ccSPf
         WEJzxVeLc6U9F1hDIsjWmqMNerA8kBYv90t2g9MBc9N3F7y6FFdAlsB+6FGFj7ekL1sM
         Bkmyg7mzLj953tiswxo8R2fPjA+DC4Kq6aSlk6UXv/qi7aHuK1/IMBVsQWKGDrvqIDlO
         AW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051315; x=1787656115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        b=PVfNOljtl948rQcKa1jC3pt8BFuVdwqYes3fUWsrjzCrXoKaEAdesEjjab2ruyj6ch
         pGvD/MUfEYsekc1u+aVMWpb3oncR+eXEpLfF8/sKVx0hVJqT6SwXeW2jKe8PiiGjT1R1
         IFFeWye8RCQ37CTKDzdFl7VDEgnEbDK3EfL88yJuk5sMTDF8oThJo8m7CCHXbAYeFkzF
         cQSZ7kRlTIsfHJ8834gHECjyE5a/GFh5LZkNsfQgxzOn+xGv6OkKICcrADP1z7Lz/Y7Q
         BEubHuNo7iE2JVXZKFaQaDmqWgLWaGkmFzaLemxPJjDADjwpYqktmnHvxczTungFKeUq
         1C5A==
X-Forwarded-Encrypted: i=1; AHgh+RoLUqCb9eRFHan2M+KgPtYPx36UUsM9ACe5DvYW7KPfPIQA+M55QfGUSHrzP9lNTaoflnwubtcRseaz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9jhCs7faRncgzlpnG0HQh7PtjPsLM2751Jw6tLiBKbgm9Nny
	K294ANnW2I9yvsmkBY9LGh/AvdCitWjZXtTLFs45hiPwt8t6bjdPaojVCUG9VrAMnadN/zNKtn3
	W8nBhiXSCqfSQksJP+71XQumIFcLkb8PGPTN9ynlRn35T1zii+sYyK9XDPyHzmD0q7Vz2CeQgIh
	j9D538AufXE+xHcA+IBIWG8Wmob5ZCjT3BYSXKbg==
X-Gm-Gg: AR+sD12eGq6aGH8Es7ZdPUjlXiPqHaPqHIeTUvnN3sUUpEiUqxLQWlwssZcqLIQ7mDq
	OxcBhagwzRu7rCys1wFNTvf7aYkN1MyGX+ny9KZq+S3akbj0P90NVU/6x3KCyUWUV/zoTaKG3Ek
	PeG/8sYKI1lCxJuOj4B/jIEaUC2aEPN/b85biqNJv8fH7ns2vvH+2F56ayxS1Rb1YkpEonlfVIh
	jAcJmed8x8fRM7azyXYDIY8tfeYi+SeGElE5x9tsNioTk12eYV7F3l1LzQ=
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-49987971986mr470732565e9.10.1787051315313;
        Tue, 18 Aug 2026 04:08:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49987971986mr470731715e9.10.1787051314884; Tue, 18 Aug 2026
 04:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814075049.223793-1-borntraeger@linux.ibm.com>
In-Reply-To: <20260814075049.223793-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:08:23 +0200
X-Gm-Features: AcwNN1VqT9BPc_oMjQ5yGwpZ-4wjOVBs2OoiaEOqIU4aOI7_4ztG1OMv3qk04ck
Message-ID: <CABgObfYx5gY1ZZjuc1OV8eAT1bZajv9vBwODveyNyOHn8nOs5Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: s390: Features and Fixes for 7.3
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Anthony Krowiak <akrowiak@linux.ibm.com>, Ciunas Bennett <ciunas@linux.ibm.com>, 
	Christoph Schlameuss <schlameuss@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Douglas Freimuth <freimuth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:51=E2=80=AFAM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> large chunk of s390 fixes and feature without patches as reply due to
> the large number. Series is on top of v7.2-rc2 but I merged
> kvms390/master to pick up additional fixes that came too late for 7.2.
> Of course also other patches/fixes directly on top. This automatically
> contains all the previous s390 fixes for 7.2, but this will reduce merge
> conflict potentials, so I see it rather on the plus side.
> I made the pull request statistics on top of rc7.
>
> sashiko reviews for the patches
> 1. Fixes for vfio-ap
> https://sashiko.dev/#/patchset/20260812200240.818004-1-akrowiak%40linux.i=
bm.com  without patch9
> https://sashiko.dev/#/patchset/20260806173435.105044-1-akrowiak%40linux.i=
bm.com
> 2. Fixes from Claudio
> https://sashiko.dev/#/patchset/20260812104436.109741-1-imbrenda%40linux.i=
bm.com without patches 4 and 9
> 3. vsie Fixes from Christoph
> https://sashiko.dev/#/patchset/20260807-vsie-cleanup-202607-v1-0-b18659b5=
5e3d%40linux.ibm.com
> 4. diag 9c tracing from Ciunas
> https://sashiko.dev/#/patchset/20260724103959.14861-1-ciunas%40linux.ibm.=
com
> 5. enable CONTEXT_ANALYSIS for cio and virtio from Heiko
> https://sashiko.dev/#/patchset/20260806153849.2622576-1-hca%40linux.ibm.c=
om
> 6. move KVM code to prepare for additional arm64 support
> https://sashiko.dev/#/patchset/20260812153631.3376090-1-seiden%40linux.ib=
m.com (patches12-21 only)
> 7. AI triggered fixes all over by me
> https://sashiko.dev/#/patchset/20260811153738.206885-1-borntraeger%40linu=
x.ibm.com
> https://sashiko.dev/#/patchset/20260805110455.7200-1-borntraeger%40linux.=
ibm.com
>
> --
> 2.53.0
>
> The following changes since commit feadc5e84dcb53422a437556c35af9efd9826f=
d5:
>
>   KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46=
 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.3-1
>
> for you to fetch changes up to dd6f4ef6f8a37412909ad787c837332fb070159c:
>
>   s390/vfio-ap: Fix NULL deref in status_show() during queue probe (2026-=
08-13 16:04:33 +0200)
>
> ----------------------------------------------------------------
> KVM: s390: Features and Fixes for 7.3
>
> - merged kvms390/master to pick up additional fixes that came too late
>   for 7.2
> - Fixes for vfio-ap
> - Fixes for the gmap rework
> - Fixes for vsie
> - AI triggered fixes all over
> - diag9c tracing
> - code move preparation for the additional arm64 support
> - enable CONTEXT_ANALYSIS
> - update to vfio maintainer file location

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Anthony Krowiak (9):
>       s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_=
set_kvm()
>       s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap=
_mdev_cfg_remove
>       s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for=
 NULL
>       s390/vfio-ap: Fix missing lock required to access list of ap_matrix=
_mdev objects
>       s390/vfio-ap: Fix required lock not held during update of ap_matrix=
_mdev object
>       s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>       s390/vfio-ap: fix potential use of uninitialized apm_filtered bitma=
p
>       s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain=
 removed
>       s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>
> Christian Borntraeger (15):
>       KVM: s390: move some facilities from FACILITIES_KVM_CPUMODEL to FAC=
ILITIES_KVM
>       KVM: s390: Remove user triggerable WARN_ON
>       KVM: s390: Zero initialize data structures for inject_pfault_token
>       KVM: s390: Zero initialize irq in reinject_machine_check
>       KVM: s390: Fix memory leak in guest debug handling
>       KVM: s390: Fix old_data leak in guest debug error path
>       KVM: s390: Take srcu when importing watchpoint data
>       KVM: s390: Free guest debug data on vcpu destroy
>       KVM: s390: Fix length check __import_wp_info()
>       KVM: s390: Fix memory corruption by not reinjecting CK machine chec=
ks
>       KVM: s390: keyop: use mmu_lock to read gmap->asce
>       KVM: s390: vsie: zero stale crypto bits
>       KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
>       KVM: s390: Restore sigset on error path
>       Merge remote-tracking branch 'kvms390/master' into 'kvms390/next'
>
> Christoph Schlameuss (6):
>       KVM: s390: Remove double 64bscao feature check
>       KVM: s390: vsie: Remove duplicate assertion
>       KVM: s390: vsie: Convert shift to phys_to_pfn()
>       KVM: s390: vsie: Assert mcck_info offset in vsie_page
>       KVM: s390: vsie: Assert crycb alignment in vsie_page
>       KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT
>
> Ciunas Bennett (2):
>       KVM: s390: Refactor __diag_time_slice_end_directed for single exit =
point
>       KVM: s390: Add tracepoint for DIAG 9c directed yield operations
>
> Claudio Imbrenda (7):
>       KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key=
()
>       KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
>       KVM: s390: Fix get_all_floating_irqs()
>       KVM: s390: Fix pgste_get_trylock_multiple()
>       KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
>       KVM: s390: Fix kvm_s390_clear_pv_state()
>       KVM: s390: Fix potential tiny kernel stack leak
>
> Heiko Carstens (4):
>       MAINTAINERS: Update s390 specific vfio sections
>       s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce(=
)
>       s390/cio: Enable CONTEXT_ANALYSIS
>       s390/virtio: Enable CONTEXT_ANALYSIS
>
> Steffen Eiden (10):
>       KVM: s390: Extract gmap tracing to a separate header
>       KVM: s390: Prepare include guards for a new location
>       KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
>       KVM: s390: Move kvm_host definitions to kvm_host_s390
>       KVM: s390: Move s390 kvm code into a subdirectory
>       KVM: s390: Move PGM code definitions to asm/kvm_host.h
>       KVM: s390: Prepare gmap for a second KVM implementation
>       KVM: s390: gmap: Make storage keys optional
>       KVM: s390: gmap: Make CMMA optional
>       KVM: s390: gmap: Make prefix handling optional
>
>  MAINTAINERS                                 |   8 +-
>  arch/s390/include/asm/kvm_host.h            | 723 +---------------------=
-----
>  arch/s390/include/asm/kvm_host_s390.h       | 729 ++++++++++++++++++++++=
++++++
>  arch/s390/include/asm/kvm_host_s390_types.h | 349 +++++++++++++
>  arch/s390/include/asm/kvm_host_types.h      | 347 +------------
>  arch/s390/include/asm/nmi.h                 |   3 +
>  arch/s390/kernel/nmi.c                      |   5 +-
>  arch/s390/kvm/Makefile                      |  11 +-
>  arch/s390/kvm/gmap/Makefile                 |   5 +
>  arch/s390/kvm/{ =3D> gmap}/dat.c              |  17 +-
>  arch/s390/kvm/{ =3D> gmap}/dat.h              |  21 +-
>  arch/s390/kvm/{ =3D> gmap}/faultin.c          |   3 +-
>  arch/s390/kvm/{ =3D> gmap}/faultin.h          |   6 +-
>  arch/s390/kvm/{ =3D> gmap}/gmap.c             |  19 +-
>  arch/s390/kvm/{ =3D> gmap}/gmap.h             |  25 +-
>  arch/s390/kvm/gmap/kvm_mmu.c                | 133 +++++
>  arch/s390/kvm/gmap/kvm_mmu.h                |  18 +
>  arch/s390/kvm/gmap/trace_gmap.h             |  47 ++
>  arch/s390/kvm/s390/Makefile                 |  14 +
>  arch/s390/kvm/{ =3D> s390}/diag.c             |  21 +-
>  arch/s390/kvm/{ =3D> s390}/gaccess.c          |   2 +-
>  arch/s390/kvm/{ =3D> s390}/gaccess.h          |   2 +-
>  arch/s390/kvm/{ =3D> s390}/guestdbg.c         |  11 +-
>  arch/s390/kvm/{ =3D> s390}/intercept.c        |   2 +-
>  arch/s390/kvm/{ =3D> s390}/interrupt.c        | 109 +++--
>  arch/s390/kvm/{ =3D> s390}/pci.c              |   2 +-
>  arch/s390/kvm/{ =3D> s390}/pci.h              |   0
>  arch/s390/kvm/{ =3D> s390}/priv.c             |   2 +-
>  arch/s390/kvm/{ =3D> s390}/pv.c               |   6 +-
>  arch/s390/kvm/{kvm-s390.c =3D> s390/s390.c}   | 159 ++----
>  arch/s390/kvm/{kvm-s390.h =3D> s390/s390.h}   |  10 +-
>  arch/s390/kvm/{ =3D> s390}/sigp.c             |   2 +-
>  arch/s390/kvm/{ =3D> s390}/trace-s390.h       |   0
>  arch/s390/kvm/{ =3D> s390}/trace.h            |  40 +-
>  arch/s390/kvm/{ =3D> s390}/vsie.c             |  22 +-
>  arch/s390/tools/gen_facilities.c            |  14 +-
>  drivers/s390/cio/Makefile                   |   2 +
>  drivers/s390/cio/vfio_ccw_drv.c             |   1 +
>  drivers/s390/cio/vfio_ccw_private.h         |   3 +-
>  drivers/s390/crypto/vfio_ap_ops.c           | 203 +++++---
>  drivers/s390/virtio/Makefile                |   2 +
>  41 files changed, 1703 insertions(+), 1395 deletions(-)
>  create mode 100644 arch/s390/include/asm/kvm_host_s390.h
>  create mode 100644 arch/s390/include/asm/kvm_host_s390_types.h
>  create mode 100644 arch/s390/kvm/gmap/Makefile
>  rename arch/s390/kvm/{ =3D> gmap}/dat.c (99%)
>  rename arch/s390/kvm/{ =3D> gmap}/dat.h (98%)
>  rename arch/s390/kvm/{ =3D> gmap}/faultin.c (98%)
>  rename arch/s390/kvm/{ =3D> gmap}/faultin.h (96%)
>  rename arch/s390/kvm/{ =3D> gmap}/gmap.c (99%)
>  rename arch/s390/kvm/{ =3D> gmap}/gmap.h (96%)
>  create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
>  create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
>  create mode 100644 arch/s390/kvm/gmap/trace_gmap.h
>  create mode 100644 arch/s390/kvm/s390/Makefile
>  rename arch/s390/kvm/{ =3D> s390}/diag.c (96%)
>  rename arch/s390/kvm/{ =3D> s390}/gaccess.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/gaccess.h (99%)
>  rename arch/s390/kvm/{ =3D> s390}/guestdbg.c (98%)
>  rename arch/s390/kvm/{ =3D> s390}/intercept.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/interrupt.c (98%)
>  rename arch/s390/kvm/{ =3D> s390}/pci.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/pci.h (100%)
>  rename arch/s390/kvm/{ =3D> s390}/priv.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/pv.c (99%)
>  rename arch/s390/kvm/{kvm-s390.c =3D> s390/s390.c} (97%)
>  rename arch/s390/kvm/{kvm-s390.h =3D> s390/s390.h} (98%)
>  rename arch/s390/kvm/{ =3D> s390}/sigp.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/trace-s390.h (100%)
>  rename arch/s390/kvm/{ =3D> s390}/trace.h (95%)
>  rename arch/s390/kvm/{ =3D> s390}/vsie.c (98%)
>

