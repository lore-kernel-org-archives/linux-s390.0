Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793098911;
	b=dB8kkKObUzPxUBZPmzFSWHlVF69yXENTzXXIPA885tQ2Cuksf1QtiggnmWwcgwoftXZB
	 fMZJ8GLmCublCL8PAL3fi5QIoRA5Zy7DXnU4K29TekyyJHwCw4TZB7BCUBUjlB03aX0vF
	 MQA0T3+NdYv6S7qMCEVT9aFcvHgJll07oYusBEywNRgfEwd9DSIxvYN8RYDoEn2y5/n0R
	 mbD92ssexGP2Zz/vfTQXg43BvkN8flEdTxrXTy0oZMCOg6m+DoVq1N/LGP+JsD7W30dDb
	 DT5FNXLnSEQys9u3kKHtqIKmLti5Vea//2tp3zkCbiYjmET/GX+u8TjH7X/5dDpaVEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098911;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
	b=bPBjTtXdfwt80qlIUjQKYNzpf+UwpC4mcMD/Y8WS5IRSN2LJ92vIh5sJLOaTsekDFY6V
	 7AuCXk9aeMNbQMmJNKDDa2mw4YDlMH9Mu5Oenrd6QbXU0sD28lxKvgn0/BExZTNYeQ7PX
	 hG+vr4TaugEkRbBmSlrcKCv36FH85tSyTvifZgwWdLrShCDY7GoGIXarQ9hUQwF5DzGs6
	 BjS3XJImTCHjGoReO94u47Msz4PjOOZi2YNhPU39vYafOG+mnB3caP4cc3PEVMGToAXAR
	 lrIfqT+G1A585L1creAl+UACmWNG28bYLAPZ2UbD1Lv3C+2XB0GdgVCP7EtqOXj9FdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AiPXEGUx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MyCJDhh4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FB606A323
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 381FB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AiPXEGUx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MyCJDhh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793098910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
	b=AiPXEGUxZJEFydOVe/xa62W7XNMHwECKpeeaYgUWJxDkxcVGI4o6M2ZwwlKHVdzALEHsQ1
	Sgu4dKlwL1caNZKxUW6CFmPsfX7/UdfZ8ALB0q/w5li7VHBaeBHGNnFFgjXDoOuonHH37i
	516Fum1pgH8MPQoVKQtFk3el/ji9vfI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-XwlwD--zOhSnAaVBT552eA-1; Tue, 27 Oct 2026 07:01:47 -0400
X-MC-Unique: XwlwD--zOhSnAaVBT552eA-1
X-Mimecast-MFC-AGG-ID: XwlwD--zOhSnAaVBT552eA_1793098907
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso27658895e9.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 04:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793098906; cv=none;
        d=google.com; s=arc-20260327;
        b=IZWHDXUFr51ujDS+GPHQ25xkKKVyutotEyzjEhMNaw5wmXkLn42qmAkp2MRXrKyWBc
         j6Xkc2XXuJ68iMzJzcxee+ukBbpO+m+tNHZwhdB1WhkF3hS+N3ifzFIXpVlsJYLeULkd
         6xuVr7Zz0gfoWjMZKiz+m1yejQ8FMNsUs0EDM36gXLZ3qA7cdsAkxVZDfO2y9Wb0673n
         jDcvluIYds8WwRxPGfldWtisHsxctrOcl/1JF73iuGnZlpZ2sJuzmxKF9HPwsqwvGi3i
         Nq1WPntmjdk97AJeoRy2xFOrmfIfVHIOgvUNIHkTO0qtLyDNt7M3MX4ddMc5t231UGgB
         MLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        fh=L2sZNI9cZvuRyLaIGIJW49hZv1Q0DCP0giPXn2peJco=;
        b=jb3QH10ivP9jreAKqTRoMowD43/H6zDq4F5ziUmTiSCdO/EdYKR6fU9gjuEWLoHagB
         fgIZct1ay7eQ5lnsprTcC3ie9vJbdGjUprs6Ib+a+idn2Wit/ZcgqifiPXLE2M4Mtbru
         KyHoVwc/njyVLXnlKzZF/ds+aWzmDWfQpjSBtumVMj17DQfDzdYuvLHGt1HKJgLHbYs6
         CSUdov5RvndcwdXKAu2MxsGkQJc145olhEOkrzCrcV5zDYtNhG61cGiCPbCveroGlc+z
         RvIERzTxjnCOanGgQPssll0opL01sAz3uwkUamTUj5eHIMR9ZN79AYUxA+XfxkGpWFyx
         XCsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793098906; x=1793703706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        b=MyCJDhh4t0awaj5ua+PfViuasF8XsJnahPe+pBlR28q7tHuIuUStaR8bdQCZS158LT
         ItliZF+jla82QJvCswfC0cTiPS+xwMKf80jEBIQ3fZ75MIOIw6vSaHkEZg2FzQNPM+kf
         lWJHWK0OInwhV5PdyUGpkSVl5Q1UapZ8O/uY3Lp6vUbmeVu4ItKwTrKm3pVA/gkP9qun
         Rjdn1CqceEWVKyGmpGDbBSq2g8IX6TEkHh1wfGCKu+NcqsdowN6ExFGwVfKQqXyrGQBU
         aiZtcSB7RAerVWoPaeZiytHtQLqgrKvVTyoyMv6lsFXjwWissUXi219M3SnjisyP9UoJ
         tfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098906; x=1793703706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        b=yyIZ4SRNA8j6jLBnWvvXAY32kaQ8c58fcqNYmLXCGmLa6djvut4tH4noQ2olE9+pyE
         ppQZ8yVfvEhE/xtCnOYuN77BeqmWALW5DTpHKK6WwgQELIzC9XluevmUK2hsYbQfSU7I
         gSCforCeoiPR2u0wadQi/7ZI4GuSH7F4aPUNUWxQoO7MWXnXFz9S3d2N0vVZbFDoz6pb
         yYNdQ/rVSv+oxCF9hfNiWZmyIPSjyNHjCLWogR1T7xit5EPA6IXzYD2fbFugsLmWmRrF
         10EqBBXX3PWrowe02lyJN4ZBGxs0zcqpjbVMJudv83EKlENbqWh+uIT5wHilKAnniRFQ
         g7Dg==
X-Forwarded-Encrypted: i=1; AKwUvByuHMVCSsz5p8jfz5HUBlQgt8tbl6bUMiS1cwPl2YXEvoatdQ7/KdrAFQ5wSUJjJl24QIiaiORXCx/A@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+KwZnycMyjREZb2eJfhGsEdXRplg9f9M+MrzviGS9b++EthqR
	+d8OQeMXUHE9WHgaPqUdBwQRCHW+rhTtWDS+VJutfIDxOcer5rdEEfASJS23mML9+C1TMdArVx1
	gauvvFkZZrPcZYJ9uX6ArTdrMHpc6+cDIefsnpALHWo5OJXNlzXbo/37p5N7fQH8FMpfPsxGr/W
	OBXfRRlV8U7rWQHpebp+JZ+c7jnhTABwysyxnKIg==
X-Gm-Gg: AYBFou2Vo9z0L84R6NA6xknnW8goVZ/cKz7Je9yjHdHvUEV0TwjasdOBWt3HHtsLOQt
	HaoDUpLjeCp2z51vlC0cR84hQC63bsoQUgFq4gkt0UzASJlhc+qT9Ftu+NVCRfCxx0UeJgYZyPv
	RDuIoh8nZO6EN5NbGDrFqaTlVWR+uDnJ9G8nMixndH1ZCUzIt1GC82+52MANIxjn/UdBKc/fzFh
	d7JPthN9szqE4fH5KTVDIZAG2EiVKFKovkqWK5e1++N4PTFDY4g0OwNfHcJiA==
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4a7669cc9d8mr64989115e9.23.1793098906382;
        Tue, 27 Oct 2026 04:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4a7669cc9d8mr64987735e9.23.1793098905407; Tue, 27 Oct 2026
 04:01:45 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <at9ahKiYsVtH8kpU@google.com>
In-Reply-To: <at9ahKiYsVtH8kpU@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Oct 2026 12:01:32 +0100
X-Gm-Features: AclHuK_gMHxkpSkqtzZpmI4E9n3tRQVDE0ExdUQ32JdSX7MqnvWed3WEPGPoNjU
Message-ID: <CABgObfYgZ87=W+6E=N=WwTuyYkaoKU3hqd84JDTSAvT3_9dh6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm, drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christian Koenig <christian.koenig@amd.com>, 
	David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
	Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:50=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > To sum up:
> >
> > - patches 1-3 introduce the new MM API, and use it in the DRM .fault()
> >   callbacks to install writable PTEs in response to write faults
> >
> > - patch 4 is a preparatory fix in KVM, eliminating inconsistencies in t=
he
> >   handling of !VM_READ and !VM_WRITE VMAs; these would return different
> >   error codes for a !VM_WRITE VMA depending on whether the PTE happens
> >   to be mapped (but with wrong permissions).  This needs to be here
> >   because the next patch would introduce even more inconsistencies.
> >
> > - patch 5 moves the check for writable PTEs from follow_pfnmap_start()'=
s
> >   callers to the function itself
> >
> > - finally, patch 6 is a KVM addendum that will have to wait until
> >   the next merge window; it removes yet another inconsistency in
> >   KVM's handling of !VM_WRITE but is technically userspace-visible,
> >   and therefore it shouldn't be included in stable kernel releases
> >   unlike the rest.
>
> What happened to this series?  It seemed liked something semi-urgent, but=
 AFAICT
> it got silently dropped?

It ballooned a bit and getting acks from everyone involved is hard...
Either I or Sergio will get back to it.

Paolo

