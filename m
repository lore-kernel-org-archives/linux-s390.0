Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204F28E0
	for <linux-s390@vger.kernel.org>; Fri,  3 Apr 2026 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257936; cv=none; b=bjuGaWsdc2WEVDP7Yz2xrtNnnLVn3vvp3tKRNOHGkphEK0vQftAjAFzWVfEwYR859dvHPARhNE1A2vvnEiyAw6sS0goMzADC0uYEQLwaMbxvjjtl5ngRzUKhEh3VvOP/DlgcG0zpCEwXVj207YN6teMEwCqomfcmFk+X5u1rP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257936; c=relaxed/simple;
	bh=3WA9M4W76ecRe2C4Jnp8JN6QasjMyK6QvZXBaPxQ0xY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxwT89yLsJQbQAN22MGQ1ye43CgMokzo6SOZOjl24HO8yWxwy9LYasHBx2eCyAYnw5111AaA5FudRllZ9jXIQCUFEbuHPUyX+TsSY8tzMnIUTSAUeW1TA0uuNpJ35GKJVGWNSr/fMm3dTw8LcxiIu/IsBrZji2dajwqFkUiQDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsw/IhiR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsw/IhiR"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ca8323edbso3264661b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2026 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775257935; x=1775862735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdgYiNCpCVITKt4WdfY63SIPUYiDMIfHM1afvBz0ai8=;
        b=rsw/IhiROOJ9nBPns6oBdS2gj6QhLqU1BgRbQvNmld95og8g3HqykF+Wy53G4o/adz
         /QNfJkxJhZYnzJWLjqF98Qag4Zi2WD/AJVe0xe7NlCKcMiOEl22ZELzLl42fzOXLgaG+
         ihA0GBIt3JsMpM/ZY/mdFM4TXhY5Eq0kTCSIE70KsbBqRh5zGhcqlIj2NZCOTK200Qt7
         Vs4BWf+Zux1GvgDK2VuV2gTkxp0s6aov96CtUdk19fHS3f2GFREnvEcavWYn3gdbdbY8
         5Nn1uZGTMzh5RHo45ndSvkPzp5v0C0wRnkpiWp70qy/e7ZUJxyQUnLXOl3QaldcyK/pL
         eWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257935; x=1775862735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdgYiNCpCVITKt4WdfY63SIPUYiDMIfHM1afvBz0ai8=;
        b=XDwWxPIfsI4HmQPer8AfyCsbFGN0iFLyBQpKO0XcAY5QZy/RzJfxVNsV4+Ha9BRsvS
         LYV2OIDD22x9673LY6PRP2IW4yosuy6bUHYRO9VAfBE/nWA9QXtfLn3+fYl03ykJzni/
         5UbLqvl/MyVf0IZUUkJzWSS6/ZNff1H8c3d2GZ4U8gtLyPUPmRcQbYUC2k3FOHlrDyWq
         z+51I+rzT16Vwfv6bIloH7dDpRJcXnoOHEwxz9HaM4NW8SWOtL4KuVnKAk4+VclXg2Hz
         +rwDf0xNMlWQsEYn2Bluc1rclyCUU0aPSGR/dSuVAuUWt92WtUZibm1zk17Zk43jE4f6
         m4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXmvhEt7chASFxzFOma5jIop7lGsvdj9ehTTWkclnNaE4IarAh6bDdAfdIJPSfRHm3DOE4x2/zhoAas@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFaFFtt4/Uu6BGTIvXhNcMf+8XG6HnFuUDjCc8X6GOxAHlIAC
	17ah2rGnSzIs4l0p+llyH2FcnrMmtwGvFl0AaJd9eU10fp2BUgqFVyB4v9amPYPHBIUOTAPDNxC
	oc0qbRA==
X-Received: from pfmu23.prod.google.com ([2002:aa7:8397:0:b0:829:7ce4:7fcc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac82:b0:82c:daa4:ce2b
 with SMTP id d2e1a72fcca58-82d0dbcfa01mr4616677b3a.49.1775257934902; Fri, 03
 Apr 2026 16:12:14 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:12:13 -0700
In-Reply-To: <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local> <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
Message-ID: <adBJTXeE6G2vQNKX@google.com>
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
From: Sean Christopherson <seanjc@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 20, 2026, Baolin Wang wrote:
> > > -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> > > -						unsigned long start,
> > > -						unsigned long end,
> > > -						gfn_handler_t handler,
> > > -						bool flush_on_ret)
> > > +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > +					      unsigned long start,
> > > +					      unsigned long end,
> > > +					      gfn_handler_t handler,
> > > +					      bool flush_on_ret)
> > 
> > Can we please fix this terrrible indentation while we're here :)?
> > 
> > static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > 		unsigned long start, unsigned long end, gfn_handler_t handler,
> > 		bool flush_on_ret)
> > 
> > Would be nicer, thanks!

No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
find mm's style much harder to parse).
