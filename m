Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F66358373
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486457; cv=pass; b=Fo/hqI2T4Tip7jKCh1hhXNch6P2i54D0M5gW3b+r7nDiu5nJHC3/3sljTKJpePOCthBJt6F5/z8aD9ntOaCkO9lcBCTJC10/XInYnAb8bSFnt1Oy6ngOajH0Lul75Cr4Lfmlw7e/iZ40WJSvLe0K5sbh7JeJZ7KSuMQH6NuxP9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486457; c=relaxed/simple;
	bh=9gN2wocCr7kmLGcuM/2jBxArsCzUj2R1X99dFK58MjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6x5qHwjB5/CtmMl/3PAfAOs+po+VHXqNQs/1o4tB2KlflABV5DDQSRdiCiqu8yBeM8omjFpPxAbBitdQ02F71XHVdkmItsX0hlEzHObN68u6oMtgKtwcrIJZtXMFr9orT+X6StrXJ9lVQ3fgC1FA1q+z67vUsjQZn3HPKFebcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6YsIDTb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPfs5QDl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6YsIDTb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPfs5QDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772486455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kFsAiWjV29y4/mqvpo63lZBzBcmEx6G8LioYTWyjt8=;
	b=h6YsIDTb6H1r7K7oCSDfj6Ivj5tdMgnB6Il7nxXard4qcf7EKWPPsMwlbNEWBprjqK75uV
	bswtcCCpkoNaVA98XT2eqI1jK9MpjAiqZ5lJqNS5iTD0lhR0UIBAmC4OIt4UE9BPAyjB0Y
	g0ruEMup7jghKvu8+E0YbOlr+3UMiWc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-LQtagB1EPXuQg0x1GIEeKw-1; Mon, 02 Mar 2026 16:20:54 -0500
X-MC-Unique: LQtagB1EPXuQg0x1GIEeKw-1
X-Mimecast-MFC-AGG-ID: LQtagB1EPXuQg0x1GIEeKw_1772486454
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79472373f48so86331827b3.3
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 13:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772486453; cv=none;
        d=google.com; s=arc-20240605;
        b=UJSR3tCiBoDH6yFTq0QkMPRLC4f0c0/uEkyAQKUu3wqeWs4dyGlGRuyl7FmdczlNrZ
         P80ne8w0ZCEsG5+Ei9I5a5U9FkeLxelwuUyjuW3GaurElEqNCy+W/FWsdHviPRDUK65V
         ZV/xFW0ErD4iB70juVlbhJ1HDAg9arfpZx0Uj0CPDbFEzDdxLB4GvwD7GTIBLopxlfjp
         1P2fQsb8D+nbIgwocvTsNv9J2MGJ0I/NNue0+M9c4l+os0EQ2y9gisvar/2J64736qJz
         +bIV3VCuF6P/5rma0waeamEgCBTCQ83f7JlifptnkxID0TJtPG8uZDJfwlaeMxIKsLfl
         zvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kFsAiWjV29y4/mqvpo63lZBzBcmEx6G8LioYTWyjt8=;
        fh=1PYe2Ju+mip2yr5bGfcoyEKaHjvMTpTwCeBHjwTYjbY=;
        b=GgPVjg8c6aaVSDEWWQ/rhnktjb0PMWncH6IJQEocSu5cmG1b00rtwfTGfTa2FDyC/D
         zEudS42UiQ1sL9SqLXNwRllDVgxokdDMzgBM9Uib3Gks3Kk9sOZy/ferh5i45JgZKqdG
         Y+LWDp60srVH2pZTv7Dud+P4hQQI6ZlxQD4ETZX6Bm2XntC5Is4UfiGcNuPzCugIYQm0
         5qMuPLqGokIamAK2O1YK3E/cISps7dhv7azzYXbxCi/UHvYsFwmblNMXlTmNWdJp8i3H
         DuiTnwfSkgTvWoVHIpVLT8ZaeHsZku3272DbDHIb+QTxYLNjRVVX/0rZFk9EWB/8KKlO
         nPEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772486453; x=1773091253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kFsAiWjV29y4/mqvpo63lZBzBcmEx6G8LioYTWyjt8=;
        b=EPfs5QDlu4k9z3V5i2teAfIkoBGjnkrOVOBSjJyZc3+wM2sc7XYls9J8J3zU8rd0/9
         KJkDAsZt3U6SVub936pCo1vRuPrVASX3iSyM8jDYsFxhDrPJn0jrdwqMYc9/kb/ec40B
         Ik6SqiSJ2s3U++OPZOPL9D5gPdwyN+yluVyPq5m5+vH+GKJSDb5yb1XM3u/kgiUpwNuI
         ntzZMQEjHf/H6Zlx7QApHVOz/YJ/yO8Pku+y0dYjfWLYhV7Sqo4/Kq06zl0bTFdgykui
         S5bhnm1FTxIMuG+vMq2eY02A24IYPzY48TLduQsMke4b3Jv+JhPF/KlOJujECigbuA4w
         hhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772486453; x=1773091253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kFsAiWjV29y4/mqvpo63lZBzBcmEx6G8LioYTWyjt8=;
        b=Zcnl8jNNeNOebmLTRDr9FOb0KsFzj8gfYnqKx+yA8OV1owzzcUSDknFQnhAEhjRKTt
         EVbJvGpopiMMrJtBETK8FeKjRpxSF+lnyrMDxjgC0n3C7TCapVvkKbxAPc8xFNyO7/0v
         pDVeLRp/ZLclEq+ot3AxfaOyUijZLxLQEb59S5LatmMvhODn7UeRQXqLvE0gaTIZjEof
         EEFo8Huk/p/46L9MnthVqTFCGIH/tNFK3YbwrGvl0oFbsMHyrOACTMAmnitxMHU0f2dV
         QrSdFMukNcTpGJ/LvN50KiAlyAr76nICepqUrC8NQLuWt/bNLyILspl7CrIlveSkmS9k
         LFHg==
X-Forwarded-Encrypted: i=1; AJvYcCXY1WTWLbmlWl/OWSTQeCPvZn2xtyX3Tkwdiggn496SnrusHk76pqtotJ5uXQ89+csXNKqH4D0Rgey2@vger.kernel.org
X-Gm-Message-State: AOJu0YzdV13p9sVmrc67kY0WTIss6s3xtAyh0cGC/whxNP180kcO3QF1
	lDeZ22oUBHH39v6szy8fB0c+IGdj/68FkWu5jPh0sh0//hQdMrg0qjgChHEo8FdYvU42Uup66EB
	uG/AYWtghx68I8KXWHJ1UTUdo4sLggvT23BhHYJyCNuOW89KzCKg4hAU9fKuOSImD2W63guRMzR
	8C1o2WufG5yeMh+HY9K4+DPjb5oBu/5Kcf4Luy/Q==
X-Gm-Gg: ATEYQzwbtvuZVot69t+VjPfve+u8u6jisHnWUJMJzT4gKwfTMjgVRqhLXwlzwGIdoBs
	CPSBZc5wolO9yleIXoB1rI0wG5OZry48epJXyLl4xqpMehTHA1Efs9QXZ2ofHmN+SCDfXB0Rwzd
	aRZ+EfLiTOs/48ehxKD0sszAEz4IgxsgBZqLTuo+RmOqzL0iTg+7XkDqf2h1oXpHE0m1KbHxCNx
	g0t
X-Received: by 2002:a53:a04d:0:b0:64a:ee9d:8b7c with SMTP id 956f58d0204a3-64cc2225811mr7952722d50.42.1772486453724;
        Mon, 02 Mar 2026 13:20:53 -0800 (PST)
X-Received: by 2002:a53:a04d:0:b0:64a:ee9d:8b7c with SMTP id
 956f58d0204a3-64cc2225811mr7952704d50.42.1772486453337; Mon, 02 Mar 2026
 13:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226113233.3987674-1-usama.arif@linux.dev> <20260226113233.3987674-13-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-13-usama.arif@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Mon, 2 Mar 2026 14:20:27 -0700
X-Gm-Features: AaiRm50qkaj59sngcutouq41dPDnCRD-fKXemv-mcnstHZb0L6rgl_hR_ovxMIM
Message-ID: <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
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

On Thu, Feb 26, 2026 at 4:34=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> Device memory migration has two call sites that split huge PMDs:
>
> migrate_vma_split_unmapped_folio():
>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
>   destination that doesn't support compound pages.  It splits the PMD
>   then splits the folio via folio_split_unmapped().
>
>   If the PMD split fails, folio_split_unmapped() would operate on an
>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
>   to skip this page's migration. This is safe as folio_split_unmapped
>   failure would be propagated in a similar way.
>
> migrate_vma_insert_page():
>   Called from migrate_vma_pages() when inserting a page into a VMA
>   during migration back from device memory.  If a huge zero PMD exists
>   at the target address, it must be split before PTE insertion.
>
>   If the split fails, the subsequent pte_alloc() and set_pte_at() would
>   operate on a PMD slot still occupied by the huge zero entry.  Use
>   goto abort, consistent with other allocation failures in this function.
>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/migrate_device.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 78c7acf024615..bc53e06fd9735 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct m=
igrate_vma *migrate,
>         int ret =3D 0;
>
>         folio_get(folio);

Should we be concerned about this folio_get? Are we incrementing a
reference that was already held if we back out of the split?

-- Nico

> -       split_huge_pmd_address(migrate->vma, addr, true);
> +       /*
> +        * If PMD split fails, folio_split_unmapped would operate on an
> +        * unsplit folio with inconsistent page table state.
> +        */
> +       ret =3D split_huge_pmd_address(migrate->vma, addr, true);
> +       if (ret)
> +               return ret;
>         ret =3D folio_split_unmapped(folio, 0);
>         if (ret)
>                 return ret;
> @@ -1005,7 +1011,13 @@ static void migrate_vma_insert_page(struct migrate=
_vma *migrate,
>                 if (pmd_trans_huge(*pmdp)) {
>                         if (!is_huge_zero_pmd(*pmdp))
>                                 goto abort;
> -                       split_huge_pmd(vma, pmdp, addr);
> +                       /*
> +                        * If split fails, the huge zero PMD remains and
> +                        * pte_alloc/PTE insertion that follows would be
> +                        * incorrect.
> +                        */
> +                       if (split_huge_pmd(vma, pmdp, addr))
> +                               goto abort;
>                 } else if (pmd_leaf(*pmdp))
>                         goto abort;
>         }
> --
> 2.47.3
>

