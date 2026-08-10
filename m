Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220BB410D3D
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379085; cv=pass; b=e/HVot+LtNEGZ+XWRNOehssd30K5PA7nhA74AzB99UjxagyGU2BWEyNNtd6is1NmbFCkM0TfLp+RvHcx8Bb/3XIVVTG1XapNZl1xOjzl+ixvSHvRv2umk9J/74rvPTzkWE0v+yuJh0U/5wDk5FWIS8FpLCbfX9i6cefcBqiV6nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379085; c=relaxed/simple;
	bh=xsv3OYq+qhqNl5YPp2xtEfRcSQIlgKl80gny1Oxx4q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCVMoH/0uzKcNMFmnQ1BczLUUT6a04UefZMPfGbw5e4XMB9Vh0QOtOnxkNgeYMIpTngZ01UIKQyZsm54aX8JZ8gf6iPKYtreUVblB4dnQU+hA/V1TBfdsAj+ddYJJTQjN0jhrGmURwr61MlbMXAxh9pyqFdM6B+ZNMP0KFh+P40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwVJn2aU; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwVJn2aU"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15a5b265so440611cf.0
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 09:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786379076; cv=none;
        d=google.com; s=arc-20260327;
        b=Vh1fsmTtEaCa+yI4xe2vi6S5Fhbnpwenc6BKP1y4nDhYB3BF+BHhFzy2/PloDpQeO+
         btgJHYA4KyIWPrvkYOm8HKds12DvY9kLOTazpaYjtqz/T9ygGuYHK1TRbrrkGNDRYoEv
         jQTEPT9A2e06XvvXu4QdYlNOkUwGbgk2b+XFCQC+67rZmiY9ZNUpnjsRvlhcsN7cSoWm
         Obegaq8ehF+CRipxMCqWx0iM9P8e+KOkGCete32l7uGoFuCy8FhK1OC04tC+PIC0Tj9o
         GAJjt+4LZOhk8VDsOZbKYVRtu1yyij9d7tg0cUeMKRH0af/SEma4ln9+kyyGVb1XDMub
         0A5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JnpU+yjthofc0zpgkM1QSjOc8GqltDckB0JeUB3rUkg=;
        fh=eoIGRj5NB0CwwYAMciOPP5Rf+bvIalzBbJjfn01Wsik=;
        b=EaZUmLAP+mma1MV2ik1iM8C/4TpgQJVGdHHuI8V+srZPbmLQxrStXH2yM0nGR2b6af
         JrJeru+xzQOFIgN6MsIIoPTDDiQfO8U9Otj0fb748W00U7kHeOzA5WSnKPbV8yxnPeRu
         KYSW773LjnKSWWcGiQeDjtYgpQMLDYeJGgi4r2o7clJV9rPuEC7Zkb3JeHLWjxxtJn9F
         mXkaCJWlYMborhBNbKSlvSiU/v5Mk8sS6p8aE/F8RZ95kUQtTIZ5v7BWuVTxXS2UOzl/
         6AL1bmJimK44V++j6ORZinE60J10GfPlSyqpG/KuvVRA+9eVM029a+OUBguKXxu3/vqM
         h9DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379076; x=1786983876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JnpU+yjthofc0zpgkM1QSjOc8GqltDckB0JeUB3rUkg=;
        b=CwVJn2aUT+uPUxvWndznLyNgoAttgvstZNGf6IG+zWNLE0PcW9XUojG1o+LB55xczN
         eoxS4uFpilcfMF2uGQ9vvcoKMshs03OE07DjaKlRhDxGm2YN8wF6Pz6zC94t0Ebqm6Y/
         Jmg1TzeA6qCQJz7G6PidXwbBeZQZOElJQcKgtahyQBla3thC2s5HmQy85YM6cBds+D8C
         Tv+j1RMaHLEQl+fxJQZph3PbguWzf/bB1D/ZMG7wc3BRdQ9EnSqvsmZG9vh+fGU6lqyC
         qCjCDULhxVX+9MktVBl/uCczxb1m4VD/7p1X5DngHRseshP7DSlWncnCytksMbggpEzU
         g3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379076; x=1786983876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnpU+yjthofc0zpgkM1QSjOc8GqltDckB0JeUB3rUkg=;
        b=kwrre2ZJn3if0LeqnQK1PInxJ7IqhpVCEcuXFsacR55MXyDUi9vVU1FfvQ31465ljX
         hn6KxxTehyTPy3ypSRR0cbqMnQfjIJgiN0Vi2euJ+QyUyjPpWwyFuuQ7sVXviHnu3hLu
         DK+LZSn4eX86EhEXacVQi4GMrgYLG5weBeS7icx2k8Ap+9HlLWkxnDw/irQtF/aZ6xSP
         /N+xbUYuzrO4qe/pRUbFhCcmJRh1mgLIQOlCgZe9FFL9sIBI/b2b2Tfxbw2ifBrXRmCy
         AfI0MXMd1uoMYmmOVwqu0RonPYsepDH193aZtpCec2P69ctt0tvC4na8e4BLLsXwbGRO
         +H3Q==
X-Forwarded-Encrypted: i=1; AHgh+Roey+GRL8TUDiFG6W6vpgi/gVkFM2OOMRYDmbEVk01A8LZ4FuztH/jx5GsGoIZe7os3bRZQ6E/l5vFi@vger.kernel.org
X-Gm-Message-State: AOJu0YzbohXa5UTccYW4AvEHc1QnFt8wusm0qCforYEzcgeqfgoH/np7
	sdt8U6alw0+H/bqwZlYIndAYdMQYiOJLHktEwnmEnc20It0CO6dKacBMLk/NvDa9Rr9FXBUifPN
	Qf0Ee7KYJsZpYfA2XOOaaYZZDASCQGlRG2jKW/E7V
X-Gm-Gg: AR+sD13hqpajHLoBcL0bOS3IYG3lqVA2hS7Jg+lD+0/71MB1dHvtYrgX07kkbwtdW+1
	/DeuywlSkWiT9BdyRlD6q1VqE5bUMPQWsUzldaLSWnrgaRu3ipn+hXllZjfQxShWwRoWUjMLqLm
	fDUQnm0FxILQ837QwFc7l+8WfejHmCylew2tz9OH+PJnHfMSzq9cFwvBPf6OoK4wub67VBwc1iN
	Xmp9XWnePb7tuInnoW6deTsePI4vykwbBqfgtMKOAYLbbMAGL8mKDQrQ7+R5W8OcHiwXUMcdOF5
	m40QntISGvC7uTD+CMOyz56qX+J/yquzZQ3i/wB/pXXOdJojDD2JLw==
X-Received: by 2002:a05:622a:2b0a:b0:519:b655:235 with SMTP id
 d75a77b69052e-52d2810222bmr38915311cf.3.1786379075203; Mon, 10 Aug 2026
 09:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
 <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com> <anmLnvWAyIJwjsXj@lucifer>
In-Reply-To: <anmLnvWAyIJwjsXj@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 09:24:23 -0700
X-Gm-Features: AUfX_mykce6fbL166nHsURFiLv_kMzKY9gOukzdEiVHYnjVKW8Vop-MtXqL00bE
Message-ID: <CAJuCfpGJuf3NOuPg4+7TaWhNOv5sN7WEY2awZOpDv1VV13J-DQ@mail.gmail.com>
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

On Mon, Aug 10, 2026 at 1:36=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Sat, Aug 08, 2026 at 05:51:10PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Aug 6, 2026 at 1:22=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 87feaa5a2b78..df78847f5f07 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const str=
uct vm_area_struct *vma)
> > >         return vma_end_pgoff(vma) - 1;
> > >  }
> > >
> > > +/**
> > > + * vma_start_anon_pgoff() - Get the anonymous page offset of the sta=
rt of @vma
> > > + * @vma: The VMA whose anonymous page offset is required.
> > > + *
> > > + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulte=
d then the
> > > + * anonymous page offset at the time of first fault.
> > > + *
> > > + * If the VMA is anonymous, this returns the same value as vma_start=
_pgoff().
> > > + *
> > > + * This value is used for tracking MAP_PRIVATE file-backed mappings =
by their
> > > + * anonymous page offset.
> >
> > I assume this function should not be used with shared file-backed
> > mappings, right? If so, maybe add a comment like the one you have for
> > linear_anon_page_index(): "It is not valid to call this function for
> > shared file-backed mappings."?
>
> No that's not the case, it is valid to access this for any VMA though it'=
s only
> meaningful for MAP_PRIVATE and anonymous VMAs (though in the latter case =
pgoff
> =3D=3D anon pgoff).
>
> The code keeps the anon pgoff values consistent even for shared mappings =
because
> - hey - we have the field anyway and it's easiest and safest to just keep=
 it the
> same.
>
> One alternative would be to have code that checks the flags and zeroes th=
e field
> otherwise , but then you have problems like - early on initialisation now
> there's an ordering requirement which can easily go wrong.
>
> Another alternative is to just leave it stale, but then that seems object=
ively
> worse and again requires branching code on update and set.
>
> All-in-all it's easier to keep this working the same for any type of mapp=
ing,
> it's just useless to do anything with the anon pgoff for a shared mapping=
 :)

Makes sense. Thanks for the explanation!

>
> --
> Cheers, Lorenzo
