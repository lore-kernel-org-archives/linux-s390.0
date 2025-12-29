Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5521A447;
	Mon, 29 Dec 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767040891; cv=none; b=iM7R45pRDQHtqIptp1/HJnXyzSHeZztDK6b9lLD/mNEqbIrZPEq3P/LR9FAVwlBfIMyyOLJFGtpgzP9/6SzJFrTusxr7AZpnugqT8dhw7+ynWHZ/zDkV+UxIgib9IDJ2APYH8gcI+GLt0AE7XrS0tKe3LtY521I9/+MoSIv8TZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767040891; c=relaxed/simple;
	bh=GZ+1KKfaWUAEcxuxIpgqLNo0r9p6egS5f7P9gKbzco0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZThUKzkekykAuP3G23BY4KsgKZEd2sB7NTpDPATXSqTpTtonUC3KtgWJoWOz79FDAxxiUMtB/QM12MZlr3NKjX9oDFwE5tGh2e1ufzlb7ye1MGeDdaRRQOw4oXK9o2jfizDk3nGsXKBImwpnXta1lQMPV1Q/9br52pb3fyfGMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSRG7hvx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSRG7hvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9322EC4CEF7;
	Mon, 29 Dec 2025 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767040890;
	bh=GZ+1KKfaWUAEcxuxIpgqLNo0r9p6egS5f7P9gKbzco0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSRG7hvxBwQ796IfjClt8gqnHeEg9FV3z8mjQpYJOHPTnhcOUr+/cnAT4eS+xWhcw
	 Ry/Yz2NJZ5DA5UhE7xlqILcigyZGgJoMpuIuB0HMrcb7Ey7m1vgaCm9xAfhtLSz4bn
	 sbTYmz31UIAeLJcFVaXN7OOZdttuepR+uxZUfFaBQo541btafW7mlmwhzqU1GM58MY
	 M1UJdK4hRPnph8apO7+VSUObxlZC5iMC2GiurW2KC0C0UTBxkCWb1C8TBghjVP78ye
	 lD82sIfiiyao8xdsYvHQc2rwHPPIbHwa6sC1CjLJJW0iqFCco3pfM0oBcDvtUsNP3Z
	 l3grsjsZqTnwg==
Date: Mon, 29 Dec 2025 15:41:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v7] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-ID: <aVLneaA6gaGUaBJS@laps>
References: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
 <20251228143533.33e2be2d6282d036f55e12cb@linux-foundation.org>
 <398ca47d-19d4-4b26-98db-2bf283b6b0cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <398ca47d-19d4-4b26-98db-2bf283b6b0cb@kernel.org>

On Mon, Dec 29, 2025 at 07:35:18PM +0100, Christophe Leroy (CS GROUP) wrote:
>
>
>Le 28/12/2025 à 23:35, Andrew Morton a écrit :
>>On Wed, 24 Dec 2025 17:25:24 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>>
>>>Note for backporting: This fix is a partial retrieval of the commit
>>>mentioned in the Fixes tag. It is only valid once the change referenced
>>>by the Depends-on tag is present. When backporting this patch, the
>>>commit mentioned in the Depends-on tag must be included first.
>>>
>>>Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250121150419.1342794-1-sourabhjain%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C93a8f925fc024ff9c3fe08de46616c3b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639025581404027066%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3iVUdaMBWhExKkDiV%2BBfYufPTKva1dVikhyQShOq7mc%3D&reserved=0 [1]
>>>Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250128043358.163372-1-sourabhjain%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C93a8f925fc024ff9c3fe08de46616c3b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639025581404053206%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=GamDe2R87SdpFurnj9Cmt9wOQtkGLgIO1z7nl5QPxgY%3D&reserved=0 [2]
>>>Fixes: c2833a5bf75b ("hugetlbfs: fix changes to command line processing")
>>>Depends-on: 2354ad252b66 ("powerpc/mm: Update default hugetlb size early")
>>
>>This will be the first "Depends-on:" in history.  Which is a hint that
>>we're doing something wrong.  This innovation will surely fool any
>>downstream automation.  Let's use existing tools if possible.
>
>What do you mean by "first in history" ? Do you mean it's never been 
>used before ? As far as I can see it has been used several times 
>already. First one was in 2014 with commit a0855054e59b ("iwlwifi: 
>dvm: drop non VO frames when flushing")
>
>Sasha, do tools use it ?

The standard way to annotate dependencies is outlined in the docs:

   To send additional instructions to the stable team, use a shell-style inline comment to pass arbitrary or predefined notes:

   Specify any additional patch prerequisites for cherry picking:

   Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
   Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
   Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
   Cc: <stable@vger.kernel.org> # 3.3.x
   Signed-off-by: Ingo Molnar <mingo@elte.hu>

   The tag sequence has the meaning of:

   git cherry-pick a1f84a3
   git cherry-pick 1b9508f
   git cherry-pick fd21073
   git cherry-pick <this commit>

My tools don't look at Depends-on: and I don't think that Greg's tools do that
either.

-- 
Thanks,
Sasha
