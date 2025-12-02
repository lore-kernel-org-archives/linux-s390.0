Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D32C0F96
	for <linux-s390@vger.kernel.org>; Tue,  2 Dec 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697180; cv=none; b=i4Vzd4thfqBCDywKRw0MdMFoK3vidanMj0vRTLxRXy6LObrhHV+1O8dW3wPzUDh6msoph3ff2XyaUEwSEjvXJ3EXN3zwAD/Axu+0t08NP8h+aZ1zNwAR4S0YC4phPV8OGAOsXro30QX0dssZjvNn7F6wC1tZNhZKj8EezYPL8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697180; c=relaxed/simple;
	bh=oInRkGJiJ2P6Yt6xSBvvIBIikMUAG2Q4J8//1n5jS60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtUtlFmFDIFAfSgu6/4UHMycuOkEhvSEnY2zuB7Vjar9WA7LCaq7JBpHZXDOsA0qq5utga4dbBfEJ+uIF4FYHlLprk6nP89Tk73dDLWSkdkIyiPsR7y1rx6b5HQNysi8nSOi5Y2iCQ5bZP3J1OwpPiQAmOWXHaP3Ee0q6jdc+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ3JfVab; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=myG1ZaFt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ3JfVab";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="myG1ZaFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764697177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo2vKek2jWqEfIF/rtdHvm9y4Cw5ZkqAU8NTL1Lxbs8=;
	b=MQ3JfVabftf0AhgR6/duYbcerK7L/HBIhTQgaHaudfiiAEt89fHqRb059e6dnXjlFYG/Nw
	bInHjKszH0N4hiTvQocWMys0jv7PhDvqX9QJCbLgoqH5IaBhqqwU7rWXmEyFq66jjYbZAb
	K2XzVq5oVVBF8UQisb02Uf0zoJG9pUA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-m5h3X_TqMnqWPv3dPtAvRw-1; Tue, 02 Dec 2025 12:39:34 -0500
X-MC-Unique: m5h3X_TqMnqWPv3dPtAvRw-1
X-Mimecast-MFC-AGG-ID: m5h3X_TqMnqWPv3dPtAvRw_1764697173
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad29140so2850560f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Dec 2025 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764697173; x=1765301973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo2vKek2jWqEfIF/rtdHvm9y4Cw5ZkqAU8NTL1Lxbs8=;
        b=myG1ZaFtBb2tZPP5S3GxWOaCfu2Fp+i44+wZ6UK5aueXr5i/q3mUrsFAndGSTFdTqB
         SWadKdTdgCR3mMA9qqcklUzLEMyh7Eso9But7UFSGB5cYY5vmSrWMwE4KwghPGb7lcNW
         jpxxQzVCqXu1XbzHFuFbMgkntlmyPeVh8h/ix/ZFpDK9DS8Sn2UkhMFiYQ+yL6rrnk/g
         Uv7ymvX+mWnZGw021yCiQUjU4WufY58/G2cPAmSE4Z1pzIJdL3Xz46U7tbkScfp3rLao
         aSGODySIZTQOOjRM8lbKp+LpHumL+lxr+naStWi562/5BP/oRZT8Pqz71KFE35nQcxWa
         cMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697173; x=1765301973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uo2vKek2jWqEfIF/rtdHvm9y4Cw5ZkqAU8NTL1Lxbs8=;
        b=Jf36mYxO8KcunpCDiEdN+d3weroe+hVqhav7sjLp1E6gombp95FX/J487QzLJOQTFD
         w0+oEU6KLHv1OF19tL+D+4LWd6KLY5VilrUUk62S3WF+2XVoycLur1VJLW9qW6u4ja9Q
         HEKbJYykOMtNGrEArYnyuMsUYR3KMWscuf1azIzfdlRZJxCZK9KxO8FWNgxYDaWskopR
         BjWwXuV8gYYOK5WkDHUrZWcdT5Ju5P/hCn5mfW27GHuJfXs40b9pPXD403ZV4m0yeOkY
         qFbfWtGOVSYZEuQhjPSwk/IbbIHQq3xzimfiTenxJWxrJJPjD23QrV5y5Q2nJGBNA+wb
         5fpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ql2P3voIfS7Lxstf8ZNPmpG0g/EBAPhtKPfxRSIX8Q4s8sJwXHrZvbcN/5KACs1LWxA6x0iAsymm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6wT8DM11SJB8jZ71fdLnj9yFmk/8+3ccWfvmxGHfJC3b9hr3
	Cy1fP+hZVv92XXqBOuHqbfb37xGdMRQxCPFm6sn4Esa+yGSVpsCVLwH63sQT3wSq0fLmCT0Y18L
	d82K4SMdgKishtfJdpLi2FtYPO2LzggVxQW0AafJtHUzVhHFvpWmtE8Fn6DKLbiWzJmKZ+zXehC
	c5ik2yAD/mg7sxDYq5SR1cQDhkNkUZKWr+529nTg==
X-Gm-Gg: ASbGncuFYDXj5gtfDXclX2qh8rgszrhTL7/btNgvkr0RWIPcsunIY07XDqWeayTS9G4
	l+D7NTvp01zzEkR4MVjoJFs6SnaAJAjXTuiCH8pydlK+uBDJvbUovVF0rMZDAXiFgPpRX450u+Z
	QEGD8iobex3a+cOKRaAJbU43zrKcKXACVgN9xazD9k86SCAk7/kau1Wj357Uu0LPslSYUSliDwC
	fZpyQV8t3vynYCQyJSDn5DYfqeHx012E70JdBtfxmS2tYaHl0IcK7I8LDBVUSilu+BTuwI=
X-Received: by 2002:a5d:5848:0:b0:427:8c85:a4ac with SMTP id ffacd0b85a97d-42cc1d0c9d6mr47265260f8f.47.1764697172692;
        Tue, 02 Dec 2025 09:39:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnNIloFvxiRUn+fYrIxvCBSBE79k+FBv1YJFndwydrDPdofVuZxX6cMXMrJsUx2ak1P6rmZDLHt9YSXMBuB50=
X-Received: by 2002:a5d:5848:0:b0:427:8c85:a4ac with SMTP id
 ffacd0b85a97d-42cc1d0c9d6mr47265227f8f.47.1764697172220; Tue, 02 Dec 2025
 09:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201124334.110483-1-frankja@linux.ibm.com>
In-Reply-To: <20251201124334.110483-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Dec 2025 18:39:19 +0100
X-Gm-Features: AWmQ_bnfBNG38_ENciLUbvBKRtiiVX_KXI-I92nNeDJP9V2a5Q0LIpEicEzHXKM
Message-ID: <CABgObfZ2Am9dDJdNUDz2yLif6Z_wqLVdv41HYbWRmb4Jo+EBeg@mail.gmail.com>
Subject: Re: [GIT PULL 00/10] KVM: s390: Changes for v6.19
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 1:45=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> Hi Paolo,
>
> here are the s390 changes for 6.19:
> - SCA rework
> - VIRT_XFER_TO_GUEST_WORK support
> - Operation exception forwarding support
> - Cleanups
>
>
> The operation exception forward patch had a conflict because of
> capability numbering. The VIRT_XFER_TO_GUEST_WORK may or may not have
> a conflict with the s390 repo because the kvm-s390.c imports are
> changed in close proximity. Both conflicts are trivial and the
> resolution for the capability numbering is already in next.

All good, I gave you 246 as in linux-next.

Paolo

>
> Please pull.
>
> Cheers,
> Janosch
>
> The following changes since commit 211ddde0823f1442e4ad052a2f30f050145cca=
da:
>
>   Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.19-1
>
> for you to fetch changes up to 2bd1337a1295e012e60008ee21a64375e5234e12:
>
>   KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions (2025-11-28 10=
:11:14 +0100)
>
> ----------------------------------------------------------------
> - SCA rework
> - VIRT_XFER_TO_GUEST_WORK support
> - Operation exception forwarding support
> - Cleanups
> ----------------------------------------------------------------
> Andrew Donnellan (2):
>       KVM: s390: Add signal_exits counter
>       KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions
>
> Christoph Schlameuss (2):
>       KVM: s390: Use ESCA instead of BSCA at VM init
>       KVM: S390: Remove sca_lock
>
> Eric Farman (1):
>       KVM: s390: vsie: Check alignment of BSCA header
>
> Heiko Carstens (1):
>       KVM: s390: Enable and disable interrupts in entry code
>
> Janosch Frank (2):
>       Documentation: kvm: Fix ordering
>       KVM: s390: Add capability that forwards operation exceptions
>
> Josephine Pfeiffer (1):
>       KVM: s390: Replace sprintf with snprintf for buffer safety
>
> Thorsten Blum (1):
>       KVM: s390: Remove unused return variable in kvm_arch_vcpu_ioctl_set=
_fpu
>
>  Documentation/virt/kvm/api.rst                   |  19 ++++++++-
>  arch/s390/include/asm/kvm_host.h                 |   8 ++--
>  arch/s390/include/asm/stacktrace.h               |   1 +
>  arch/s390/kernel/asm-offsets.c                   |   1 +
>  arch/s390/kernel/entry.S                         |   2 +
>  arch/s390/kvm/Kconfig                            |   1 +
>  arch/s390/kvm/gaccess.c                          |  27 +++---------
>  arch/s390/kvm/intercept.c                        |   3 ++
>  arch/s390/kvm/interrupt.c                        |  80 ++++++++---------=
------------------
>  arch/s390/kvm/kvm-s390.c                         | 229 +++++++++++++++++=
++++++++++-----------------------------------------------------------------=
-------
>  arch/s390/kvm/kvm-s390.h                         |   9 +---
>  arch/s390/kvm/vsie.c                             |  20 ++++++---
>  include/uapi/linux/kvm.h                         |   1 +
>  tools/testing/selftests/kvm/Makefile.kvm         |   1 +
>  tools/testing/selftests/kvm/s390/user_operexec.c | 140 +++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++
>  15 files changed, 271 insertions(+), 271 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/s390/user_operexec.c
>
> --
> 2.52.0
>

