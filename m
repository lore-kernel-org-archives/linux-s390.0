Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A223793C1
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939911; cv=none; b=Vu1piXG0RPmkkWNZHW39g/u52eBQz/rYHR0x5i42G0qLc9WVwkzeAGdk/1jbK5f4vo+KCuwrMnltnzAexnbSjePf/u6pvZQV5gij7pQCCXUZ7oKRa6r0k8e2mlx9uRa8DG5i11YD1/VQHlqME6/y9LwG0NMne6gpBUi9AYYX57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939911; c=relaxed/simple;
	bh=cdv4G1v1iPQh+uog2MJQGouCWPMjvkyzyRfo7p9D3Lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR7zEMaO2Ut4VKE4chkwT+yp5mrzf/x7ApxwufgAuvAruZ7Oe6/AXQ5ZrR34ZT8jiMSYPT8uZsd1nNKK5klBL+kk6gMD25sJdVWbYk7K/8/wFpLpxcDeOHpsCdt+bCJJpjFsEhDpWVHpDEXezl1qusp3+8H4OyQvETf7N5I8c/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XebOZkYV; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XebOZkYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787939904; x=1788199104;
	bh=cdv4G1v1iPQh+uog2MJQGouCWPMjvkyzyRfo7p9D3Lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XebOZkYVtRikZ+tyW+mcs98Ef1BeA/utB0qQXkGAz3JPDTffYcXKVPQekkzIQ7bHb
	 UckrRssIvlkYrft3thPNnopBydkaf8oQeCRZOW2MPP3Luh1rQAe3HXniPNLNwoRgWG
	 YVzZqqUtPKaD9xyzMRlBwiR7B0El41RrJ0E25AT0NvSGRPWf7z9+Gak6jS+pryIlUB
	 oSmYKqYwJebl7fur4/plGV1kBcRkBnpWuaq3V8ixgCUBLPmp0O7DpiMFU7Jgwbf6WJ
	 84N7Qf+msNOwxJ4Hqjbr0Kwi7u/epZhEUwNvNbLknsNVBeuykEJcAHfUGIuv7q8/Sf
	 kfA/MvK7D/+XQ==
Date: Fri, 28 Aug 2026 17:58:18 +0000
To: Alexandra Winter <wintera@linux.ibm.com>, David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Aswin Karuvally <aswin@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/iucv: filter frames in afiucv_hs_rcv() by ingress device
Message-ID: <20260828175803.11391-1-hexlabsecurity@proton.me>
In-Reply-To: <20260821125501.3718748-1-wintera@linux.ibm.com>
References: <20260821125501.3718748-1-wintera@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c5ea6a74dcb098c0a4b2f7c327c483d5d58ce252
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

> Bryam, would you accept a Co-developed-by, as you did the analysis
> and you proposed to add checks in afiucv_hs_rcv()?

Yes.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Late for the commit itself: 80230a18c164 went up in the 27 Aug pull request=
 and
is in mainline carrying the Co-developed-by without a matching sign-off, an=
d
submitting-patches.rst pairs the two. Nothing to do about it there. Putting=
 the
sign-off on the list is the record that the consent existed.

I'm dropping 1/2, as I said I would, and I'm not respinning the
transport-filter patch either: yours closes it, and it answers what Jakub
asked for on that thread -- the device test in the same loop. He was right
there. The changelog argued a reach the two-line check did not close.

2/2 is unaffected.

On timing: I'm in the middle of a larger project and have only a few hours =
a
week for this at the moment. I'd rather say so than go quiet on the thread.

Thanks,
Bryam

