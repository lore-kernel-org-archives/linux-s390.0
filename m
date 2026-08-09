Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBA2E7378
	for <linux-s390@vger.kernel.org>; Sun,  9 Aug 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236685; cv=pass; b=nh2c83ZD2wXe76mWaaeDt7hSRTmmRl1eiWckUxq7xfY3rY25DNxP10ZMAK4FJlo3NFQjyIl3rInpyx+6/xS45zEozYeFK8hp1FRT7H0EOCugHrbu+2FAITEZCur0tKTQeEVsvqEUD7/KcOTl8QWf5zN/+L+6+e5gMod/4ODghjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236685; c=relaxed/simple;
	bh=zs4SfiVaTFG87zEuWa7DYEYXMveiqU+3HeFFRIGyKW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhHc0b7T9jhNQxahplAjrva0IOHuqHL3WysA90KysVrTKRkrCyu3u+NX2fb8MiJMOcKhj5JhfhBg00SVuJEaE5Xr505991aPpqfLoFX9SC0OF2biVjLVGJYp1p0PCzQt17TBVTUkaQTJFO3B14Bw5q0VsyAZRvaiKUXoD/IONW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mayzSwPH; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mayzSwPH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10e86e52so135041cf.1
        for <linux-s390@vger.kernel.org>; Sat, 08 Aug 2026 17:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236682; cv=none;
        d=google.com; s=arc-20260327;
        b=Tb3fgDYYM91694paLqCGVqRmHzDnfQALY8wWipoCs3DFkwX9mH479VcgBS2bwwNAkd
         htkdWc8OS4rZwHiUF5GoXPUQGwmbDgqsa2nxBsiM4vp8Zw+/HlcutsSc1mI4DYV095Hr
         jLKtiXj8KMjlKZkx+530xGRWGspJb4YAA9yR7sweVHUcyNtrKj4Hb/pb3SdZiirqFmTE
         QKo9UzNBdDme4phiW7pAylOwp8NgkilNv77o4e7VSq9YJaICy88qbSIoVpthwB021XcU
         gXKIXF9gvA6LnYovXzDLg+6omkozUrACHLCgxQWtF7SrtSRo6ywTrTOLfF86eNFoe9IZ
         Dhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        fh=Mo5Kkz6tLXEXFgy2a9ZaAkX8uyiietNvCYhYZ+y4WZ8=;
        b=IRnc5VTo+h5594E4ID8cGAbpoLTIrglqjZzblnmSUZ043nWWmuvOOxnVclaWlYHI2W
         ydtUuoglacWI3/u2J3c4rqn/MC5A5j33F2+C3B+qlIvh8y97JVMcqfyHUHPt91i3ZIoy
         VVgF9Ddwu8xGfopreYYjjGHsFPR0YVHiJMEAzR/aJMjlozjQagLBW+xq00JV0jds7NXb
         p8pxNAZyeGx/cOuUNiz1KnITocEk2c2MG3zfsEhjVoIZWeF9Ms4fZf+iNgvUzRVAbT+Z
         MhwoUgoWBsXPHoKTrS4a1XpSyW23dmal2dwNW8l6mybQLBjd41ejgAZMaZy/6p9YEy64
         WG9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786236682; x=1786841482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        b=mayzSwPHAL/EG8FJoZI5aKdT8CHoYJZoOfGR60texMJUcsaFfweID2d2APveCsFmm1
         7NfP3GfZ2EQU894bhlpMILuLG+mTAieRNk2Jbtyqn98artzE34Y0EuWwG/QK6ZJ6toMn
         n5lK4xcaN8kCTgvUrVo9N9V5hR2yPbiohBmiih119V+93+N+BujhVBcKw9vy47pvbFo+
         TwQZREPnF2dEqkUaMXFFfIH2oMsuXEzfppmkQt9dP8O7W2ds8X2A8VUohwh1dmhKplIl
         3fWjha0ZSz5WNIA8LvL1QIChiW5WKOaWQhiyxQJ06q+i6dlaSnIGjChtT02tH4Fvqxot
         LKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786236682; x=1786841482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
        b=V3gjWfMKGsKlAwC+etf5AQue4ktvx06EnIfTl8QSdi5DZA4hlfL1D81tbYvP+Vyhxf
         QYtGywMmGP35TQM1063RHoK/9UQGYnk2hFln0iwH2ajiTh6AJDgAJI/WGiLahyalFdby
         GCakp393Gy8PsL626ZH83h7NCY2e3gwVpZBSadkJOKcxXYooed525V9pkoZ4nCk64m5A
         Ls5EJOnfvh6I0s5LHxYie9DZ/0e4CYMv/60NTmGWjGUSFvrZTVE9ELTqyszJWnsex8MR
         M1XSiDCdgnaMgnr+oavcSoEnu/bo44Qp0KSMMNwtY5My1qKnaNk51uF46/eNdB3GiInC
         dw1A==
X-Forwarded-Encrypted: i=1; AHgh+RpuEHpgmwep7p6Zq/GxwF+vc67IMM5mG4LKNMaSqlo2Uail/hnixsor7IrcXd7dwby0pdcSeyfwk9rJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRj6Eigg2/Jxqw/pKsaAw/DpwRY2vlFHHFWBw51XhyLbPXCwU
	Q6qsWlVUuH44FU0v2AXEsLONX0c4+5IEjcyzS/ZwA6fJQJOAEDWweROBBcJBJhxAftAeVhvINFo
	mUwgtG7Fi2As0HNcCIPTCiaQYH2tKkUbgooUXg5i2
X-Gm-Gg: AR+sD11PVRPtOkOT7JpONKyYWFcI40b+z5WJecDv4KCabXyo5f3aK8KizfWJle9PS7s
	EOmrF80V8eg4u/hyaRihs4Xh8f+yIKXDbIFlor6PW/XuavtDe3nVe8BqMkhniIAde0I5J95R3FG
	HIdiqkr2d+dQvZ89K+WwqVWNXwZPy/OdKx21UEnadvHfOE8SHzncxgu7mTS6YvCOemruR9/bXPP
	fCSOGhR0BsTjXqsKqepMys03apkWJ1a/w9PUjee0AjTpkC+nFss6u3Kok4YVPwdWJfOtN19ayng
	xh41FlifLq9x9AsnHD/eD9lsG3SITjKGqhzLi7/Xd0U=
X-Received: by 2002:a05:622a:2c2:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-52d28104052mr10844831cf.5.1786236681095; Sat, 08 Aug 2026
 17:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org> <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:51:10 -0700
X-Gm-Features: AUfX_mwrAfErRpWaGdsaXjFbVsuLxmBdhaCS8dBRSF7bNpazo-ZM1X1L3isxLV8
Message-ID: <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] mm/vma: introduce VMA anon page offset field and
 add helpers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:22=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Establish fields in vm_area_struct to store the anonymous page offset of
> VMAs.
>
> Initially, the anonymous page offset of a VMA is vma->vm_start >>
> PAGE_SHIFT.
>
> When a VMA is remapped to new_address its anonymous page offset is either
> updated to new_address >> PAGE_SHIFT if unfaulted or, if faulted, remains
> equal to the anonymous page offset it had when first faulted.
>
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offsets. By adding anonymous
> offset as a property of VMAs, we can now track them by their anonymous pa=
ge
> offset instead.
>
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work f=
or
> the scalable CoW anonymous rmap rework.
>
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
>
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.
>
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
>
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
>
> Update the VMA userland tests to account for this change.
>
> No callsites are updated yet, so no functional change intended.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mm_types.h        | 12 +++++++++
>  mm/vma.h                        | 14 ++++++++++
>  mm/vma_init.c                   |  1 +
>  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
>  5 files changed, 112 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 87feaa5a2b78..df78847f5f07 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct =
vm_area_struct *vma)
>         return vma_end_pgoff(vma) - 1;
>  }
>
> +/**
> + * vma_start_anon_pgoff() - Get the anonymous page offset of the start o=
f @vma
> + * @vma: The VMA whose anonymous page offset is required.
> + *
> + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted th=
en the
> + * anonymous page offset at the time of first fault.
> + *
> + * If the VMA is anonymous, this returns the same value as vma_start_pgo=
ff().
> + *
> + * This value is used for tracking MAP_PRIVATE file-backed mappings by t=
heir
> + * anonymous page offset.

I assume this function should not be used with shared file-backed
mappings, right? If so, maybe add a comment like the one you have for
linear_anon_page_index(): "It is not valid to call this function for
shared file-backed mappings."?



> + *
> + * Returns: The anonymous page offset of the start of @vma.
> + */
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +/**
> + * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive=
 end of
> + * @vma.
> + * @vma: The VMA whose end anonymous page offset is required.
> + *
> + * This returns the anonymous exclusive end page offset of @vma, which i=
s useful
> + * for expressing page offset ranges.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The exclusive end anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +/**
> + * vma_last_anon_pgoff() - Get the anonymous page offset of the last pag=
e in
> + * @vma.
> + * @vma: The VMA whose last anonymous page offset is required.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The last anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline unsigned long vma_desc_size(const struct vm_area_desc *des=
c)
>  {
>         return desc->end - desc->start;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 939b5ea8c9e0..ebf0d912be7d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -967,6 +967,11 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       /*
> +        * Low 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_lo;
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
>          * list, after a COW of one of the file pages.  A MAP_SHARED vma
> @@ -1041,6 +1046,13 @@ struct vm_area_struct {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map vmlock_dep_map;
>  #endif
> +#endif
> +#ifdef CONFIG_64BIT
> +       /*
> +        * High 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> diff --git a/mm/vma.h b/mm/vma.h
> index 0bc7d521e976..54ed7c744e3b 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_stru=
ct *vma, pgoff_t pgoff)
>         vma->vm_pgoff =3D pgoff;
>  }
>
> +static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgof=
f_t pgoff)
> +{
> +#ifdef CONFIG_64BIT
> +       vma->__vm_anon_pgoff_hi =3D pgoff >> 32;
> +#endif
> +       vma->__vm_anon_pgoff_lo =3D pgoff & GENMASK(31, 0);
> +}
> +
> +static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_=
t pgoff)
> +{
> +       vma_assert_can_modify(vma);
> +       __vma_set_anon_pgoff(vma, pgoff);
> +}
> +
>  static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t del=
ta)
>  {
>         vma_assert_can_modify(vma);
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 715feee283f0..baa7e82f47e3 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_stru=
ct *src,
>         dest->vm_end =3D src->vm_end;
>         dest->anon_vma =3D src->anon_vma;
>         dest->vm_pgoff =3D vma_start_pgoff(src);
> +       __vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
>         dest->vm_file =3D src->vm_file;
>         dest->vm_private_data =3D src->vm_private_data;
>         vm_flags_init(dest, src->vm_flags);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index c52b23773cd2..26d9210b1e8b 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -577,6 +577,7 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       unsigned int __vm_anon_pgoff_lo;
>
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
> @@ -612,6 +613,9 @@ struct vm_area_struct {
>  #ifdef CONFIG_PER_VMA_LOCK
>         /* Unstable RCU readers are allowed to read this. */
>         refcount_t vm_refcnt;
> +#endif
> +#ifdef CONFIG_64BIT
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> @@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct v=
m_area_struct *vma)
>         return vma_start_pgoff(vma) + vma_pages(vma);
>  }
>
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline int vfs_mmap_prepare(struct file *file, struct vm_area_des=
c *desc)
>  {
>         return file->f_op->mmap_prepare(desc);
>
> --
> 2.55.0
>
