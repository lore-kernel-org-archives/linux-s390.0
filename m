Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D427180B;
	Wed, 12 Feb 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385378; cv=none; b=Y07rbaO1hzSne5Rrh/RVzx2w7qftq7ckUOfciml93VBgcxV88uGi/duzq0lKafgTm2x9dackBlSqIPIMcZ7yxI+WpZmAf4Jz2FEz2SrDCP44IkxNdl4q1zzOr/xkinUJRzr2PDJDkbcbSCVU7dwAMqqRgw7kv7JjRTYobzVP270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385378; c=relaxed/simple;
	bh=Vh9Rbn/USbZaZLNcqYAetb2q1bAZ2gtKppOiaqB9Vms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbHwQM4qZ2Z9FNGMH/wrdzYBooueEMLT0IJFwnuHzwJzvcv7QKRtCb8FPoJNMdeIs5Tuq4A9oCvllVrYoyu2tx7LrO8oRmDNsruvqC1oo8KvaxMx27kxhg2I/TQ64M0a95V7szuPcTYDV4o4mBDCSqxnbADNtzj/Gx85FS5h1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01928C4CEDF;
	Wed, 12 Feb 2025 18:36:15 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:36:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] arm64: scripts/sorttable: Implement sorting
 mcount_loc at boot for arm64
Message-ID: <Z6zqHY0a5CPEaTCN@arm.com>
References: <20250211141139.03d2997e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211141139.03d2997e@gandalf.local.home>

On Tue, Feb 11, 2025 at 02:11:39PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The mcount_loc section holds the addresses of the functions that get
> patched by ftrace when enabling function callbacks. It can contain tens of
> thousands of entries. These addresses must be sorted. If they are not
> sorted at compile time, they are sorted at boot. Sorting at boot does take
> some time and does have a small impact on boot performance.
> 
> x86 and arm32 have the addresses in the mcount_loc section of the ELF
> file. But for arm64, the section just contains zeros. The .rela.dyn
> Elf_Rela section holds the addresses and they get patched at boot during
> the relocation phase.
> 
> In order to sort these addresses, the Elf_Rela needs to be updated instead
> of the location in the binary that holds the mcount_loc section. Have the
> sorttable code, allocate an array to hold the functions, load the
> addresses from the Elf_Rela entries, sort them, then put them back in
> order into the Elf_rela entries so that they will be sorted at boot up
> without having to sort them during boot up.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(unless you want this to go in via the arm64 tree)
