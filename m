Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A44C0419
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718407; cv=none; b=HsoheSZYLTcOIsmf9QPM+w8KbHDrhpr1qX/UxW6d1ufb3n03iqVWCP+LeVEWXJFjVquAQWi2DzGHSQy7ZARD9tNteC26Fz0PZus2+aoxenN2y+/cdzBq3CVN9FpNre0u9hYwsvTwgrXkMGA9sjSJhqKcULYetzE7X3XfVQR5Ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718407; c=relaxed/simple;
	bh=vvz0c55hY8DhYP6t4+LYYz8F2b8TKp8alo4WT/Pu4M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8UkZXkv0adOxUEhqheutf2PgmuDA8eWP43R7Ya8zSdtMeCkz0PvVc1nlySny26ayvwPjDoteql3KlOtmZztV3vsSN4Lg5pakfaIPYbB8DyH7+vppOXPUcGcc1PklsD52RMKgMZAHA4xTPinKO+DMzlr8x0fDKfSbFBWw6KR6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iHl07Q97; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iHl07Q97"
Message-ID: <453f43c3-e27f-4688-88db-19cc7f668f94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784718401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB10h+Ovn7oiWBzr/kMs2J8IwKcmXDWyxgkrS6xQ2Yw=;
	b=iHl07Q97SOJuy+5ZsUYgyx/98Ru4BthOxSI0C9KlwLsLRQkFKY1UmFd/V1PpcCtG0Ta8ka
	yKzHJYM4Z0StTJLQpgy/1TFplz2KW1WJDrQ/HaQjpNSwtoVjsXWAADucEqd2/Gvr16Wd5f
	WhBkYH8ZwikBaOmB6+IirWUzHiZaWCU=
Date: Wed, 22 Jul 2026 12:06:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS
 (SMC) maintainer entries
To: Wenjia Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260722085705.56755-1-wenjia@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260722085705.56755-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/07/2026 09:57, Wenjia Zhang wrote:
> Due to a change in responsibilities, I can no longer serve as an SMC
> maintainer and need to be removed from the MAINTAINERS list.
> 
> To reflect these organizational changes, promote Mahanta Jambigi
> <mjambigi@linux.ibm.com> from reviewer to maintainer.
> 
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>   Kernels.code-workspace | 1 +
>   MAINTAINERS            | 3 +--
>   file                   | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   create mode 100644 Kernels.code-workspace
>   create mode 100644 file
> 
> diff --git a/Kernels.code-workspace b/Kernels.code-workspace
> new file mode 100644
> index 000000000000..9e26dfeeb6e6
> --- /dev/null
> +++ b/Kernels.code-workspace
> @@ -0,0 +1 @@
> +{}

this is not needed part...


> \ No newline at end of file
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ab8736850ea..f60ccc62e710 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>   M:	D. Wythe <alibuda@linux.alibaba.com>
>   M:	Dust Li <dust.li@linux.alibaba.com>
>   M:	Sidraya Jayagond <sidraya@linux.ibm.com>
> -M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
>   R:	Tony Lu <tonylu@linux.alibaba.com>
>   R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-rdma@vger.kernel.org
> diff --git a/file b/file
> new file mode 100644
> index 000000000000..e69de29bb2d1

