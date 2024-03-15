Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E618E2A
	for <linux-s390@vger.kernel.org>; Fri, 15 Mar 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498554; cv=none; b=HowEkvlWeGbCLrPSjcfRGZBXFnGRvgMuuXFwGBzuAQt1gHsLUwJAv8hItMVNAahNLHYeFTrifK63XJeQuCOo9taQ9qhKhKr0T3bCg/s8ZFKoU/mFR+qMHWovRp7SvMi3TVd7qGeaXI+WGu3lJf3Nd8CO4xTAdqHZnwahlbiL1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498554; c=relaxed/simple;
	bh=WjtDLSxpesB0ZqjiaU1pcR2XZxE+SssNvSi40zWY64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOeIoAJPbL8J/PDJ4izoqb2/ZuNsCbkJw25wuMIdt9Thp4+E+bF6IcqSMsfObkZE4RI4efixlmjFgtAzw9mlB62RuEy2sSVW8b1d+hJEUkNhHgKriM6fQp8K9IYcmIC0pouYRK5B02KrYgthii+1DDlJ6lYEk+NDKXJSh6wD4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dk1mQzM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk1mQzM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710498550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LzVKYzDeMlNU7muM18EJurw+KHPOsJVd6gjVHme+u4=;
	b=dk1mQzM7BoInPg8nQfUAp9O8EG+xMsgE3SJtdTdYfRwI4SGuHF8vRVxzdKyFnhAUwotNGS
	VuqasmZkE+ICqMVUFitq7uOQzavFzhS0OPorNQp855dynZS4nxOKCulfqOmEQY7Iqc2ff7
	vS6ng9HJeFr5+/fhk4W4YYNsD2Flrdg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VHlg5kOLOJ2DiH1duq5DQA-1; Fri, 15 Mar 2024 06:29:09 -0400
X-MC-Unique: VHlg5kOLOJ2DiH1duq5DQA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed489edcaso214511f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 15 Mar 2024 03:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710498548; x=1711103348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LzVKYzDeMlNU7muM18EJurw+KHPOsJVd6gjVHme+u4=;
        b=Opk5Oztfv9j7G0bMHy752pM19asofzaR7K01gKuHy9N2lvDbAxUvZpJqzEKtyG5ACl
         9WXkRXVJxyO4vc3F2ns8oZWf+3fZzGeicoFdeSzWLuXDMEgeWOU7nBf+p0qWFBkHpVI+
         CXUw2BEfazHiFJvYbIA9++Ohibhgq9sB+Ho89mAHEW5DSweSeV6gO3GXk5w/KTxu0Nja
         tafRgfIklr5iFaroaD37idaDscctJ2Kw3pN6BXyjlDhNxMqvAZMhGZB24/w8bs/6Cqr8
         GySiEXD4eK0EhBo1hbUWYa/rLzoJ+MGnaN7EqYwpOOhasNOU/+xmJs4R/cdojbF013Vl
         n70w==
X-Forwarded-Encrypted: i=1; AJvYcCXBuqFaufL+IJchDBuGtsECK7uJWiVwz8C6YFC1xGhMGrjaAedNEK6R/CSLJTCLSdlaia8QgC4hVzao/yMDLQKA4ZVbuE6N16tUJg==
X-Gm-Message-State: AOJu0Yygv+jJHoMzHuk4gcI1DoJ3N4zGKNxK8C4GSNsqqHppGnB0HXQG
	VntgpJOcSeztpxjkzKw+797oEZLuqsx84wzZMGU48Kf5rQEfNZvhW3DHIXxri/tX7KOwhebEeKq
	V9uPJTz9OTfK5T/FsGCWG7katiZYEp+9JmUNSlYSVA0odhWJdbSYeZZmjDdIzZZhSIvNojoweqr
	bKkPpexDXfnG2wu/1sP64Mr1ayd75OfEmusA==
X-Received: by 2002:a05:6000:ecc:b0:33d:365a:64ce with SMTP id ea12-20020a0560000ecc00b0033d365a64cemr3514068wrb.34.1710498548155;
        Fri, 15 Mar 2024 03:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3IXpQwWRJk68QeroZGtOynXZQtN41Q8sdLnkfZ9rvuAhejnc7cGVhIoVWUvJFb9WshmjTEyYsi418JuDiY9c=
X-Received: by 2002:a05:6000:ecc:b0:33d:365a:64ce with SMTP id
 ea12-20020a0560000ecc00b0033d365a64cemr3514046wrb.34.1710498547787; Fri, 15
 Mar 2024 03:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226122059.58099-1-frankja@linux.ibm.com>
In-Reply-To: <20240226122059.58099-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Mar 2024 11:28:54 +0100
Message-ID: <CABgObfZA_=W1GoKaQ-OW05rfJAcxf3N5wC=Jj1bn6m3J9QNw+Q@mail.gmail.com>
Subject: Re: [GIT PULL 0/3] KVM: s390: Changes for 6.9
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, 
	seiden@linux.ibm.com, nsg@linux.ibm.com, farman@linux.ibm.com, 
	agordeev@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:24=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> Paolo,
>
> please pull the 3 fixes that I've held on to as they were very low priori=
ty:
> - Memop selftest rotate fix
> - SCLP event bits over indication fix
> - Missing virt_to_phys for the CRYCB fix
>
>
> Attention:
> Three additional patches will go over the main s390 repository since
> Heiko made changes to the FPU handling that caused a conflict with KVM
> but we didn't want to create a feature branch.

Pulled, thanks.

Paolo

> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=3Df=
or-next
>
> - KVM: s390: fix access register usage in ioctls
> - KVM: s390: selftests: memop: add a simple AR test
> - KVM: s390: introduce kvm_s390_fpu_(store|load)
>
>
> Cheers,
> Janosch
>
>
> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1d=
d3:
>
>   Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.9-1
>
> for you to fetch changes up to 00de073e2420df02ac0f1a19dbfb60ff8eb198be:
>
>   KVM: s390: selftest: memop: Fix undefined behavior (2024-02-23 14:02:27=
 +0100)
>
> ----------------------------------------------------------------
> - Memop selftest rotate fix
> - SCLP event bits over indication fix
> - Missing virt_to_phys for the CRYCB fix
> ----------------------------------------------------------------
> Alexander Gordeev (1):
>       KVM: s390: fix virtual vs physical address confusion
>
> Eric Farman (1):
>       KVM: s390: only deliver the set service event bits
>
> Nina Schoetterl-Glausch (1):
>       KVM: s390: selftest: memop: Fix undefined behavior
>
>  arch/s390/kvm/interrupt.c                 | 4 ++--
>  arch/s390/kvm/kvm-s390.c                  | 2 +-
>  tools/testing/selftests/kvm/s390x/memop.c | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
>
>
>
>
> --
> 2.43.2
>

