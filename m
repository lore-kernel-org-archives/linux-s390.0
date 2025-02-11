Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229282505C8;
	Tue, 11 Feb 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288796; cv=none; b=EuCG1o3l3xoc5cPp25NR9q/gTUCidBYHXjRXgfr0uTv0i2Ot3oH6IFWmgk25R8TcF8dAHaxyygUb0vTdfAZOdSh/+4HNRdwtIa59emkCqOL76K1qXKYqIWPbb6q3rP/AQsT0mX1lK/ahhBICKO3mBFMXDcqEVTytbtSLWs59VGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288796; c=relaxed/simple;
	bh=6fu3wYfrbxpX9ThH36XIH7LpZ6BrCQc/5hqS5lNA56E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHUP7eGvtHb0ztFMf8gPx8usCCvA422yftBmCKxGHjFcwMAlVTP2tncMELNNpA4w5julLYswTo3/EkhPODRGFKplqao0Dp0wQwy7CT9eBg480039XXibmqeB8uUw3jAidRag2fYbDeXaiWblXO1Sdu55CMzrOntmDkBjYHLiXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B98C4CEDD;
	Tue, 11 Feb 2025 15:46:34 +0000 (UTC)
Date: Tue, 11 Feb 2025 10:46:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, oe-kbuild-all@lists.linux.dev, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Mark
 Rutland <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <20250211104638.0cdc51e1@gandalf.local.home>
In-Reply-To: <202502111626.K7CTghCR-lkp@intel.com>
References: <20250210142647.083ff456@gandalf.local.home>
	<202502111626.K7CTghCR-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 17:07:13 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
> 
> >> scripts/sorttable.c:306:13: warning: 'rela_write_addend' defined but not used [-Wunused-function]  
>      306 | static void rela_write_addend(Elf_Rela *rela, uint64_t val)
>          |             ^~~~~~~~~~~~~~~~~
> >> scripts/sorttable.c:287:17: warning: 'rela_addend' defined but not used [-Wunused-function]  
>      287 | static uint64_t rela_##fn_name(Elf_Rela *rela)          \
>          |                 ^~~~~
>    scripts/sorttable.c:294:1: note: in expansion of macro 'RELA_ADDR'
>      294 | RELA_ADDR(addend)
>          | ^~~~~~~~~

The above isn't used if sorting isn't enabled.

Looks like I'll have to add some "__maybe_unused" attributes.

-- Steve
