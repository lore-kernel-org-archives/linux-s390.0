Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378222;
	b=tefoGA4mKMnL+H6k9Feig+D72r8RxWXIEmWc1Fzu77fA0rx/5gR6Eb3Sj8RdAkJUV9fw
	 IYeGlNBkO/KKek2S3RsiCkvPSGrT0k2gAOQSBW4zfPIKrkVBok51hFU9SiWlbx18ZSzlq
	 71o9AYEWXnKpfHEuJzbsAmw1cdf30J7txZ4AqC9YENHiPcDn5DlB7G7dPlb/jcmJGqnJs
	 dNwRbwg+VZ5iNOgY7MmG8MyARYM2AOJy9BXTY1o90LDjFboV5WCqFjLUbHscC4gHUrt9m
	 dAjjSuAHkf/F5sDoiutfsSKcyKf5ABL8CHtgbu8XA4gtOGntGG2uVO1nI/c9yxtASaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+FsNSHYaB061hlu2KABqxgrNYuq8vEgF2fs6tSZjLEU=;
	b=MAEx8xEb0zIZHts1MOGVBeWSurRe/mQZu7Ao4pRRJ6gRT5n3f1y2BqohdaC/UEGAyw9Y
	 q4lU4tsFQl7JzqESfPrxmv5pqDmTwTS3Pos2BpVOc3CawX9FJqHl73NbS/9DmvDz6oWv8
	 NMApQcKSN0AO8Wq15SrjVb8FvNLX70QMXIuHQFT6GWHN3UUWVpFMqkDmGRLuOA2CwrBb1
	 qFGMLNlwK2TM9rn1YZaN+k7eO26GkBkW63tfxZYEgDEAg2PA2hOeuU90WRhO+lOxyxoIs
	 JJpapZihrEZZIG4iOoIFtotEHcAnVxEydZXVUdqFQBmNkL5cLl6Nt56cknJ3bQkKMeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OeKs4h20;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1B606A32E;
	Sun, 22 Nov 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OeKs4h20
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EB11F000D8;
	Sun, 22 Nov 2026 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795378222;
	bh=+FsNSHYaB061hlu2KABqxgrNYuq8vEgF2fs6tSZjLEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OeKs4h20pS30oNZ1IR6GnomWw5DqimBeyeF3s3kvf9vG6T6et1HFpXwu+3RUD3kAl
	 VTBl8DZ7dNxpuLlaF0l10G+XbXn4Bh8/advm28c8V+2c9NNnSdrLUBtzuJz1FfZvob
	 aI+udgeSDGFiJYNYNYYS0x1Dy9+r3s2cQyGX418c=
Date: Sun, 22 Nov 2026 12:10:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Hugh
 Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
 <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Peter Xu
 <peterx@redhat.com>, Breno Leitao <leitao@debian.org>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Arnd
 Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 04/15] mm/hugetlb: account temporary folios
 separately
Message-Id: <20261122121020.4c0964fa03c2255e29fd43d7@linux-foundation.org>
In-Reply-To: <5f477c4f-9874-4f51-ab84-5b044a3ea568@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
	<20261116-fixes_hugetlb-v2-4-4dd9e94ea9ac@kernel.org>
	<45997a78-95bd-4e50-b433-f64237f9ec1a@kernel.org>
	<5f477c4f-9874-4f51-ab84-5b044a3ea568@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Nov 2026 19:44:35 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > In combination with
> > 
> > 	mm/hugetlb: preserve persistent flags when returning folios to the pool
> > 
> > This results in an issue during boot.
> > 
> > I think the following is required:
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index bfc88d42ef0d..aa6ad8d93266 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1804,8 +1804,8 @@ void free_huge_folio(struct folio *folio)
> >                 h->resv_huge_pages++;
> > 
> >         if (folio_test_hugetlb_temporary(folio)) {
> > -               folio_clear_hugetlb_temporary(folio);
> >                 remove_hugetlb_folio(h, folio, false);
> > +               folio_clear_hugetlb_temporary(folio);
> >                 spin_unlock_irqrestore(&hugetlb_lock, flags);
> >                 update_and_free_hugetlb_folio(h, folio, true);
> >         } else if (h->surplus_huge_pages_node[nid] &&
> > 
> > I'll test real quick whether that resolves CI issues ...
> > 
> 
> Yes, that makes it work. @Andrew, can you fix that up?

np.

From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: mm-hugetlb-account-temporary-folios-separately-fix
Date: Sun, 22 Nov 2026 19:21:43 +0100

In combination with

	mm/hugetlb: preserve persistent flags when returning folios to the pool

This results in an issue during boot.

This fix is required.

Link: https://patch.msgid.link/45997a78-95bd-4e50-b433-f64237f9ec1a@kernel.org
Signed-off-by: "David Hildenbrand (Arm)" <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 mm/hugetlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/hugetlb.c~mm-hugetlb-account-temporary-folios-separately-fix
+++ a/mm/hugetlb.c
@@ -1792,8 +1792,8 @@ void free_huge_folio(struct folio *folio
 		h->resv_huge_pages++;
 
 	if (folio_test_hugetlb_temporary(folio)) {
-		folio_clear_hugetlb_temporary(folio);
 		remove_hugetlb_folio(h, folio, false);
+		folio_clear_hugetlb_temporary(folio);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
_

