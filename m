Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111E389458
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563460; cv=pass; b=JobFl/S71l90zcwA+NwjEP2s+fe4GOJ1P5W/EWbV7+9ao/AHrcqfvMM2aywCT+e611o9RA+qg8P3i7uZaN14Y11obhXIcZR7f4N4MK0Q+bezBVaX9eYr/7z87PT3rKCv2+nY+f37t2bokTYvrTLzSlabZn7IWhAUtfmfmmHKZZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563460; c=relaxed/simple;
	bh=oJjbZrkBVJ1PiPFEzs1/91v4GpF38orIAk8N5WksNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsIQ/KKLBuw2MWcuE0jZlvLTwF8w0gleHjuMlKwB2WMyTqXoT/P0aC3nD9W2AQybddn5GLgDLCPD0uJE/mFmytYEsM4y6V5NQhHB/AUDsS4kCPlvs+QqyNDf+osnpzWYmxOU2HIZlCNgjwYP6Q7iiNgi46W40T/h0Wlku1PL7oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5OcGEM3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO57doND; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5OcGEM3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO57doND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791563458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
	b=K5OcGEM3LPY+AHoH4QSH7+St3AsATRPFeTf3cxMrjlr7Oxlf6Rwk3I98XN8gr8eUMn4akr
	pcTaku2F3242poJ25rbLFVRZOuNKy+A+JLep8o+rmnwtlgmhrwuuhQu1Lb31OGo0PiARDb
	MiTW1ZsanJL2D40/prWDsqkC0cugq6Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Lb0avpTKOia_0O5kB2x8Yw-1; Fri, 9 Oct 2026 16:30:56 +0000
X-MC-Unique: Lb0avpTKOia_0O5kB2x8Yw-1
X-Mimecast-MFC-AGG-ID: Lb0avpTKOia_0O5kB2x8Yw_1791563456
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c46582442so1798f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2026 09:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791563455; cv=none;
        d=google.com; s=arc-20260327;
        b=LOLS7fMKIHCM8y3G9NL0KmpNMGh+2HSMINCIn9U5tOj7J8LPw5jiaXx63JiCtViG5u
         mpLSNskT45e1Kl+XLmcwtaKKwY27Hor+1Qffco4ZzRniNxDWB01xzz/U+T3Vq3J/gM0+
         jUHFM2g8CDY53dL7z9ZRFfDLF837rBQ2NPWmx3A9fPgv/tziOqKAlbzNtl4ZogWZHxr4
         dbiJiBh2IpVYym+i1jimcwxaBD0ubl1MSYu7g6CKrgXwVgjIQakp7zGvkYNWf4zFJaB8
         oGUzIT/enXt4StuckqLNchQt86B3R+FchciZkfnWyRXpSyA5TiYR40KfulkXrUepEBEq
         x1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        fh=t4cIPT2zDmokj/yTfugPvyijPRWnEbw3SFteOzbIvng=;
        b=V29kjGtn7FnNCyW9lYAF0y9ZAnKP5efHDpWUaUUpf9436ral1yVrLnw8Vzi9XKKHkw
         TW82jVQW9/Upuhsjb209znOFevnunBytCQ9D2WHmwy/lm8DEa88j/iYVMUIohvPjX8Lc
         wjVyQmDafYtPPZ4YWMUUZalRvmi14DgjDsnMMBNSpOli1oDFI5heFpktRq6nSkZ5rGq+
         jJvik9nDe4BKnDrHOAJ1sw6aEgHBvL3DRwyBswabaN6QTyb+/QEdaz21MfWJtW2QqmqL
         Uls27w+jatD/1Ld6zzcUgQKzNUA1J811aNeQARuIPJ3nj46AiKWaaQH7UM76tQOfxbrP
         zPpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791563455; x=1792168255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        b=DO57doNDRv2cOhr19TwzPu/7+qLfubFAZeNgO8L2MHCEo4Mq83EmfKyLIEp0rDX32q
         1HOoepXJP8//ZPApiFz9JfGy+m+G5sjXzAkRd4/mKDAOR8W1pno9bgNxLqLPrC430MLi
         bQ0AU70bEjE0jRUNLbZbbbZ1BhOyO4fOYopxDZIpI2Vg3oo77xTJR8+zUdtwcBuw1EGD
         BMiFiUZlbHNVhoNRFdYu5xINT2eriU60oGIUAQrP7I1s4TqBbce1PGRJHzOIXC7oHcuw
         qBLsD09UdUdwjuA3P+4G9W1+OKmFUN8I+HdERsMasuGO+WJV9RCadleUE9vM/M0e/g6G
         gtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563455; x=1792168255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        b=yTOZoMjHgGB1PvVFfZTTZVO/SJeTFvwoTVjOszzPXSpXO6PL8V/+QuUt7n5M3mAUCm
         82k0uB0qLiaEfl5Sa/om/8y2Y3dSpYvyoE2q1iZhnGWtMg5cl8T7Sff91focQiqt5/Es
         ApTn9ODqOGOTrKft5CG3S9biO+HvpEejSCF/KdIiQ8andQ177EPzWw+XDjajzqXiuXDk
         OrDcLyrjlosRhwFjba5slgYCjBOXctsp559ZhUVAmZIK+QDl2RBeYvX+T3dTXwgYPOri
         G0vmMhSKwJvQvdDviu/rrLIlwiHHCdi/12pLcninFxTFx2VSHh/fq5BJvxGDXzlhF/F9
         D93w==
X-Forwarded-Encrypted: i=1; AKwUvBwdKsEczAfFZd1cgxr4XRV8B3dZib28yN3sBH3B8tdMPB809hPodMzY1G89+cRgk8xwFMXf0oRPj5OL@vger.kernel.org
X-Gm-Message-State: AFq9FYLgV3cxePyOftPR23LD1aEqTBrcUkSwLIHIvTwj/RhSOpTPoYjg
	BaedEUffnInQS7/vprbw4tsYPVp62jMs4cfAFvHwToF/i9kXuigGB1qwbClrrz3FXQH3nvQrRJT
	u0CSxB56aCToIS9/EoM1zqxm1b02Xn4z32yYu/DGiXGH3D6T3TvYxr+/INj73/tIxncptm6gA+g
	6HjCPFjNAZBcDjY+TApIUOCQO14D74TPpDdzn//g==
X-Gm-Gg: AYBFou0pZHax1VpyTXctpml2cwgOHy4Z0LfZR1dRPiuUlMwC09KKLRZxv6nVt2qnHGV
	/fOOAi4QFE3YJSbgfUS8IIEE+bvcA8x+lXMC/38AvaNAdamIPmdWmf4KHrxoxLoVx/Jd46X5/JO
	6M6bX90UF2Iyh9k3Fxe4gCOUvXKvQBd25F1O5k0pTHtJEzhxBKnYdS0nzsUJrB2NC18lfBR6MAM
	Enn3FuFNQqq1Kzjld+nvFZ87+Udl3T4gK2k2TyVsQhxphMwtvmaqdc72yxVnA==
X-Received: by 2002:a5d:5f48:0:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-48dba9c8d45mr5019876f8f.25.1791563455638;
        Fri, 09 Oct 2026 09:30:55 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:487:6f2:1a4c with SMTP id
 ffacd0b85a97d-48dba9c8d45mr5019823f8f.25.1791563455214; Fri, 09 Oct 2026
 09:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Oct 2026 18:30:43 +0200
X-Gm-Features: AclHuK83C4CDvo9EtkFIIQksf1QULcxw-SlHfNTwKc0Z9wirBe-7J2xrO1T1MY4
Message-ID: <CABgObfbqh3+ivyY2CXhy+ZWHg40Z9xQZPKys+2+TFsb+x89Q6A@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM/vfio: Use file-based reference counting for KVM
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christoph Schlameuss <schlameuss@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:28=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
>
> Paolo,
>
> The following changes since commit df2908090cda368b01ff43709f51890076c561=
57:
>
>   Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.4-1
>
> for you to fetch changes up to c22295d0d75f5590fdde5493cb90e2d50d5f508e:
>
>   KVM: Remove unused file_is_kvm (2026-10-02 10:40:01 +0200)

Pulled, thanks.

Paolo

>
> The tag points to the vfio_file_reference branch of the kvms390 repo
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=
=3Dvfio_file_reference
>
>
>
> ----------------------------------------------------------------
> KVM/vfio: Use file-based reference counting for KVM
>
> This series switches the KVM-VFIO interface and external consumers over t=
o
> standard file-based reference counting, eliminating all external KVM symb=
ol
> exports.
>
> Currently, VFIO integrates with KVM by looking up kvm_get_kvm_safe() and
> kvm_put_kvm() dynamically using symbol_get(), manually tracking module
> reference counts and storing a put_kvm function pointer in struct
> vfio_device.
>
> In the ARM64-on-s390 architecture, a second concurrent KVM module
> (kvm-arm64) is introduced alongside native KVM to host hardware-accelerat=
ed
> ARM64 guests. Having exported global symbols (like kvm_get_kvm/kvm_put_kv=
m)
> creates symbol conflicts and prevents clean coexistence of two KVM module=
s.
>
> Additionally, the file based counting simplifies the code and reuses
> the existing fs refcounting.
>
> Instead of passing raw KVM pointers and managing module symbols manually,=
 the
> interface now passes the underlying VM file descriptor throughout VFIO an=
d
> associated architecture subsystems. To safely extract the KVM instance fr=
om a
> file, an architecture-namespaced helper mechanism is introduced that veri=
fies
> the file belongs to the expected KVM implementation before accessing its
> internal state. A back-pointer from the KVM instance to its associated fi=
le is
> maintained across its lifecycle so subsystems can safely acquire file
> references on demand. Finally, with VFIO, architecture page tracking, and
> device hooks converted to use file references, the remaining KVM referenc=
e-
> counting exports are restricted strictly to internal KVM modules.
>
> ----------------------------------------------------------------
> Steffen Eiden (6):
>       KVM: Introduce file_to_kvm_<arch>() infrastructure
>       KVM: Add file back-pointer to struct kvm
>       KVM: x86: Use file_to_kvm_x86() in SEV
>       KVM/vfio: Use file-based reference counting for KVM
>       KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM module=
s
>       KVM: Remove unused file_is_kvm
>
>  arch/s390/include/asm/kvm_host_s390.h |  4 ++-
>  arch/s390/kvm/s390/pci.c              |  9 ++++--
>  arch/x86/include/asm/kvm_host.h       |  2 ++
>  arch/x86/include/asm/kvm_page_track.h | 10 +++---
>  arch/x86/kvm/Makefile                 |  4 +--
>  arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
>  arch/x86/kvm/svm/sev.c                |  8 ++---
>  drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
>  drivers/vfio/device_cdev.c            |  2 +-
>  drivers/vfio/group.c                  | 13 ++++++--
>  drivers/vfio/vfio.h                   | 14 ++++-----
>  drivers/vfio/vfio_main.c              | 57 +++++++++++------------------=
------
>  include/linux/kvm_host.h              | 19 +++++++++++-
>  include/linux/vfio.h                  |  5 ++-
>  virt/kvm/kvm_main.c                   | 21 +++++++++----
>  virt/kvm/vfio.c                       | 13 +++++---
>  16 files changed, 132 insertions(+), 91 deletions(-)
>

