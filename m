Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDA320A2D
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739597; cv=none; b=Blp54D2SuIJ7RtE944LCAbrDcaqdBYnSCxIrj3EsY6RjzKGW7sBf6HDZKmd4r1hVhef6qdben14T2RQqrleIT/n5XaoNWeeARhA8+iRB194IGAlAJKPC+OV+ttwVF47DiZvX1+J0chWhHN3nrgEd962sB1cz/cdBFOMHFdX0Qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739597; c=relaxed/simple;
	bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyklmzwNzgJWp5knZptSrV4rwc4TI1u8HGzHEAtHzr5AZIPe1C3CXZS6ZLUuorCsFGt6ZNIO1Y4Kn6afBOy8YZxKFk88njyYendk4NiaO2sbIGr93WTG6pIfB2VbIIQimicsr83S4uoz/Yr4ZprICqxuTFR52a3t8lGQxilTPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cd/cMr3m; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cd/cMr3m"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b040df389easo313153566b.3
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739594; x=1757344394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=cd/cMr3mBFUKj/l85MxxINGe2ZL/wWXCouUOLF2P7u7Sbb3G2TSO+T7MMjaT92i8ib
         xVVye2DysYNSVHq8tJ6lKA4Lfe2j0OP/3aSBx7XrTl+MRwh75YHhMdSJp9YYyfIHRO39
         Ac9SPC5f1PEpMwBCrIbTUQfFNA7/0Z1pB89UOn0AWo0ZV/a+e7jGsUznoZHpQ+8lCHN6
         celxCU/rqMtV7FgC/CvN4UVi2u3gRCZv6iXKZLyDlHC0rFJR2xSaHcZV3AVn34Oi4Har
         ypZu2Kxo7s7oPnvu1oreYhxXi7Igh14F5/Iifs9vIPSXDKTC+a/3Mqq+6OB11kxfPlUU
         R08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739594; x=1757344394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=hKV8FCyE3RZwgoMhnLwae41EMQ7riv1MCwqxCJPPCjRqYD7pc6JJtKH3PkJ/jVhVqz
         CuEdVW5rs3id8eN+9joUOsfS7k10+RY7HDAVDb63S2rrcqGQlr58hBqEZ7rpD3ZINVti
         UhVaDIU15yzM1mJVzqYJ+NsDg8Efei6bieCrCoHTG9BFbSs16c8tTXRnaTz6rY//tLFO
         fPVJneRnI3duzq1fDrkbDTkRbr+QYTCNKSaBSkyuuH3D5/bSUZCKG4Ha36ub/rDdpjQT
         iQoVrzvnB3lB9XPSgfvSGxIxrAPVGff+1Lwr5JPkdTYFovXnCHgYvXHKgLqfXhx9Y1+D
         54Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUeV4pb89UxzIaAmckEWx6SK6HKBhkq+kZRLxBFj1agnjHgC5+rFOTAdS/bJhlHV6Ew/pMPnQ9TFnmj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/60Rub5Pu2SVh/9lXdbgk2UnxMSuO1UCoN6AB9xZcdPEKx5Yv
	p3PH51yEbWNRW4hK31XCsdj/FYHyOW7gPTREPMB+aKi9gaR0a9BEWIDqX/kJQRP+PFTBWsRMm/I
	0orhIMszOterK/lIebtsNkd98TazGQl1YQiC7lETJbQ==
X-Gm-Gg: ASbGncvlUoBsuVpg8nw9MNKrsVxfHxXY1haCkiLoHQ9XBFIso2uSXy44a0agAmpwXdZ
	AkTqM6Rwjg++iR5ucJRcAjBh0VGsjUXUIh1YdoMVgaJy2gSMskIzMtvbxv8LEvVwPH6wMb5qx8f
	R6axBLWn5MnSRdCaLijz2nU5ngd3ytowjwhBFiOZ+dtwfPcwp50C1VpxA1VYqQjy0mGB5T05OhC
	GR+46s19VrY4XWQIA2GN5prhYI+pLXjYApsgbDedVKg9Q==
X-Google-Smtp-Source: AGHT+IEFPWeGuNqM2+QiOgw6fHvRg/b0a6N13KZkb/trfYqooePyXBS3syenI4NwqPjQnySBBQHmRMnR+cpdOfOLUuA=
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr930093166b.54.1756739594447; Mon, 01 Sep 2025
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-11-max.kellermann@ionos.com> <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
In-Reply-To: <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:13:03 +0200
X-Gm-Features: Ac12FXzpx0s0QI5qZl1CeOcQ-w6EceVXiGl7R5sUJVErAX6WQ0b3KxehR5HEiuA
Message-ID: <CAKPOu+-zBstZVw4LjKz7ZQyTh_PKEJXaWYsgF0-E0+shAaTvwA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] mm: constify various inline test functions for
 improved const-correctness
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

On Mon, Sep 1, 2025 at 4:00=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Also some getters hiding (and functions that actually implement logic --
> folio_migrate_refs())

Indeed; I mentioned that one in the message body, and I thought this
was good enough, but I dropped the word "test" from the subject line
to avoid confusion.

> > -static inline int folio_lru_gen(struct folio *folio)
> > +static inline int folio_lru_gen(const struct folio *folio)
>
> *const ?

Right. Added for next revision.
