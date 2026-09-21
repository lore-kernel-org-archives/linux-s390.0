Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8833446B0;
	Mon, 21 Sep 2026 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962508; cv=none; b=IRuUNWazLwHWcuGq/uM+uL3cqBZQBONF6tOw8wJthyQlfREtbZpDlyPwYSGo/eE2ZeIJ/OC35M7NUAgiQSJJnh+Vu9pGC2QckzXRXmIHRW3JlHDB2Bn9LXEon/iYluR1yfOO3qZwllfiYb0wH89ggnNFJRWflj5KGLSsmenWBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962508; c=relaxed/simple;
	bh=mopJf9/SDQRW9KRJUeuUQUsp7SnqhZu4QlKh/AJ6RCk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uY9QQu53WFAKprnd1XtVyunjNg9yKKb/NFIuuXczKvyPbW2XKB/+14/GKeb+wrlVpTqBizDFPNfj/i0x8xPDvOypW58zDe3sBOwmMAkTpEI/tEaVavnXzmWL4xU2zH7822yqYmECOEx/KagbO9Zd57hwzD31KJDpTIGrHJRR+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmL37mUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmL37mUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DD81F000FF;
	Mon, 21 Sep 2026 03:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962506;
	bh=V8OBPLd5thLYEUtF4FPQVb9RyDbgr7s5b+VJV9r/eNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YmL37mUDElrdd27lhIZcRn3URfqANLh4vAEwnYPoZEQYkeZJFHyercqGKH9GZ1+pC
	 T/XTrzxmVm3Dy/ziUDCFZZrid4P1DAbEeanQcKvHENsmCtHU6pMjzLCm4UHLOy1MFx
	 sOUI2seWJIXiuSrj3e8MvfBcwVhJQcnz+3Q5FgZuud1Fi/fC8iQsGAM9RUmzNXf/br
	 vZinAhmLVsDs9YQVzgf0rUdl4gtIfegbV7R8dwOYOvupl16Eqh37mWKKS4aFP/kUyS
	 CoDNDw3gRvexDR1gqPJWQSi4a4p/s4E1FgsOTX/hU4thcjRlbbD5l0iy6kGfEe7mJw
	 9e4LyNWmU4klQ==
Subject: Re: [PATCH net v3] net/iucv: require IUCV for AF_IUCV sockets
From: netdev-bot+sashiko@kernel.org
To: hppiscas@163.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com
Date: Mon, 21 Sep 2026 03:48:25 +0000
Message-ID: <178996250579.2160803.3689804935882322466@kernel.org>
In-Reply-To: <20260920034503.17322-1-hppiscas@163.com>
References: <20260920034503.17322-1-hppiscas@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net/iucv/Kconfig: replacing `depends on S390` with `depends on
  IUCV` for AFIUCV reverts, without disclosure, the design intent of the…

--

net/iucv: require IUCV for AF_IUCV sockets

This changes the AFIUCV Kconfig symbol from "depends on S390" to
"depends on IUCV" so that AFIUCV can no longer be enabled when the IUCV
core is disabled. It replaces the v2 approach of always descending into
net/iucv from net/Makefile.

Previous posting referenced in the patch:
https://lore.kernel.org/all/20260815135456.53684-1-pengpeng@iscas.ac.cn/

> diff --git a/net/iucv/Kconfig b/net/iucv/Kconfig
> index 5cfddc9c6498..2686d795cc2f 100644
> --- a/net/iucv/Kconfig
> +++ b/net/iucv/Kconfig
> @@ -9,7 +9,7 @@ config IUCV
>  	  communication link between VM guests.
>  
>  config AFIUCV
> -	depends on S390
> +	depends on IUCV

[Severity: Medium]
Is the stated rationale accurate here?  The commit message says:

  "Independently entering the directory is not sufficient: AF_IUCV also
   relies on the IUCV implementation."

Looking at afiucv_init() in net/iucv/af_iucv.c, the only reference to
the IUCV core is compile-time guarded:

	if (machine_is_vm() && IS_ENABLED(CONFIG_IUCV)) {
		...
		pr_iucv = &iucv_if;
	} else {
		memset(&iucv_userid, 0, sizeof(iucv_userid));
		pr_iucv = NULL;
	}

and iucv_sock_alloc() treats a NULL provider as a supported mode:

	if (pr_iucv)
		iucv->transport = AF_IUCV_TRANS_IUCV;
	else
		iucv->transport = AF_IUCV_TRANS_HIPER;

The other iucv_* users in af_iucv.c are iucv_path_alloc() and
iucv_path_free(), which are static inline wrappers around kzalloc_obj()
and kfree() in include/net/iucv/iucv.h.  Does af_iucv.o then have any
link-time dependency on the IUCV core at all with CONFIG_IUCV=n?

The reason af_iucv.o is not built in that configuration appears to be
only the traversal rule in net/Makefile:

	obj-$(CONFIG_IUCV)		+= iucv/

Also, c69748d1c9b5, named in the Fixes: tag, deliberately changed
"depends on IUCV" to "depends on S390" together with
"def_tristate m if QETH_L3 || IUCV" so that AF_IUCV could be enabled for
the HiperSockets transport alone.  Since this patch makes the AFIUCV
symbol invisible for every CONFIG_IUCV=n configuration, is the word
"Restore" describing the right direction, and could the commit message
say explicitly that the HiperSockets-only configuration is being dropped
rather than fixed?

One further consequence worth spelling out: iucv_init() in
net/iucv/iucv.c bails out early on non-z/VM systems:

	if (!machine_is_vm()) {
		rc = -EPROTONOSUPPORT;
		goto out;
	}

so on an LPAR, does a modular IUCV still work as the provider that
AFIUCV=m now depends on, or does this effectively force CONFIG_IUCV=y
for HiperSockets AF_IUCV users?

>  	def_tristate m if QETH_L3 || IUCV
>  	prompt "AF_IUCV Socket support (S390 - z/VM and HiperSockets transport)"
>  	help

[Severity: Low]
With "depends on IUCV" in place, IUCV is always y or m whenever AFIUCV
is visible, so the QETH_L3 term of

	def_tristate m if QETH_L3 || IUCV

can never decide the default any more.  Should the default clause be
reduced to just "def_tristate m"?

Similarly, the prompt and the help text below still present z/VM and
HiperSockets as separable transports:

	  Select this option if you want to use AF_IUCV socket applications
	  based on z/VM inter-user communication vehicle or based on
	  HiperSockets.

Do these need updating too, now that the HiperSockets-only case can no
longer be configured?  The IS_ENABLED(CONFIG_IUCV) test in
afiucv_init() also becomes permanently true after this change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920034503.17322-1-hppiscas%40163.com
