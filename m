Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD96377A85
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637162; cv=none; b=Ilvqerpsb1EXy+coglUsd+cksOM/wRCyx1nOedkTESItGuMESabT5S2qBZzmCz7QCsypxp3ou4xJbjELt22MJtXmH/s6J+LPmewF8jjcekZ8NFFgn+LGd5uZmItyJ5tIQBzPk4WQt16VkgnTQ6MIj12jEhBf5Hy0mfPF2fNRgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637162; c=relaxed/simple;
	bh=HmPY5JCNvLYg4CCXbmkGHV4GzmeFPbjF80yuOclm19w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=flVpdcjVxnOJurol4M3NNNTVN5dWp/le0VdtCpu3ISEJ9Kv3JMCHaLOtAIRbxvJslqbLmarvTpqMPMEFacNJ38Ya3/6GAPcs6pqTIdUv3FjyIdpeEx34EDaM6vpXKkdegQvpEVuVThBtDvgKtecTtKRtin+dPF17i/7uLpdWfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBA8XWXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBA8XWXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86911F000E9;
	Thu, 13 Aug 2026 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637161;
	bh=4tk19nDg+zTgvMVncLv0L/s6ErK8QEjsn5oVEbwkXvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBA8XWXobBYMDS2T+46yflseKeQbUmAc5BRjv4+N18jxu1zxWisJcTUVkvk/tDmhH
	 RZGbjAkSh7pwDJ7HyNZ/nfNEfSuSc91Ry18TKosimjLxq6mxC5N5uDlBiiZaXXnI8G
	 3b58Lh47RJepqjhJ5NvHJT9Uf9xpqHRuRCxzYHg9OzSdo2zVRJ2x/1fKE3ZDyLRDdP
	 7sbaJQTXUxfhDgcy2QMwaIL4OjzsWyTdW9m/2CBrNdOl3Wq8gAQnQWnUTnrhPEPnrs
	 nlbyKzYq99BNNpbzbyACPeaRhbcEspAOoEakOKcI0CWsgcRFyPoILnWMaOpM9942lg
	 HCLUtwnj0gkcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390/crypto: Fix missing scrub of temp buffers
 with AES ctr and gcm algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260813155406.50051-3-freude@linux.ibm.com>
References: <20260813155406.50051-1-freude@linux.ibm.com>
 <20260813155406.50051-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:06:00 +0000
Message-Id: <20260813160600.E86911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit scrubbing of stack buffer `buf` containing sensit=
ive cryptographic data in `ctr_paes_do_crypt()`.
--

--- Patch [2]: [PATCH v3 2/3] s390/crypto: Fix missing scrub of temp buffer=
s with AES ctr and gcm algorithm ---
commit 51e29c55dd2cdbff3549a70ef9403795fa389aa9
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorit=
hm

This commit fixes missing scrubs of temporary stack buffers in the s390
AES CTR and GCM implementations. It adds memzero_explicit() calls to ensure
sensitive cryptographic data is not left on the stack after partial block
processing or error conditions.

Cc: stable@vger.kernel.org # 6.8+

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 366ce22d36237..10561aa687c78 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>  		ret =3D skcipher_walk_done(&walk, 0);
> +		memzero_explicit(buf, sizeof(buf));

[Severity: High]
This isn't a bug introduced by this patch, but should the same fix be appli=
ed
to ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c?

It appears that the protected key implementation handles the final block for
CTR mode using an identical approach, but the stack buffer is left unscrubb=
ed:

arch/s390/crypto/paes_s390.c:ctr_paes_do_crypt() {
        ...
        /* final block may be < AES_BLOCK_SIZE, copy only nbytes */
        if (nbytes) {
                memset(buf, 0, AES_BLOCK_SIZE);
                memcpy(buf, walk->src.virt.addr, nbytes);
                while (1) {
                        if (cpacf_kmctr(...) =3D=3D AES_BLOCK_SIZE)
                                break;
                        ...
                }
                memcpy(walk->dst.virt.addr, buf, nbytes);
                crypto_inc(walk->iv, AES_BLOCK_SIZE);
                rc =3D skcipher_walk_done(walk, 0);
        }
out:
        ...
        return rc;
}

Could this lead to similar exposure of decrypted plaintext or encrypted
ciphertext on the kernel stack?

>  	}
> =20
>  	return ret;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813155406.5005=
1-1-freude@linux.ibm.com?part=3D2
