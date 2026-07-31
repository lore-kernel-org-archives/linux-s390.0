Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82C45A29D
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516099; cv=pass; b=edpCGmoIeyD+Gmrtxh3Win+9q25CKSQCK6qUEKWSEfhqipWOlrm4oTnTMv+qkbC3V3TvUaG8S6t16IePJ+amM7UfTbXOtKTw/DY3TiENFTaJXLClkafs4krriKzKqaCCqYvQ269zzuhlYKNklYbG0mStWg2fukT/xaPja7QRndE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516099; c=relaxed/simple;
	bh=F9xZYVz4ZEkB/YY1VXAwOyBTHT4hbBho8L47fEJ29BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klDUS24duOxMwxbCtChpRuKXfki1dyiBwsVqTXJPFmjvAkPCrZTyglcWJbGfHM2cUk8No0k+/tKN2z57cZWwe6dEx+axvZiUrgtBYLb39UVwA6QO7z75jCg3YWa7LX9SnJpPMx+5bLG3KUvOhJDaxnKdNOIrkWUUH5M801/Ffkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJp120P3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rl1VaN6F; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJp120P3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rl1VaN6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
	b=VJp120P3CYTqKyfOtbsCca4G75pxy54yuMnknUWvSMxDWbePz1CPOlBfEXQp63md2zwNYk
	Vyq3Ai6dehAkyAYsxrIG/NIsO6k/QzvHIpqiPAhpqnxVvsPwWxZ8Jv3EuCh+t1Vwz2ZUwt
	YuUT6C9XRL3e20hJRVjW108NXKLrJPs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-BzWT5j97MHm_HWVcIZqOCQ-1; Fri, 31 Jul 2026 12:41:35 -0400
X-MC-Unique: BzWT5j97MHm_HWVcIZqOCQ-1
X-Mimecast-MFC-AGG-ID: BzWT5j97MHm_HWVcIZqOCQ_1785516094
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83416551so1284175f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516094; cv=none;
        d=google.com; s=arc-20260327;
        b=buvKtiYqoL1Owj1msbeImtL7ZWYTVEvsq1l0EV+6scK9hPesKCM6xiO25SnN/5gyRh
         sSJKl9rXx/pxIld/id/4auyRPJdO5Rx5a/jmpEHMrbFojloFx4tjqyihHVdyxjOZOxSB
         x1U08YeEwjoEM9cudhhGJt53etoVyU28qEttO1hdsSUFkht3wlEkGY3At7RmFvLWuFWy
         w6OCm5J6sadBxRBZ+Fkakm5hLDjVLn/8mCfL39GqkQi71jOnoaz3+YmuCZV0O2kkQ0KZ
         UrMe7TunQeooppFdj7isUMqztwyfcxeRnXR/W7qNzM8Z0noIJTRlqvL1v4FmIzchMgaF
         +7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        fh=G8NBnkvycZUBUxDkkxoUBTuBavS3ZzlyC303PE/iKTo=;
        b=Tc528FGL0RU1HMrlvyI4DXIV9AJXENfLgIwE4mMWtJw/XoulJmSKTkk5x9wiJPls+Y
         hDgh6sVG3a6qyVg0a6BI9G9T1oi6cMfyeoHgv5p6ex7s/icgVzQMABjKxf0trdAguNmv
         aNic8S9uihf3y8CwTYJ8YHFhI9snwn+ba7PAj24imq6miFVLtXeIlyiwW91qCgS2pZu/
         wiIqDLdx0rqGiD7h5x6a3RAKBvNNd0aVAy3srKOsS/prP8arvbe8s8C1U7ZUShm0ZRgP
         jA4yRU5z5vUORFGkeh01uewfxAljn4B7DJebIfUiCEvCFfJdLlV200xm26S2yx++k+sk
         igfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516094; x=1786120894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        b=rl1VaN6Fn3EjsrsytPgDAJYqNv5B9sFw5H8P5xqhbugduEGuKm7uRzjtn3aw2n6zhP
         Nw8tHWq7vnHfNs3x0LsQKCxAms7O50gI4mFBNtLYX7V/feSjFZzhgD1/xUIgIGWBS07T
         H9MdcxZJDNq7DYmyecKLny0Yyahst4H7zmGofqjCBUIqZD1GbXm3hEwArEkSW6uIc2wO
         X6gzP12LVfSBdTgNBnTQsCQMmIUhTrghXJhXz8nWtNBDE+Z8SeJGqV5k2M/TG22MTBrc
         9vUDlH+Zgy/l+F28PFcOE67Ks++8ioIgHVHLbU7doPgcflOJPSPdfmSUIWnm/0LQE+h2
         +XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516094; x=1786120894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        b=m8nBFDo+76gTsQszZdjAI6PVw82IKVZ0ZnUR5Har55vbVKQ/arHgphi9BTq8xQq4HA
         +NzAHDd1zxUXFPprQlELP03IjrU8WeDXyjwzRN0CgAVpBYBwmmHXrxj58yjbi737+WFM
         n/bioSENGfPrZaWKftmrL6dbmmSqY8fn6XoraeftGzhQDQXBlkmY8fqJ3NcYDpJviyic
         70NOwq1punyiVAZePkuogygIz8Q4sFmtTtoplfG4yAkik//EckqGyPSbb6OAxswGxRT0
         CvlOWIf3By/OoHNEvJ5ewEVeY+FrVIS0HI4N3qLInj2SZWUxL8Lc4KL92n21wJMserZm
         PFyg==
X-Forwarded-Encrypted: i=1; AHgh+RqiPeA4pDZv/Geq37UtjtdoasfJcgJb+whq1A7a12X+qei4Y++tH4ieFPptibrvzP0rne4I9nMrKcwV@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxY1/DpB3Qi0biadHy0oCL4rNqv83jN94JSOYCsGvLV/MkIw5
	ckMSraGAZulthpNU+zGVjFPOKhD1fdt903EPOAmE4z9iLrPMciG4nYnbQ46qPB8Oafv8nEr+t3y
	tcrwargzUnG/NjSHnvL3wNVVYx9dpf5Copkfk2wGKx+6kU/QXoieVYWmV9TdafIvRn+kIO/LFKW
	bRvKe1te/tu1BN6nTfxKPPG2OsLo9yDrkBUD+nIQ==
X-Gm-Gg: AR+sD12Mdk+HY6Ozd+ojZLB02br6iJviMq2CYau8fQ9hPy39NHGenno8cBS4w6Tfn1l
	a4VTL1atZf6gHj64e5Fx/kNnNRRA7aofhOQNUC2RRXsUOu+yk/DnBQivIc39fDHHBCD2xem9UbJ
	bkj7UUmVYlxsYsPPx3JbKCe8mAm1pxBEo/7W5OBsLtbl0gxQY1t0vRVI5XWZQllbmETwe+kVYtw
	ub+EGeKu3d5g5mbpK+34JBkFiW8kZN+veNc1qvPxUsFhNn3KS5yt6rFQtA=
X-Received: by 2002:a05:6000:25f3:b0:47f:6fa4:58e0 with SMTP id ffacd0b85a97d-47fd72f15a4mr665697f8f.35.1785516093962;
        Fri, 31 Jul 2026 09:41:33 -0700 (PDT)
X-Received: by 2002:a05:6000:25f3:b0:47f:6fa4:58e0 with SMTP id
 ffacd0b85a97d-47fd72f15a4mr665651f8f.35.1785516093659; Fri, 31 Jul 2026
 09:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731160514.1101989-1-pbonzini@redhat.com> <20260731162036.1FA1C1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731162036.1FA1C1F00AC4@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jul 2026 18:41:21 +0200
X-Gm-Features: AUfX_mwboGSq7mPSFXQ7e5KxQ3OYwhupahjJ5-r1wrcYmDVpP3Nemd0IWm0sYoM
Message-ID: <CABgObfbkqYNsPQnKxK1_4adXF_tSdtScPU5-Xrg-sXyeWfMVfQ@mail.gmail.com>
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] KVM fails to return KVM_PFN_ERR_RO_FAULT on write faults to read=
-only PFNMAP VMAs, breaking MMIO emulation.

Let's look at the bright side, I only messed up the part that *I* maintain.

Yeah this is correct and fixed with something like:

    /*
     * A write to a VMA that isn't writable can never be fixed up, as
     * fixup_user_fault() rejects it outright; report it without even
     * trying follow_pfnmap_start().
     */
    if (args.write_fault && !(vma->vm_flags & VM_WRITE)) {
        *p_pfn =3D KVM_PFN_ERR_RO_FAULT;
        return 0;
    }

before the first

     r =3D follow_pfnmap_start(&args);

Paolo

