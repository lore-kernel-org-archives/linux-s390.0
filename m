Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4894A33;
	Sat, 20 Jun 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967843; cv=none; b=NgP2rAlG6eoAO2sXchYB/RBavmXL4UDp/pAGHwi9fW3q70ou397K1lse5//9iGZ8tIFxtBeVFu00jK1znGKQ7MilYZX106IsXsVZ37+JiZg1tWDWOksx5uRJimyke/ESBdJuy4QzASXPQoGUHGj2jAu99oCsxugYnxkedup6maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967843; c=relaxed/simple;
	bh=1Fb2V5n37y0TpUPKkRa3aIW+N2BFKNzCFpC+CnDdOOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bk7C+Z2qWDhOeGiQarWhZ8Rbi8wf7Pr0sQtkA9QYiYJIqnAV6WW/OM+ecu/d/SiAH1ZvDb3SpfJa94s13Kiqa9ltqAN/jW5quhieQxrRJhV/+an2l0SlRXxp20T72vtGhrAsRKzXZC6l6NvIwEvJ0uVjFyEaCmckpr1/C0lj+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHFqepYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHFqepYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716451F000E9;
	Sat, 20 Jun 2026 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781967841;
	bh=NMNxP7dFFt/5T3vnJmpDKH4x27qF05pdQQn6o6Hpwxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHFqepYOxHYYXszdhMU9TUywOpMqYf7ZyyEsq+DhYwxKFrXUZcXWLAZGSEQoXuUc+
	 LKsnti6F4bFh3aPDkwmHx4cpo2YxJfGtPsUH/HRJDhI3VU6uO6N1U+Mo2TAdwrSn3s
	 TbHAIO6t3Zp9jnJNn9IqvIbitXgHHPb0ynKqodNoqy+1gtUgSlXIDe70OEfecDC0oE
	 31HBf2IYEULWlyxeG7+1sYZ9X3E+ZQBbKiHrhQRxLXOXIsCtT9iI2T+Y+BLLSEQ6qQ
	 Mejhlwceian65HqHlnKeyjiHvAwMwjKdhW44AQD10xo30upypDGPK2bT0fJd2NQLHW
	 ie+W379/vSF5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix out-of-bounds read when
 sk_user_data holds a sk_psock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
References: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 15:04:01 +0000
Message-Id: <20260620150401.716451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Overwriting `sk_user_data` during SMC fallback destroys BPF `p=
sock` tags, leading to an infinite loop in `sock_map_close`.
--

commit cfd1a0bff0746ee614e26837804e04bb4e94ae6c
Author: Sechang Lim <rhkrqnwk98@gmail.com>

net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock

This commit modifies smc_clcsock_user_data() and its RCU variant to
only return the smc_sock when the sk_user_data field carries SMC's tag
alone. This prevents SMC from interpreting a sk_psock structure placed
in sk_user_data by sockmap as an smc_sock, which was leading to
out-of-bounds reads.

> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 52145df83f6e7..88dfb459b7cc4 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct =
smc_sock *smc)
> =20
>  static inline struct smc_sock *smc_clcsock_user_data(const struct sock *=
clcsk)
>  {
> -	return (struct smc_sock *)
> -	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> +	uintptr_t data =3D (uintptr_t)clcsk->sk_user_data;
> +
> +	/*
> +	 * Return the smc_sock only if the slot carries SMC's tag alone.
> +	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
> +	 * not an smc_sock and must not be dereferenced as one.
> +	 */
> +	if ((data & ~SK_USER_DATA_PTRMASK) !=3D SK_USER_DATA_NOCOPY)
> +		return NULL;
> +	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but the patch fails to address
the interaction between SMC and sockmap during fallback.

When an SMC socket falls back to TCP, smc_fback_replace_callbacks()
unconditionally overwrites the inner TCP socket's sk_user_data:

net/smc/af_smc.c:smc_fback_replace_callbacks() {
    ...
    __rcu_assign_sk_user_data_with_flags(clcsk, smc, SK_USER_DATA_NOCOPY);
    ...
}

If a BPF sock_ops program had previously attached the inner TCP socket to a
sockmap, this overwrite erases the SK_USER_DATA_PSOCK tag and leaks the
psock pointer.

Later, when the inner TCP socket is closed, its sk_prot->close function
(modified by BPF to sock_map_close) is executed. Inside sock_map_close(),
sk_psock_get(sk) returns NULL because the tag is missing, and the function
evaluates saved_close =3D READ_ONCE(sk->sk_prot)->close:

net/core/sock_map.c:sock_map_close() {
    ...
    if (unlikely(saved_close =3D=3D sock_map_close))
        goto retry;
    ...
}

Since the protocol was never restored via sk_psock_drop, saved_close
evaluates to sock_map_close.

Could this cause an infinite goto retry loop and a lockup if triggered by
userspace? Is there a way to handle the fallback case without dropping the
existing psock tag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619150342.3626=
224-1-rhkrqnwk98@gmail.com?part=3D1
