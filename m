Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099713C1D7A
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321752; cv=pass; b=EjPLYLX4cIhqSF9E38FMq4Dz642FjJJ1l3XqmSkL2RL4GHdpMlJhDd8RrgWTcWYtr8T+ozDXJTCudNfDxvqP/FTrmPCiLGOzSpfonTTpq5ztar9R2FsmlI5tSlToIWxc6/i/zsVzsjGLPbqGeKxR+REtfEmyl+f7ZRY6kRy7mKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321752; c=relaxed/simple;
	bh=QleRDPze6Fay9Y/d+9oXHJ/g/hcfyRz6rdp7ap/qQ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNnlIaxXJh9V140s5GwlT/cyXS42dXd99SvtgPghkx5RvqfzLh6AkGW4z0MuaN+Hq8FGjK+NtiTqm8W4JNNwzFiqhTeB6yMzqo794fZjGPejttGR2bMIlvBvXuf72ufuPkr8d/YYYImGHRbRhaIGbfNfXGJUMHvqX6UqZmS4vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBGvWS35; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBGvWS35"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5403a12.1
        for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 00:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321747; cv=none;
        d=google.com; s=arc-20260327;
        b=YV3hmfHz+UJ35WLx0uwrNhr6AWGs4uhYBGn/+717t17fMF/SpJcq8Wlj939J52jFU+
         vDoRu8C/lyzY2AgN0f6CT8uIBGNEE5tqL2SI0hG/TITS7/lOd3E2qqkLGEB9HU1Tipz7
         Ry9+rXSQQl8cvR6+yhkGT8iNkGwqN4tVNAhIP+wXmik3OxUvS+o0SDmDf2YG0qM6Pk9E
         QOkWpC24zQygYi+7/PBhsVlM4ky4YFjpYr6161V2WFNYdmsoFeu7xfgwnd98niXs73NR
         HcKA+qmrAwEC9GEv+GbDj/Pj2oBaNSoQ+gwXClNb9jNnFGfSfoqDI4UB9rZn2M5Wllak
         5yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        fh=woleo2mrgeOdelO3t5GkY+ho5RTluAAlXpipavEiA64=;
        b=A+1Hcsw2HPEDO7WmhH0PfZ8jnL5EB0DyEEPKrw9ouh/Xu6rq8QotUGMW56LyHA6bFS
         1+aQy7Zuz6y3RAM6yap6DwilBOkfTWO7rtE8pRjOGQ+WPitWyLbYqGawJ5QDwySWfjj2
         WNxQj7+yp0UjwmVF/XtEGP8/abMzQyKmTn5rvSEvXSKLR/pF8AuzSCWezAWkmbFuxT3G
         ++wHj7gQ1O4pzN2oQJBhjhxlZ5dDIpKtih37pj2palrGVhlaI0bqrz0ZMeqR3rCySn0R
         F2t7YeztHzFmY1xQRAvc4X0jxfmywrC2M6jLsulhzHgyaT0WP6RrOnU3blsmgg8QvPNR
         20ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321747; x=1790926547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=GBGvWS35CRs52H+n0HibcXUxhDsFXef4XaGWh2jw679xAwuCg1uimStbUKyOmHzo62
         aSMchmwbdzg7paOFIuf/8kQtxcF/LgrwJ4PWnwSTcUhTacl4XbbHR9zZfdic0iMf+lpj
         xanAi9EmnoAPJUYHYLgxzOZH9198NTbtD+rg556M+8CT6VKcwMlDw2jxIv5UX9YzP9WH
         OJARG7aOAYL2SLSrUoundJe8jBeryf8iNeYj6/bFKGTzhaYARaL24JE2HpwdUQCtcaMS
         Afp21cIeWui2Su01twICQfXS+YmDFvrnzmWqxdXqsREfAh07Rj07E3xCH3No5p6o7nNy
         +gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321747; x=1790926547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=C65fOXBHUpN5XehQw6i9A8JuWkfZYP1naM5hKZEDPtCnm2dMB1pgINIWHNQ5o9pqVG
         pzLYJpaH/l6XVoEZmleh6BeQMhvuX3MlOpqxLessZkddbS9KW1suyuzK0DMCPkKl4jaf
         RKFmVCpk6yJwUzuPZzsHaxdaFTmvip3KAk/8b4xP+o3Q1BYTj4Z3VlDvzR9wnpV5kyZt
         eFK6XxC19lNP/sutFp/kRFP02OIHsWg5wbpRRvEFECrM4sbNctU1975tosiLcR3gP87J
         4DnvCTmrl/8D43HzFM11X5UWNkvaJWVflk0F2IygOZxujAymDp8NMm67Wf7XJVAM5cHv
         W9cg==
X-Forwarded-Encrypted: i=1; AKwUvBxiu00RJgs9ScM/OA/zgw7qJRuKM2Ioyxd6bbqyptpIpUKisQV6rQiQBrGg9uFWU3agsKOR5TN4D2Lw@vger.kernel.org
X-Gm-Message-State: AFuF++kC0ZbN+hCj1H4mdrIeKCK3rLsgFNIZ9seQR+UvYujxLwctAVOR
	hpDGLYy9Q+zUIfbjHzwTC3ncuJKQhoYIk8XOUu9DO/iaDldvGbry2BiDdL4NN5xOhIw2MKHINHH
	oC6LGAfB7LXTZZs1MOW7ndfw/UK3Un/6oUsB9nRBR
X-Gm-Gg: AYBFou2Pu1SU24m80Li1ZNk+wLhq1vmAS4EERWWx+TQcVWkD1Asmd5QmMFw087i4Qvh
	rvBLED6I5sQugiD56OKrJqlAzMcdWcglg8Du6j75DbFwQqf1DJGXzP0ppWEJlA4IMf/ka1xw2QT
	bp44ADnRXJWLNhezvm2My2ci1Jtif8xxjjFjbtgVP6j/M1i5ULC8Eje11xenIpMe6ODY7e3PcTv
	NsmMN4G51okV1n9voZkvTfyGphDFF2jxn/EvjuUtRKBsuBAXCwmkOhnvF7pJVnG1nUxV51tQ6si
	sbx/NlboTbLblOLGhB6c3s1439f89f3uM/WeVyv+2DHUadvAFbf3Fi941nqwE5Wx
X-Received: by 2002:aa7:c64c:0:b0:6aa:e332:b762 with SMTP id
 4fb4d7f45d1cf-6aae49c58f0mr23500a12.8.1790321746110; Fri, 25 Sep 2026
 00:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org> <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
In-Reply-To: <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:35:33 -0700
X-Gm-Features: AclHuK_NuiQlFRW78Nf23QbG4E3oej6nx-ZjiAb0IRRSHloLT2xGmv-6NXWsN8E
Message-ID: <CAJuCfpHpo58c6eOPY_CvP+ts2zwXQEDNX2bohXd0CBANYWrBWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
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

On Thu, Sep 24, 2026 at 12:30=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > There's no reason to export the symbols for these functions which are o=
nly
> > called from internal mm logic, additionally there's no reason for them =
to
> > be declared in mm.h.
> >
> > This patch therefore removes the exports and moves the declarations to
> > mm/internal.h.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h | 3 ---
> >  mm/internal.h      | 3 +++
> >  mm/memory.c        | 2 --
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >
>
> Makse sense.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
