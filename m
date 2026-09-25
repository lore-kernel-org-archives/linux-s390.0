Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818744E043
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321868; cv=pass; b=RvxsRKVZrRjO4V4B6l16FUaBSBOzshcGY1CCDFHg8eUy5jv7Q2cUNyH8722U48y+XvtMHe4KB7Lm1zbz65ZxY5b0xE+IY4W6qtK4+8dDsiriDpS+G++Cbyr2R610l49/HUTv6aohpaBaAF7eVaggawQsUFCCiUPul6zX4/Xb73M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321868; c=relaxed/simple;
	bh=4HRCApcqOCblV/nRa/gIhH9hhLpyjFWAyS7KPdKAl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIg4mE+/tDJWp9SzFil4drhFXCOy24VjRz6pkkUHnWN3r2hSxJZyW1LOiAefyhENOre9upuHvwaZ6l/NheyhRSzeGsEGuTy9vDFEAYBKSTvzeT461L8Ciped3HCDdjDeyPi9HqlluQXdo90w29gHxSA1dQqpH9zfLdayZ/+SMew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlkVmOpR; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlkVmOpR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so7273a12.0
        for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 00:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321863; cv=none;
        d=google.com; s=arc-20260327;
        b=cJkcae5xbLzPKQ5jpAWL/dLX4igxM2uyEO6MDkexYJKaeuPcyIRQUclCbk5mzJ7r53
         UiYkajfIKqVt50iQoTYeYhp3FPd3I2ArAOf2OC8vPmWeD2DOWi898ql3gXsC2D2NGkgP
         yossQ22cn679L6xN6wUU1jEhcSh0yoNrpfkxd82BM9y1W2BZ7gzHXqdTzNU4cyahZ4mh
         h6XfW03TQ21i/Ae6Vo4uT7+V9k9Wo6bcedVQZfo1uqGAOYhiChD+AxlX2h9vQ+sqalYz
         fCaPQtoShBXYdYAFhDFr95LVo8c+JdOc2XzrgLKSi/NWiop0k5lYxo4mf+sjhPPI2rS3
         xeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        fh=gAKEE2ap4cy6XrvWz6xV4XLDfOPbROF2TIWuIGPfYj4=;
        b=mHqJzcRgNxSMf0ch9mTY4ttEgAwjlcl+RyxYA8jK8CveH6e6mjd00/P/Ywx2riUgWE
         HPsBOwmKdV8RoZp1OIq4LnmTL175yKOQ3dtc28Ox6I++sixMMVLoP0sDvXKr+LKLX4+b
         jXhdnzCymgqQaN3YrWVnml2nDeV6a8kyDJTns23C47KoLYlrjk66dBdCrTnZKc6r7wZn
         bk5WPkRY3l7/Or0MX8AU23YtgqX2VAIYT+xJD2VUhWySNtd1genkpbkCn/7o+A04oWOe
         m9yzxtoLllJC3Rxqkq/HQtUY2s+01jKZZnnui/JIulfYY5TTIJE8NeQCKTsnlgGezqgQ
         1S3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321863; x=1790926663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=HlkVmOpRpLNLXOpGROpJAA33a7WfUHPm2SbLTKxgpfVO7eae2NKA/nP/L/6YOhbJog
         UDzvTBRcEZCQlKOw2akXJi5+EJpsK7Cy8XN92Sgp/dqVCCzjxM2qqXpHElxFkkmua+bT
         K/X6fBRv1KB0fvohOpj9dt0dr4EKKrGPbTVJhpCzuWJseyyypz1LBHoar/jTaMKUQhJH
         uNyFuHKRpK9hYSgh/hijVF0OTZ+GPaoZiubgc5RHceg2zWcXHy686vOg/gl9326Uhb/e
         CApN0+0pmfMibB3qEGja7gpGJqk8wzJCgAmkvTZgJ5j9YQbz4EXogR90r8vk4gscZvnz
         rplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321863; x=1790926663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=i947CjS2BX/YwCUo/FjcNpMGWLEuWAA3VXA69qnyDrgvKg8vGWs9mguqdFjaJz1ysr
         KHeW36kBAE3+a/XEzofCtVzDMxZuEzRNTC0RXZcFZBxCQVqug1zJsJVJkChXNye2FBYa
         9PzHXncaILYLZ7Xx1VnPMRpap+mbPAyAWoHQvRpGAAqwb8g4EQOqCiikBYLmASUHiVB4
         niz9pOva0YVncET/ctZdj1TKh11SbvaA9Yc9srl+t4Ia6Ck4wzSZJujWglD9VWOeVhSO
         D5kk6IY0UW4JhcN6MMB7CYbR44m86J4rrM8QcDP/zF0TEJeL5wVbWnRmtNm+wZ7Xr7yj
         ELqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/IDYeWm+PM+b1jp3SdAmJoigz18oroFVJRB7aprLpb/KZOwNaH+8TlYte2b1QefmMlBw5ZVoD9xLA@vger.kernel.org
X-Gm-Message-State: AFuF++nCNnnISiQvQW08eWdanY2d9C7P6bTlqCInQnoxWA3LtKybMeo8
	UIsZbed62Nw5EdR+FR6Ebra6rJerlrFFf5dRxYdkT7zZXzoKf7bDAha2qA9qSb1+SND7zbhO2iK
	YBQTJGV3Pl8lYIX4tICnvO6x2A99xc5snHx4P8JOs
X-Gm-Gg: AYBFou2pxbL2li/DtajPTddZyEKvUwFCYvNXTOopLzggoEQ4idDwFawoHJWUDZ+6XmI
	Ct++qpDYKauC8lo1sp1CynvGpVUFfMaXvxlSE6AoETdkix3CMMyuunyRhHvtwX6whBKxRAxCafH
	0SZDZVcbcFyXqVEwNAlBUwScE+kMSApYJLpq+udimP+rMEP98OR3D1qU7uC+InRUR0FJ0jmGZ4F
	A8awbc/vux9Drb855IpQmOyMGa8VH6tDYflMIEz2iLLY/OmaCK6bqPgfbzoTACG0ovpdNf7fU9U
	rJ5P+S+AcSsY08CHvTdHIQhd2OskJzdYzVJc5g6imqagPJRLYyb6VA==
X-Received: by 2002:a05:6402:2714:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aae4729638mr36915a12.4.1790321859803; Fri, 25 Sep 2026
 00:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org> <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
In-Reply-To: <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:37:26 -0700
X-Gm-Features: AclHuK_RUT9CXNFLpx8ZY_roLEZNzp5S3oNdpNL4cW25fJBFg9wRGnSWohuMdYA
Message-ID: <CAJuCfpH6AF-hOo4jU6OeNVpd+fgpqLpmcfAGs11J=nPCgAqG_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, 
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

On Thu, Sep 24, 2026 at 12:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied=
 by
> > MMAP.
> >
> > Also while we're here delete useless comments for mmap actions whose na=
mes
> > clearly indicate what they are for.
> >
> > Also update the userland VMA tests to reflect this change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 2 +-
> >  include/linux/mm_types.h        | 8 ++++----
> >  mm/util.c                       | 8 ++++----
> >  tools/testing/vma/include/dup.h | 8 ++++----
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
