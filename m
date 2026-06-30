Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100C3672AA;
	Tue, 30 Jun 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813138; cv=none; b=csGUiSArJcxrCQJN11Bm1LqMwVgl8cEaQAzIaoRaRuN70Io3grnObiN9bkXuKZci17vNvaCP4MAymw3IcE36rd1zL1ntfSYZUZ4hkfphpZ96kW9HezbscZC+S6bOSaKoUfFPDqQvUmGSAJMS2q5n1i6jjf6E2cbuc3JFhvbl24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813138; c=relaxed/simple;
	bh=4AEHIzMCZcxg9t2riWJFpxeAE60rFmYEGL7IPhTAY0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qASMOzn9LXBfA5ykOvCLfKoFqD8UPoWgG3IHIpBmsIyeBAfKGE3JC2MPgYsv+6xScMh81byUviK6hvEc4qr/f9IaeM9odBFirIi5n3cD56FlHsfl59zSLDwjqTOfV+VXJS0liPX/4kpC0JJspEPv3lvL5aGH4cJi1k2mcyAJnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c22Ret5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c22Ret5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E744F1F000E9;
	Tue, 30 Jun 2026 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813137;
	bh=Ds+AcKUF7VZq89zOEGnfguG1ZgDODLx9JwjZigq61NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c22Ret5l+1JJ2rQ5/8d1QziL6XYH8ZdKshOFi6JiMrSDDmfVWXtJzyEqXl4e6JfPR
	 TTcnQww4mjuYpyr9i7ROBG9IPchf+qjegvsTN8LGxg0WSETKhEionj4P/KDQS7eE27
	 WcMsMgQoLAcU/8OBwUVndqTRTGH9+6yOm01h99QMntZPNXT0n9RtzMyv0ZBK5PB3Jc
	 kQdqw1TfTB8EUqrHbBZXuzRvEwUIdUVarufyuSeGZlv1po7yq0SHfmYb9Cfjle1h4Y
	 MZU0XpMtooz04hz5rM2Nm72HEcFZo4lLaQp9x64BvTfoQbc1BtLSus6Rr3u+7eb1Rl
	 kQghHWf3Z1oGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: fix out-of-bounds read when
 sk_user_data holds a sk_psock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
References: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:52:16 +0000
Message-Id: <20260630095216.E744F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional overwrite of sk_user_data during SMC fallback ca=
uses sk_psock memory leak and critical type confusion (control flow hijack).
--

commit c092e3d84654761aba7753030c182ca2840fc519
Author: Sechang Lim <rhkrqnwk98@gmail.com>

net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock

A passive-open child inherits the listener's smc_clcsock_data_ready callbac=
k.
This commit reserves the child's sk_user_data with a NULL pointer tagged
SK_USER_DATA_NOCOPY to prevent sockmap from claiming the slot, and releases
it at accept.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20f..78f162344fe3a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c

[ ... ]

> @@ -1786,6 +1791,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc=
, struct smc_sock **new_smc)
>  		if (lsmc->clcsk_error_report)
>  			new_clcsock->sk->sk_error_report =3D lsmc->clcsk_error_report;
>  	}
> +	/* release the slot reserved in smc_tcp_syn_recv_sock() */
> +	rcu_assign_sk_user_data(new_clcsock->sk, NULL);

[Severity: Critical]
This is a pre-existing issue, but does clearing this reservation to NULL
explicitly re-open the window for a BPF sockmap program to attach to the
socket during the subsequent SMC handshake?

If a BPF SOCK_OPS program attaches the established TCP socket to a sockmap,
sk_psock_init() can set sk_user_data to a new sk_psock and hijack the socket
callbacks. Should the SMC handshake fail and fall back to TCP, the fallback
path appears to blindly overwrite sk_user_data:

net/smc/af_smc.c:smc_fback_replace_callbacks() {
        ...
        write_lock_bh(&clcsk->sk_callback_lock);
        __rcu_assign_sk_user_data_with_flags(clcsk, smc, SK_USER_DATA_NOCOP=
Y);
        ...
}

Can this lead to a type confusion if the hijacked sockmap callbacks are left
active? When TCP data arrives, smc_fback_data_ready would forward to the
sockmap callback which dereferences sk_user_data expecting a struct sk_psoc=
k,
but receives a struct smc_sock instead.

> +	write_unlock_bh(&new_clcsock->sk->sk_callback_lock);
> =20
>  	(*new_smc)->clcsock =3D new_clcsock;
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629095140.6797=
54-1-rhkrqnwk98@gmail.com?part=3D1
