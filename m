Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCD40F736
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379131; cv=pass; b=G9Cq6cjuaTm0h4oPi4ya/xiO6nVDItXeJ0tzA0ql9yAcMQs+mpqFBVhZK5NSS66rhAJIXIFhCY1E1xCIWMH1dKHs5f0CKJnmc6Ni91TF/Vsj45iPOg6t9cOrB0DykW2NT8oe01V/QtTAFeQr1isxWBIQipVtSJqJ11vusz+kjPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379131; c=relaxed/simple;
	bh=vvgNKu9uyv9I5R9kHg2ihehIkxNH8NosNyyy4+wPpsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmfo1QAuAZWsgJuQq32JHaNG3eICI9kuCbXvLRL7Slc6qx8m4iX0WUDAcLl0Q8kWCHx8bx1l0n7DEDbY2VU+y0yZm5y8BE52hqkPFuiNAldRoeMp4pYZRtpIM65ZAO7MVGt1MFt0bvSG4hFSOqIjp6xvyKi/mYB+CQs/d0fzL4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnSX4srl; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnSX4srl"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so441181cf.0
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 09:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786379128; cv=none;
        d=google.com; s=arc-20260327;
        b=WUHAFpWI0QcNTEiFR0d0aIaR55xwJY0nfGzpmTdvOX7C6+xqfCWWOwtwzVeCH0kFf7
         7AG6V2polkfNMrbOqTNcKw3JqG9iSvSSsPchqFSrXhgWy6xbc/O+pQuUSydGR4FFm4L6
         GcmlGt9zfQcgXUJJulRCu+pg+7C1l01P7i40QzP85f0UAf883nBgl931QflM+FQAQoC2
         OzIfe5PtgXuhoJjaWsvVHWjobHEsDR52igX7wOutsWj/YkItPLyt2YHa8xnNmq9Dd1g8
         e5W6KLDdUnU82VpzB8VGnskS7oidBlNvI7gXFUq7h4UZGt2Wf1lNn9mpcfWhr/WyJjPf
         ESKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        fh=h6uEJDLxvcDWJt5AfJQr11prsXS4OeOEdV5k5w8U5ws=;
        b=aaOnK9UQhWr2sTK7X2Mw7bVQi6WPpctmjvhoNbQohoUszKrLSVkiOQQ7e3pwNutsyK
         66MFwg+Ljltqb54V8MB6pLK0OoeYUeVcDSfOR8yo+E/JkjmoLMaRR+olgGIKn0zw39NH
         yJv5ghxP6eM+3NU/47wOtWSr0NC1WhqGQOSfEW+wAuKY0ajF6LNQfrTx3HDK48Rs0+0f
         6nxoygfEBdh8Fpj8GO6/RhH0QFwQJ/sSDtXajreK8HcoFMuL4PTeMcBN31zGmUtBbufy
         lBxYyh4tqOA/M6a6Iw7Z+htOVDo5phud/v5k08BFRNEx5eshfIpAS6Ocl5L1teQZwLuW
         WDuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379128; x=1786983928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        b=cnSX4srljyHNxtz8+ebQsbPLVxspqfpoIqSLmsWAildeeNYgXoHZa7KGoAxUyX77W8
         D4KguptuceXODwM8sSDS3p0s/amPy4tk+0ZFSm55MxazfgCDZe3PeT+WxElOCjKq6roJ
         r4vSyIRR9ejNSjq49zaOp9cMSJmbiSZC3WBoxA53w7seEAZpUaGyTpMnkkdcP1xyK+wX
         VYAwX8Auqw00xcAkHeGfaFPwoYNXnXXfhtwyP1COxg5ltXdanflWeA8lr2oOomNqfTA1
         Hwi7+82yfHl6cT+dEZ5OgCgY09gNanMzX3aOPmbj/3VwMfiwJkmXH1dCPDhOCNdC48cZ
         8Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379128; x=1786983928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        b=SRelCqeYphatmyWYq4OuOte09wuJ6lYf0/dzYNt4CMbuM5QkT22a7Tw9+2lOAob8MM
         76bRNSPJu7kS7JnJfazekKAyAkzjP4w2e0d+QPfvRiqvcVwegWQDyOn/oCaDjLhnxQZQ
         02l+rWn1MBgQxZangOSq+aODG4DxWp54Pp0gS+NE5gh45ThZ/sT7p9GvgwRYUkIFL7Z+
         +8O807X66m5zz8uLpyTqfdcaXHYjE8on0h/WAr8meQOT6yLZ2PZMipudbWDirShhX689
         +kk33qTyCezgKGhHAeoqH4ozzEXL0xDH63OerVQU4F5owpiKaijt/CB9GueI+sDP/Qz1
         iChg==
X-Forwarded-Encrypted: i=1; AHgh+Rpfb4rHzcG18xuKxy0GneMOH6S/ID0EOhSXDHHUZcijkt60X8xfIkUDu8EaxBoEdAgzwYT00neHxH8o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1EUolNDcfIiAV2LlPZvzjnn6wELjhRdVEoMtVMRs4eQdSmQL
	Zx5sknokno4LiI7DqArdi29SK9TzihDYgL1OZXWVbFDqo7gN+5kK5yV6pWQRhKxw1Sj3bBpEgYk
	wPhkqnKMWxvhVLYpD5dHUyDVVGQOG6UqojC9+wJBt
X-Gm-Gg: AR+sD12KwVySP8n9vPPSvOIh9NUrGDqehU7tsfOcA+3Wv8hIxi4AUOtZRd8ydoDalAz
	7MTUv76/ZklvfoL3y07Ha7AfjGtjk9kHUS7M3BE7huLmi2vMMHTEHQr5AT5cNlPnZ1Lm8VESN3h
	tuJa9UBQZfCpg6GV5YABEB8rZZ0p0c+424rMsGOhAnZhjVq+SXWnRuwb7VGc3rLZ4GBvgHQ1D2I
	pAD2HFXhelgOmMZsqXwOw7CcKaYj8KhY7Wo+B79xEFJ+fJ8UC2nC+5smRmKSdt4akSReQKKZQ6D
	1tjGgsSOV5k3oGQyp0ihyvHz5G5EKVVStbRYc6ir5hM=
X-Received: by 2002:a05:622a:1b06:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52d2817b938mr34999921cf.13.1786379127554; Mon, 10 Aug 2026
 09:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
 <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com> <anmNojqwGzdiLkIm@lucifer>
In-Reply-To: <anmNojqwGzdiLkIm@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 09:25:16 -0700
X-Gm-Features: AUfX_mz9WU1SPgoH6YTV3DTKwNKGMKFcURK6j4M8chTMyTH0jJu5GwZ0wv2wrtI
Message-ID: <CAJuCfpHtaeeqn9UbnG1U0iA8uhrcQpEG8g8+G_RybVbwoOE0sA@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
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

On Mon, Aug 10, 2026 at 1:40=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Sat, Aug 08, 2026 at 05:49:48PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Aug 6, 2026 at 1:23=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > >
> > > This function provides the anonymous equivalent of linear_page_index(=
),
> > > instead offsetting based on the anonymous page offset of the VMA.
> > >
> > > It is valid only for anonymous or MAP_PRIVATE file-backed mappings, i=
n
> > > other words CoW mappings.
> > >
> > > For pure anon VMAs, this will be equal to linear_page_index().
> > >
> > > Assert that both of these invariants are true In linear_anon_page_ind=
ex()
> >
> > s/In/in
>
> Ack. I ran these patches through claude several times and it didn't get t=
his ;)
> the machines are not taking over just yet...
>
> Andrew - could you change this in-place? Thanks!
>
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index c6fc783aaee5..0adfa6605653 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const=
 struct vm_area_struct *vma,
> > >  static inline pgoff_t linear_page_index(const struct vm_area_struct =
*vma,
> > >                                         const unsigned long address)
> > >  {
> > > -       pgoff_t pgoff;
> > > +       return linear_page_delta(vma, address) + vma_start_pgoff(vma)=
;
> > > +}
> > > +
> > > +static inline pgoff_t __linear_anon_page_index(const struct vm_area_=
struct *vma,
> > > +               const unsigned long address)
> > > +{
> > > +       return linear_page_delta(vma, address) + vma_start_anon_pgoff=
(vma);
> > > +}
> > > +
> > > +/**
> > > + * linear_anon_page_index() - Determine the absolute anonymous page =
offset of
> > > + * @address within @vma.
> > > + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @addre=
ss resides.
> > > + * @address: The address whose absolute page offset is required.
> > > + *
> > > + * This returns the anonymous page offset of @address, which is the =
page offset
> > > + * the address possessed at the time the VMA was first faulted.
> > > + *
> > > + * For anonymous mappings, this returns the same value as linear_pag=
e_index().
> > > + *
> > > + * For MAP_PRIVATE file-backed mappings, this returns the anonymous =
page offset
> > > + * of @address, which is the page offset the address possessed at th=
e time the
> > > + * VMA was first faulted.
> > > + *
> > > + * It is not valid to call this function for shared file-backed mapp=
ings.
> > > + *
> > > + * Returns: The absolute anonymous page offset of @address within @v=
ma.
> > > + */
> > > +static inline pgoff_t linear_anon_page_index(const struct vm_area_st=
ruct *vma,
> > > +               const unsigned long address)
> > > +{
> > > +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address=
);
> > > +
> > > +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> >
> > As discussed off the list, this assertion works even for read-only
> > anon mappings because, as you said, "there's no such thing as a pure
> > anon mapping that is !VMA_MAYWRITE_BIT, there is no way to achieve
> > that."
> > It took me some time to see that after reading your discussion with
> > David at [1] and [2], and I don't think it's very intuitive. Could you
> > please add a comment explaining that? Maybe add a comment at
> > vma_is_cow_mapping() definition since you are using the same assertion
> > in another patch of this series?
>
> Sure will do! It is very confusing stuff (and I was duly confused also at
> first).
>
> To save a respin (unless there's more stuff I need to address) I will pro=
bably
> reply to the relevant patch with a proposed new comment.

Sounds good!

>
> >
> > [1] https://lore.kernel.org/linux-mm/anBjpdMicqaGADr-@lucifer/
> > [2] https://lore.kernel.org/linux-mm/anLyhaI6kW-EWk13@lucifer/
>
> --
> Cheers, Lorenzo
