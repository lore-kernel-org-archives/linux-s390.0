Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F481AA8
	for <linux-s390@vger.kernel.org>; Sat, 29 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986519; cv=none; b=sZxq4Hls6w0l55badn8TLdZBoEK/ptxVV16B6Ks8NqY4qeipkrhsKU11YoZmRHndXCnlEV935KGQzd5Wdrv1+xgMGRkpfxbDdkU0UKWD8DX3sbKiywFIpcK0Iii5NLWcMwYHPo1gAATa2FLUmWFbPLrri3auFXw1WVxnlMIzDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986519; c=relaxed/simple;
	bh=fHJPtkIrHBDYlwV30l7AbiP8EngvWt/3dz5UAjSokG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZnX4E/L9karosqu9h/07KjSrODu2iZq48/ZANQIaUrTv3tjo3kU8//VwXC387wGDubqXInfQU8n2qkj2Rl9phbn3HEWf7kFA8EcG1iraIOCaUV/30yMRsM/3H3vwg9onBV2iq2sfavnqf7uMNjqbU31WmCZsnCKfJbjr8VxJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP4m8VTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP4m8VTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962971F000E9;
	Sat, 29 Aug 2026 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787986518;
	bh=kW4NruhbmMl2rW9dGbtOteKQXAmYeq1eXAuFf5ViIuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YP4m8VTtNVC/1HK7HoBPS3iSQ48wHms1IkICPf5fC12w6H66vA7eHtHfjYjazjyD3
	 77YEeT0prtPNsESkpQ0Iga8ABPWjvFBsA5rXNqgCEfKYCcC6YD7GytCwEP5f9wLUq+
	 37pz+5VbypxCfzCaOFIwiKiOQP9dQOIzQaVcYMdEKyfF83OwwPjqqU/D6F1SCKH+ct
	 ZJhhdkuq7YH/bRUplhsvVq8m3MJRvqa1RjCRILohGiAGwZpEPo80QSmhHRxUTtqj7i
	 LrapVG3wPl6r7Iu3ifz5dw4W+qfMQQghq7PORHqmIgfKBXcBZf0Q2SdK/lzhR44BZY
	 LVxBMr4CCLuCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net/smc: fix races in smc_diag dump path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahanta Jambigi" <mjambigi@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828065439.3582783-3-mjambigi@linux.ibm.com>
References: <20260828065439.3582783-1-mjambigi@linux.ibm.com>
 <20260828065439.3582783-3-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 06:55:17 +0000
Message-Id: <20260829065517.962971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Missing protection against concurrent connection t=
eardown for SMC_DIAG_CONNINFO, leading to Use-After-Free on conn->sndbuf_de=
sc and conn->rmb_desc.
--

commit 7eff481cca86fa2c9b695508a4e20ae6a02805ad
Author: Mahanta Jambigi <mjambigi@linux.ibm.com>

net/smc: fix races in smc_diag dump path

This commit addresses concurrent teardown races in the SMC diag dump path
by adding mutex protection to clcsock reads and spinlock protection to
the LGRINFO and DMBINFO block accesses.

> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index bf0beaa23bdb6..06db3d769929a 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
[ ... ]
> @@ -143,45 +162,57 @@ static int __smc_diag_dump(struct sock *sk, struct =
sk_buff *skb,
>  			goto errout;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does this incomplete fix leave a
use-after-free regression open in the SMC_DIAG_CONNINFO block just above?

The patch successfully adds lgr_lnk_lock protection to the LGRINFO and
DMBINFO blocks below to prevent concurrent teardown races, but completely
omits this protection for the CONNINFO block.

In __smc_diag_dump(), the CONNINFO block locklessly checks
smc->conn.alert_token_local:

	if ((req->diag_ext & (1 << (SMC_DIAG_CONNINFO - 1))) &&
	    smc->conn.alert_token_local) {
		struct smc_connection *conn =3D &smc->conn;
		struct smc_diag_conninfo cinfo =3D {
			.token =3D conn->alert_token_local,
			.sndbuf_size =3D conn->sndbuf_desc ?
				conn->sndbuf_desc->len : 0,

If smc_conn_free() executes concurrently on another CPU immediately after
the token check, it will free conn->sndbuf_desc and conn->rmb_desc via
smcd_buf_detach().

The dump thread then locklessly dereferences these pointers when
accessing ->len, leading to a use-after-free that can be triggered by
an unprivileged user running a socket dump during a network abort.

Should the CONNINFO block also be wrapped in the same lgr_lnk_lock
protection that was applied to the other diagnostic blocks?

> -	if (smc_conn_lgr_valid(&smc->conn) && !smc->conn.lgr->is_smcd &&
> -	    (req->diag_ext & (1 << (SMC_DIAG_LGRINFO - 1))) &&
> -	    !list_empty(&smc->conn.lgr->list)) {
> -		struct smc_link *link =3D smc->conn.lnk;
> -
> -		struct smc_diag_lgrinfo linfo =3D {
> -			.role =3D smc->conn.lgr->role,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828065439.3582=
783-1-mjambigi@linux.ibm.com?part=3D2
