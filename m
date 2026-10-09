Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D67446C01
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527579; cv=none; b=R/823DCLU2zgnKkqC8Lp7lJWnAqJlgIq9uGnAWpRI3vbLN8v2xHysH4Vj4yUnQ6nTE4njZ+VC4EATFhsLa2sgw63wtzn/CwmRLWq7ceQ4bS4ZcOnNgGHRiFI3SHmF47EwhsfK++bK+9XvkLrkbjocct+spHkyu9tahXDSr6tVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527579; c=relaxed/simple;
	bh=mgftGTQVRoPofCT2AuPz365MaTQ9UCurhG6eLo7oIMI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qEgMGzK2P39FZcpFG+D8wPjS920/w2BasoMLqyj9jMkHhz/E1FWbxFrOtQqpqtV6tqCEF4XrTn4+CsPzZahHkd7lSREZ7AQmONS8lujROXulnn/fQqSN1MF+v7FNI61EXeOFTl8vjonpEsmpWNm650f9mbCKhGPlH6uy8RS2+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQNsTZTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQNsTZTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF01F000FF;
	Fri,  9 Oct 2026 06:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527578;
	bh=spQHKyBbGwxLUiWSSIkCJB9HbWTqXjyRc4bNGFVOZRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQNsTZTuHs/7UUImwFzLfgwro352+HM380RiymcN9mPe1hyhyT5w15JkLCU5JpCrq
	 e7IvtSNjeehbMkrj8DF90uMj3g1hPFEB/TAOgyy8vYM9Vc4Km0WvPSOlqYj9UP77qd
	 2DC/YSnJVFrBvoSYo7sMtxQFIWo3NO3PtTj146fzglahi359dohEFIE+fX2uneNLdr
	 J4NgNXpgZl8IDjlKnZ+vEIRLTP2r1tC8jK673pGZnyGOV4d6lKiUzaOidToU1Ijxkr
	 aBn3/yaTT7F7/XxZnydlkS826jbxWAH1llBKL2am0WTwIXoEoZrdJFAeoqlY5LScZg
	 cGBWNUOppsQuw==
Message-ID: <sashiko-outbox-164948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-4-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:32:57 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/pci: pending directed MSIs cause spurious interrupts on reall=
ocation
--

commit 125383b5f8790de7f1cbeff916db7b71f9226ee6
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: Fix use-after-free race in zpci floating interrupt cleanup

This commit splits directed vectors from floating vectors into a separate
zpci_dibv array and adds RCU synchronization to zpci_msi_teardown_floating()
to prevent use-after-free issues. It also annotates zpci_ibv with __rcu to
ensure safe access to floating vectors during teardown.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index d5763c5feb097..c5fabad381395 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
[ ... ]
> @@ -342,13 +343,16 @@ static struct airq_struct zpci_airq =3D {
> =20
>  static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
>  {
> -	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
> +	airq_iv_free(zpci_dibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);

[Severity: High]
Does this code leave pending DMA bits on remote CPUs intact?

Only CPU 0's vector is passed to airq_iv_free() here, which clears the
physical vector bits on CPU 0 but leaves them untouched on remote CPUs.

If a hardware adapter interrupt was pending on a remote CPU in
zpci_dibv[N]->vector, the bit remains set. Furthermore, there is no
synchronization (such as synchronize_rcu() or draining) to ensure remote
CPUs have finished processing the old bit before it is freed.

When a new device allocates the same MSI bit, it will overwrite the ptr and
data fields across all CPUs without memory barriers. If a remote CPU then
processes its delayed interrupt, it will read the newly populated ptr and
data, resulting in a spurious interrupt delivered to the wrong device or a
potential kernel panic from an inconsistent domain/hwirq pair.

>  	zdev->msi_first_bit =3D -1U;
>  	zdev->msi_nr_irqs =3D 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D4
