Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D972DC350
	for <linux-s390@vger.kernel.org>; Sun,  5 Apr 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432103; cv=none; b=a0dZ+iUQso19w4igk7zd2hsPgIXP4qN8Rnr/dWqgIsmU1DngBJBi2fVhf76jHCcn4EFs8PstGvWSFAWuQGGp63UpSzkbrGLS9QAD+RPglAiSm98y28BaKU4v9ZS71Mnw4lHvA9svIpCV0W3KLuVU7ZmP34dZGWptZZpVIafnaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432103; c=relaxed/simple;
	bh=B7cuyw9xySPaJZtqPzWi7xYG+G28EUTfrjGcp+C9qQM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cRLONgkJ66DFXxh8M/zYCTpi/6OXMiIqKAC9yCRr1OmWK739ZvZ/ovS8D0ycHOUS+shR2xzpfRbQAc9+jL1jkmhmZ4Wyf0HRL2JlmF2SeFZKE7toYTLKnEQtLiFRmWLzOfFIPqjv+bSGHRrWZwAc4WoGKVhjFp4lRdpNeg0FRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGYj0yKt; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGYj0yKt"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-650182d19e0so3843151d50.1
        for <linux-s390@vger.kernel.org>; Sun, 05 Apr 2026 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775432101; x=1776036901; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzm3/9j9sm7zHb61fOGxB4CuuzgAL6dQcGBwWJvxxMk=;
        b=gGYj0yKt0fTN3XN/Z3yOfJTViI+QcfhHaBnP421xurxA/CdMFgwjCtv5t4+xvmiUah
         0/aZV+9zgPkivSFWLqOtNFfuC+ewiH4vT8fsZY2l03uRTw25KQbfTdSpabRubf+0aUuc
         wLBv+Vvu18Yop/Ps1RI7ckqWEkMzcuQMert+2NiwOMw3aOySeBtez/mbfrw+cyFyVUGa
         FCUrMCijD8Cn/39lCDbZ4fQ5dYZ6pZgtnUtRficpKlqJBp9Ynp2AvvqTNmC1oP2chTW0
         kC6EM1CuBPC9WxcfNH/VRKhgAAJaKdpr2LJ4pL89AwHZsXIl031QhkwcIAqVlaoYHVxl
         a0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432101; x=1776036901;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lzm3/9j9sm7zHb61fOGxB4CuuzgAL6dQcGBwWJvxxMk=;
        b=HHMjlipuFG9Ca2w4JoYu20idDYdNlefXkqguaUCXeYmu1ymDiGaBrthLQI+6ERU465
         HXfWArr4cGGzYZQr+G5Bi18TIrj+U+VJdB125Z/CW+xiu29634i2LCSOQIBQU38ZrwYs
         SIxJJwOcHQHOUQ9HMzyydRyFnQmnQZU8gMla51q/s3KbyAv9a+FqAxi+QV+bn3/ZBuA7
         ZK4cqr8gAZLek65bS5R7Q880Y/VS5qIF/gDvKpZQzgS9w9YUkYiqGkp3+OaOvkWuke8/
         6rNXMFReBhpn2Xmb3WX1I8QK8YlvmfTeT9Trb2jP9QlzvQyS7oI1Gxn/6eAP+hV1jngI
         oC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHTR7rpB1ftOLXy4WZxxcdUiOuLn55y2Nbd6byg3k4cEvw+/Kk2KGVSfed7hdC29pwwMxVIC5JKMEO@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMlsvqfqASWvn272GbXh7YyHV0ekzGIQz4S70dCPSn6yVBaWg
	VkeFeO5A5qJmQv1/ct2t0Ev6sOL4Gx7ji0JTD0t7zKK5TYnpe2+4eq0Xd8gdDe3OrQ==
X-Gm-Gg: AeBDievy50ihhL1QyU0LqIQ8v/bkaPYu6c6vxqf04uyWZl0l9k5vrodHDkB+ZuF9gfQ
	r076TGBRdjhw56Pj12svF4YOsek3AytXms6rmmbeY82GeZHfNOBLElXPXx7J1iQrIg9vVJokez2
	m5fkjcTSMuOHVr0EmjlAEYURsfXwYfhDOzbo5xQnWf2cOlg3ZRwIZzh93yggC4No/8dv0YH3mMF
	Wqc81Oon8Lmdd15lM8Ln2L4SJYqU80xn+E/tNLg+4CDJuRwd5ZREoPiNBFb0bZUErpbP5+KlkEW
	johIqqI+lA0BThbURggFeouCUTRdpMEiezVkMN3aMoMpPctPw0FWBrAZpupRnvQZSnBaGIgh/Ub
	lkKmNnctVvO8P6o6QkFOjJXrvNlSTyDbmrpVUO/vEx/9qKh60e+EeLa0JStpupfpuX3R6TFa+4C
	okJEGceqPbTmPjhZlUzZ4gzoIIjWkTD6heQrG8UbaGGxiXvnXKpG5v8m0k4W+25L/mK3CZOu1+s
	uSDbRNNCI0=
X-Received: by 2002:a53:b009:0:b0:63e:2715:5ac6 with SMTP id 956f58d0204a3-65048828b7fmr7933343d50.35.1775432101086;
        Sun, 05 Apr 2026 16:35:01 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a83adc3sm5317274d50.5.2026.04.05.16.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 16:35:00 -0700 (PDT)
Date: Sun, 5 Apr 2026 16:34:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usama.arif@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
    Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, 
    fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com, 
    shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, 
    dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
    Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
    Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com, maddy@linux.ibm.com, 
    mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, 
    gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
    svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
Message-ID: <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-802286629-1775432100=:17421"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-802286629-1775432100=:17421
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Mar 2026, Usama Arif wrote:

> When the kernel creates a PMD-level THP mapping for anonymous pages, it
> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
> page table sits unused in a deposit list for the lifetime of the THP
> mapping, only to be withdrawn when the PMD is split or zapped. Every
> anonymous THP therefore wastes 4KB of memory unconditionally. On large
> servers where hundreds of gigabytes of memory are mapped as THPs, this
> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
> could otherwise satisfy other allocations, including the very PTE page
> table allocations needed when splits eventually occur.
>=20
> This series removes the pre-deposit and allocates the PTE page table
> lazily =E2=80=94 only when a PMD split actually happens. Since a large nu=
mber
> of THPs are never split (they are zapped wholesale when processes exit or
> munmap the full range), the allocation is avoided entirely in the common
> case.
>=20
> The pre-deposit pattern exists because split_huge_pmd was designed as an
> operation that must never fail: if the kernel decides to split, it needs
> a PTE page table, so one is deposited in advance. But "must never fail"
> is an unnecessarily strong requirement. A PMD split is typically triggere=
d
> by a partial operation on a sub-PMD range =E2=80=94 partial munmap, parti=
al
> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
> All of these operations already have well-defined error handling for
> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
> fail and propagating the error through these existing paths is the natura=
l
> thing to do. Furthermore, if the system cannot satisfy a single order-0
> allocation for a page table, it is under extreme memory pressure and
> failing the operation is the correct response.
>=20
> Designing functions like split_huge_pmd as operations that cannot fail
> has a subtle but real cost to code quality. It forces a pre-allocation
> pattern - every THP creation path must deposit a page table, and every
> split or zap path must withdraw one, creating a hidden coupling between
> widely separated code paths.
>=20
> This also serves as a code cleanup. On every architecture except powerpc
> with hash MMU, the deposit/withdraw machinery becomes dead code. The
> series removes the generic implementations in pgtable-generic.c and the
> s390/sparc overrides, replacing them with no-op stubs guarded by
> arch_needs_pgtable_deposit(), which evaluates to false at compile time
> on all non-powerpc architectures.

I see no mention of the big problem,
which has stopped us all from trying this before.

Reclaim: the split_folio_to_list() in shrink_folio_list().

Imagine a process which has forked a thousand times, containing
anon THPs, which should now be swapped out and reclaimed.

To swap out one of those THPs, it will have to allocate a
thousand page tables, all with PF_MEMALLOC set (to give some
access to reserves, while preventing recursion into reclaim).

Elsewhere, we go to great lengths (e.g. mempools) to give
guaranteed access to the memory needed when freeing memory.
In the case of an anon THP, the guaranteed pool has been the
deposited page table. Now what?

And the worst is that when the 501st attempt to allocate a page
table fails, it has allocated and is using 500 pages from reserve,
without reaching the point of freeing any memory at all.

Maybe watermark boosting (I barely know whereof I speak) can help
a bit nowadays.  Has anything else changed to solve the problem?

What would help a lot would be the implementation of swap entries
at the PMD level.  Whether that would help enough, I'm sceptical:
I do think it's foolish to depend upon the availability of huge
contiguous swap extents, whatever the recent improvements there;
but it would at least be an arguable justification.

Shared page tables?  Generally I run away, but perhaps
manageable in this limited context (a store of not-present
swap entries, to be copied on fault).

Hugh
---1463770367-802286629-1775432100=:17421--
