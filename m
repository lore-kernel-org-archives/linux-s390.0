Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BC3CE4B6
	for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872203; cv=pass; b=RkSbYhepfks8EPWbuuXE6HtVd1E1f9+7XLgvvuBwCva25H5q0AM0Bn365pCqc4Dza1//cOX0HyJAMQSY/tOgY8E62xojMc0IQs3Vaji/9p+vDS6DtjSDb2KFTaWsisj892mZl99IAYZ8h9fSxG8NewP5bHDnzUHYyJS9SwQLSUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872203; c=relaxed/simple;
	bh=dlojckMTP0EqbPzAwVconofdQz/0gm7fgmh/1rE97gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwMklO8AysdTX8yQgNclPhLLXRDUc/iBOx6WaKBk8b5z1PYB6XV9D6U7qpLF2m5UyIpqzCFGuktAXa5xeYUG533xFrisaDxzGfpGpEqG3s0true0vjAWdRLgoxVr5bHfILV09jhxhSu5aNMdHT8ate25HBd+SqBskt9tdM6SMWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dU8ix4v1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N16m2BY6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU8ix4v1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N16m2BY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774872201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
	b=dU8ix4v16RIHJXXnE3hIevQ5JdPkTkUyjaQVA9O5ovmYxBqS6jFt9nfHVg4Kl2FmC57U1M
	e3Kjk33cUfx4oWdbrGKN8fjFcdlOG00+wp9m9byzpgTp6RUMngNKuSnF91qsU2XkBXVf/P
	MeoyIT/0tzBf0g/jGhzY/uii/yekEGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-YE2qoNprMyW1pYSe3IzzcA-1; Mon, 30 Mar 2026 08:03:19 -0400
X-MC-Unique: YE2qoNprMyW1pYSe3IzzcA-1
X-Mimecast-MFC-AGG-ID: YE2qoNprMyW1pYSe3IzzcA_1774872198
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853466655dso27314875e9.3
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 05:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774872197; cv=none;
        d=google.com; s=arc-20240605;
        b=F517rlHSzhxuT3xCxNE3qgkLr9Nt4bVdZ42asnVrdMuStDvHjN0JVUv+9IWQxYJ0Dd
         4cDrQ8eqf8J/Ad0j1ZALgZJTmL0v7HTKE/kFzHs385kGeyisqLBuBJ5U1pm4HQCbCZ5e
         8xowTJiIE+uQpWpHtCO4NNusSKkgzRYQFhhcOD82nD/BPf4+oQEJNZL48JXk7q7qs5/J
         90gxlKRdoAUqXNAPLW7GA38JzS1F07yGvhoXdH6i3vOn8MJ5Yt4Ksqz3eri7I5TA3wWx
         mj4bnk2rScViL1RaAWaL1xkKTo9ZbQ025U7pxGRxF3/5AxaeEbsDx5eJ6F42ly6O7BfP
         YtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        fh=E+SWMBoQfK2G+ji7fhlBbrvt1DeKvLSF8eWxv2z8Kgc=;
        b=kYNVQ7KDzHAO1Z9l4nD85ofgqXkgPs6i2w6D6Am83StKm/9eIjIyrQRAqMqO9066XC
         R54Dg+QthEEcdr2ZZndRTd6+Amx84+SaMxukeCnoku2I5h5rJJeVl4pQ2VxCw2Tp25bY
         HEBJ0AWzijbx3uI31sC+JS3DOwNT8Dkcl0VC1w/MSh+NjrcK7A9hht1OoFa+R19AbITq
         DRp++flXz2Y++i790p88wzcxOYOGoaoRz8vdguFc13XfAhx4QQq2cr4mlOlU9vpD2uVf
         teY8g/yhpoU8TB6jp9zRD1SU2fDMa5WJaUJE0JK4enoPjMk+j1XcpMq9+lkHUN2vghVn
         +H6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774872197; x=1775476997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        b=N16m2BY6BEO8BFEvRjqC04HtguBZQFVgOQJyGOYJBy+3j0aXsP0pLthWEm58V+4Tns
         b8I/yF+yZMjTlk+g12X/SZzElXlCn0zGyO3Df0v0LtKsCUyn6MWbpk2yZRmm5wMe9kGn
         DA0ZsOxAFmM9oMIRCtvbLS7VGWEwO/x1u5ktAlDeP3V0p1n2May+5AbJKOpVKc2aSh8n
         Vs2ZA7M6Ez5YLNzzruzOx5mMmVgE9wyLV3O1U6y66qUTXw4bgJN+4Txvz1NnjoJnR2Xs
         qtIyT22SlgFKDFVsdkcmGf43Jd0dxBDiEQmos88ZB3y924NZkABvMDyoZXGwCwACEaJU
         qBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872197; x=1775476997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+c+wp6lYqHlPGMdt+a3t3fT0eXuCeYj5fFyxz3577M=;
        b=sQTEw/1VoPwkm+Yd7cbt5Yk12qG8Q1dOt9D3jBJz6Rjz4SgZSYrF2Qg1I1iQUel15i
         oyjYuiVvNaT1g/9lOkegAAYOBS4e4aMxN+L64W+tx40pOC9Q3AVNkor0AbmSFDGguz96
         RZZLuZ66Jjxje/j7mpcijWum/Q+pm0H2YDDahZtLhVNzs04dN1/A+bofBaNIqh4CcC1u
         AT96mmTk6yE/m4bm1AeXlFYG2Zx037U23rdb8R9kFZpy4sqlxU3DVWd3uGNqiNnQNAwU
         uNYwtdeF62B8AwZKcHMNXRnegbf7S5733C1FGoGzB5S+BPDLIq6MP6sko5K5XM1AaD3R
         kqsw==
X-Forwarded-Encrypted: i=1; AJvYcCXwOAv29Msx0tkM23ksEa8JfWXtRiM1YqCXf60cS0Kao/D6TIuZsEvYgdP1WZD9epHYPtBr1BQkiLsc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7m6rFLMYy3mbqWAFWcok8kHjn2b4mLAZmQCuUDGzNcbvO470n
	WmC0Pcfx/YEUIggxUv0QyL1xZMpr+2Kou27TxQFcE/vMXoBFv+HzEdlxlJdSDC8tJezc3nu9AZG
	y1E9mpd1LmxszVmehJ93giTj5OmZypPG9bf6aUlKdTgSxE5CM3hoxgRcqexgfZQi4p1kakjQ0Zw
	lX4eb1TUFkFy9ZuYTlbpKVnEnVPiXEE19V4wA2moJwXHz7UQ==
X-Gm-Gg: ATEYQzyiD52qkuj81UMG9i0GWw4VYe9y8rxfFZvuD5Igbhfdmdyr3l6Snow8DU79Ik6
	TC/hC8eNrRVSLQ2S/xNvN2gqb9Ft+9l8JgcDBWaTPCJiun0BNZ0C5gcL7wpvPtZ2HTIH5MlVgkP
	q3yhXrWcWW+YYOKVAszdFEKCcBZyfVAn+f6kHufQrNQlCmDta6VH0ZCqUYODDjmLgYq5uuKjRnY
	dMhmyGmo7pT6Rl8a/IHAYll/GXN+uHj8E4fCTdcKfHgnfFJoW1NMKw2FZUXetQSkGmPIBGYM3Sy
	5eOy
X-Received: by 2002:a05:600c:8485:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48727d73642mr226867795e9.8.1774872197378;
        Mon, 30 Mar 2026 05:03:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48727d73642mr226867195e9.8.1774872196886; Mon, 30 Mar 2026
 05:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 14:03:05 +0200
X-Gm-Features: AQROBzB3DWnxPR3jSWpAVvne6HolnmzmB3FcTS64hP940Rx9hlh4ePIXuVThH7M
Message-ID: <CABgObfbyp0HXTozDZs9L45xMfAHRyqTKYKX8tQ=VQyCFTpqdLA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/10] KVM: s390: More memory management fixes for 7.0
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 4:24=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> here are a few more important fixes for the new gmap code.
> These are (hopefully) the last fixes for this release cycle
>
> please pull :)

Done, in fact they're in -rc6 already.

Thanks,

Paolo

>
> The following changes since commit 0138af2472dfdef0d56fc4697416eaa0ff2589=
bd:
>
>   Merge tag 'erofs-for-7.0-rc6-fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/xiang/erofs (2026-03-25 18:41:35 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.0-2
>
> for you to fetch changes up to 0a28e06575b3f3b30c1e99fc08fa0907956f35a4:
>
>   KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl (2026-03-26 16:12:38 +0100)
>
> ----------------------------------------------------------------
> KVM: s390: More memory management fixes
>
> Lots of small and not-so-small fixes for the newly rewritten gmap,
> mostly affecting the handling of nested guests.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (10):
>       KVM: s390: vsie: Fix dat_split_ste()
>       KVM: s390: Remove non-atomic dat_crstep_xchg()
>       KVM: s390: vsie: Fix check for pre-existing shadow mapping
>       KVM: s390: Fix gmap_link()
>       KVM: s390: Correctly handle guest mappings without struct page
>       KVM: s390: vsie: Fix nested guest memory shadowing
>       KVM: s390: vsie: Fix refcount overflow for shadow gmaps
>       KVM: s390: vsie: Fix unshadowing while shadowing
>       KVM: s390: vsie: Fix guest page tables protection
>       KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
>
>  arch/s390/kvm/dat.c      | 100 +++++------------------------
>  arch/s390/kvm/dat.h      |  23 +++----
>  arch/s390/kvm/gaccess.c  |  71 +++++++++++++++------
>  arch/s390/kvm/gmap.c     | 160 +++++++++++++++++++++++++++++++++--------=
------
>  arch/s390/kvm/gmap.h     |  33 ++++++----
>  arch/s390/kvm/kvm-s390.c |  18 +++++-
>  arch/s390/kvm/vsie.c     |   4 +-
>  7 files changed, 231 insertions(+), 178 deletions(-)
>

