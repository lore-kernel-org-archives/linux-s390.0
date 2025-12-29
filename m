Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AD3314B4;
	Mon, 29 Dec 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033326; cv=none; b=s6+Ww5jukJ01ZzCvzNcXEm94v8V9efT+cII8KKzwOxEslqMyjltp4VJDKbLrByA9S0iyyjR3WdhWIeFuNRTRzZBPr71sznFYEj3RR5L627hRvZP3yRxUmy7uykDyQgmBKvkYNkPrl0KMGI9m0ffpwxlz/4qc4OLy/yxNcnwR15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033326; c=relaxed/simple;
	bh=eG2cXpjbEn5KgR3sqGbsjKORgaU2dlYeuXkzKF8Mu+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNnozfqb69y8FeQ+M4Ibau/m0qBzC6rahMp8Y9ZLabR4ftAKmyvdfcCuGR3mKtu4W5ZpwotA1KbLkNSQ70nsdkjGdqfYa7YPrkoxOD4mwnqBTN+qubmffX8IEEfXWWrJUbwhNdyRNyxZYDcCOXr3Y8TiXX4g4SSzSF7CzumouNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJiTqQdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJiTqQdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EF6C4CEF7;
	Mon, 29 Dec 2025 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767033326;
	bh=eG2cXpjbEn5KgR3sqGbsjKORgaU2dlYeuXkzKF8Mu+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tJiTqQdxcxiahCt/5Na42Sqqnb6QMNXBFsKWCsh/jwM7SZm5uZJ6HLYmiAziNGUIM
	 bStVvsBKeMwq3158DF+MVo9QN/3PmTb3lyOHtcBb4uKosJIhW1HwdKEgIRXdhJLqIv
	 Aze3DO85ITf1QVHZwt8J08+vxDRRz+G7IJLe4q9AeAEu/dotyEun9ursQ2VT4iGuwF
	 /uUam40Exa8qQD64T3RwaQSpZhRY3Q8GKi1W2craqo9vuRBjDKQdEdaMErKFYMrgrL
	 I+Qs35NIYKKJSezvh7BHgJsqWQugepNS5WIMPfLeYt/RvPpPpf/xHw5lAuaNu5cPsR
	 klwqXccc4oIpw==
Message-ID: <398ca47d-19d4-4b26-98db-2bf283b6b0cb@kernel.org>
Date: Mon, 29 Dec 2025 19:35:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: Andrew Morton <akpm@linux-foundation.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
 <20251228143533.33e2be2d6282d036f55e12cb@linux-foundation.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251228143533.33e2be2d6282d036f55e12cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/12/2025 à 23:35, Andrew Morton a écrit :
> On Wed, 24 Dec 2025 17:25:24 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
> 
>> Note for backporting: This fix is a partial retrieval of the commit
>> mentioned in the Fixes tag. It is only valid once the change referenced
>> by the Depends-on tag is present. When backporting this patch, the
>> commit mentioned in the Depends-on tag must be included first.
>>
>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250121150419.1342794-1-sourabhjain%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C93a8f925fc024ff9c3fe08de46616c3b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639025581404027066%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3iVUdaMBWhExKkDiV%2BBfYufPTKva1dVikhyQShOq7mc%3D&reserved=0 [1]
>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250128043358.163372-1-sourabhjain%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C93a8f925fc024ff9c3fe08de46616c3b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639025581404053206%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=GamDe2R87SdpFurnj9Cmt9wOQtkGLgIO1z7nl5QPxgY%3D&reserved=0 [2]
>> Fixes: c2833a5bf75b ("hugetlbfs: fix changes to command line processing")
>> Depends-on: 2354ad252b66 ("powerpc/mm: Update default hugetlb size early")
> 
> This will be the first "Depends-on:" in history.  Which is a hint that
> we're doing something wrong.  This innovation will surely fool any
> downstream automation.  Let's use existing tools if possible.

What do you mean by "first in history" ? Do you mean it's never been 
used before ? As far as I can see it has been used several times 
already. First one was in 2014 with commit a0855054e59b ("iwlwifi: dvm: 
drop non VO frames when flushing")

Sasha, do tools use it ?

$ git log | grep "Depends-on: " | wc -l
137

$ git log | grep "Depends-on: " | head -10
     Depends-on: e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
     Depends-on: arm64: dts: nuvoton: Combine NPCM845 reset and clk nodes
     Depends-on: 058518c20920 ("landlock: Align partial refer access 
checks with final ones")
     Depends-on: d617f0d72d80 ("landlock: Optimize file path walks and 
prepare for audit support")
     Depends-on: 7ccbe076d987 ("lsm: Only build lsm_audit.c if 
CONFIG_SECURITY and CONFIG_AUDIT are set")
     Depends-on: 26f204380a3c ("fs: Fix file_set_fowner LSM hook 
inconsistencies")
     Depends-on: commit 045b14ca5c36 ("of: WARN on deprecated 
#address-cells/#size-cells handling")
     Depends-on: v6.12+ with PREEMPT_RT enabled
     Depends-on: 045b14ca5c36 ("of: WARN on deprecated 
#address-cells/#size-cells handling")
     Depends-on: commit aec89dc5d421 ("block: keep q_usage_counter in 
atomic mode after del_gendisk")

Christophe
