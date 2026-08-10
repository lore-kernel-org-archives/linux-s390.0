Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA57385D75
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356334; cv=pass; b=HTNT+Emkf5OdEtoLV2TuBuXeaxhWVGD9u2J9iO3rb/48aUdwsNW0gyJUYNtFVgFp7JYn/Neulr1kU4bfXQf/2PiL+CybMvoVuOF6CCnOK81A6hLBZa00JBod+O0GU6vd0lg2zKTRJ9YcQ812NRhsRap4oNACLN3RIz1ZDeX3oSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356334; c=relaxed/simple;
	bh=4LdAx9fvvsBB7MjnkYBLZN0nPHxZGz7WnwP8m1gHhRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvHTiEipiQDxbEMF2i5ePt3w/hhiHpHo3X+DxXSc9qNC7UUR06x0PokWgZWQF2BmIqyig2qD5x7iN4WWk89vqV2IcGKXiJVbKDyMb3ct37Tw1uKFerlmSfT0MppMa9xdgWD+7gV2jbYAgErHkABtoaU/TMgPg1Kzx3fuCSHQ3dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTEa7/16; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C550Dx8Y; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTEa7/16";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C550Dx8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786356331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
	b=QTEa7/16a/7shE+b0ITk9RK4I2UZkFD36BnX5OYf+q4ndwMw2dxvVLVFTlpNn+QIGzQJHd
	pS8Yl+c3kv65tFBafIf8P+QhM0Bo+EjyCaCnSGNwWNyFzp3MxUOeTn6hqDDgvvrt1uLSpm
	d9IjhLEkDTKWZF33XedKcDFJBc/cODo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sDPyvrsCO2K6RJvjVjz3Zg-1; Mon, 10 Aug 2026 06:05:10 -0400
X-MC-Unique: sDPyvrsCO2K6RJvjVjz3Zg-1
X-Mimecast-MFC-AGG-ID: sDPyvrsCO2K6RJvjVjz3Zg_1786356309
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954a93c565so9264065e9.2
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 03:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786356309; cv=none;
        d=google.com; s=arc-20260327;
        b=VrD60s4AstXlsD0TOSYK8yi3kkfNAXgmLPjC5/L1IkVZlTZ94UKzyvj/UDQg1PT/9q
         dVyTGKAbVXo7tKWkndJEFpOaJcAFal6BvagzWWg33mkId0HT0aw0vOMgXOtkeV0Ogb2t
         GMqzDYfUijdxx9tlEa3T3mcsgNUzoSndz9EXAMn/jsI4mLV640NRJ6NMrMyHVcFVvEpG
         0wKb/pH6WJOSH8DGC0ZZ2GoTvkh2YkPqouoRQ+o6WPUmG8N306ObnjVDiF+C5TkMQv4o
         H2fUPu8KwcZ1qv1dz9xXHiTl2+xKeNUnAejW8bFsCwehxNS3EyY/Uf6AVf6us2SdAfcZ
         RCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        fh=OKp5eQZn+8aJhTYK7aK5nBL9i0Y7Uka0Xs9WKmSkZCU=;
        b=aY/qkGiTTTxC8PONiX13ezzFYB04mkL6Yuo5N1x+T/PNIdkztRNlc572Vy7SCuL18j
         JwmW9JXu8rP5cRBM3xtRcsb6Bw1aThhrLdNLXb56rFAw1NFOq7RN7omIuRRTI4kF01Sf
         fMYs3TMRKbEzrRguS0KsAy1lobh8FNcbg813fGv9Rs6WeCDkwxUQHqoF/Cd7hZgh2RBM
         wzEwe+2tVCtGprfI5T7z8lUwMhvdtDgTx6qB6CZr2yAY46HHCc4pP8EJDjSmDl2ygIo0
         Dpln+rolg2GhUJcEoTuppJuBi2K4FzYZ/R+wzbQyXtpURsNKk6TZfSsckJSuYMtGCuvh
         p1dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786356309; x=1786961109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=C550Dx8Y4F8LdeHXnN+Nag7AvjpSQKSZJigSZZ96cHQU/4uJlKENkqe3evapvfrPWy
         /Bgzihvkp04i/sbEHSMDONR1oyVL8+nFQH5ixnxdiSihyS6EArcRGJV56mV6bDgg9k4w
         6uIIYgRkr6suElCfqPTEAi4PKGRNkpV72812R7c3cyIY3wB2RSXG7xRgOAZQDZRkchIQ
         VR9XVvBbfaGDa7goWuCZgFacuejAawigokyVHlUq10v+yPIGSRcKZ/urTa+iw1dBt6x7
         UO3AiQSynCtHlZ8o9jtGKNDT/cEcFktSxu3Wka254ps0arMhAEzif2FxWaIn5AH9Lg+U
         oQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356309; x=1786961109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=clNFmiSo76pPTnPBEqh0HFwbez09oQGcIjXzn93X6yubmVGFNiCzu0V+Ty/UKeYqe5
         r7pkdUKDoOHCWp6lmIiIU44T6aN1wz3pWLDSxMIFHkLVR3loFMSO2fDsNcKkHQoSxiPK
         4XmjSnJCJIWv9fzAjMIA2PvN68kE8Tp/MnsvxoGKExKdWosNQ74RhDFA7dkxydHekirH
         s/O3WlhkfTJNv+04kZPrkkmhlxLz2XauyIoRGTZH2x5YMQdeULofPI9vSzQOlfls4pJS
         gadnmgWr8Hj/GuIIvp98Kk0l8eC+iJPN51+ACAcXjPxbnJG7qxwKZ7CueJqx7hrY72zy
         At+A==
X-Forwarded-Encrypted: i=1; AHgh+RouC9c1aAFa0duCAT41YZu8aY/v4tmXZnBXbmrEd/XXV7Mzomxl2PzoTvPQS7nSYvytt3YvFGeuYmOC@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7Y1PHRtqSGYU8u0ZLaMCrJkQV+KuOQvSHkXNQbO74rEBnsRF
	uvL1l7GdYNB/vyCb790LVV21/uT8faRnZWfmq/lrezCWCB5NsCezDMg26792cCkYcQima2ftyb6
	DX/u8vufrMHdJlRbKP8JXTM1Iq7CO4NeqGcrpAb3OIma0p6+Z128Gl8Vjbc8Zu+RAXizoy5qoy5
	U8gGHOFWORzbbZciNhVrdtIcQNXNSfr6N/96+ymNOmUytGLg==
X-Gm-Gg: AR+sD13Zt82rnUTVy0KUPaRyiCEYz/HRI8LR+craIOJt9ab3WYDLPxV0TYRPwR9FEVI
	5WSgGr0B5gPHXeEkthJGMZEdVyWk4F5BrtZ9PB2a6KD0GHdFJFmmvNqqDZn8V8ETvNg/NtHOpbu
	I9G754LgK5JJsC9goLU12CY8xtHc2hzF9IY77vBRk0zYrLUnoOm2ugVQJkur/Y1k0huGZKR/oji
	asstckLE7zReSclc3eWAkvTAuAvrKo1dmcIvrmiofQhyzzaHh0JC6qNKN4=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499727a3b84mr5344275e9.13.1786356309221;
        Mon, 10 Aug 2026 03:05:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499727a3b84mr5343835e9.13.1786356308812; Mon, 10 Aug 2026
 03:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-4-pbonzini@redhat.com>
 <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
In-Reply-To: <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2026 12:04:48 +0200
X-Gm-Features: AUfX_my6VzuSeHJgh3uVKaTYyn_VnWzP5xLi-qQ5sWEuv-5l4TAmINZeor_-704
Message-ID: <CABgObfYvz_SrBBXmzJfiW0VsQyRa8OWQdP7myfY=WAws63oguw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:01=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
> > -             /* Never error on prefaulted PTEs */
> > +             /* Never error on prefaulted PTEs and never map them writ=
able */
> > +             mkwrite =3D false;
>
> As far as I can see that is a really bad idea, we do want the prefaulted =
PTEs writeable.
>
> The whole prefaulting is essentially an optimization for cases where taki=
ng a fault has massively overhead (virtualization for example).
>
> Wasn't vmf_insert_pfn_prot() making them writeable before?

In general yes and they still will be, but not if pfn_mkwrite was used
(as in the vmwgfx driver). I'll change the comment to "never force
them to be writable". Setting mkwrite to false is exactly the same
behavior as before, setting it to true is a superset.

Paolo

