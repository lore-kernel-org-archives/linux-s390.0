Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54072519DE5
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899038; cv=none; b=fe6BwkkTRRHXcpcRbPIs6rrVPTRrj47oEsIWB67WQYN+HcSO8TMcSHY76aALEnHSlTYpAGbcvip3DNd8s6IMtY3vhD72RdllHdUdAZ5L01SFw4cuUBqnZSkdWjXTphEnESJh66GJHVZ1NbiNlx/c5Vekb7iYYS1xTjn9dctnIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899038; c=relaxed/simple;
	bh=OFf257AzwV5sGNKejZhgDp8ftyQRLXmERUn8nIteG+0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QGjV6JSq4AW5AhhVNMAKR/Mq/zkTD/KvQ/yo2gXlia5xanzuCUydycCoTe5FtpTQv5H2yA2i9znShVlwCQC70mDAuKBpLOmqw65XguyHhZr0UDDlanF9wgPEMZbkX59hm5C1eeIo6qVYPOpZjHlhpXGMZjjpJLfMsyHbKSEndy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e35xyOju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e35xyOju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1AE1F000FF;
	Tue, 13 Oct 2026 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899036;
	bh=OFf257AzwV5sGNKejZhgDp8ftyQRLXmERUn8nIteG+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e35xyOjuSTTEmym3fY5r1/WqjqZR2PpRCz4yqWjQatL04/nWoNyJU/fCLS98UYj0g
	 vJ1DeDIziQekZCIjhHMLkQ2Tal8DJodAv36gUJtYzxnJHxbQwJKjvMV83+1I00jNnd
	 H9eTfRPYwpsJcUQHHnMW4JJlrE6biybAW34vI+ZV9QcKi/WeewfMQvzz8UraWiZ1zC
	 /B+LmOqJo27eRE5KyJCfx8oQZaiAyUNu6mcMf4NbhADsubU13DEd6h2TesGbBnVOvp
	 kdy6rdg75dHEnsjRn8pUIudwApDNKJiluTYQvlmuaSIXkaGxCupGlNlrQp+Q4HjW04
	 9dcdk/DxioFeA==
Message-ID: <sashiko-outbox-169849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/signal: Fix incorrect return address in
 signal frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013133453.2288894-2-hca@linux.ibm.com>
References: <20261013133453.2288894-1-hca@linux.ibm.com>
 <20261013133453.2288894-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:43:56 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> exit_to_user_mode_loop() can call arch_do_signal_or_restart() multiple
> times when signals are pending.
>=20
> If the first call set up a vDSO system call restart by saving the real
> user return address and adjusting psw.addr so it points to the vDSO stub,
> a second call builds the signal frame with the wrong return address.
>=20
> Restore psw.addr from arch_data, and set the return code to -EINTR before
> building the signal frame.
>=20
> This requires restart_block.arch_data to be properly initialized for all
> tasks. Move the initialization in copy_thread() in front of the kernel
> thread check, so that it also covers kernel threads and their children
> (PID 1, usermode helpers). Only PID 0 is left uninitialized, since it
> never returns to user space.
>=20
> Fixes: df29a7440c4b ("s390/signal: switch to using vdso for sigreturn and=
 syscall restart")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013133453.2288=
894-1-hca@linux.ibm.com?part=3D1

