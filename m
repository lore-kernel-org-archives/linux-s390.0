Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6762E2DF2
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098761; cv=none; b=Swqw/lymHVHzwUWuk9jzxKnQQOHdLSf3lC6TtPRPo5/lQj4itoX47bLDRSJ/Y3jFW0wBs5vMMMkQCLQ7zX3k90qidt/kVRYXFCl/q/iqNox04De+6QK5PLAtR3vsS6b5edCZce6Fkd+W9sKkqfPxPVqqOx9CnnLKorc6s4GXm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098761; c=relaxed/simple;
	bh=ueV0dCW35Ji2Vz4+gzOMTmZxSMs9jupI4igg695g/7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e7C6+gzmvNnzBXGVFI7LqiyWnN/96MrAQtpZSxD4cHmR9H13pSRtp8FR4iRH/RnHe6NPKdGhGlv/mMlDf49fg2rQ/5xQHEwQ/FAYZ+8atchubgov2O/utC5Pdqwm6SLwFWUcU19cqrBn42Au581+EkCEIV8wpqs9/M/dMZj5h9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOjKazNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOjKazNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D21F000E9;
	Fri,  3 Jul 2026 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098759;
	bh=ilJAS6P336tJgldnt72tum2bTrBIl+GKzUTK2Txvyeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOjKazNTcitAKRZ5RrnLBkj3U/NYkNYUzoBtXcvM9jiteSqjwtRMeha3+aM1naTZ9
	 fCCDTvfIYzMmonAoXZPfuDHd3DaZPo0c6vIdND3c1gjQ63jhGHfHYfLMA6C5rQqBMG
	 E7CLtUhcAdTekPRpN74MpWwRkXVnSn1akdLBkMBInd4ZGqyNUOV+xzfEG288f0ZnN0
	 xH/fofAtYBoluIxxmlFG/9BxlBDV17i03nzUpDpyjlC2fN/aeookX05FKI+8JOpGL+
	 aYpNSYXanlmCQASq/z5go/KF1BsnKnXd+tKQpi2UW+LkIhSYdlJnwkC84rN65WQwXj
	 G6Og+52wc2lSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: ignore peer-supplied rmbe_idx and dmbe_idx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dust Li" <dust.li@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
References: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:12:38 +0000
Message-Id: <20260703171239.625D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Hardcoding `peer_rmbe_idx` and `tx_off` violates the SMC protocol =
and breaks interoperability by ignoring the peer-supplied buffer index.

Pre-existing issues:
- [Critical] Missing bounds check in `dibs_lo_move_data` allows an arbitrar=
y out-of-bounds write in the kernel.
--

commit 60af5c80d503d1904779918ca5eeba8800e8bbe9
Author: Dust Li <dust.li@linux.alibaba.com>

net/smc: ignore peer-supplied rmbe_idx and dmbe_idx

This commit modifies the smc connection setup to ignore the peer-supplied
rmbe and dmbe indices from the clc accept/confirm messages. It hardcodes
the peer_rmbe_idx to 1 for smc-r and 0 for smc-d, and unconditionally sets
tx_off to 0, assuming the peer allocates exactly one buffer.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -729,11 +729,15 @@ static void smcr_conn_save_peer_info(struct smc_soc=
k *smc,
>  {
>  	int bufsize =3D smc_uncompress_bufsize(clc->r0.rmbe_size);
> =20
> -	smc->conn.peer_rmbe_idx =3D clc->r0.rmbe_idx;
> +	/* Linux uses exactly one RMBE per RMB (always index 1); ignore the
> +	 * peer-supplied rmbe_idx to prevent a malicious peer from setting an
> +	 * out-of-bounds tx_off.
> +	 */
> +	smc->conn.peer_rmbe_idx =3D 1;
>  	smc->conn.local_tx_ctrl.token =3D ntohl(clc->r0.rmbe_alert_token);
>  	smc->conn.peer_rmbe_size =3D bufsize;
>  	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
> -	smc->conn.tx_off =3D bufsize * (smc->conn.peer_rmbe_idx - 1);
> +	smc->conn.tx_off =3D 0;

[Severity: High]
Does hardcoding the peer_rmbe_idx and tx_off violate the smc protocol and
break interoperability with standard-compliant peers?

If a remote peer multiplexes multiple connections into a single registered
memory buffer and assigns an index greater than 1, ignoring this index could
cause the Linux client to write its rdma payloads to the wrong remote offse=
t.

Could this corrupt the memory of other connections on the remote peer?

>  }
> =20
>  static void smcd_conn_save_peer_info(struct smc_sock *smc,
> @@ -741,12 +745,16 @@ static void smcd_conn_save_peer_info(struct smc_soc=
k *smc,
>  {
>  	int bufsize =3D smc_uncompress_bufsize(clc->d0.dmbe_size);
> =20
> -	smc->conn.peer_rmbe_idx =3D clc->d0.dmbe_idx;
> +	/* Linux uses exactly one DMBE per DMB (always index 0); ignore the
> +	 * peer-supplied dmbe_idx to prevent a malicious peer from deriving an
> +	 * out-of-bounds tx_off that causes an OOB write.
> +	 */
> +	smc->conn.peer_rmbe_idx =3D 0;
>  	smc->conn.peer_token =3D ntohll(clc->d0.token);
>  	/* msg header takes up space in the buffer */
>  	smc->conn.peer_rmbe_size =3D bufsize - sizeof(struct smcd_cdc_msg);
>  	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
> -	smc->conn.tx_off =3D bufsize * smc->conn.peer_rmbe_idx;
> +	smc->conn.tx_off =3D 0;

[Severity: High]
Similarly for smc-d, does discarding the peer-supplied dmbe_idx cause ism
writes to target the wrong remote offset if the remote peer uses an index
other than 0?

[Severity: Critical]
This isn't a bug introduced by this patch, but there appears to be a missing
bounds check in the smc loopback driver:

drivers/dibs/dibs_loopback.c:dibs_lo_move_data() {
    ...
    memcpy((char *)rmb_node->cpu_addr + offset, data, size);
    ...
}

If a malicious local process acting as an smc loopback peer allocates a
small dmb buffer but sends a forged clc accept message over the tcp socket
with a deceptively large dmbe_size, could this trigger an out-of-bounds
write?

The local smc client would compute a massive peer_rmbe_size and pass a large
size and offset to smcd->ops->move_data() when transmitting data. Without
verifying that the requested offset + size fits within the actually
allocated rmb_node->len, it seems this might overwrite kernel memory.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702171137.1099=
051-2-dust.li@linux.alibaba.com?part=3D1
