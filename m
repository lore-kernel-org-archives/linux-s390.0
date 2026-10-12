Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FE3C07A
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815310; cv=none; b=IMvM+rCDdfJL8FIwTO0XEBzIp7cr98ZTW9HXevH6FGsPsRF7c9IydKlIb+EKp7fzrUfm0wZ5dNfxTojN1CSr2LMvIozrPlYZOtpr9EpjFfRhWwJ1e44iW1gVlff8qQ8ZXAIINM/hEnGStXbzDz7uf2DVQruXbOkf7yYqQ11X69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815310; c=relaxed/simple;
	bh=bZ0mVJaML2rrZ70tpvu3XD/6gRUGHSsBXufWyL/V9og=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n84rVzDYOW2gA2D/FrLk8Y8u8ZJjJtAYzLLckf4TLu6HStv9OTgYxT1BX/jbzqfv4moMib6LHlC9ByvpI9j4F2g1R8AxWG7JfI+xRiIhnrMcbVEseA4KWud8QWugXGglhwqPUswZTaB27u/lfPiB+9Cwu3lYd9Gxg1cSgAUDx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHuzrrBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHuzrrBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E871F0089B;
	Mon, 12 Oct 2026 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815308;
	bh=bZ0mVJaML2rrZ70tpvu3XD/6gRUGHSsBXufWyL/V9og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHuzrrBkTNvXXn0mrn/coGzkkJLqNMtec6v17hKBj5meV2ZKVTVqhBuEBNd8wBUCG
	 0zo1dN62egDbmFy2kEUffWFvtbouopt52kQKume+f8BBabfOEAwbs4GdILcwwderhd
	 yW0f51w5+iDce1sCz/FQhh0TeCpteye5kdR9cIi1IUn875skMdyfK+HGMv5drICs0E
	 GvFOjCwpC08oZnrcbRy8Ra3v8RKKPGsN11t3vir0YevIlM7QTnb+/WsCmGbMuEwRzT
	 Sd+kG5ealmfBAz6fjABw066L0rMcGVL8I6XLP+Ngbmasgn9RHDSw+HV8eGket5jwzM
	 9U0NHx0QyPE5A==
Message-ID: <sashiko-outbox-168261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] s390/pci: Use 32-bit fh outside of inline asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-2-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012-rpcit_trcfh_upstream-v2-2-1812db73dfa5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:28:28 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zpci_refresh_trans() declared the PCI function handle as a u64 type just
> because the actual RPCIT machine instruction required that in a 64bit
> register, while the function handle is architected as a 32bit type and
> defined as such in the zpci_dev struct.
>=20
> Push the extension from u32 to u64 down in the call chain to just before
> calling the RPCIT wrapper function. Since the struct of the typical
> req's matches the format expected by RPCIT, too, create one of those to
> pass along.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-rpcit_trcf=
h_upstream-v2-0-1812db73dfa5@linux.ibm.com?part=3D2

