Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887A2F4A1B;
	Thu, 13 Nov 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049245; cv=none; b=muIZ4bFQjHKeUhlNtwMByWDM/MahBQA9Q59tKzB631IHo40lHUgO8hZvPt162Q+n81rNmb8WX1sk557/4IGTHGKTAPVSYNLwOLk8hHGhTFffwvKO0zrkdAjYZfPFG62mvTMcvnLW0n5NXwCaucNpXGbz1LDqi6rH4FSyDCvJbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049245; c=relaxed/simple;
	bh=j7wRqOkhInBDFJO29zzutLscWpsibyHgqvyp1r6MiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blpYPaMfI1Ty/Fn5qbRCCN64FnLKujp2+QiDO8+NkMRv8Dbh53BjGyGogN6XuGg2b6jro6FDSXjsHCgQJpJK1SC7y1HUvj+2vTbAtg1T2vTkR703PKYjNhJlylrWIgX59i1l3pSyOqFkKYbEmH9O9J+cle8FYkAvAI1f4RMCAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S2NaooOP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S2NaooOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763048640;
	bh=j7wRqOkhInBDFJO29zzutLscWpsibyHgqvyp1r6MiDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2NaooOPpPtUQ2u0x3xwn9yu07Byd4hSZLg1fJGxqRzqxhSuEsa4ILB4tgYsxcSFN
	 HoC20sO2sr7uKXjEEdmFNIu/3nZIAbMf4g45sxG/70MhodtZY7vQ0fsVlUeTX+Uu7q
	 mlSgGJdX9OYk75rZ9VOPCB9wteypM0+5QKz4VPcw=
Date: Thu, 13 Nov 2025 16:43:59 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andreas Krebbel <krebbel@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/8] tools: Remove s390 compat support
Message-ID: <72a8ffff-5074-4a7f-94ee-454c21f8a130@t-8ch.de>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
 <20251113150731.2697279-5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113150731.2697279-5-hca@linux.ibm.com>

On 2025-11-13 16:07:26+0100, Heiko Carstens wrote:
> Remove s390 compat support from everything within tools, since s390 compat
> support will be removed from the kernel.
> 
> While removing s390 compat code replace __s390__ ifdef guards with
> __s390x__ everywhere. Even though this is not strictly required this
> makes it easier to spot s390 compat code support leftovers.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  .../arch/s390/include/uapi/asm/bitsperlong.h  |  4 --

Wouldn't it make sense to emit an explicit error from the UAPI
headers if a user tries to use them in 31-bit mode?

>  tools/lib/bpf/libbpf.c                        |  4 --
>  tools/lib/bpf/usdt.c                          |  2 -

>  tools/include/nolibc/arch-s390.h              |  5 ---
>  tools/include/nolibc/arch.h                   |  2 +-
>  .../testing/selftests/nolibc/Makefile.nolibc  |  5 ---
>  tools/testing/selftests/nolibc/run-tests.sh   |  6 +--

Acked-by: Thomas Weißschuh <linux@weissschuh.net> # tools/nolibc selftests/nolibc

>  tools/testing/selftests/rseq/rseq-s390.h      | 39 -------------------

>  tools/testing/selftests/vDSO/vdso_config.h    |  4 --

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net> # selftests/vDSO

>  9 files changed, 2 insertions(+), 69 deletions(-)

(...)


Thomas
