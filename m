Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B23A2E0A
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024116; cv=pass; b=coFAZK3jsbM33k+z18Yh4EcO6DpRza7rtnRo4N9lwvftrJQpPP0pHxkxsH2A5eR/LZa8XuK1mwGle8XkUDMLjU81ynYmm09lpri3rpKCU+Sc9go076cIyTOBHgYtjBdMpn+sRx1wRvCng0T8Xpfh9nE2OPlXZC6nxeUg4C6k0QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024116; c=relaxed/simple;
	bh=6gtl7710ZFeRPvJ4cGlV0w1ug+lUsGrDAXKe3A0xqm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3UJQYuJBzuHSlv7+4+tqz8nEuOEvKZbeMpEpx1wQyihYO9eag6icEp/VvFRYuS0DLJnJsH11T/TSXiNGBOR7YwA2zV/Q/To5S1z6wAMkuaiGbTZA1ty0Gtwb16MQDr6xAs3f6ycjssSBlR9MY8KqYfflbNMv67pIeLCYXRmT04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ippVKS/B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPnDQHHR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ippVKS/B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPnDQHHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786024109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
	b=ippVKS/BOqgUjrRT4ef8HZ7MN0xWkCwxyTd6FFVjSpCHH4deWeXgVmQcLOaF1j59t8xSFP
	ZemNJE11I9IfIyjS6Kp81LrZ7axYbyA1Nx3Sb9PyZ/Y3wwpBkNeBZBtoaPIVS/jjJqR4dL
	Pc+3M7KnOARacl9XVb0up6PCf1vUJV0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-YGWXsYIFN6m_Lw_redCoiA-1; Thu, 06 Aug 2026 09:48:22 -0400
X-MC-Unique: YGWXsYIFN6m_Lw_redCoiA-1
X-Mimecast-MFC-AGG-ID: YGWXsYIFN6m_Lw_redCoiA_1786024101
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475e540a0ffso1383472f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 06:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786024101; cv=none;
        d=google.com; s=arc-20260327;
        b=KwJl9NF+ZPm4bJ9jUKmGZZJyfcgX95twIzU3vle0VzIwlH2Wx+c9UvRwENXdWQrpeR
         WBUhUL0AHRBL7HPg5L2A3ikfVv0+FZHyBQg2Mw+b8bXxEuCd5u8X7NAM4LMJBZuQP6P/
         AIsxD/Ylse0bhhnQxW3HzSPKb2xmZDExPlCVV4l4ol7UqqeRh3Q7ezlVrp51Bqo/kvad
         AZc1ZAJC8E59BgRZrjaCvKXLJynv6v1RycSf5NOZrGKjyXQ9NgEPhfcE/G38okZOoyKv
         S7S3spfLZcEU9ES58z1HDj9wsOkKq9SMjK9GayIDjDUCdyTy19YVBp6otmxBp2nJ+7ns
         gHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        fh=Uyt6jD4oBTBTyofQjTAT5craVb9rtGiSLTTyS1wSFxg=;
        b=XDlYOYP3V6NCqlXvJgEdo2bYJIlVDGSAQuVZKvLebpnJNaXwkRwu+NYp4DbERA5aGa
         FhgZr16060WmzjUBd4mo1Niwxs1wef13Eg1h1QNBBD3ajBcjw4AbmsMH2DjvcnID1zsl
         lP4L6bkZiYWoeKkIrh3J4A+zHd7W8UL3zYDUwjzrn6JzZdb8DUd7n4VeZi4bDHLro0Xd
         xcUarKk10dLHZx++OFEic2ITjK/YiGg2SrknBQXAuunk086AiuAYnBp6fuQVbQ4uThja
         m3UFujPoO3nf+g7W+5u2ZCrqhoBHSs1migoliWMIQQmBx2TMsZ8y8YrQnq3vnobB0y+3
         20EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786024101; x=1786628901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        b=mPnDQHHRIWNCq4d2K97hriEog7COkh3nwXwMmd0g2e5NUQhXR6+ji6Q05Oc+DUktSO
         s5bn/B0kxJjnTJuYraF1XrjE8Ekdtghen8fT0AoZyiUYSZ4EQWbW0yaNhv6lEDKwdQBy
         mZhfaipI1WY6QRqP/G4r66u8Whk2xs0vC98q92Z5WagH5vmZgJJmTLcfouFqG1BSpeyx
         oB2vfPQPapuy896jFNybUw+4uPLaPa6mNT285DEeJm4kqcEsfTHaL2m1f9cvUTjHgAwm
         wCQFI9GKcCRMt/wfBw93OmwHfJsJ+DfjGEvSscfbwfyyaZ8pm71EuUlAj39rdPt+R5MS
         Q+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024101; x=1786628901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8Y0ExwL5RJmYW1fILSeng5LBvxhpRt1TCM0nL/CNRQ=;
        b=Eokbykkw91DBut7ajMbabbO3YIX9fRdgXzAphjs0MdaSuw/4oGvwMy0WyXTVhJzj7c
         vB1AnM9uyAqi0dbS8CQy0XTP9DM4qxuLbDJTZNgo9dPm0mNUfcjFp3hN8Tr/EJyfm/KC
         aUDLG9ViMdRZvMhZABGdhHs26q+izsXTPRZWa9yGLl972AEV2WZag3ovGJXQuu30/m/4
         TwxmJhcWWHajwL/ed6MbMd2oFJzWEXmR5nR7r4bfEZdKizFAO3F62kZ8FOp4NLUL3C6Z
         B2R7WQpTsGBWVvHW2hJgHb06Sb72LnpBK6l0V6VWF2b89ezuNzMA0c7vsciTl5mOZnkc
         MDSA==
X-Forwarded-Encrypted: i=1; AHgh+Rq27SSl4aDYxCO49uwtWCRtfUrRfg7enuiBVpc24rbUv4LJNtFZWcc+QwFZBA0Q3tbIpoEGvLMKcaxl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7s/85J0Idf69rGrLa5gGyvwtNP/4fBtPx7H9d1qZKzFNHBAjD
	1EQUxIVfnZqqvXv4tITRl5Ttmnb3hQ5W/z8urLk6H75pFPvRvvurpVAdalflt7+i0wDggCtwFo+
	xr49lw29HNbKdi3s8ePhJWbXUUt+ignRlCQkpDTCY3mAKRQ2vtInODQrpELVoWrMN/YOCWA56Wp
	hZpUp1T7fCtuGVvLz9yMWR60O/lHb2LJjnU/9KA4EEoklbVw==
X-Gm-Gg: AR+sD12twAgdBC3kasCepNaig4i31xAW7bX5hnE0BH3YKpW1dcD7zVy95VterxoJUdx
	sCFyfcGzdT6AdEEPv6emCWlGWtzTvogrRQUxGE7/C7m32lXpUOjWM48O6tExMyfF8m+n4CvybhU
	mNeC8HhI6uPvAFhxgKOqRmZdS8Ro/r0/0EyTL3oj7Bez/dpWGpIcjRHRVylhoQEqS7TN9jcDAUL
	bSEcucoAb8W60jJn/ZoC+1fwfdhHLrg/YQPzFmyfVbDpX7ytRiDrkOPugo=
X-Received: by 2002:a05:6000:4808:b0:47f:80ee:744f with SMTP id ffacd0b85a97d-47fec5222dbmr23617568f8f.16.1786024101321;
        Thu, 06 Aug 2026 06:48:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4808:b0:47f:80ee:744f with SMTP id
 ffacd0b85a97d-47fec5222dbmr23617499f8f.16.1786024100926; Thu, 06 Aug 2026
 06:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Aug 2026 15:48:08 +0200
X-Gm-Features: AUfX_my4ahHsSjtDt_RgC7cSARlv-tVLJYAEL3hBv5okb1db2aWHdU6uSuJOe1s
Message-ID: <CABgObfb6K-GJgxvYtbOhzmdy-gO=Uyz-tbXWm3Hr+JkKg1rhtA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/23] KVM: s390: Misc KVM and vfio-ccw fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:09=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ibm=
.com> wrote:
>
> Ciao Paolo,
>
> In this pull request there are a bunch of fixes to various KVM/s390 and
> vfio-ccw issues.
>
> There are still some small known bugs, which will be addressed later in
> a different series.
>
> The following changes since commit 9972befc3e34ff8b6847198c84f11bfc312dde=
40:
>
>   KVM: s390: Fall back to short-term pinning in MAP ioctl (2026-07-27 09:=
23:53 +0200)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.2-3
>
> for you to fetch changes up to feadc5e84dcb53422a437556c35af9efd9826fd5:
>
>   KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46=
 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: Misc fixes for 7.2
>
> Fix a bunch of small issues that came up during the previous round of
> fixes.
>
> They are mostly extremely unlikely races, but they should be fixed
> nonetheless.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (13):
>       KVM: s390: Fix unlikely NULL gmap dereference
>       KVM: s390: Do not free SCA if it was not allocated
>       KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
>       KVM: s390: Fix overclearing ESCA in case of error
>       KVM: s390: ucontrol: Fix sca_clear_ext_call()
>       KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
>       KVM: s390: Fix race in __do_essa()
>       KVM: s390: cmma: Fix dirty tracking when removing memslot
>       KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
>       KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
>       KVM: s390: Return -EINTR if a signal is pending while faulting-in
>       KVM: s390: Fix ordering when adding to SCA
>       KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
>
> Eric Farman (10):
>       s390/vfio_ccw: Free all memory if cp_init() fails
>       s390/vfio_ccw: Limit the number of channel program segments
>       s390/vfio_ccw: Fix out of bounds check on CCW array
>       s390/vfio_ccw: Ensure first IDAW remains constant
>       s390/vfio_ccw: Calculate idal length based on idaw type
>       s390/vfio_ccw: Ensure index for read/write regions are within range
>       s390/vfio_ccw: Cancel existing workqueues
>       s390/vfio_ccw: Move cp cleanup out of not operational
>       s390/vfio_ccw: Selectively expand io_mutex
>       s390/vfio_ccw: Implement a crw lock
>
>  arch/s390/include/asm/kvm_host.h    |   1 +
>  arch/s390/kvm/dat.c                 |  23 +++++--
>  arch/s390/kvm/dat.h                 |   2 +-
>  arch/s390/kvm/faultin.c             |   6 +-
>  arch/s390/kvm/interrupt.c           |  19 ++++--
>  arch/s390/kvm/kvm-s390.c            | 125 +++++++++++++++++++++++-------=
------
>  arch/s390/kvm/priv.c                |  10 +--
>  arch/s390/kvm/pv.c                  |  43 +++++++------
>  drivers/s390/cio/vfio_ccw_async.c   |  16 +++++
>  drivers/s390/cio/vfio_ccw_chp.c     |  31 +++++++--
>  drivers/s390/cio/vfio_ccw_cp.c      |  74 +++++++++++++++------
>  drivers/s390/cio/vfio_ccw_cp.h      |  10 +++
>  drivers/s390/cio/vfio_ccw_drv.c     |  21 +++++-
>  drivers/s390/cio/vfio_ccw_fsm.c     |   8 ++-
>  drivers/s390/cio/vfio_ccw_ops.c     |  39 +++++++++--
>  drivers/s390/cio/vfio_ccw_private.h |  10 ++-
>  16 files changed, 320 insertions(+), 118 deletions(-)
>

