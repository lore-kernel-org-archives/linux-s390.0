Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAD47C0E1
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898983; cv=pass; b=egsBxvfZA8yJczIazldaPvW9Owm1ivy9sSZR2yHsYjqYIi1X3Qvhq0hPPA5+0HBTafzEwIQJVO8bmkipddf1hcUjRYGrsVgohIosOUQAlvfjaPgnd2Bt+iOJCvHww8vyOmZmUmMTsMGJHUrKXWEFxOGuk2oDrTEahEFsw83PO50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898983; c=relaxed/simple;
	bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0MZdZbB07ubEQOVFVmTH++Tkt6xYTpDrCpCrYfjCSo7yoc0QGBHsmeE3mzO5uYHso+nmsbIVyfp/PRB/bHcx2dSpi/+IOWXy3uU/hFLIt0TIhDLItBV443e02nLRlL+rq7Cpr7m41syECOa+dXau8DYAk2oZ0UphcSExZcqIUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntOo4Dd2; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntOo4Dd2"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so1975ad.1
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 13:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898980; cv=none;
        d=google.com; s=arc-20260327;
        b=l3gauD0Kaj/roEOlOS/69FPALEPcv5NZ1NNgCXIa0ItdXsxBZuMZbPWmmBsyikUuDt
         GCsBYyxp0r/fznKNj//DeOPYbqz2wtra1efNA14tSMvEjLP0FEKD2J61IDKOZjE7LsUB
         dEEQK6AjmndYWnt+oO8Y1dsbJgY9mVWEUOxX/ZAfi+LYjtRSwSbfmxHrXvmOXYNbd0c0
         Ec8iHX9pZKUinceK6/qNXd48AE3OIWhH5w+FhsdPvU+Lw1ohLHZMAbkeB7JQHjAECpZZ
         WI7MsibsgAYA/ksKH8x6c3G1LcPV5Y9ugnnsBbQW7Dgp1W/p1xs0ERnrCbxyGrPyjbAG
         2lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        fh=a/+Ldp8O3xtTxqsaTYRXUrAgZehjNimk3g0pn6a2X4k=;
        b=qJFxclo4fFnFT6FrpYlQdGsVJGe5j1I1A1eu3qG6y38xzd7T/0yTyKs8RI2CqYJ3/w
         9gQnI3giIeoVi8lRI+pROZrQMyU0T7zhthA0jedbuvRaibRJbgEjczXnQrD0VjG2L2Ch
         1+U5x2eyFQ7QqdFx0/OHlOmCzPD61Mw4eRSwivWuUKTN8V/GOKSL1eVWqMFB5t2dVQJX
         Q+kRlk+sCrbU56Rhu9k2qnenBGKM2qUMQPpkgUqJ8deE+7CKT/WLl3iDtZBdx6FXV8oR
         oJw4VzTvFyNdVY7QqAFpiU2AqWEGdLXveSzXnCuswBj5Ku3AS2LoNfs6t/MvjVTxF7Qb
         o/3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898980; x=1789503780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=ntOo4Dd2KCtMh6fBhqHQ/RGFE1orVqGK8S2syt3BPFajZxvVl9npGFOgC06f4MbrT2
         nrZ66yX7WsPU33nxoLTb92fMxXK6YzLh6zV7pVU7GRCvBTFoj1wVtMYwpvTriAT+e6ca
         V5gJM6sLqdlA6l+Af94FYALjxhxQWVMinBGTZAC5P/kYlFay4qHihlYVCAJ2dKh0gmhU
         kF3+RJIFcarOnBVf4uZVyXI4DNtQXplt7ZNj44MdcdIfusZWjTsHZMcWOGgZmz830GyT
         GjIxloPx3WhS6FfnI5d11hrwXSWn71hoEw0t8AAkNhTj+3hmxPKubcdoOUXe7lW7WnWG
         JtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898980; x=1789503780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=idf++Tmz14iB4AMdNkVmOz3UAcWmidkLBCBiaQb3HXFu4rG0/a+mLT57krI7RscMbW
         petog1+ZTY7HXJdxIHtsu//2LZM/dvLXR4t3wvTdjZdr58wpW3YyCgXQnZKDWU4Jwikb
         hvBvQ3KD/krqljtn8WOvjqL00drTRBrhVG9WX4rZXI/T19OIUm07XS2L4cotWVyAFgrb
         qFNVA57cJ9WuGluFiIAE1nMaPOjJQiOPcrdj2tLO3TZIcFScx6GT1P9u+0C9rkIrdagD
         Bxnoc8SjGYR6kasZD+ZDm2ZI/iIB7EeiLiuijzdYMe1Ufrucvkbq8HY/I0s1vSWArFrP
         a4ww==
X-Forwarded-Encrypted: i=1; AKwUvBwCII/V2mdeSy9/IXALIa4ZdlHHYr+qtv2cQHeifsROBM1YCczRXDEtbb3Xe84UjcyAAhaFOLPooMKn@vger.kernel.org
X-Gm-Message-State: AFuF++nUgG5fwDbift4mkStsGCRPrRrD7GZCKGMCRlTKt1YV69jjOVVH
	zPQTygQNxomVWjCcXOEAnxcPeSIJRWYyn3h5kklgSPV//wkqz5kWj8tXeheA6kXxO4rtofy44VR
	n+LcnPdh9+T8h5F+A22rWhN1h9U6yvtzVlAYrR8Pk
X-Gm-Gg: AYBFou2aTZBqgcptkasnu1qCpM7Vxqev6veX8SQTLV6M6UKC4qGN79Mo6OyjPSH+5xm
	ddPfAvYkgSfId//jrHcPTcXpOKP2d5tkBfpJAYTeI8guNw2gfG3Lc9oVFBs15UXh/uOZVS3ynq1
	kZ+E5DP0rOtzV9uigg3XWgEOAO2piJE/9O/u8HL5VEfRyy1t0oF2hlXHHSajBMQ/tHF2+4UIOGA
	8u6msHrVFUVFFkueszfe1AGZG4dL4JHF+20mIze62he39q5bB6BvU/qeWveFFMKStudqBj7VM+v
	FEB4sZSUV/Lxo4Ib4E5gRZhUI5Tvo+LOiI2+Y4dZxCNjw5U4dw2w4ofjpU4IWYpCEjxlhwiw0C7
	DHDXCMyMPJncDbgyUPABG88LTumx0/83p
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
