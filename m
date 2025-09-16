Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3A2848A8
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003809; cv=none; b=Pnww1fWyG6wdW3oeWtR8OahKEP1BBhz6yNwJSwbQhDK7M02Qr12C2jPJ6og1vDWB9h4msvsmQYTfCG1uUKgx4jdhKTScXrJvTakablfRZNe8/OqnnKcGDj0W3pk+DkQ7UIo8jsSQb5LDwAoui1EyH2qMGOYOM3N+3sOK3W4mdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003809; c=relaxed/simple;
	bh=ATPz90HRMzTO45UePY5i8G0/KGUUiD+EHn3zGHoMIzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q2AWA3Sy9xPzgYHNhBaiIzpGyxZZ3Q7nlUUayePYemAn6QsSWnk43FNtn0idSqr7YtJbRCiNcsbbdY38H+JeO/6YVkGVlBcdk3QdGN9ObR0rxC7nd2ufaPhub1xG1/Gyc97yL4oX4queD6t/xWXiA8A+8ZiRZ+bjnwIDlRLq+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lv6xc298; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lv6xc298"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603a9cfaso38840507b3.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Sep 2025 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758003806; x=1758608606; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzwxSCgUK/3UElXn+qMCVZOXd6lLimgLpQ+KrGfwqaU=;
        b=lv6xc298WRJweENer27hHOnZy0J1mSXlDgmMJ1XczXvig9lmT8IYSsn9wC0mwdfdj5
         e2gtCB9JxtDJOurDvlfbaUzHHwKflOORnpiA5dc+y3kvu3dZCX6i4KBcdxZ17sleigYY
         gBLX12DMTlSLsrsCCJObjFN4QNvzBCd1Yo26iwrOOeADEc9m77h2TsFWtfwIWY+BUdtD
         rM2niwRROy03NsATXmlmhT+G43nmno+aSv1AGiF9uvqWiSCfynDgsiD1YkFSoa7d2HNT
         SCfpVm1fDymRq5fAGHZUjmuj3fXsdACYAKt95DiS0JTGHYdbT0Ib95o1aC3W0qV7NcSh
         KIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758003806; x=1758608606;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzwxSCgUK/3UElXn+qMCVZOXd6lLimgLpQ+KrGfwqaU=;
        b=tgM6XS37LNcjNSRLnEvu/M22DKHBfcc3uH93ogAE+T5gKgwgRbGdI8Adq2TNY01cgs
         nU9k86B7duJ8WfAzRZ9wyqdS6Dltu3acRbKeGaDYH41XYnQwkRsHdiAvcJBaR6KvQKiR
         eb6QFxNvXYLODab1OB3kzjTn2oZm/HDrK1d6CslX2o2v52U8zRkRQWtuaDy6NSR03ard
         fc4fqR5O0HErpIfkWQuRSwvoG5bYxp3zJRzJ1tHaD+0FMY7Q6VtIHVSscVwmCCWoKHKY
         LebJD1E1Yjc3GncqzK5nMhMT86tw2Crl6bgTR5jSZZlgq+bRqk13gBqNi1wRxYId9g04
         stvw==
X-Forwarded-Encrypted: i=1; AJvYcCX5megyaef+uAqsQoT2MNEZCCuA/yE/DboXEXR0S8qrTM0mxEnDi5vZJZAYFWjBSHL6u9ewdS7WuAKL@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBiLuDHfsihnsYSSNVnoY5z0CUxUN+M7uLTFZ/DDGUnlsRHpW
	7/TMaoF/5cigQXfM+2TpJ2RnskOJygkgBjSa9p0pvx9yjZLVp6J5A18fIfMF8JUL5A==
X-Gm-Gg: ASbGnctkzeHHxoi37nUzvO9b806sUQHlOzOtMSBdHy6MgYe3WpT3ykUZTbTSO4JY6mJ
	skO/pZ8NMzZbw61aBuIS3GdHagqXSv6FeNkZAyyG01AfgR3O6wlzUfd99uQv7On+PwLajYG5H2l
	LtHc/eb0Mr5J4mBBIW0p/HYFaYdLW547Gs6QrjmZNjmaU55+aqCzEk1uMzeCBpDRA5Z+rkFY2Jw
	ousIP7WG3NCatNRnqGmChOjIwx6kEJz3FmdFRyaeAM5KUrgWvUBg0aATVhNRZlLjeJN2tQ0mPgN
	dKjcpolve2fQulf+u8hd7Peh+o6iiVouz5FrAYcIF70VtXbUtLbOBeA5o3VUtjXm7aGzX6oC369
	Gv5o6zETrSOKialy1oiSsCH+Ml2mu13HARzoPDS9wJJ8QS0gMmbpAvk/MOvIn11N6hIViXpPfR3
	PrFbDDzN9BX5N0Hg==
X-Google-Smtp-Source: AGHT+IFYH7nKR98YSl0bgd4j6elLmVBr5qc5bTleI6LMDXL64/KgQAEWWcRI4ClTxXA+31LnE3T7pA==
X-Received: by 2002:a05:690c:b13:b0:71f:eb2b:83e0 with SMTP id 00721157ae682-73062ca43c8mr138095197b3.13.1758003805348;
        Mon, 15 Sep 2025 23:23:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7683148dsm38488107b3.23.2025.09.15.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:23:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 23:23:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Roy, Patrick" <roypat@amazon.co.uk>
cc: "Thomson, Jack" <jackabt@amazon.co.uk>, 
    "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
    "Cali, Marco" <xmarcalx@amazon.co.uk>, 
    "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, 
    Elliot Berman <quic_eberman@quicinc.com>, 
    "willy@infradead.org" <willy@infradead.org>, 
    "corbet@lwn.net" <corbet@lwn.net>, 
    "pbonzini@redhat.com" <pbonzini@redhat.com>, 
    "maz@kernel.org" <maz@kernel.org>, 
    "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
    "joey.gouly@arm.com" <joey.gouly@arm.com>, 
    "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
    "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
    "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
    "will@kernel.org" <will@kernel.org>, 
    "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
    "kernel@xen0n.name" <kernel@xen0n.name>, 
    "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
    "palmer@dabbelt.com" <palmer@dabbelt.com>, 
    "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
    "alex@ghiti.fr" <alex@ghiti.fr>, 
    "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
    "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
    "hca@linux.ibm.com" <hca@linux.ibm.com>, 
    "gor@linux.ibm.com" <gor@linux.ibm.com>, 
    "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
    "svens@linux.ibm.com" <svens@linux.ibm.com>, 
    "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
    "luto@kernel.org" <luto@kernel.org>, 
    "peterz@infradead.org" <peterz@infradead.org>, 
    "tglx@linutronix.de" <tglx@linutronix.de>, 
    "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
    "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
    "trondmy@kernel.org" <trondmy@kernel.org>, 
    "anna@kernel.org" <anna@kernel.org>, 
    "hubcap@omnibond.com" <hubcap@omnibond.com>, 
    "martin@omnibond.com" <martin@omnibond.com>, 
    "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
    "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
    "david@redhat.com" <david@redhat.com>, 
    "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
    "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
    "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, 
    "surenb@google.com" <surenb@google.com>, 
    "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>, 
    "daniel@iogearbox.net" <daniel@iogearbox.net>, 
    "andrii@kernel.org" <andrii@kernel.org>, 
    "martin.lau@linux.dev" <martin.lau@linux.dev>, 
    "eddyz87@gmail.com" <eddyz87@gmail.com>, 
    "song@kernel.org" <song@kernel.org>, 
    "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
    "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
    "kpsingh@kernel.org" <kpsingh@kernel.org>, 
    "sdf@fomichev.me" <sdf@fomichev.me>, 
    "haoluo@google.com" <haoluo@google.com>, 
    "jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
    "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
    "peterx@redhat.com" <peterx@redhat.com>, 
    "jannh@google.com" <jannh@google.com>, 
    "pfalcato@suse.de" <pfalcato@suse.de>, 
    "axelrasmussen@google.com" <axelrasmussen@google.com>, 
    "yuanchu@google.com" <yuanchu@google.com>, 
    "weixugc@google.com" <weixugc@google.com>, 
    "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
    "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
    "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
    "shuah@kernel.org" <shuah@kernel.org>, 
    "seanjc@google.com" <seanjc@google.com>, 
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
    "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
    "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
    "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
    "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
    "devel@lists.orangefs.org" <devel@lists.orangefs.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
In-Reply-To: <20250912091708.17502-2-roypat@amazon.co.uk>
Message-ID: <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
References: <20250912091708.17502-1-roypat@amazon.co.uk> <20250912091708.17502-2-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Sep 2025, Roy, Patrick wrote:

> From: Elliot Berman <quic_eberman@quicinc.com>
> 
> When guest_memfd removes memory from the host kernel's direct map,
> direct map entries must be restored before the memory is freed again. To
> do so, ->free_folio() needs to know whether a gmem folio was direct map
> removed in the first place though. While possible to keep track of this
> information on each individual folio (e.g. via page flags), direct map
> removal is an all-or-nothing property of the entire guest_memfd, so it
> is less error prone to just check the flag stored in the gmem inode's
> private data.  However, by the time ->free_folio() is called,
> folio->mapping might be cleared. To still allow access to the address
> space from which the folio was just removed, pass it in as an additional
> argument to ->free_folio, as the mapping is well-known to all callers.
> 
> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> [patrick: rewrite shortlog for new usecase]
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>  Documentation/filesystems/locking.rst |  2 +-
>  fs/nfs/dir.c                          | 11 ++++++-----
>  fs/orangefs/inode.c                   |  3 ++-
>  include/linux/fs.h                    |  2 +-
>  mm/filemap.c                          |  9 +++++----
>  mm/secretmem.c                        |  3 ++-
>  mm/vmscan.c                           |  4 ++--
>  virt/kvm/guest_memfd.c                |  3 ++-
>  8 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index aa287ccdac2f..74c97287ec40 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -262,7 +262,7 @@ prototypes::
>  	sector_t (*bmap)(struct address_space *, sector_t);
>  	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
>  	bool (*release_folio)(struct folio *, gfp_t);
> -	void (*free_folio)(struct folio *);
> +	void (*free_folio)(struct address_space *, struct folio *);
>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>  	int (*migrate_folio)(struct address_space *, struct folio *dst,
>  			struct folio *src, enum migrate_mode);

Beware, that is against the intent of free_folio().

Since its 2.6.37 origin in 6072d13c4293 ("Call the filesystem back
whenever a page is removed from the page cache"), freepage() or
free_folio() has intentionally NOT taken a struct address_space *mapping,
because that structure may already be freed by the time free_folio() is
called, if the last folio holding it has now been freed.

Maybe something has changed since then, or maybe it happens to be safe
just in the context in which you want to use it; but it is against the
principle of free_folio().  (Maybe an rcu_read_lock() could be added
in __remove_mapping() to make it safe nowadays? maybe not welcome.)

See Documentation/filesystems/vfs.rst:
free_folio is called once the folio is no longer visible in the
page cache in order to allow the cleanup of any private data.
Since it may be called by the memory reclaimer, it should not
assume that the original address_space mapping still exists, and
it should not block.

Hugh
