Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C936531600
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179176; cv=pass; b=lRXrh25/qjjchrxpkHbG5qK7zgB9wTrrhfS4pEF/wJZu536EoSLhAvNONlkhYD3PzBZUEciw1T1jVT9EjAAWrzDnmEpLqAVzmr+nZRUw7QN3+4FpQse+Hs2CHF+wTWgIR3lN8S68oDGqkX7A5h2fvLWN1Z7QbcUmeTy4qGAjHqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179176; c=relaxed/simple;
	bh=sBl4ZByYDzJ/8ZI6Q0kRMv16nUjI5dxFlwl3GS78+IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQDEzR6n3jI2kgfovebIOvkT6LehHaOClMCeG4u/2/BxWxXEC3Xn7rQWbM0nwmpeR19oUYkjsHqF65FpvUQZymnrgZNpeNcGOX/Wb2RgwD+3JW5TpqP1/4vc0Hr48YVznz0mtLBp1S0wpjyRgWXcdfRh4Fh7OW7c5u1nYMl5NUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHwu69CH; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHwu69CH"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-532e9ad9a1eso236121cf.0
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 08:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179169; cv=none;
        d=google.com; s=arc-20260327;
        b=s+Ra1NhWXbmpafEg/dYAIgO5HA11pwN1Zm0sXK8eVX8hg9t3D4DDbziZ5UtB0Dd4zc
         MkVjmZQPE1FsSpsNp1GtgyACp4fnrID4iNfDoWgQD3ubxWJ3a+3E8+Dn7TnqLulU9EjQ
         gDpMsmQD6cHnCYo+LouH5kGKNloeco2HniLkeLtrg+e6cKkc/J8j4IcbuCha/APDyYW5
         G8T3k+6QA4CKCQXwi8RjhTrmEH45pjB5KU/XyzwRfDCiHO4RrM3Lll4SWA4TSk+aLDBU
         rmFTnqk2hTGfymDOImD9NJldpDjLiSP7Iy06AadKjEnvIUwysqdqcnwYlho+Kq6LF8RP
         EOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5SJVNSnlSjsq34C95HzHvRHsOZa9DdGTi/lITK1YAw=;
        fh=AmdwELOEqfT1tEfD3skHWLtDPhqT27atL0n+ongXYBA=;
        b=as62rTD/8oIKqcbhI03ZkR74MZab5QPl2ih4YsOCWZw8Av3QjvLmnvM5Ta6Oy4sIkr
         mhevM7JNxaP6fimy8VR9hT/caFh74WIvDRaCcFyDXxX3rFJW0xaxZCt8241AHaXtv4XO
         HTSVPZXejLlKkMKI4CWaVWVgdstgT4WybmmN7giOsNRA+EDgiTn9B4e8PAtZTPFZXuDV
         2xOlIs1+8W8zmIPyK5gf60Qi7mGnMO1AYMEBR+RRjCH8R07z97JBTBMAHtd2cXgN9QxU
         UKzLOhjts0LRo2m7Bl3jsegWp81dp3wahnaw5uL1ngk/LYvW+YJbttAHUOJMYQEU/CNd
         jJPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790179169; x=1790783969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5SJVNSnlSjsq34C95HzHvRHsOZa9DdGTi/lITK1YAw=;
        b=AHwu69CH5xFuFip4yAK1pru8PwxBDM6K80mpiWYRMGd7DhgH8BzYYIcEbgotqua1mW
         UzgxBRgLLESZ8TClQJvQgowFY4p1MSmHQ3kjootIZp2CRiq/F9hq8eXTk1ksJpnpZg7w
         O8L7xKPj21LIvyWKwx1DNa3QOi5BUKbAGHfnb8CDPrW228CZmiFvc3cdq5TaeH4KJT9l
         qunP0NRFFDJxaCibPzO2BRdC/3WCk5mrnFzFQdYz4fgPNrrqZn1fipoC+dJ/QNwYtebO
         J69ukukhFhrYJL5OZsIlAnYIEbFoSL1TGfnWrdmPP3cM7ghcO8HnmjCpeWGQECkXpmEg
         Ns2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179169; x=1790783969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5SJVNSnlSjsq34C95HzHvRHsOZa9DdGTi/lITK1YAw=;
        b=wspryxuBU8hKclcueC+oPyL949faS3Ynr1z6dy0EmTxHT20b8fBcLc03nHMTFl+nKf
         y+V6axDLSUmLIH+RyEY0amhNirDx0BxSvQcZppOUKiLRpprvg6isl3nRHVXuU9FMVUJ1
         ki/t0htmPMaDqFteqN/Y34kcy+TDK2TT2FnHiKGYcWTx5P/o1MCrUryrSLowYwb7KNhz
         G+L3FLSY94W3OjQjf0DETCo06xq664WZxxZXigwYqfoOrqYSTZ2hk/e+agwMrpQrCSJd
         jaNW16GRzzegr7SgvCCx0YVe2AvEx4BNe2qrbphkv/5EHz2/cMnQC20qvrjKtseIgp6Z
         kimA==
X-Forwarded-Encrypted: i=1; AKwUvBx0QxID4G6cmT9QWHutMqxiXOorXmHs0pEFjil4IRIVXwfKnPnGDksATI0ailBOofhWJNd0I8ycmmFA@vger.kernel.org
X-Gm-Message-State: AFuF++mLY7t2BBauPEwXbXoMR7Vvy1ENVUBWjs6EcCzMlAtpFCOnAkf4
	QWn2HPojDwhcrbS9zL5C4MadMR2CWtGUQtF78JDJUhCGAqsKoXcuN24/4SBomkh4HlvY7ANAzvw
	Kt7JAOglTGEiAjTC+RVG5vU0wjsR74HfxHNwjLcxo
X-Gm-Gg: AYBFou3e4O3L+xPhrb32t2MpkMVCav/hPwcbSDo3hYMY1RssTx7t/RoadYz/0XdLrF4
	FUur1+kueFIhes5zWFWp+0cl79N+pqpC3O8bkIyykuZJNddSNyQVpKxAKOox1teQ3XiML4Ojb4u
	0+gyBpKLnw2u63fGADRlY8psfbXXC5N+xmgqeuMrGhF2h0xBDWhUP7tUzbjjqFz3/yA1ULofQsj
	OfP2/Rqmqu9rm6rqJBx5HMKId9EF/MZB98sH7W1N4U2oOfOAEWyBFcr6DUugPD1CmkiZWoP/w3H
	tnwfDEfYQD8IY8seo+fVMON9J1W4VWjlWmrAnICLw92Wzi/CDHDdcFZifEkKViNXuBwoLKcSdSV
	svEMnvuXMlhk7iPIxQ8NA
X-Received: by 2002:ac8:5989:0:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-532f8ea0340mr1106341cf.8.1790179167963; Wed, 23 Sep 2026
 08:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-1-4583d8a23bca@kernel.org>
 <CAJuCfpFe+pLusPy-xWYHp2rTP1becBb2nhX16xXd+hKD5Q+Z3g@mail.gmail.com> <arPw-ivHytA_YZTQ@gremlin>
In-Reply-To: <arPw-ivHytA_YZTQ@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 08:59:15 -0700
X-Gm-Features: AclHuK-LB3FJjVej026w9dFvJtSh1nBWJXsZp4uIwz4rkW0AFsOG-iMlndIpr-4
Message-ID: <CAJuCfpF8u=uCkqQ6+2BiOo2ufR3E-JM97ML-_Sbo4cQBfeEHuQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/40] mm/vma: fix mmap_prepare file handling, remove file_doesnt_need_get
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:47=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Wed, Sep 23, 2026 at 08:21:58AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 17, 2026 at 9:23=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > >
> > > The map->file_doesnt_need_get flag is confusing and the existing
> > > implementation has holes.
> > >
> > > Drivers are permitted to change the owning file of a mapping. If they=
 do
> > > so, they are required to take a reference on that file.
> > >
> > > The mmap() operation which ultimately invokes __mmap_region() is guar=
anteed
> > > to drop the refcount for the original file the mapping was made under=
, but
> > > this is not true for the replaced file.
> > >
> > > This has been addressed so far by tracking map->file_doesnt_need_get,=
 which
> > > is rather poorly named and unfortunately fails to correctly track whe=
ther
> > > or not an additional put were needed in a number of cases.
> > >
> > > Make life easier by removing this flag, and instead drop the referenc=
e for
> > > both mmap_prepare and the deprecated mmap callback in a new function
> > > put_map().
> > >
> > > Track whether this needs to be done by aligning mmap_state with
> > > vm_area_desc and store the original file in the map->file field, keep=
ing
> > > the updated file in map->vm_file.
> > >
> > > In order to have the same behaviour for both types of hooks, only dro=
p the
> > > reference __mmap_new_file_vma() itself took in its error path, deferr=
ing
> > > the replaced file's reference to put_map().
> > >
> > > To make this work correctly, map->vm_file has to be updated before an=
y
> > > error handling, so update __mmap_new_file_vma() and call_mmap_prepare=
() to
> > > set this field first.
> > >
> > > Also when mmap_prepare() changes the file and is then merged, the ref=
erence
> > > count also must be decremented, so update the logic to call put_map()=
 in
> > > this case too.
> > >
> > > Also update __compat_vma_mmap() to manually perform this step for sta=
cked
> > > file systems using the compatibility layer, and update
> > > compat_set_vma_from_desc() to replace vma_set_file() with a correct
> > > refcount/file update.
> > >
> > > No in-tree driver is impacted by the incorrect implementation of this
> > > currently (no driver that does this is mergeable for one), so this do=
es not
> > > need to be a fix.
> > >
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  mm/internal.h |  1 +
> > >  mm/util.c     |  5 +++-
> > >  mm/vma.c      | 83 +++++++++++++++++++++++++++++++++++--------------=
----------
> > >  mm/vma.h      |  6 +++--
> > >  4 files changed, 59 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 0dca33db068f..fe576d468af4 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -7,6 +7,7 @@
> > >  #ifndef __MM_INTERNAL_H
> > >  #define __MM_INTERNAL_H
> > >
> > > +#include <linux/file.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/khugepaged.h>
> > >  #include <linux/mm.h>
> > > diff --git a/mm/util.c b/mm/util.c
> > > index bf0513d1d3d0..016932780925 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -1228,8 +1228,11 @@ int __compat_vma_mmap(struct vm_area_desc *des=
c,
> > >
> > >         /* Perform any preparatory tasks for mmap action. */
> > >         err =3D mmap_action_prepare(desc);
> > > -       if (err)
> > > +       if (err) {
> > > +               if (desc->vm_file !=3D vma->vm_file)
> > > +                       fput(desc->vm_file);
> > >                 return err;
> > > +       }
> > >         /* Update the VMA from the descriptor. */
> > >         compat_set_vma_from_desc(vma, desc);
> > >         /* Complete any specified mmap actions. */
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 55917d097933..fa784f069da4 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -24,7 +24,8 @@ struct mmap_state {
> > >                 vm_flags_t vm_flags;
> > >                 vma_flags_t vma_flags;
> > >         };
> > > -       struct file *file;
> > > +       struct file *file;      /* mmap()-specified file. */
> > > +       struct file *vm_file;   /* May be updated by mmap_prepare. */
> >
> > Overall I like the change but I think you could avoid extra churn by
> > keeping the name of `file` as is and add `struct file *orig_file`
> > instead as:
> >
> > +       struct file *orig_file;   /* mmap()-specified original file. */
> > -       struct file *file;
> > +       struct file *file;      /* May be updated by mmap_prepare. */
> >
> > Then many uses of map->file would stay unchanged.
>
> I didn't actually want to do the churny version of this but the problem
> with doing something else is that would then contradicts what's in
> vm_area_desc:
>
> struct vm_area_desc {
>         /* Immutable state. */
>         ...
>         struct file *file; /* May vary from vm_file in stacked callers. *=
/
>         ...
>         /* Mutable fields. Populated with initial state. */
>         ...
>         struct file *vm_file;
>         ...
> };
>
> And suddenly what is 'file' there (inherited file) is the modifiable one
> here and it's more confusing.
>
> As per the commit msg:
>
>         Track whether this needs to be done by aligning mmap_state with
>         vm_area_desc and store the original file in the map->file field, =
keeping
>         the updated file in map->vm_file.
>
> But maybe I need to make that decision clearer there?

Ah, I see. The description is clear, I was just too focused on the
churn, I guess.
The reasoning to rename makes sense to me.

>
> >
> > >         pgprot_t page_prot;
> > >
> > >         /* User-defined fields, perhaps updated by .mmap_prepare(). *=
/
> > > @@ -43,8 +44,6 @@ struct mmap_state {
> > >
> > >         /* Determine if we can check KSM flags early in mmap() logic.=
 */
> > >         bool check_ksm_early :1;
> > > -       /* If .mmap_prepare changed the file, we don't need to pin. *=
/
> > > -       bool file_doesnt_need_get :1;
> > >  };
> > >
> > >  #define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, anon_pgoff_=
, vma_flags_, file_) \
> > > @@ -58,6 +57,7 @@ struct mmap_state {
> > >                 .pglen =3D PHYS_PFN(len_),                           =
     \
> > >                 .vma_flags =3D vma_flags_,                           =
     \
> > >                 .file =3D file_,                                     =
     \
> > > +               .vm_file =3D file_,                                  =
     \
> > >                 .page_prot =3D vma_flags_to_page_prot(vma_flags_),   =
     \
> > >         }
> > >
> > > @@ -70,7 +70,7 @@ struct mmap_state {
> > >                 .vma_flags =3D (map_)->vma_flags,                    =
     \
> > >                 .pgoff =3D (map_)->pgoff,                            =
     \
> > >                 .anon_pgoff =3D (map_)->anon_pgoff,                  =
     \
> > > -               .file =3D (map_)->file,                              =
     \
> > > +               .file =3D (map_)->vm_file,                           =
     \
> > >                 .prev =3D (map_)->prev,                              =
     \
> > >                 .middle =3D vma_,                                    =
     \
> > >                 .next =3D (vma_) ? NULL : (map_)->next,              =
     \
> > > @@ -2447,7 +2447,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
> > >   */
> > >  static bool accountable_mapping(struct mmap_state *map)
> > >  {
> > > -       const struct file *file =3D map->file;
> > > +       const struct file *file =3D map->vm_file;
> > >
> > >         /*
> > >          * hugetlb has its own accounting separate from the core VM
> > > @@ -2496,7 +2496,7 @@ static void vms_abort_munmap_vmas(struct vma_mu=
nmap_struct *vms,
> > >
> > >  static void update_ksm_flags(struct mmap_state *map)
> > >  {
> > > -       map->vma_flags =3D ksm_vma_flags(map->mm, map->file, map->vma=
_flags);
> > > +       map->vma_flags =3D ksm_vma_flags(map->mm, map->vm_file, map->=
vma_flags);
> > >  }
> > >
> > >  static void set_desc_from_map(struct vm_area_desc *desc,
> > > @@ -2506,7 +2506,7 @@ static void set_desc_from_map(struct vm_area_de=
sc *desc,
> > >         desc->end =3D map->end;
> > >
> > >         desc->pgoff =3D map->pgoff;
> > > -       desc->vm_file =3D map->file;
> > > +       desc->vm_file =3D map->vm_file;
> > >         desc->vma_flags =3D map->vma_flags;
> > >         desc->page_prot =3D map->page_prot;
> > >  }
> > > @@ -2586,6 +2586,10 @@ static int __mmap_setup(struct mmap_state *map=
, struct vm_area_desc *desc,
> > >         return 0;
> > >  }
> > >
> > > +static bool map_same_file(struct mmap_state *map)
> > > +{
> > > +       return map->vm_file =3D=3D map->file;
> > > +}
> > >
> > >  static int __mmap_new_file_vma(struct mmap_state *map,
> > >                                struct vm_area_struct *vma)
> > > @@ -2593,20 +2597,23 @@ static int __mmap_new_file_vma(struct mmap_st=
ate *map,
> > >         struct vma_iterator *vmi =3D map->vmi;
> > >         int error;
> > >
> > > -       vma->vm_file =3D map->file;
> > > -       if (!map->file_doesnt_need_get)
> > > -               get_file(map->file);
> > > +       vma->vm_file =3D map->vm_file;
> > > +       if (map_same_file(map))
> > > +               get_file(map->vm_file);
> > >
> > > -       if (!map->file->f_op->mmap)
> > > +       if (!map->vm_file->f_op->mmap)
> > >                 return 0;
> > >
> > >         error =3D mmap_file(vma->vm_file, vma);
> > > +       map->vm_file =3D vma->vm_file;
> > > +
> > >         if (error) {
> > >                 UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_e=
nd,
> > >                             map->prev, map->next);
> > > -               fput(vma->vm_file);
> > > -               vma->vm_file =3D NULL;
> > > +               if (map_same_file(map))
> > > +                       fput(map->vm_file);
> > >
> > > +               vma->vm_file =3D NULL;
> > >                 vma_iter_set(vmi, vma->vm_end);
> > >                 /* Undo any partial mapping done by a device driver. =
*/
> > >                 unmap_region(&unmap);
> > > @@ -2623,7 +2630,6 @@ static int __mmap_new_file_vma(struct mmap_stat=
e *map,
> > >                         !vma_flags_test(&map->vma_flags, VMA_MAYWRITE=
_BIT) &&
> > >                         vma_test(vma, VMA_MAYWRITE_BIT));
> > >
> > > -       map->file =3D vma->vm_file;
> > >         map->vma_flags =3D vma->flags;
> > >
> > >         return 0;
> > > @@ -2631,7 +2637,7 @@ static int __mmap_new_file_vma(struct mmap_stat=
e *map,
> > >
> > >  static void map_set_anon(struct mmap_state *map)
> > >  {
> > > -       map->file =3D NULL;
> > > +       map->vm_file =3D NULL;
> > >         map->vm_ops =3D NULL;
> > >         map->pgoff =3D map->addr >> PAGE_SHIFT;
> > >  }
> > > @@ -2643,7 +2649,7 @@ static bool map_is_private(const struct mmap_st=
ate *map)
> > >
> > >  static bool map_is_anon(const struct mmap_state *map)
> > >  {
> > > -       return map_is_private(map) && !map->file;
> > > +       return map_is_private(map) && !map->vm_file;
> > >  }
> > >
> > >  /*
> > > @@ -2688,7 +2694,7 @@ static int __mmap_new_vma(struct mmap_state *ma=
p, struct vm_area_struct **vmap,
> > >         }
> > >
> > >         /* Invoke callbacks. */
> > > -       if (map->file)
> > > +       if (map->vm_file)
> > >                 error =3D __mmap_new_file_vma(map, vma);
> > >         else if (!is_anon)
> > >                 error =3D shmem_zero_setup(vma);
> > > @@ -2797,11 +2803,15 @@ static int call_mmap_prepare(struct mmap_stat=
e *map,
> > >         int err;
> > >
> > >         /* Invoke the hook. */
> > > -       err =3D vfs_mmap_prepare(map->file, desc);
> > > +       err =3D vfs_mmap_prepare(map->vm_file, desc);
> > >         if (err)
> > >                 return err;
> > >
> > > -       /* It's invalid for mmap_preprare hooks to clear vm_ops. */
> > > +       /* Update first so file refcount tracked correctly. */
> > > +       if (desc->vm_file !=3D map->vm_file)
> > > +               map->vm_file =3D desc->vm_file;
> > > +
> > > +       /* It's invalid for mmap_prepare hooks to clear vm_ops. */
> > >         if (!desc->vm_ops)
> > >                 return -EINVAL;
> > >
> > > @@ -2811,10 +2821,6 @@ static int call_mmap_prepare(struct mmap_state=
 *map,
> > >
> > >         /* Update fields permitted to be changed. */
> > >         map->pgoff =3D desc->pgoff;
> > > -       if (desc->vm_file !=3D map->file) {
> > > -               map->file_doesnt_need_get =3D true;
> > > -               map->file =3D desc->vm_file;
> > > -       }
> > >         map->vma_flags =3D desc->vma_flags;
> > >         map->page_prot =3D desc->page_prot;
> > >         /* User-defined fields. */
> > > @@ -2826,7 +2832,7 @@ static int call_mmap_prepare(struct mmap_state =
*map,
> > >          * anonymous mappings. Rather than allowing these mappings to=
 be odd
> > >          * outliers, simply make them truly anonymous.
> > >          */
> > > -       if (map_is_private(map) && file_is_dev_zero(map->file))
> > > +       if (map_is_private(map) && file_is_dev_zero(map->vm_file))
> > >                 map_set_anon(map);
> > >
> > >         return 0;
> > > @@ -2845,7 +2851,7 @@ static void set_vma_user_defined_fields(struct =
vm_area_struct *vma,
> > >   */
> > >  static bool can_set_ksm_flags_early(struct mmap_state *map)
> > >  {
> > > -       struct file *file =3D map->file;
> > > +       struct file *file =3D map->vm_file;
> > >
> > >         /* Anonymous mappings have no driver which can change them. *=
/
> > >         if (!file)
> > > @@ -2868,6 +2874,20 @@ static bool can_set_ksm_flags_early(struct mma=
p_state *map)
> > >         return false;
> > >  }
> > >
> > > +static void put_map(struct mmap_state *map)
> >
> > nit: maybe put_map_file() to be more specific?
>
> Sure will change.
>
> >
> > > +{
> > > +       /*
> > > +        * An error occurred or the VMA was merged.
> >
> > It's a bit weird that the function explains when it is being used.
> > Having an appropriate comment at the call site seems better to me.
>
> Ack will change.
>
> >
> > > +        *
> > > +        * If the file was changed by the driver (which is required t=
o increment
> > > +        * the replacement file's reference count), drop its referenc=
e count.
> > > +        *
> > > +        * On error, the caller always drops the original file regard=
less.
> > > +        */
> > > +       if (map->vm_file && !map_same_file(map))
> > > +               fput(map->vm_file);
> > > +}
> > > +
> > >  static unsigned long __mmap_region(struct file *file, unsigned long =
addr,
> > >                 unsigned long len, vma_flags_t vma_flags,
> > >                 unsigned long pgoff, struct list_head *uf)
> > > @@ -2922,7 +2942,10 @@ static unsigned long __mmap_region(struct file=
 *file, unsigned long addr,
> > >
> > >         __mmap_complete(&map, vma);
> > >
> > > -       if (have_mmap_prepare && allocated_new) {
> > > +       if (!allocated_new) {
> > > +               /* Merged, so need to drop refcount. */
> > > +               put_map(&map);
> > > +       } else if (have_mmap_prepare) {
> > >                 error =3D mmap_action_complete(vma, &desc.action,
> > >                                              /*is_compat=3D*/false);
> > >                 if (error)
> > > @@ -2936,13 +2959,7 @@ static unsigned long __mmap_region(struct file=
 *file, unsigned long addr,
> > >         if (map.charged)
> > >                 vm_unacct_memory(map.charged);
> > >  abort_munmap:
> > > -       /*
> > > -        * This indicates that .mmap_prepare has set a new file, diff=
ering from
> > > -        * desc->vm_file. But since we're aborting the operation, onl=
y the
> > > -        * original file will be cleaned up. Ensure we clean up both.
> > > -        */
> > > -       if (map.file_doesnt_need_get)
> > > -               fput(map.file);
> > > +       put_map(&map);
> > >         vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
> > >         return error;
> > >  }
> > > diff --git a/mm/vma.h b/mm/vma.h
> > > index e97bd2dfa786..f15faa83f3d6 100644
> > > --- a/mm/vma.h
> > > +++ b/mm/vma.h
> > > @@ -394,8 +394,10 @@ static inline void compat_set_vma_from_desc(stru=
ct vm_area_struct *vma,
> > >
> > >         /* Mutable fields. Populated with initial state. */
> > >         vma_set_pgoff(vma, desc->pgoff);
> > > -       if (desc->vm_file !=3D vma->vm_file)
> > > -               vma_set_file(vma, desc->vm_file);
> > > +       if (desc->vm_file !=3D vma->vm_file) {
> > > +               fput(vma->vm_file);
> > > +               vma->vm_file =3D desc->vm_file;
> > > +       }
> > >         vma->flags =3D desc->vma_flags;
> > >         vma->vm_page_prot =3D desc->page_prot;
> > >
> > >
> > > --
> > > 2.55.0
> > >
>
> --
> Cheers, Lorenzo
