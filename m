Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2A2D5942
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740181; cv=none; b=RwqNDDfcgtL2T738dns+QBMlmikfMO375Qm1NKdV5WKA9eajSx6lnPkfjfxk7tBtzDxHGrAFHsHNmLu8Xy+7NvooNh8A0EJvpT/v1P3hcZgvhRqg7XeYwlpOzsM8QHEqJcH50Z/7w/tWxSK4XF3m1xHpgf9AOB6L6+AHNsyp3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740181; c=relaxed/simple;
	bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNjxpyQceEshMz7J9SmffSVT+gQVPRNB3xXAXILjhSKTS85Z3wVs282+7YQgwlqJHGInqP/jDhgaCkLCEfp0ZYTW1fR8p0M7G8QreWrNnnjikszGJ9Xu3ZPKEqc0blpyFkd7iihqbeq30KpnSodhOhFzJr2AZGYsvku7f7Lee0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V8FU0ftV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V8FU0ftV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc3953cso131332866b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756740177; x=1757344977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=V8FU0ftVpb2p3tqAzIFJXxS9Ss99K7zDrWutbLl7NXM+DVbrHRVuPdUwELaYxrUoJ5
         m9CACTX/9p5DCsmSlRkv3pow87OTYaHJ+U/hZ3zV1ObOLfuEdmJ6W2D0SdgImFxt1rGc
         YBOBj8dcjxunOFCA4rlg2VL4iJpu8cz9Q9kZ9wh7pakm9lptgJPkdDmrl9Wbumvavx55
         PEVAgB14GA468wMQXDOyGILndkwcV4tLIz9txw9r/0k6Jh3z/xgkmkWzHLxAwFIh0tWW
         A2IhGwemR1wxv1W8X5/qKELXxe8HrfXNd6ANkNeRr8EAxaYN82MI94epPvY+f9P4695p
         dzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740177; x=1757344977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=VrWyH7hV5EJkZ0akJHCYrpMsix6lNoMdort331RQ++tBEV+/EiGjDIqJVjIclJ5zef
         /W8c/wuNveX56TjTP7Z0vqmbD3HlOHHQc/yfsXQmsW45Yx5kLNKly4AaRlBjHdwrVGZB
         Q3V+CnNz+h01lJ9hgggh3xb/BixZIn3sZGQtbG3RBxnv5zmtq2hd468SRK3QsI/LLMtW
         rvXH8VJGOAPMzvlOHMspEm4XHqU578k/UNcSmUWi9Pvs9/AExqUZdOWjnHCGmTd0NG4t
         seIk63kpVB/Mpy8wBvXk8egNikGZG0xndLqPkQXYaEBVVCTMsR+muUuTX9+NMsQHLRvg
         e0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWItSGw7njkUawuQec8OD2hyMq/m0c8h3kNsT8l+k6ACQSHhshZu3eJ1np/SvbKzvo+9tDlEX0XjXDA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOg71JnLehb+iXivocP0Frm2dnKpTMQGPWKo+RDrSd8RN53cY
	F+WWW2I3Uor0+pdUnypbYxX+H7/Rr+Th5DIzTtqI1hoMQz/WwVH5Xy8f8ik94rjFcWyfsXjotmT
	i6NUZCKanstssWQjKCzbZgby9epXndKxcusfzI9F3Yw==
X-Gm-Gg: ASbGncssHrsEnodvwtEtOk+V2RwDV2eagjoMcmBeTe7+lPXvS9b+0mTLNv7ed3UROB6
	mBTurRxy7/bW7qFXHoqngg7/KOdnRj0K08fi/12CkWRj0/z/njNitIYKHKEMUlfJ3RSDh164fsV
	9+utNjd46OgAxbib8bkNpFvJkc6VNI71KK/+z85Ec8oExQUBP8nET04XCLOCly0eorfFVklp+/P
	c54wp+kyPRfZoPMdrmWIH07w2vYXy5EQ5g=
X-Google-Smtp-Source: AGHT+IGyHGBQU5Fmr9N1bQCrhCA+i8zJzAFx27YAdwJf0bpouLhs7aYdtEtaq8rinlUX8phhR2x58GzGpQKldL70zDk=
X-Received: by 2002:a17:907:60cf:b0:afe:a7f0:80e6 with SMTP id
 a640c23a62f3a-b01d9756fb9mr875954466b.33.1756740177075; Mon, 01 Sep 2025
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com> <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
In-Reply-To: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:22:45 +0200
X-Gm-Features: Ac12FXxiiebv9X2d18G9zaz1-52NeLol_OdOPtBiylMXolSmoqbk-OqNT_yTCiM
Message-ID: <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:11=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> >> Should this also be *const ?
> >
> > No. These are function protoypes. A "const" on a parameter value
> > (pointer address, not pointed-to memory) makes no sense on a
> > prototype.
>
> But couldn't you argue the same about variable names? In most (not all
> :) ) we keep declaration + definition in sync. So thus my confusion.

Variable names in the prototypes have no effect either, but they serve
as useful documentation.

Whereas the "const" on a parameter value documents nothing - it's an
implementation detail whether the function would like to modify
parameter values. That implementation detail has no effect for the
caller.

Of course, we could have "const" in the prototype as well. This boils
down to personal taste. It's not my taste (has no use, has no effect,
documents nothing, only adds noise for no gain), so I didn't add it.
If you prefer to have that, I'll leave my taste and home and add it,
but only after you guys make up your minds about whether you want to
have const parameters at all.
