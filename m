Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7725A631;
	Mon,  1 Sep 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709935; cv=none; b=Dk8zVLTx7bU3OjCoyYI54CC8qP5vkR6bcRFFlr883AGlIwBjpx96WZWdk9y/3eL581DuLGAuZQFTfiXvt4KwBfzNFgoSHRFe78WmU4XPyxhnUyzcQ/HLEJRC/7uYfBi0Nv9+dromLeXsp4dPsbzQniaeotml05PJLmSxoQlKILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709935; c=relaxed/simple;
	bh=bzJJHmbX9vM5aOF/O9o6rY71Kq2Iv7irkIXBpj8H6B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCGve1U3lCE1Glbom+HmMP1p660pfl0zFDfawl7zLeRo+l+5dBgoVZ5hjUVmBsR3qtFFXWsDYkpDgyC0WDTllIqEXuyvfn6yY+Q+HsvPCERoxe41E8wa9pxwA4C4OtukIMtY3dCmq46nbLzPid6fMiK2BXfXGOh0dsgm0RcraMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 23474582078;
	Mon,  1 Sep 2025 06:43:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4140743A5E;
	Mon,  1 Sep 2025 06:42:52 +0000 (UTC)
Message-ID: <f7d55c91-8877-41aa-8cf0-64af38a9a109@ghiti.fr>
Date: Mon, 1 Sep 2025 08:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kexec: Fix invalid field access
To: Breno Leitao <leitao@debian.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Coiby Xu <coxu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kernel-team@meta.com
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledugeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejkeeugfdthefhveelffdvgeetgeelteeijeekheehfeevtdduvdfgteevgfehffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemkeehrgekmeehrggvugemsggrsgefmeeijeelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemkeehrgekmeehrggvugemsggrsgefmeeijeelhedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemkeehrgekmeehrggvugemsggrsgefmeeijeelhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmr
 dgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghogihusehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Breno,

On 8/27/25 12:42, Breno Leitao wrote:
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
>
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
>
> 	------------[ cut here ]------------
> 	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
> 	load of value 252 is not a valid value for type '_Bool'
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> An initial fix was already landed for arm64[0], and this patchset fixes
> the problem on the remaining arm64 code and on riscv, as raised by Mark.
>
> Discussions about this problem could be found at[1][2].
>
> Link: https://lore.kernel.org/all/20250826180742.f2471131255ec1c43683ea07@linux-foundation.org/ [0]
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250826-akpm-v1-1-3c831f0e3799@debian.org/ [2]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (3):
>        arm64: kexec: Initialize kexec_buf struct in load_other_segments()
>        riscv: kexec: Initialize kexec_buf struct
>        s390: kexec: Initialize kexec_buf struct
>
>   arch/arm64/kernel/machine_kexec_file.c | 2 +-
>   arch/riscv/kernel/kexec_elf.c          | 4 ++--
>   arch/riscv/kernel/kexec_image.c        | 2 +-
>   arch/riscv/kernel/machine_kexec_file.c | 2 +-
>   arch/s390/kernel/kexec_elf.c           | 2 +-
>   arch/s390/kernel/kexec_image.c         | 2 +-
>   arch/s390/kernel/machine_kexec_file.c  | 6 +++---
>   7 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: 3c642997252eef4449cb6b6e02af3dc22515d817
> change-id: 20250827-kbuf_all-b9d55c9291eb
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>


I see that the commit those patches fix is in 6.16 so we should add cc: 
stable.

And who should merge those patches? Should we do it on a per-arch basis?

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
