Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125B2D876F
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764217352; cv=none; b=touJyn71bvhgZvp71oOG18zio8xz/dKLT6E6rwO1XZwpuKxDauyV2jMLlxPiR7Qo8Dk/AYkGdiuX/tvMOgOKBSQaPD5P37c1b4ImnrP+ZH+yWpJ2KwfJxoEBCMJc25t7sh5ApbEd0BDsalJfDN/3OUJjSnH62FC8TvkYQen7OKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764217352; c=relaxed/simple;
	bh=2mT8NkA8n4pI7iGhBuPOIC9L/ZbQrFHsOpjeHsUJ+lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM2htURF+aozzQjatZyCAW/GhuI2cFHtQPLYmNpTApXOOl41Q4PPKMdg8YeRO3RWSM6j+G3KVr77ZP7O1sMf+ciV3NCLThkJ01saYFMTSKEhvaaXKMt/bQfBf6nsfgxD6NYRvYDrwa1odGlPTlINdn/3qrpBIxuPQij0sd0CD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maG/SUC3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maG/SUC3"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2aa1ae006so59500485a.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 20:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764217349; x=1764822149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBY2hGlp5xDNa7Ek85Hj92aNDRHVnR99QGNyQtFdIz8=;
        b=maG/SUC3rwijxOP4dhtgqIP/986auH09v/q3a5WlrWZalaszqlzOwgcTsORilpmzVs
         YZLjfMwt8PFV25oHG4lEFKpu2W5aIecDStgF4k/tSuQIebkaGaCMNWDFhATvvUxhGNWn
         XWv+0vfNZW4Y57MGEv/d27cnP+EThjK+6qcmJT2AHx+k2Yh3b7p5k/SbX5i3XDB7UmF5
         g1YLRauSIXd6yodcZJs59+jNJYt6aFbIPxA8HRKms+f3hOaA062MoasKGUd2yQuBPEo9
         MCZcRElDilMCifRB7jYSnY8Tr2MtOcP1Cm3GdK+4ZWRtKDybbQXJxXZAuABzLErAPG1z
         KrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764217349; x=1764822149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBY2hGlp5xDNa7Ek85Hj92aNDRHVnR99QGNyQtFdIz8=;
        b=s9myFAWueT4gOp46sxjg28qV6VUUEPgIWhD+FdCKVzGbMhuSHMZ/VkFKDupVxpERti
         f0olnymUg91X/FwGlR/GIEWHLg1jUouMhpMS0WS/PXX5OUUrqD2Nz4vx+vlfidMnobmD
         7jtl1cAZkLAtJzbxjOHQDHVFwdT1VmNWd25GwuLqOpsH5YQzsK2/2i6zzkNVCatGr5B9
         wN4bcj0erLQmLWNWwsz1YXj64O0G36ZPE03SPKuoByvycfo8lF3FIueAH9tPzPo9d93R
         hs/xuCR8IKCjM8BtB2ynAIrQWsdNugrjfTBAo5Hlm/Md4I8nGzEYhJ3dy/qFWblWelMH
         E2jA==
X-Forwarded-Encrypted: i=1; AJvYcCVqpOocB/U+VWhPcQ7NHUWVHx6hc5KsenU2c/ZCPZyNbPoEM80q7v7CcrXsoxJmOdIbtaQwlT7La5Zw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywty7WsjzIGYoCSLPwkdvQDFyvbml21cjfKGLSpJAhs1XEyDbU8
	38ARz36yc2lvFyTnxllGxYjKAHhbALd6OcBlywkbhgODOul8ywPTT/c6EW1dJayZTVkd+R9u1C5
	j1gSEeWbOf8x7y4yihbdURXc7l+cKbRc=
X-Gm-Gg: ASbGncuiXrbCYC2FPjaga3A4mmVzy9gJLh97egffdVZCvBA9uiuRgWArthlEpgoDOV3
	A9FZV2eJtSso1pHkW1vBCnh38fJNCTE8zh6smpxdT4u4fNx+lySuxLxIgd5aUgTCSe+RqH27LAa
	NZ1Cyxj1Ix3W2f7h2CgfYpVl+bO15UFLwBc1IYeoEF80SraeIoAS5GGIxb/2v9N3e4PrUFvZhRR
	MA5OFqZjRaT6DPKX9+wskiAwbs6IqfFXH4bH+j6HgqUOsYMVtmwq0E0LSmUktuAHZBtDRmTJGKn
	F1PK
X-Google-Smtp-Source: AGHT+IF/2OHEG3LUgPMXOJw4DDaFf/N1kDbkxj4PlQ+jOCs1AfpUOxHzVBEY8oHxETzeiPPKmtGSMi/k9qIz1abldeY=
X-Received: by 2002:a05:620a:44d4:b0:8b2:f9ac:a893 with SMTP id
 af79cd13be357-8b33d49a4c6mr3106281485a.66.1764217348492; Wed, 26 Nov 2025
 20:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
In-Reply-To: <aSfO7fA-04SBtTug@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Nov 2025 12:22:16 +0800
X-Gm-Features: AWmQ_bnJyCR-GwS1_fTaB2mJ8nbB2MiVvoC0dBi_6l0nwDIR-Nl2i2LJsMX4LWo
Message-ID: <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
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

On Thu, Nov 27, 2025 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > There is no need to always fall back to mmap_lock if the per-VMA
> > lock was released only to wait for pagecache or swapcache to
> > become ready.
>
> Something I've been wondering about is removing all the "drop the MM
> locks while we wait for I/O" gunk.  It's a nice amount of code removed:

I think the point is that page fault handlers should avoid holding the VMA
lock or mmap_lock for too long while waiting for I/O. Otherwise, those
writers and readers will be stuck for a while.

>
>  include/linux/pagemap.h |  8 +---
>  mm/filemap.c            | 98 ++++++++++++-------------------------------=
------
>  mm/internal.h           | 21 -----------
>  mm/memory.c             | 13 +------
>  mm/shmem.c              |  6 ---
>  5 files changed, 27 insertions(+), 119 deletions(-)
>
> and I'm not sure we still need to do it with per-VMA locks.  What I
> have here doesn't boot and I ran out of time to debug it.

I agree there=E2=80=99s room for improvement, but merely removing the "drop=
 the MM
locks while waiting for I/O" code is unlikely to improve performance.

For example, we could change the flow to:
1. Release the VMA lock or mmap_lock
2. Lock the folio
3. Re-acquire the VMA lock or mmap_lock
4. Re-check whether we can still map the PTE
5. Map the PTE

Currently, the flow is always:

1. Release the VMA lock or mmap_lock
2. Lock the folio
3. Unlock the folio
4. Re-enter the page fault handling from the beginning

The change would be much more complex, so I=E2=80=99d prefer to land the cu=
rrent
patchset first. At least this way, we avoid falling back to mmap_lock and
causing contention or priority inversion, with minimal changes.

Thanks
Barry
