Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31A74BE1
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764218559; cv=none; b=qrDwe1lItt6reYN70KOyc1jYM9HStO8aeLOtUh/vprbaehkYC9psRyKk95KqGaub4llS0in9iyA1MCI6Tt73gmGRq3mH/21xGJuQmrm38t4wvxo980ULpIqpNYfeNdUE+tiiRUjdsoPG42efvgRzWFs7oLINkGpzCTrbtzLYIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764218559; c=relaxed/simple;
	bh=YLP/s4t/NXTvIWfr8ei9K64dIAZgEaqRHx1rmLkSSKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUid0tR+9cxO271V3bvvUHYwKH4OfduZnmpspC1YF+Tp4nn/SYo4QxOyqCuaH+9n7sTrHSGQBNpuhmZ35ieMfF7g1vWc2/uZQd1KyAJXbXyvjbL3Cy4Vmn7GFKnGZtcVEfvnxrJWrbneuIDwlMzkDZSCblFcZTSJM07rJGAc4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcuPZy+m; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcuPZy+m"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dfaceec8deso358597137.0
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 20:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764218556; x=1764823356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEhopEuyFNhgXqkSaWLWBfzS2UzIUD/ULoq0kMipD7w=;
        b=kcuPZy+m7seEmSqarWZhGhNNaXog8hUU8XW4pmTFlTGwxdYlXb0o8aI8lsmC0iqEIJ
         KbyWlJVyhxC6w4xkR0vrSpFO6kfpdQlQV0efNsCZwTZ9fE4M6QH3tWT/ZPDJ2/kYa03D
         7d8AifUkHyLlWBEYXUGW4TEpv8lGtnYBYRQv7RbuxiB6IvgF3hRrhoVAc+5ZKPtkrC+L
         MITKTn/2drqi8ta8IxcVh93GmbV4BC2nUIC4M2lpx9Yucq+FNFyhohuOxFhd7NYs8Ebc
         6+hTYEqulCSprrwtiJVy4aT7Ex8Yqll0HHTbYtyRSNFAlbSzUx2VkzeyKNnjVg4ULRbZ
         HN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764218556; x=1764823356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEhopEuyFNhgXqkSaWLWBfzS2UzIUD/ULoq0kMipD7w=;
        b=Tu3FFaebdzDGKg1ILPrBzxYBm6I+ENBWyEr9nJwN5ygkRfqYh+L7OOHVbuLlfUCWhY
         RWE4wi/A79QG6cmAFmtkWVLb43SViTcwZzdOq15kgD2/sh8iLV2jmnbX7rKvid8nLYB6
         BAh0pjSVHXKGy5jpMPBamnH6nEQ2CuQyEX6S/3DQe3aM3Gpp0Q13Wes6u//xOGFzKPAt
         SbQeIeCExQLHvZfwEe3XpamBDRt1m3SbT4YLZjcJb9V1q/WDPUfesDT7uyK0kAzAtK11
         nRE1nzlBbZG2r2hcC30r9LYjNs18ZlwhPvUYUO3k9T/MYkwlp1wNYFpB6/UXiGFPX/Qa
         q5wg==
X-Forwarded-Encrypted: i=1; AJvYcCUmPodCzCa4OrXJ6693ipuUyAHiwZHP3dV6V+nr3PdoH2SBxUdVVOQGnxZcefKNt8H40LaczbBzmbCe@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLn5DOEmL+wIYSOsf96BSLbLgVGsfjdwUKJJ3HMoed5sJTMot
	t/OvL37COUQbEqeBpTtbNMAFekEyqVogNwuRBgA0WhXG/m6eaaaEJbF/vG0Yw37+f6II648Viee
	qbq2XqvaV4cR+551OpBlUYy9tXfoC2KI=
X-Gm-Gg: ASbGnct7nY/MUds0f9bkwNiV302+/Ka9dx8QIMfpWBtYkl705O2HoCuU04ISRoR8xkF
	OeKFnzFaYminWlmHe/MMr3xSo33ERfWXUY+9hia4w2dg+NnuRJEvLcsn15MqSnbkU1zCDqrQRJx
	tCGi24rygvM/XxVKRT135/NXcLLVLRRy2IMocKPfYcpBzhQQNZw+EkbHHzIYSg2ht9WE5mC/aXp
	Cfxk5z1ayqAFCqw+4fDfECJaIuhvbxGLfJ5O5PvYVMdV/EJaPoSsXoLa38HFH07RKCCfg==
X-Google-Smtp-Source: AGHT+IGH43TrgsJFNtUr5ao/vogWT9GdRhnXVZ07KbbMX+jdayVJE8Rn0KQfN/TjkQoluZkh1Kzptkw+oLx2u2WmID0=
X-Received: by 2002:a05:6102:54a2:b0:5db:3c3b:7767 with SMTP id
 ada2fe7eead31-5e1dcfaca59mr9155596137.16.1764218556121; Wed, 26 Nov 2025
 20:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
In-Reply-To: <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Nov 2025 12:42:24 +0800
X-Gm-Features: AWmQ_blP9KP_04bFNRiiSxH6Z8Vu2JxzZ1V6hdafxe8pxPoB5frW9rAs1E64Uhk
Message-ID: <CAGsJ_4w8550U+1dah2VoZNuvLT7D15ktC6704AEmz6eui60YwA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Pedro Falcato <pfalcato@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Oven Liyang <liyangouwen1@oppo.com>, Mark Rutland <mark.rutland@arm.com>, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	=?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Wentao Guan <guanwentao@uniontech.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Thu, Nov 27, 2025 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > > There is no need to always fall back to mmap_lock if the per-VMA
> > > lock was released only to wait for pagecache or swapcache to
> > > become ready.
> >
> > Something I've been wondering about is removing all the "drop the MM
> > locks while we wait for I/O" gunk.  It's a nice amount of code removed:
>
> I think the point is that page fault handlers should avoid holding the VM=
A
> lock or mmap_lock for too long while waiting for I/O. Otherwise, those
> writers and readers will be stuck for a while.
>
> >
> >  include/linux/pagemap.h |  8 +---
> >  mm/filemap.c            | 98 ++++++++++++-----------------------------=
--------
> >  mm/internal.h           | 21 -----------
> >  mm/memory.c             | 13 +------
> >  mm/shmem.c              |  6 ---
> >  5 files changed, 27 insertions(+), 119 deletions(-)
> >
> > and I'm not sure we still need to do it with per-VMA locks.  What I
> > have here doesn't boot and I ran out of time to debug it.
>
> I agree there=E2=80=99s room for improvement, but merely removing the "dr=
op the MM
> locks while waiting for I/O" code is unlikely to improve performance.
>

One idea I have is that we could conditionally remove the "drop lock and
retry page fault" step if we are reasonably sure the I/O has already
completed:

diff --git a/mm/filemap.c b/mm/filemap.c
index 57dfd2211109..151f6d38c284 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3517,7 +3517,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
                }
        }

-       if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
+       if (folio_test_uptodate(folio))
+               folio_lock(folio);
+       else if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
                goto out_retry;

        /* Did it get truncated? */
diff --git a/mm/memory.c b/mm/memory.c
index 7f70f0324dcf..355ed02560fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4758,7 +4758,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        }

        swapcache =3D folio;
-       ret |=3D folio_lock_or_retry(folio, vmf);
+       if (folio_test_uptodate(folio))
+               folio_lock(folio);
+       else
+               ret |=3D folio_lock_or_retry(folio, vmf);
        if (ret & VM_FAULT_RETRY) {
                if (fault_flag_allow_retry_first(vmf->flags) &&
                    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT) &&

In that case, we are likely just waiting for the mapping to be completed by
another process. I may develop the above idea as an incremental patch after
this patchset.

Thanks
Barry
