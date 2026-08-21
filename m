Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B328505E;
	Fri, 21 Aug 2026 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279027; cv=none; b=Z7vqqvS+H6i3BKeggZBpJ6n3DbukZkNJd2t9ghaWdGEKOtA6U8xdaDEo8sIJkoBhh1ppOonpqSXF4SmBFYP1xe6Npkc5xHZtaT3p6ZYo2/5c59H0MpmvWKlHbU+lqe30XuBrZBSqJJ3A+dLL5g7xDyhfk365NEqzwmSEHlrrkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279027; c=relaxed/simple;
	bh=8wTjae5ItH3+9qVgMgpyKw/xjrBMDHD6eVKxcIkHwwM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gs34YAnedTbfyUCb1Efri6k0cNHXW1yDPB07O02bcxWWcjPxgtVDvyMQsCQm9JiAWnUnRTsozv6ocd8LlEbaQ3gaxju3hy2P8/goCpUW4qb2rd9Z/0xKBFMOXtPsNu+S2foTlnJYnLRNJDJobt/6JNPtRB00Wb2yAU0svoQ+ZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKOdp80K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKOdp80K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7941F000E9;
	Fri, 21 Aug 2026 02:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787279025;
	bh=nwj029qvfIuS0n2IlGGdFsymc671fa/erueghYr3m0A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FKOdp80K1NCdExfZ1tcV6jarRclI8uxefHf43o0VfsGMY7h6gHGbb2Rx1STpUXm3W
	 ZqllCnvzbL/8/x8dercSC6kVEvqT2XPEZGyYrbE/rwLPpSiTtbtKl/4vEvNiotiM+H
	 /ppk8euQ1OD384/8sy5svQj87ViMgNLjapwxeRn6TmnDbBv5i/zXQQ8t/325nQ2NjH
	 AqolJF6RXXh+L7bpAQA8mNzojnq//qqj9QpSOI+LWw5dQiVChms/JXaexpX7c34u1l
	 e++Owow0HeRcTCq1jG3DhsIBIx9wYnOEK/idwAIO06GpBh+b3diywe7T4A4oLu4hfJ
	 p6mVte1Qi/1sw==
Date: Thu, 20 Aug 2026 20:23:44 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
    linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
    linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
Message-ID: <236a0edb-76f4-a28c-175b-f43994310a9f@kernel.org>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-746012605-1787278993=:86110"
Content-ID: <1dd06b80-a066-feec-b1fa-addb8fb6fff9@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-746012605-1787278993=:86110
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c4da6fb9-7dfb-d0d8-ef0a-6c21140cde31@kernel.org>

On Mon, 2 Mar 2026, Thomas Weiﬂschuh wrote:

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
> 
> Move the symbol to a kernel-internal header.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul
--8323329-746012605-1787278993=:86110--
