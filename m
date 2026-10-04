Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13D46D092
	for <linux-s390@vger.kernel.org>; Sun,  4 Oct 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134312; cv=pass; b=hAVraQTKIjW6tIng+NrcMkghANiZZCfHwJEqTblVoB5ttD3Y5Od/dMGul3TD5w7ZsVsQfKdNbFYhDOV3Vp3iB6lKqxqDi7aRj2xi/yVlzWreI2pMPTIcUox6/1eqUzNxOrTHOLFKUpbK2qZVjV+6zMCTZfVSacbXjjVSiIsQCSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134312; c=relaxed/simple;
	bh=Og6qpLhWHly4IoZcNfYZyEY8s5xN9sYAkBks0QnUI28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcMXumWo/9KfP/kAaQ5D+77k9q6pYt9hMehz+/saqQDRdV/bmPtnJQfn+81nkVZpO/CzrOurqDeS4xaURg6pjwyDOtFOiqh2CEft7eMVctdcyPFrR1kPNutoRJhPmRhed6NWNmAWJSVNzSB8u9/sTwbkjYQ5hO0o9a6j6jV50CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeOZJMDE; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeOZJMDE"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so246031cf.0
        for <linux-s390@vger.kernel.org>; Sun, 04 Oct 2026 10:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134308; cv=none;
        d=google.com; s=arc-20260327;
        b=A/1ewXfsSkIEVvyPQRwfiLhTsHCWNOAOwvJCS0s3sM754fgS6lo0MNC25NsVjS0lzw
         N+5rpMsVJWHxjfc/Em4JOZeAQrp1GbIKpPFNugA0EJFT/CvDmRndW0HSEESAlZqpl9eP
         PiO5puF/cjR8mtpNyeb1uwyLqo77mGW2t3pGquMZyBtr7+FJE4sr/VAd+/duFBf8nHGU
         hu9hA7kUpEWrKOwDrMjRgaf73h7NEpKf+3lWIcti2/gAwwrnZS/W6hG/L57jpKGLG+X1
         POb4EgdvD+TINCHdpTHokYayw/iEEb0P7B7JwMSi8kTJGcOSmSzeE05EBirvBFWWafUi
         FkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        fh=jYch65rf10tCMWW4QxMG620htQ384BpyeiefiqPKgjs=;
        b=edCVdGk7MN2rkcYluVjWIvqRbxYtgzEi8N5H+3PZNbMG3MQc9kSiXgufSPmvcqKh/X
         2wYkaJkUyrKiWRjiz9CW/IBcpUw7SfdKK8pAWNXKYiIFU5L2oZVMed9zU/DUFjcadco7
         5LLG1nMDRlnfYiU8/hlgMur32dLYoRFiG45aFi3MYDnULXkK3sJUoBpIDzQ1Aw+zOucC
         wy5H+8NjsDjzUBnXaZ2zGlbit/g692VZ70ThMkiqJVZ6D9Jk6IPmoHdYcY9ndSrMI1Zg
         oFJeTqq/NhOjcFCw3RxlEJiBgUxGDTKRR9Y93PkMellYxAcBJfZWvtW+y5fmsNYtLkwa
         PZ8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134308; x=1791739108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=IeOZJMDEt2qL247lMuxc+jIqy4zsxjPTwxleAIFut5mj8G2+fn0ALfayxMwtNTebBL
         RJbU8GAtzBUM9tsUheu/An8aItKMV0/OD1HywoDP1i5ZuCAEBPfK0+6p8DEX0iH9xnQh
         60NDAP5forHGc7dvpDofgIb+d7yo0My6bjDErncBm9VubHiQskbmc0eNguE4WNxyNEtX
         4EbzRviiNSaJPR8RjIii7dCQOXrUEwckaME4JawxCPYdD4zGpSOVO1IGM/3PERojKv3v
         K3jp1b6IlKprglTroQUMUhkx2M9m+VCLWlPW3xjJvdkP9/cNYbia77DYs/L7VzmOzU/g
         113A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134308; x=1791739108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=x8y6Uj2rvTZ8ED/Hxnl15i0QxdY6XQZkdNWYrefsc2IojnZmnBqXEclouNtiR3fbEV
         xdu5vv63G7jTmPxuGrlgvyGt13tx9VsubK2EM/6BlHDG5hxmuTD6XEDwGdcdk9oi7P3r
         32rCvBTM4rgIdKxwqohOJtjbWuFXLpoU7ZvS3XzxDaT3Zpa8bxUxQV/lG35hVwM7WpgP
         sUa46EiW031UwHCag6VxLscIM30QnfIRctDaC1ysL99cDzxp5vqh8cA/5MGjegwsXWFf
         CWXAkxsRuZQ/Y6UCe8sm109kaHPdN3jn2H8RUdAX2Gf/wp1YiXIu1WfKNgtjTSBH9BOP
         2gvA==
X-Forwarded-Encrypted: i=1; AKwUvBzszZvw7NaA1mjirMesoFfOhR3cI/Wo5Ziapa3/My5JJs7XGQQRYIguaKB4Ey8uy+6MHOJ2M/g0vctR@vger.kernel.org
X-Gm-Message-State: AFuF++kEtc8b0Sr2GY4xs9b8hADKd2ld3rtljZhiqepYxfWKTMwruEf6
	9C+CJIT0aH6xL9aZSu/zJcToh87cZWr5msDlxESpXSDfyUQCgMKyxk9Ff/FSZN1v34FvuHR264a
	AsLeDSSD4JLasoPqnvEbuWeRp6gcoFKJLtikgTpPk
X-Gm-Gg: AYBFou2ccaYQjT7AgYBj9JZMekUrWJg8pmoe0r0NH/E0WUMxFt30LFTfrTgygDEo96T
	mEWGpQXGz0vLX5CIPEicooulebdyPWfEX5x5OOhdeLD0bEUzLl8UD5voeXt8DifNN2lq/ErvgWi
	L0xvCw9hxfwwdbJ3O/uKkOhI72Sk1zIl1y8D0cabblS5uZaHG+wr2JhkEVBqQuohjNHt69LS6UV
	z/Q/vSXfIs0s6clPh9m0mgHevHV+DvO5L+oHy7gsZMnoshPKSM0wUuhiMUc8iGJWCjh0cpHcU0c
	gIPgyQwfS05ZMymEl0ykiUuj6oLxvvuL9i6kSO5imxpz95FqQrwt5mRl
X-Received: by 2002:a05:622a:1b91:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-535146ce3e1mr16649101cf.4.1791134306600; Sun, 04 Oct 2026
 10:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:18:15 -0700
X-Gm-Features: AclHuK_AcqqolMBhSGAldWSHQHOOTkitmvHnvL2po1Vgiun02DenXRmiOZ3VQUs
Message-ID: <CAJuCfpFkfK4gvBPVoSiSdKs_3LR-0-dw_08BVxs-NqCvQK0-Mg@mail.gmail.com>
Subject: Re: [PATCH v4 09/38] drivers/usb/mon: update to use mmap_prepare +
 map kernel pages
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
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Sat, Oct 3, 2026 at 6:36=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the deprecated .mmap hook with its replacement .mmap_prepare. As
> part of this change, additionally take the approach of mapping pages upon
> mmap rather than providing a fault handler.
>
> The page span cannot be mutated when an mmap mapping is in place, so this
> is safe to do in advance (the MON_IOCT_RING_SIZE ioctl operation exits
> -EBUSY if it's attempted, gated by the rp->mmap_active reference count).
>
> Utilise the newly introduced mmap_action_map_discontig_kernel_pages() to =
do
> this, which allows for iteration over pages in mon_bin_discontig_get().
>
> mon_bin_discontig_init() increments the rp->mmap_active reference count t=
o
> stabilise page spans. Should an error arise the core unmaps the VMA and
> mon_bin_vma_close() drops the reference again.
>
> The vm_ops->close hook implemented in mon_bin_vma_close() will ensure
> correct reference count arithmetic upon unmap (with mon_bin_vma_open()
> accounting for splitting).
>
> The existing semantics are all retained, including not mapping past the
> range of available pages, with a SIGBUS being raised in a userland proces=
s
> that attempts to access past this point.
>
> Ultimately insert_page() is invoked to insert each page, which increments
> the reference count on each mapped page. This mimics what was being done
> previously, only we pre-map the entire range rather than doing so on
> demand.
>
> The existing fault handler did nothing that required demand paging, and w=
as
> presumably implemented this way for historical reasons.
>
> One behavioural difference: pages are no longer faulted in on demand, so =
a
> page discarded with MADV_DONTNEED is not repopulated and a subsequent
> access raises SIGBUS, as with other pre-populated kernel mappings.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/usb/mon/mon_bin.c | 82 ++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index 687f6a8981f3..9d00b21a8153 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1219,6 +1219,15 @@ mon_bin_poll(struct file *file, struct poll_table_=
struct *wait)
>         return mask;
>  }
>
> +static void __mon_bin_vma_open(struct mon_reader_bin *rp)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&rp->b_lock, flags);
> +       rp->mmap_active++;
> +       spin_unlock_irqrestore(&rp->b_lock, flags);
> +}
> +
>  /*
>   * open and close: just keep track of how many times the device is
>   * mapped, to use the proper memory allocation function.
> @@ -1226,64 +1235,79 @@ mon_bin_poll(struct file *file, struct poll_table=
_struct *wait)
>  static void mon_bin_vma_open(struct vm_area_struct *vma)
>  {
>         struct mon_reader_bin *rp =3D vma->vm_private_data;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&rp->b_lock, flags);
> -       rp->mmap_active++;
> -       spin_unlock_irqrestore(&rp->b_lock, flags);
> +       __mon_bin_vma_open(rp);
>  }
>
> -static void mon_bin_vma_close(struct vm_area_struct *vma)
> +static void __mon_bin_vma_close(struct mon_reader_bin *rp)
>  {
>         unsigned long flags;
>
> -       struct mon_reader_bin *rp =3D vma->vm_private_data;
>         spin_lock_irqsave(&rp->b_lock, flags);
>         rp->mmap_active--;
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>
> -/*
> - * Map ring pages to user space.
> - */
> -static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
> +static void mon_bin_vma_close(struct vm_area_struct *vma)
>  {
> -       struct mon_reader_bin *rp =3D vmf->vma->vm_private_data;
> +       struct mon_reader_bin *rp =3D vma->vm_private_data;
> +
> +       __mon_bin_vma_close(rp);
> +}
> +
> +static const struct vm_operations_struct mon_bin_vm_ops =3D {
> +       .open =3D     mon_bin_vma_open,
> +       .close =3D    mon_bin_vma_close,
> +};
> +
> +static int mon_bin_discontig_init(void *vm_private_data, void **private)
> +{
> +       struct mon_reader_bin *rp =3D vm_private_data;
> +
> +       /* Dropped by mon_bin_vma_close() on unmap, including on error. *=
/
> +       __mon_bin_vma_open(rp);
> +       return 0;
> +}
> +
> +static int mon_bin_discontig_get(struct discontig_kernel_page_state *sta=
te)
> +{
> +       struct mon_reader_bin *rp =3D state->vm_private_data;
>         unsigned long offset, chunk_idx;
> -       struct page *pageptr;
>         unsigned long flags;
>
>         spin_lock_irqsave(&rp->b_lock, flags);
> -       offset =3D vmf->pgoff << PAGE_SHIFT;
> +
> +       offset =3D state->pgoff << PAGE_SHIFT;
>         if (offset >=3D rp->b_size) {
>                 spin_unlock_irqrestore(&rp->b_lock, flags);
> -               return VM_FAULT_SIGBUS;
> +               discontig_kernel_map_abort(state);
> +               return 0;
>         }
>         chunk_idx =3D offset / CHUNK_SIZE;
> -       pageptr =3D rp->b_vec[chunk_idx].pg;
> -       get_page(pageptr);
> -       vmf->page =3D pageptr;
> +       discontig_kernel_map_page(state, rp->b_vec[chunk_idx].pg);
> +
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>         return 0;
>  }
>
> -static const struct vm_operations_struct mon_bin_vm_ops =3D {
> -       .open =3D     mon_bin_vma_open,
> -       .close =3D    mon_bin_vma_close,
> -       .fault =3D    mon_bin_vma_fault,
> +static const struct discontig_kernel_page_ops mon_discontig_ops =3D {
> +       .init =3D mon_bin_discontig_init,
> +       .get =3D mon_bin_discontig_get,
>  };
>
> -static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int mon_bin_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       /* don't do anything here: "fault" will set up page table entries=
 */
> -       vma->vm_ops =3D &mon_bin_vm_ops;
> +       const struct file *filp =3D desc->file;
>
> -       if (vma->vm_flags & VM_WRITE)
> +       if (vma_desc_test(desc, VMA_WRITE_BIT))
>                 return -EPERM;
>
> -       vm_flags_mod(vma, VM_DONTEXPAND | VM_DONTDUMP, VM_MAYWRITE);
> -       vma->vm_private_data =3D filp->private_data;
> -       mon_bin_vma_open(vma);
> +       desc->vm_ops =3D &mon_bin_vm_ops;
> +       vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
> +       vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
> +       desc->private_data =3D filp->private_data;
> +
> +       mmap_action_map_discontig_kernel_pages(desc, NULL, &mon_discontig=
_ops);
>         return 0;
>  }
>
> @@ -1298,7 +1322,7 @@ static const struct file_operations mon_fops_binary=
 =3D {
>         .compat_ioctl =3D mon_bin_compat_ioctl,
>  #endif
>         .release =3D      mon_bin_release,
> -       .mmap =3D         mon_bin_mmap,
> +       .mmap_prepare =3D mon_bin_mmap_prepare,
>  };
>
>  static int mon_bin_wait_event(struct file *file, struct mon_reader_bin *=
rp)
>
> --
> 2.55.0
>
