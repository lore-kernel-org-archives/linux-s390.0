Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD41DE8AF
	for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370000; cv=pass; b=dojzxJ6WqQ+sS2houX2nXRmXUvjcEjQqc4X0elOdyp5C7/9ai55GrmQopoizwUhIlvicGZEMEuEZo7dnwNjEsVfNIK12LQDeA5CW+40qn+qSmKfo2iKs25Wno0E3xvQTtEpipnnzmxor0I4Y2whyWs6Zr4IhvtL3LQ3fCRsSBbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370000; c=relaxed/simple;
	bh=f8Ji74zBMWp6udWNbOhWV7NgkcEJmCbPsz3CzFk1gmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjX8khJI7EwPw/t41gb9n3i+9mW1dFPLSy/49CEKQhZkmyQDsdwZfthOjpN8eIDP0wSUE0T83NE7NcI2saGToL3rEunzeDOjyXgMBZ5Gdt7y8zVgydrIIL0eq1c+EysZBSmQ2Oy6H8zCvFwSKw5Hk3yF76vbsDH6aEbZ+dKuvcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSyl/h2h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFFW4Zpc; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSyl/h2h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFFW4Zpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
	b=OSyl/h2hHQ+0OngvsDDKuTT030Qz7o1SOuleeXP5SbQ1arYD5rydiwmSWBbHjM8RYJnieq
	oyAOtz1MPJ3UFrST+ibmAslp5Jorkf7xJUhNunHFXk820d2Ugt7xaOGSP8CzdZEsP9bokU
	UfKc3o0pWffwEkWfqaE2NBGlVp2dr6w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-6IAxLM8LPz27pHKDRljdrQ-1; Tue, 24 Mar 2026 12:33:17 -0400
X-MC-Unique: 6IAxLM8LPz27pHKDRljdrQ-1
X-Mimecast-MFC-AGG-ID: 6IAxLM8LPz27pHKDRljdrQ_1774369996
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439af7ba802so4047096f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2026 09:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369996; cv=none;
        d=google.com; s=arc-20240605;
        b=Xzcu0CDXDxOg45ZsvV2xK6jquF/xFOFIFN+jsokChnsJMWpwC1sJpUcLUOm4xlfF8y
         VNGcHeW/ZvbYEISZb/gIwTqXJbnobbuB8amTcYUl+qZTL4YnJxKy1wN/7vy7ZSGkXZEN
         D3PcZPzhx3Y2j64Naz7M8NKl2o22EOxm98cXV5ET6H4Gu5u4syXy06LJRkDkgvEjouY5
         qllB38RHGmoamAGhJQOz3PYPKVwrNb+/3BNvhIRHh+fS+izpqQYGNw7b3HrIhLMgfjlF
         TEcTw60OBBPFQxfzK73JpY4ujAsdQNHBiKUaIm1hoSUOkHFF3NH7b6t8lfThklOIpcyu
         TaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        fh=yn7TZa+IDFpqyM2m7I9kxjLHHNd9jg6ljFBOOkhCw8M=;
        b=khOoDhB3LPUOwnhYeBMFcOt9oj7swuNcIbNuFZGsI+PGZC+Y9BH0nhSKwOzmZP1V0R
         udhk5nXBZtGxxUzod/NSBgRUvu0wxhMoFfVUp3ZUOrgl3WLTnqDKXsJz2728HGLTgEfV
         ygl4ueUl8yI7pbEymDfq4OoP8GYz3EYl5swN7eSGN0Cg4x55DdA2cv3CYyVItBA8PJvS
         mkqc98LCbAN1tyF+OUWcNv//c9KOkzSNTTwvxdzRx8D2KpK02mJq7XF4J9XMGPbSvPmM
         u5smatZQoFO630hOVyQ9NaqdJDNiSMEwQHnV4kQGcY5pnT18driTs6UNbWTmKhOJnKjR
         T5qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774369996; x=1774974796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        b=HFFW4ZpcobTN0MP4SZpxTWBymR25dDdDCetkdKTiNHe3W+k5WGtR+gjiq2aZeL5ag+
         5yGDZGw/UsG8LGsLBl7PjQyE+5xiswrMeYjKdql1r47NA8buDVkyNv9wX6gWkYAosrCH
         vav3uFpMXLikaDYpCE77OU3ng4C/q44cLXzaU8eYRswMgZ7nR6hjDABNJM/tOxNaG/b3
         SdDcmEw44G2b+HC7WIX70hKIpCHupFLyUJeT9u6oKcRQg9mb2WEKVnXy/+Tb6s6Uz+x5
         QSgBQlP6p4lf2UtgfhQGqRxqPYyZ5t33CrIaa918gM7U8WWCtRyIP+NvTe91gY8GNi5S
         nNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369996; x=1774974796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        b=PEARqVKcnr99xIdig5PNiSwr9S9XN2BdkbK5BF1wAqNBRIu0HQ1Qzxf1YwOj3EDMpI
         KsIkiJ+uG19FHUyowf2atca9Mwm1yy71K+B877dmnGhhQjEIqOtCPxTuJNbwru3xKgx5
         S6rTyiRDXeuMa6kl4Yuf0uHJLvZNwSAnuWDW2gLjnuGpja0lS5DQWwignNptbVPGezTz
         7fbgqIl8RDasWmt1pMAwJwkIbGzDufhr/oBgGqESMLDsvty3t09k8es0RbVzDCqWm12C
         1FZFBkBuS63Z83ASdXTU4xumMlch6+k//uko3RaVGmrf7F1oEPifxMB1knJnASVEQpxS
         9qig==
X-Forwarded-Encrypted: i=1; AJvYcCVv8hvwcwKaTaqzYoWUtCe4/XdNGdt52IQZ59Tw//W7SarXPgwz1vQWCsK3vAyg0/DRp7Ahl0R5ILIq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nvsU8Jbvcp2QTIvlBX0bmJq54pW55b8aEorKKZlRItOf8c9n
	qFHrF39ajWaWqpVIoOB3Az9M5BcsSXZffgkBAr9jjFyk66HNrvDfzJOelTcTs53GvvOaRpv+ykP
	2LnEIhCx0W1PuCiXu0NjjIWC2miCR5ACoY/kY5iQrLNNHAMIO67tSL9RYepESD0b57qwKoxD4MI
	hkpzztqO/m0TwgPxocboa2xrqEV7fJTNibtvNIrw==
X-Gm-Gg: ATEYQzw+Wc/4dCWTSC6ToUXoFvuSiNSHQFKrqC9P+XtQ8kUVipsb1tQogtEogJY5NT+
	6UnAq9OcTgm6hMMQNbYj0uv8FIh12HHBM1yykBZ7DfvGWZ/LSFZJ5dT/eQmO3szSr3rjv4Z2AKn
	OhpE84t1AJwb4LN0xFMHkyPcfoa9VRHI36MtehsVtGqf71ORTMAmO1UO1K6mwCUXjSFirP9eS2i
	KXlSgWqlHmuynwQ5WGhzUSlNx8lOh/7bDDkdn+zrhI7ed7+d+8dJ02qpWdiGgJ67KeaZof3A3Sk
	sBje
X-Received: by 2002:a05:6000:2dc8:b0:43b:858e:6671 with SMTP id ffacd0b85a97d-43b889a8610mr204810f8f.14.1774369995765;
        Tue, 24 Mar 2026 09:33:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc8:b0:43b:858e:6671 with SMTP id
 ffacd0b85a97d-43b889a8610mr204749f8f.14.1774369995191; Tue, 24 Mar 2026
 09:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Mar 2026 17:33:03 +0100
X-Gm-Features: AQROBzA1L__5aTEPd45Ki0-lV24sXxU80G6inVcjaebTlAu2Vx9NevHsgIwhzUQ
Message-ID: <CABgObfaNi7Ocd2CE94TpcDL1pT7udpaWXym2x0eeK7HAcNN6nw@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes for 7.0
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:06=E2=80=AFAM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> Paolo,
>
> here are some fixes for kvm/master. Also with a first fix for the memory
> rework, but we know there will be some more before the 7.0 release. Stay
> tuned.
>
> The following changes since commit 5ee8dbf54602dc340d6235b1d6aa17c0f283f4=
8c:
>
>   Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsver=
ity/linux (2026-03-05 11:52:03 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.0-1
>
> for you to fetch changes up to ab5119735e984f6b724ef1b699c01479949ed1de:
>
>   KVM: s390: vsie: Avoid injecting machine check on signal (2026-03-16 16=
:56:39 +0100)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: Fixes for 7.0
>
> - fix deadlock in new memory management
> - handle kernel faults on donated memory properly
> - fix bounds checking for irq routing + selftest
> - fix invalid machine checks + logging
>
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: log machine checks more aggressively
>       KVM: s390: vsie: Avoid injecting machine check on signal
>
> Claudio Imbrenda (1):
>       KVM: s390: Fix a deadlock
>
> Janosch Frank (3):
>       s390/mm: Add missing secure storage access fixups for donated memor=
y
>       KVM: s390: Limit adapter indicator access to mapped page
>       KVM: s390: selftests: Add IRQ routing address offset tests
>
>  arch/s390/include/asm/kvm_host.h               |  3 ++
>  arch/s390/include/asm/stacktrace.h             |  2 +-
>  arch/s390/kernel/asm-offsets.c                 |  2 +-
>  arch/s390/kernel/entry.S                       |  4 +-
>  arch/s390/kernel/nmi.c                         |  4 +-
>  arch/s390/kvm/gaccess.c                        |  6 ++-
>  arch/s390/kvm/interrupt.c                      | 18 +++++++
>  arch/s390/kvm/kvm-s390.c                       | 16 +++---
>  arch/s390/kvm/vsie.c                           |  8 +--
>  arch/s390/mm/fault.c                           | 11 +++-
>  tools/testing/selftests/kvm/Makefile.kvm       |  1 +
>  tools/testing/selftests/kvm/s390/irq_routing.c | 75 ++++++++++++++++++++=
++++++
>  12 files changed, 129 insertions(+), 21 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c
>

