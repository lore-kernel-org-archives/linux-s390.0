Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8C38424F;
	Thu,  9 Jul 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589825; cv=none; b=dfpQPPP7jjTtXMc9OrFu1LH3Lh9M0l3G7aqBBZg7yJTKAc2pRumRPjUovcH7Q0V760v/JT1jdU8/RCcn+chB2TXiDABWXUi+275IvMOkh2Y7UFPCyyBjFIgGkp4Cd8RKfDFEdpl5Pzjonq5hRCTQUMfP4EWgjSu4W7ZZp4hUxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589825; c=relaxed/simple;
	bh=QseiMaM3t1q4unhiQ3umeYmkF+Ih5DAbDjo71zdoM5U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=oEcegMBkPD6hPYexofkUGXTC88A/iJsvVAIAY3MMX72EJgJu+TbHfy+JSvibJvVOwTAlI+DzcFRi0rPDfN9MdYSDnZF3iaqe+OeEneXnbrwMRMWIP7dUANj7yGoZycDTWg3Tz5g3ohh7X5vnanafLLmvBok/ZPbvrSDtcCktDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjua/1Hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjua/1Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136001F000E9;
	Thu,  9 Jul 2026 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783589824;
	bh=hNakBsw4iweOcBS9zSwRAtoEnClMELbyw+JCpMLKSfs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bjua/1HfoFc53QViTJ0GuKCIL/s4jlPhIMR5FVcgg5aYp6ckAQohiJebCD3ra868K
	 YWz3M60GQUkcCfJexQjsivc/9YWUqnr5nHOrN062Yjbb4j6+YMLpdE1f9US85KvTSw
	 KUOsC/FhWTNkTvFHkus9LgaGhl0OxBBmOWU+DaYMFHCGRNHxjSC6pz5tLPwqT/EzqA
	 V3hwZ0Jd2KNEKiUDvTxgwoG7vpUYova251bMq8WAYNiPhyGSHjrLc+k8UwBoaAAqhT
	 FuzpAEm2zmQIKC+EVWHrqE+ai+iuKhji6sAmV6gskFAefmh6vehlUe6PXK+3B2ciqe
	 NKlKRpJsOcO8w==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part
 2)
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
Date: Thu, 09 Jul 2026 12:36:53 +0300
Message-Id: <178358981368.3970180.15161129072189513624.b4-review@b4>
X-Mailer: b4 0.16-dev

On Wed, 08 Jul 2026 16:10:55 +0200, David Hildenbrand (Arm) <david@kernel.org> wrote:
> mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 2)
> 
> Let's remove the remaining pieces of CONFIG_HAVE_BOOTMEM_INFO_NODE,
> performing some smaller cleanups around freeing of reserved vmemmap
> pages on the way.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK. Heavily cross-compiled.
> 
> [...]

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

