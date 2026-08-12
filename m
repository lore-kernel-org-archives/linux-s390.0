Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94F379C5E
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563556; cv=none; b=qxhhsDhCxeFvWgTnisH4hLl5PEwafkiugL+g5G4j+ZGKvErrgk9XMqbDPx+830rccfEQEjMHi11IduXvovG92q+EaooHObTLwKCgYble2F434epfxYj41TODVTrVYn/1yWUYaV8FApvt44GQIK/pOqeg3dSOXqoFeUwPclC5cLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563556; c=relaxed/simple;
	bh=Jxlbn2kEWy8HeStc6KfR7KYADvRNrzF0gC1nZSpv45U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QyteI9IhtaWPuAOgSRx47ORrLzrV/5PaM2xrpFC8tEhSzlKj5LAOQiJbElCDGWXbfESbEhZAehhFVpCriy+u9FbqreTUK4/H4akok5z7kgf54Ah1LepQGBB98BH4apspOM3zvKG/Yg4ZLlWXqZwDtfh89Ebok6GP5BxNdes1VGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXZPoOqt; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXZPoOqt"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so1835460b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786563555; x=1787168355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3na27S9dvXCrzn4sNrcA7VrHo71pojsv2T9Iii/MivQ=;
        b=QXZPoOqtubgqsJHZfVk0gMyVIUOqNioA8ZngJLYTXhuPzKZnuqi+10mD1o3zTIr01M
         fuIjODcJW5vc9Tdm7TlbJwwXPezw8BslVqvU1m5/NHIPIbmhhIRPfrIweE+31RWTVuNS
         NI6Btd02gxGL5oNAha6ErjppSnk3h+uYsuyqmFvjlZ+/kRTeYWVWIY1uNovsth2npA4w
         DM81DYd2u+9FwzBSyLZPQ6Xdd0xYoos9xrWh3020VJWL/DXZm6wbKbmvalRIZmh+SZWL
         HJJgkj1c0k01nw5zYA/zPUBll19jyNEFQ5v8QssWUMEvJFQ23YrbdkAhbAva3GiqPmy2
         eGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563555; x=1787168355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3na27S9dvXCrzn4sNrcA7VrHo71pojsv2T9Iii/MivQ=;
        b=AhcGw1zAMExFWtum4+n5z5g8FVJxFh6D0DphCASinA3oc8Wp0F5fd4u0M+ERa19OlP
         sysFIpKtKIyyLZOfpCgW1vddCcLfHR+oJPFYRXsaHGB5hUbd2XlhKXzaaCpBcifJHTV2
         7UzdA73jerOAKVUFy7ZLYFzeF/YmPO2c7P1/8UQawEoe75PdEgtf0hgnkVOb0yVizCsR
         dkB598/088voiF/fMNc1eJ0u1bcgdSLSVAAaX6Kq/PdaHLoTcUproSaJJfFFQ379kTo+
         wyD8Z76vPPwvT5fn7gC9UUBeiV/PlbfLWVdnfMMnOWThKTndFnEaKGR9Sfgq3bUoS1nX
         Po8w==
X-Forwarded-Encrypted: i=1; AHgh+Rp42MbKgG3T1+sORrtBymZyk0SwJuYiqVbmF+x6iK/0jQ3jYPNisxBbYWYNDxcb03ADzk87W9D6nCWR@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhPQUgzjWBE5XbHjKNJjMDxpo6Zsllyb3fkuJnAdOUBKxRG1T
	uzsJ2UKbwSSm06/3X/LPVrM7wS/k26m6dpf7dh7eGGvBdr1jYPpGcRTDEmHB/9O+K16El/mNKzN
	s5+09mQ==
X-Received: from pgbr17.prod.google.com ([2002:a63:5d11:0:b0:c9e:a22d:15c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc8:b0:845:e41f:9696
 with SMTP id d2e1a72fcca58-84fc75f438fmr176338b3a.25.1786563554512; Wed, 12
 Aug 2026 12:39:14 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:39:13 -0700
In-Reply-To: <20260812192319.BF41B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com> <20260812192319.BF41B1F000E9@smtp.kernel.org>
Message-ID: <anzL4YiN7QozkrN9@google.com>
Subject: Re: [PATCH] vfio: Use file-based reference counting for KVM
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steffen Eiden <seiden@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org, 
	Christian Borntraeger <borntraeger@linux.ibm.vom>, Vasily Gorbik <gor@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 12, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > index 7e8195a311bb0..98f133e4f0b32 100644
> > --- a/arch/x86/kvm/mmu/page_track.c
> > +++ b/arch/x86/kvm/mmu/page_track.c
> > @@ -237,10 +237,11 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
> 
> [Severity: High]
> This is a pre-existing issue, but does kvm_enable_external_write_tracking()
> need to hold srcu_read_lock(&kvm->srcu) when iterating over the memslots
> array?
> 
> Looking at the function, it retrieves and iterates over the memslots array
> while only holding the slots_arch_lock mutex:
> 
> mutex_lock(&kvm->slots_arch_lock);
> ...
> for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>     slots = __kvm_memslots(kvm, i);
>     kvm_for_each_memslot(slot, bkt, slots) {
>         r = kvm_page_track_write_tracking_alloc(slot);
>         if (r)
>             goto out_unlock;
>     }
> }
> 
> Without holding srcu_read_lock(&kvm->srcu) or the writer-side slots_lock,
> could a concurrent memslot update swap and free the memslots array while
> the loop is traversing it, causing a use-after-free?

No, because the part of kvm_swap_active_memslots() that performs the actual swap
runs with slots_arch_lock held.  
