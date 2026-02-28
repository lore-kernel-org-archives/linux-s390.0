Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52163D6F
	for <linux-s390@vger.kernel.org>; Sat, 28 Feb 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772237202; cv=pass; b=CuQGaYz2Cb/lZgsZ0melXnuAU/qA5utxfDktHsA2jBWq+XF5yB4gkwduBL2tWj+176Ir34kv83qYT7VmglAokb5NttDVHxe8zgaxd4MyGgAP20CyOUjobeRuIt/nO8bdawMad/XY4uGScLKAd257ubxFJPhBlyic01Y6Sz1MJfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772237202; c=relaxed/simple;
	bh=ZgQjMLyBsefVKSZLFOZenbLdjl9yvSc36kLvDM5ApCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs3x4AHrBSx3QmVL23aHgxZJPLdRFX5Je6VakLX86gZ0WfmLcFfJghKr2lSCgSgKED2U4J0b/dI0XmxxRY1znbD8XyjaAA3XcrYjf8IlZM40HJy+upugrbMOHeyErYInJ8Z5W/SbmwP6FuUVRJaV+PaCVq1kYRFp4Kaer8CJmNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo2pvd3o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiixhWyi; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo2pvd3o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiixhWyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772237199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgQjMLyBsefVKSZLFOZenbLdjl9yvSc36kLvDM5ApCs=;
	b=Lo2pvd3o5R1ggGVQmJ5OUPdE1MW5BHeHKPvM64OCfycTdeehHPJNO6TnvP/VDPxS8b2zWU
	jf6N8HmfRZZghP0miEkn9qkGbuT8ecx3TaAVXcv1recFFOaywHEBvnv/+AcOUXfQ+WLypF
	btziB+dNXEemijLLwvGmmSST7nQqdJ4=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-VwR0mwN2MYCLrri-G3T19A-1; Fri, 27 Feb 2026 19:06:38 -0500
X-MC-Unique: VwR0mwN2MYCLrri-G3T19A-1
X-Mimecast-MFC-AGG-ID: VwR0mwN2MYCLrri-G3T19A_1772237198
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64cb719e778so4917947d50.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Feb 2026 16:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772237198; cv=none;
        d=google.com; s=arc-20240605;
        b=AC1ELdCxX/5XDLJ7PJZn1Kbsif9Q8zog2kVO1oY0/9Akxn8CrlCVFAkD0GC0BDQWHw
         GIerHqx7o3mB+o8goUT8GRaJTUkBfsRmJcriwqRPsMl/CaJtB4x5xXBfPOPq/QNF2tEw
         JsWH2vCyp9LAu+EtDsULqCLC7EsIgi6iJMaB1Ljsr0Yu1LmxCjbCqA/W4rEP+Mwe9kli
         E3pKV6ttlwNyEv6n14xrRcmzPwWvm7ItXL3mSWmv6TqJwhdVY/fUQfOsv73B3/Wf7Tgb
         ojZA/yIWKP1/bgKsHHe0oLGchIzk82p7c6bqWiF5QBF7WUVvjJu+I5UVrk7YHJKiwLGV
         puBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZgQjMLyBsefVKSZLFOZenbLdjl9yvSc36kLvDM5ApCs=;
        fh=RXo0t/T5uFyZaSJY1Pbrkw87atqGVI1c8l3jM1cs05U=;
        b=KJ1c5GwBYSl9NA5GbX9bpm+vSjkMTK+OOMqIV6R73kgCaJ/Clcqwlk2KO4i/3pCFpR
         nScyo4RW3yylB27vsRUKsY8VSxe7m0NbsKdEzsebBT1lxoZrGgYwVoPEdqmFvqDVHMrN
         lQQK1Oc3T+4xqTLPz4cWQteQV13BTjlVvfN1d5AgVt+CUp8U6wgeeiH/hUOnUuMLtQFz
         XgsoRgzjOZg9jeNtMjz6OIh3JDNdKG/2kYw52gZjnmF1RBkupQDLc7rJvF4zwclQnEBK
         WfvFGThalvolu7+UmRG9718MlSiIzTzA9uQP5ugJHp+bbJaJnQi3/U4W/cm0lHqleYDX
         w3Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772237198; x=1772841998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgQjMLyBsefVKSZLFOZenbLdjl9yvSc36kLvDM5ApCs=;
        b=BiixhWyiZ4iYlGdk1hF8HV9NQcYKzsa8ZlWLbFPIuNZ3nLqeHOyyaCDL8pceVknwyx
         sBM0uBUtyQaq6+4KWLTn3uz4vOSuf/rGK7HCyejAPOM74o1dbZuQSlik+bIqGnHDfR5R
         ePhPe5kZq5nTcZWtcqNIV2ti4LDAkQGs/GP/iQ1OwavZJ1Do/xw0Im3JQqMVRQiavkkz
         46/ImqO0HqAQcN521Gv5C8hQhD21zCUcXdqCQIP6zYgYovz8E9u3j3rndCwwIks4OIYW
         OvXnyxLM72hGMYn/KiHhtQHyoZjH3XCjBA1p1mpNxf9QE4eN9jkowz8AZl1n4BX9MMg+
         bboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772237198; x=1772841998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZgQjMLyBsefVKSZLFOZenbLdjl9yvSc36kLvDM5ApCs=;
        b=rU2+ZcUe0Ev+CFWII9X6zaRkPNBEIkVDjnPr9UWpWa7XJLh0j6c07ZlFo8YKW0fKfT
         oPsdOQZ/GjsZh1I/N/2vCr8FMqzTMJA9HgDNzCogP0+6yJRT52TnD7Zt4kY01es9UZs5
         /+PaXtR4NpltRnybMYLPXFP1XzkoNjvw3uTuok1XkBlFliKOH+6d3LP+K1hJPYpWmG7c
         78oUP+iVIXFVSSq0jNTEYWIPfPGJxsjVCssHs+gyQiCNxdDM1NRYPEuMCRjnL4eynZFt
         tdswz28gJBNz54CRbom/q6KSCaacHDELC3dz+3l2KZRh9CkXgzPYZ+JPlFldX/JVwSq4
         mSwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqanVyKPmPkNjaGMdeazmsw13pI/O9U/ptAEbMUnhkdly1IXsyFh52QQ3dEQOz9ZcIZ5uBPyLNRqNy@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwPx4S7YISckzGnoGPUmHAk4LtJw00WGNHZ+oy7tL+praQisw
	oIs0+deIPwQNGytm5QJ1UYoBEcUB9bNxo7OHCypKwPR4y6elnopjAR4ZS8S1Zqx2B6hUbWyqlTk
	hihMMI6aWiy9m9lwaXOc0liK0X5yOtUOIz08RB8tgMsWFHoPyHTIw4y6k4V5PV8uc00Fu0rfYqU
	HIKjuHyMxvj1OOPoWi7C3tDAEo6i2pQCRY6YO/Cw==
X-Gm-Gg: ATEYQzxdCzl1TOmJrfxZPiWfacVPlVGUCNOXyJq6NxNBgT8mgM7pllr4k/WqLpJ0yRR
	J+zY6ir0VM0bfKkTYgRdRsjIbkVHu37/TB6e/7qxuC8NE9iX0d5yZg3afPhWeV88+x/xPzXKw3S
	u6gW3s3Wte9GUGOQ5qlXWb6/ypTwdFzqOs1pd7uOG1tNzFuJ+sH4yoH5LeXXHsDWXvSlfY7Iye5
	CE8
X-Received: by 2002:a05:690e:edb:b0:64c:9a08:9948 with SMTP id 956f58d0204a3-64cc2302f31mr3708801d50.76.1772237198208;
        Fri, 27 Feb 2026 16:06:38 -0800 (PST)
X-Received: by 2002:a05:690e:edb:b0:64c:9a08:9948 with SMTP id
 956f58d0204a3-64cc2302f31mr3708764d50.76.1772237197814; Fri, 27 Feb 2026
 16:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com> <1d3a4e8e-9ea0-42e7-b8e7-d92fb27f80f4@linux.dev>
In-Reply-To: <1d3a4e8e-9ea0-42e7-b8e7-d92fb27f80f4@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Fri, 27 Feb 2026 17:06:12 -0700
X-Gm-Features: AaiRm50atKm0LplrPamqC93Qv4KgvjRMNXj12GuBsNodzUDc90TXdhaD9w6BIXM
Message-ID: <CAA1CXcCygvA9uUJjB-+2J00srnHbiNGwbvcbqpRer8Vy8QBxWg@mail.gmail.com>
Subject: Re: [RFC v2 00/21] mm: thp: lazy PTE page table allocation at PMD split
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, lorenzo.stoakes@oracle.com, 
	willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 4:14=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
>
>
> On 26/02/2026 21:01, Nico Pache wrote:
> > On Thu, Feb 26, 2026 at 4:33=E2=80=AFAM Usama Arif <usama.arif@linux.de=
v> wrote:
> >>
> >> When the kernel creates a PMD-level THP mapping for anonymous pages, i=
t
> >> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
> >> page table sits unused in a deposit list for the lifetime of the THP
> >> mapping, only to be withdrawn when the PMD is split or zapped. Every
> >> anonymous THP therefore wastes 4KB of memory unconditionally. On large
> >> servers where hundreds of gigabytes of memory are mapped as THPs, this
> >> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
> >> could otherwise satisfy other allocations, including the very PTE page
> >> table allocations needed when splits eventually occur.
> >>
> >> This series removes the pre-deposit and allocates the PTE page table
> >> lazily =E2=80=94 only when a PMD split actually happens. Since a large=
 number
> >> of THPs are never split (they are zapped wholesale when processes exit=
 or
> >> munmap the full range), the allocation is avoided entirely in the comm=
on
> >> case.
> >>
> >> The pre-deposit pattern exists because split_huge_pmd was designed as =
an
> >> operation that must never fail: if the kernel decides to split, it nee=
ds
> >> a PTE page table, so one is deposited in advance. But "must never fail=
"
> >> is an unnecessarily strong requirement. A PMD split is typically trigg=
ered
> >> by a partial operation on a sub-PMD range =E2=80=94 partial munmap, pa=
rtial
> >> mprotect, partial mremap and so on.
> >> Most of these operations already have well-defined error handling for
> >> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
> >> fail and propagating the error through these existing paths is the nat=
ural
> >> thing to do. Furthermore, split failing requires an order-0 allocation=
 for
> >> a page table to fail, which is extremely unlikely.
> >>
> >> Designing functions like split_huge_pmd as operations that cannot fail
> >> has a subtle but real cost to code quality. It forces a pre-allocation
> >> pattern - every THP creation path must deposit a page table, and every
> >> split or zap path must withdraw one, creating a hidden coupling betwee=
n
> >> widely separated code paths.
> >>
> >> This also serves as a code cleanup. On every architecture except power=
pc
> >> with hash MMU, the deposit/withdraw machinery becomes dead code. The
> >> series removes the generic implementations in pgtable-generic.c and th=
e
> >> s390/sparc overrides, replacing them with no-op stubs guarded by
> >> arch_needs_pgtable_deposit(), which evaluates to false at compile time
> >> on all non-powerpc architectures.
> >
> > Hi Usama,
> >
> > Thanks for tackling this, it seems like an interesting problem. Im
> > trying to get more into reviewing, so bare with me I may have some
> > stupid comments or questions. Where I can really help out is with
> > testing. I will build this for all RH-supported architectures and run
> > some automated test suites and performance metrics. I'll report back
> > if I spot anything.
> >
> > Cheers!
> > -- Nico
> >
>
> Thanks for the build and looking into reviewing this. All comments
> and questions are welcome! I had only tested on x86, and I had a look
> at the link you shared so its great to know that powerPC and s390 are fin=
e.

Good news: as you noted all the builds succeeded, and the sanity tests
dont show any signs of an immediate issue across the architectures.
I'll proceed to debug kernels, and then performance testing. I will
try to start reviewing the actual code changes in depth next week :)

Cheers,
-- Nico

>

