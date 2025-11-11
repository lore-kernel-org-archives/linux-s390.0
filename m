Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E26B2DA
	for <linux-s390@vger.kernel.org>; Tue, 11 Nov 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834073; cv=none; b=IbZpNaBvHUuhYLL9UPkhbzpAwAGCz86OIWKzddLvRc6bWksZ2AfzqJaZEEj5O+fpoSgOhXuBjRz53zqSy3mw4vEqn0EMi6dk+dBqGN2GODWrK5hDbr6Q7FaJyftn6c7qbq+SuxGsC1MmnC3hW24X6ra9V63hWZ3yQtV6NpXx/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834073; c=relaxed/simple;
	bh=sDNd3xKtQvuFQAbxJpzalFUBsuOA54Wttu1ZWggpyB4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XnYc95nbJqz8YWnrCPeWemL0ZUH2uBLrz6BZAmUTQ/7zNX4s2R1dLt3tcFmoAiM5CjiAbhvLe/upBZEn6HTtXPorKPafyKJ5uCzgLfcfKMkPK++IanNPOYc8fOIwNCaoAvsS6jp2vdiMWi60HVoa4ZaZpjhtA09SUn/yV/Sa4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCjZOCu0; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCjZOCu0"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f88b873bso306311d50.3
        for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762834070; x=1763438870; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQtvX2XQ8t15gjBEKpXNNs3ZpjZjdksPbAQ0ahr9C3A=;
        b=zCjZOCu0BeaWv5mb2hY4SDz/t/r4SViDFuaciRkffcF0F/xBEeI/T3/p/dEew7Yt7s
         kO7tISPHZT4t0insBD2ax0ZrTu4EFmGMp+tI8kx8EsxldNoE5ozgxQUndJBQ/SAYuyrj
         6DAGXYBXWTlqfKcGb6xdEtFUARPosxO6VWBu839ymHxPQjg4Tp50Yn9TCsrE6lNQ5fjQ
         pN6DmgNoDU3YIF518O4A9B0KBp+stmwFhyUQOrmGpOBihtWOfsutNF+oHmBLmVvqZEVt
         IwR0ZfkDT879st2KmK5QYHt/npvji/lpm3/mq8mJqXO0nZ4t+j4cBUIAN5YB+mDPuKZn
         /6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762834070; x=1763438870;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQtvX2XQ8t15gjBEKpXNNs3ZpjZjdksPbAQ0ahr9C3A=;
        b=Dtr+DA82ObwUbBFJH7cs26JPibJh7/b7ooiDmnuTixwe+Hq65hJmJjIqEUSG2/36I/
         AQbk0uuKYNRQudck2GhlrsvnwGn8pVoP7tqejUNtIy7UcELZG22Jnh+6aVbZN3WqXA3l
         HMKquqvJB8IHJQ0Zgi/E3cNCMYSrDsUBqWMhHRRY1BxTv+oDgVErEJCmJ0Brv8E545qt
         sD8XpgiS+iv+essWgN5VFIj7Ucp2r5REVhHCBVRwU1eyj0ikG4Yf7SQgY6KBs/Tfs1Sm
         UuhuKH3pwtFiNPngwJPJRLb7pMoLC7/sXQnrhhwa3nPQk4pNjltvnS5Yv8SOJXymtO0J
         WzIw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bFGCawqkma08evMVikCE4iJhyA70ckfEUbh2zUHMb0CJ8VXWcmySLAgnxKqT4gMGQbNAZbweXuoS@vger.kernel.org
X-Gm-Message-State: AOJu0YykSm8px07OYTIfUn8SduZGO7nJ+hAl71GZf6QyTSSxDSwUfRVv
	keHIJlyz7X+55RivIBmRM5B8rPRUAQINvoUwju7MutMK3wznv0ObwAGo9Mzc+Np6EA==
X-Gm-Gg: ASbGnct4NMm+LGn/OD6DBZ7Cn8uKbvhQvfkZAiqoBFnudhkGPtEX+z7eI97DM3OwCJC
	KU0qlYpJNKCxkS0cwYk2QtRXPQ+3KPN4YTKDoozV8iBwTpvxc1JjruKpaQAru376Tc24h01oEUB
	TrIYywhLUSakbHyeKT8YigUF/BmxMhhMVUrcy2SmU2xGbmOuoGpqARCJQeKqrkohZANTA3IcDa6
	WNAtrwTJLIn+aKTV5ldpEROHllbpZGQbDA4C/QH1fWtobCkLJuRiVUXjCHKyAubcUryM6KlvuCn
	mW4gczKEXjcWnI6rO9qNbY9b10wucyx6isp7AY8s4ZB7uYQUX8acJ4TfzW6qSgVly8kuhkzpOqT
	OZ0lu+71zWXYern+n0QCp/X15ffcH57Kzf6aERiVXyERGMg+FQ5Ud/89CO/iQrUf1EEpdpgeS/o
	hYZHT8RQy9v6efRj/OesjnjkSOERMNkfafRdk2XMCeiYDriRs2SWKeIBp/Sph9IMqqWcbIOzTwv
	bGKl4MNuA==
X-Google-Smtp-Source: AGHT+IHG/jZ//4QM4bUIX92EmnHpoMxramdxwXCxkW843uk4feMGQ0nNfJGMFAqbmmzMPaRjaD7rEg==
X-Received: by 2002:a05:690e:d47:b0:640:e6aa:b2bf with SMTP id 956f58d0204a3-640e6aab4e1mr5979840d50.43.1762834070176;
        Mon, 10 Nov 2025 20:07:50 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640d2d68bf0sm3436465d50.11.2025.11.10.20.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 20:07:49 -0800 (PST)
Date: Mon, 10 Nov 2025 20:07:34 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Janosch Frank <frankja@linux.ibm.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@redhat.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
    Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Alistair Popple <apopple@nvidia.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
    Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
In-Reply-To: <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
Message-ID: <ba5d8603-4140-1678-b2d5-d49ab1a40fe0@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com> <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local> <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com> <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Andrew Morton wrote:
> On Mon, 10 Nov 2025 15:38:55 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > > kind as I can be here, but this series is proceeding without arbitrary delay.
> > > 
> > > I will do everything I can to accommodate any concerns or issues you may have
> > > here _within reason_ :)
> > 
> > But Lorenzo, have you even tested your series properly yet, with
> > swapping and folio migration and huge pages and tmpfs under load?
> > Please do.
> > 
> > I haven't had time to bisect yet, maybe there's nothing more needed
> > than a one-liner fix somewhere; but from my experience it is not yet
> > ready for inclusion in mm and next - it stops testing other folks' work.
> > 
> > I haven't tried today's v3, but from the cover letter of differences,
> > it didn't look like much of importance is fixed since v2: which
> > (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
> > not seen with v1, and probably not really serious) soon hits an Oops
> > or a BUG or something (as v1 did) - I don't have any logs or notes
> > to give yet, just forewarning before pursuing later in the day.
> > 
> > If you think v3 has fixed real crashes under load, please say so:
> > otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.
> 
> Oh.  Thanks.  I'll move the v3 series into mm-new for now.

Lorenzo, I can happily apologize: the v3 series in mm-everything-
2025-11-11-01-20 is a big improvement over v2 and v1, it is showing
none of the bad behaviours I saw with those.  I've not searched or
compared for what actually fixed those symptoms (though have now
spotted mails from Shivank and Kairui regarding 3ffffffffffff),
I'm content now to move on to unrelated work...

Thanks,
Hugh
