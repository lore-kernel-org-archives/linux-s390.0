Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AA3D412B
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068998; cv=pass; b=D07SkfS1QIQrbGxViL+MdyHY9XFnJ1SPTnJc/pqMsw+C5uFjdS9IWMywHLkr0C+iPzZmsdUezmWIQMfhMANwHHRXJbSEJNCYI5lwySdurOoiZZHza20QC9lh5Y2I843mhbgYN1DBzf6L4SkZEiuaIsBEEE/wi4HFPnEh6MzN5NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068998; c=relaxed/simple;
	bh=gn+563RNHFdE7yNd9ZyLithUQC/1LxrVmWq5r5OUtM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3ozYa8rZJNN5kW79WTUAwfWRqbKrjKGX4jKRkpCcDzecjnJLSKlPhfbe63ARo6/4OQ9Z+DaDAKma9GBniil7UfeSEfxcvGj9riDla5YhJeJAEXZ3tDY/mqag/SiZTqSx2x21YbzHDWnicJItxDRybRjrrjh5Q+6uWhiwMNqlhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJwabNsA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsdBDZbi; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJwabNsA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsdBDZbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773068995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woFLTl4MQININgn1l26aXv8v4wFqzDNApNaqLAUyjBk=;
	b=FJwabNsA/zZi5bd/zdcjzjkaftW5QWldXPxAcv5Tm68j7X9YmAmlVKC0w42eg6IlgV7PCi
	fq/wKaRdu8m9FPv4vJZvydAdJ8bonsTEWZvToAc7pw4R51kwZwuNrxJj2KBTFHPcynuUI4
	SIIs5Ct498lIlhG/IWvUurg4tE2hkLk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-XibGaRovPGyWlM32W6uQpw-1; Mon, 09 Mar 2026 11:09:54 -0400
X-MC-Unique: XibGaRovPGyWlM32W6uQpw-1
X-Mimecast-MFC-AGG-ID: XibGaRovPGyWlM32W6uQpw_1773068994
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-798080635ceso149406217b3.3
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 08:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068994; cv=none;
        d=google.com; s=arc-20240605;
        b=gszQfQI+6IrmFS+I9wTQ5AHNyf0yXEaDX0Wvt67jXqE1nLn/AOnETYo/WZFqRYd6dZ
         x/4lKMAK+lgPt/ONqpistPFbJENoKic1NVJbxZ3ntPkekUYSY4q0aLiniD8ctwQv3rBC
         ESnsMrr65ZkKv2C4u/a5Mg1QDO6yz/nz9bpVMu3jfL03A8lWcUr4qVvcaSMf5j0jpUcX
         VqadeU2xdAqvOJj/nAnqk4a8Qs2XdazcY2YmP2usFgRAC7xUcMEyZ8bOA3loEMvwOlUB
         BVKEz6h1d0DjL00zfldHuQ1ol1S7vAKC7vUTCNHxO3iQKsDU5+qRIWZ8v3NnkFAdlIEr
         OrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=woFLTl4MQININgn1l26aXv8v4wFqzDNApNaqLAUyjBk=;
        fh=396nLyhoTDIN7Tzxbkm+U1+1NYNnnU5cNNFM7tSARCg=;
        b=DBywW9KaTKd1P0D09Hh/5OZr3X2nCGqMN9U/H/H3j2jCOUiwAIHOnXJxqVqAoC/+53
         dA5DjKSfmd9yegDnEsIEKauYVSugEArCSLjsUaRYgnjK0SbXJZ7ZeVc9mzppa9Apkkly
         ZYAS2dQOJJkMmNsyJQH7VMF4I46gS15TuXA8rnGgyH/MKdTXQTEGCdRGhvbXF998QFqt
         hSPK6pxcqJtwnztt9jnZiXBTIX8LkK5CPHZcWXn7a2YFBmVhJZZqoZ9PBOZvHzOvYyen
         ExXB3BsOWd4qS9PIivfxmw7gMI4yzck2Tdj1A8gBVBb5zwn+aEkIyPWrx9l5d5fA2wzu
         CChw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773068994; x=1773673794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woFLTl4MQININgn1l26aXv8v4wFqzDNApNaqLAUyjBk=;
        b=LsdBDZbifL180WqpI+4d0XlcraLxYhwYn9RU3L6hasPF/1aUGhvuD+mX7nsKcdkTgY
         8W4B2zOo/FwNGPgKh208AHWHqzErYflmY7/6gQgo0i/iJ1vZLo0eUgqkMVoqVZlqVMy6
         aN2IJm+GLjhRxDU58IbhUo0bfNSIpTLvR6syfv9r/Uqgd/KXMxZbj06vCuPK/Pbq34D8
         ud3oDdhzhN0YEutt51DquNqXaF/7Yc4u4+ckj7HoSycJUC6h6UMVMq7XjHw7i1dEcUoH
         BwfQVrhaY24LuSsI8Nk0GnMMajOEKZ27auKqZndjsLax2r8+fqmcACCpAh8mSs0PM/S+
         0U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068994; x=1773673794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woFLTl4MQININgn1l26aXv8v4wFqzDNApNaqLAUyjBk=;
        b=JzUlXhrHBZ8uIRJ0IQiYG7gYkN1Qd97FBUxzRLdT5JSaaZW/ASWXdjRjXDXBVqxy9f
         w4JSQktzOljMA6uf7Crr2TK5yZTyxJFDrFyh2Pt+aNRf0eoO+qiXMcddNR/dk0CAKICq
         qQKo564tUvszARB/ERUd2bW28RjNBW79OEh+CLSHF7VC1YzjY3Ey59tTDCAHHS3Uy/GM
         vqx6za0h2M7NKWzfY+Pf+Sn97zaUQaTHCtYe8wOCmt15rineM11BpoNNLLFLeTG486s0
         oYWFX+IAz6L2swqvzc3U2Tk+nR/uaAqdu9iZ8h1hFOXq8C5MfhOEz1eSjp4Dhu2jkOla
         bmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb2hbrPqxybCjJBKEXDqAQQAMMe8TYCPszttOZ74uXwi9iO0i43tfugpJiCk9ikje5aSLxcWU6WpGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfgEWuzsPqn6ltyAbAZH+Y+bbHrg2im+1XS4tqZQc+070TaBx
	fkatmb3GRtDI9KQM4ExPxO6IIKxy1vx43dJWai14C4Nd/DuE726ML3fBCIXxaaTFe3/EuLjH++/
	gkL6kP+UFd+lronU+PkFHyrjfzt7FiK8tEky8Hk84PyV6ff9DowQ4TZcIViG/56zFCgIizK2UT3
	Q8QnFSGTfV0GxCIdY/z47XpSeiGCVH9M0r4AXXPA==
X-Gm-Gg: ATEYQzwsoWtjzsdcC/wjLo9IMxV46a4E9rEqje93WT+Mn8GRHsDBSi8TkPRBTOY2ipr
	kSpbGVCYhVWQ6thpI+4K8oY2Yuyj7NpwK8owwdYrLZJSf1+rlM/S3FdeTzFx8qgz6MVdvE/SUtt
	xsnDh94IOB4xhmLJoIL03+AM6wxYioYINc/eOfZtQWAMcYlK1Rcp3GQhbrKVbPpcyN6RCUEXphc
	ArM
X-Received: by 2002:a53:858a:0:b0:646:7062:22ad with SMTP id 956f58d0204a3-64d1427cc45mr8678492d50.46.1773068993933;
        Mon, 09 Mar 2026 08:09:53 -0700 (PDT)
X-Received: by 2002:a53:858a:0:b0:646:7062:22ad with SMTP id
 956f58d0204a3-64d1427cc45mr8678430d50.46.1773068993292; Mon, 09 Mar 2026
 08:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-13-usama.arif@linux.dev> <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
 <6982e9fc-cc17-4d4f-b26e-83997c4bf070@linux.dev>
In-Reply-To: <6982e9fc-cc17-4d4f-b26e-83997c4bf070@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Mon, 9 Mar 2026 09:09:26 -0600
X-Gm-Features: AaiRm50M7EsyVTjUp3ZumpjEiav95f1tL1iFQKYgAgTcPXxEsX1_R8rjMYvu9Fs
Message-ID: <CAA1CXcCb6aZnjgtunEuwL380S-2re9N-AEjZUB+XO9G6gkrHQw@mail.gmail.com>
Subject: Re: [RFC v2 12/21] mm: thp: handle split failure in device migration
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

On Thu, Mar 5, 2026 at 9:55=E2=80=AFAM Usama Arif <usama.arif@linux.dev> wr=
ote:
>
>
>
> On 02/03/2026 21:20, Nico Pache wrote:
> > On Thu, Feb 26, 2026 at 4:34=E2=80=AFAM Usama Arif <usama.arif@linux.de=
v> wrote:
> >>
> >> Device memory migration has two call sites that split huge PMDs:
> >>
> >> migrate_vma_split_unmapped_folio():
> >>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
> >>   destination that doesn't support compound pages.  It splits the PMD
> >>   then splits the folio via folio_split_unmapped().
> >>
> >>   If the PMD split fails, folio_split_unmapped() would operate on an
> >>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
> >>   to skip this page's migration. This is safe as folio_split_unmapped
> >>   failure would be propagated in a similar way.
> >>
> >> migrate_vma_insert_page():
> >>   Called from migrate_vma_pages() when inserting a page into a VMA
> >>   during migration back from device memory.  If a huge zero PMD exists
> >>   at the target address, it must be split before PTE insertion.
> >>
> >>   If the split fails, the subsequent pte_alloc() and set_pte_at() woul=
d
> >>   operate on a PMD slot still occupied by the huge zero entry.  Use
> >>   goto abort, consistent with other allocation failures in this functi=
on.
> >>
> >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >> ---
> >>  mm/migrate_device.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index 78c7acf024615..bc53e06fd9735 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struc=
t migrate_vma *migrate,
> >>         int ret =3D 0;
> >>
> >>         folio_get(folio);
> >
> > Should we be concerned about this folio_get? Are we incrementing a
> > reference that was already held if we back out of the split?
> >
> > -- Nico
>
>
>
> Hi Nico,
>
> Thanks for pointing this out. It spun out to an entire investigation for =
me [1].

Hey Usama,

I'm sorry my question lead you down a rabbit hole but I'm glad you did
the proper investigation and found the correct answer :) Thanks for
looking into it and for clearing that up via a comment!

Cheers,
-- Nico

>
> Similar to [1], I inserted trace prints [2] and created a new __split_hug=
e_pmd2
> that always returns -ENOMEM. Without folio_put on error [3], we get a ref=
count of 2.
>
>        hmm-tests-129     [000] .l...     1.485514: __migrate_device_final=
ize: FINALIZE[0]: src=3Dffb48827440e8000 dst=3Dffb48827440e8000 src=3D=3Dds=
t=3D1 refcount_src=3D2 mapcount_src=3D0 order_src=3D9 migrate=3D0 BEFORE re=
move_migration_ptes
>        hmm-tests-129     [000] .l...     1.485517: __migrate_device_final=
ize: FINALIZE[0]: src=3Dffb48827440e8000 refcount=3D3 mapcount=3D1 AFTER re=
move_migration_ptes
>        hmm-tests-129     [000] .l...     1.485518: __migrate_device_final=
ize: FINALIZE[0]: src=3Dffb48827440e8000 refcount=3D2 AFTER folio_put(src)
>
>
> With folio_put on error [4], we get a refcount of 1.
>
>        hmm-tests-129     [001] .....     1.492216: __migrate_device_final=
ize: FINALIZE[0]: src=3Dfff7b8be840f0000 dst=3Dfff7b8be840f0000 src=3D=3Dds=
t=3D1 refcount_src=3D1 mapcount_src=3D0 order_src=3D9 migrate=3D0 BEFORE re=
move_migration_ptes
>        hmm-tests-129     [001] .....     1.492219: __migrate_device_final=
ize: FINALIZE[0]: src=3Dfff7b8be840f0000 refcount=3D2 mapcount=3D1 AFTER re=
move_migration_ptes
>        hmm-tests-129     [001] .....     1.492220: __migrate_device_final=
ize: FINALIZE[0]: src=3Dfff7b8be840f0000 refcount=3D1 AFTER folio_put(src)
>
>
> So we need folio_put for split_huge_pmd_address failure, but NOT for
> folio_split_unmapped.
>
>
> [1] https://lore.kernel.org/all/332c9e16-46c3-4e1c-898e-2cb0a87ba1fc@linu=
x.dev/
> [2] https://gist.github.com/uarif1/6abe4bedb85814e9be8d48a4fe742b41
> [3] https://gist.github.com/uarif1/f718af2113bc1a33484674b61b9dafcc
> [4] https://gist.github.com/uarif1/03c42f2549eaf2bc555e8b03e07a63c8
>

