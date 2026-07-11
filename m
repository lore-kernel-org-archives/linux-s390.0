Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409D44999B
	for <linux-s390@vger.kernel.org>; Sat, 11 Jul 2026 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743105; cv=none; b=oHT/cd5AEKTdbFZ8d2kFZtXw/hjOXBoM9B1CV2bsjID41Wt0FMt8EytUdJEu0fyG6KQ7CKXK+h3UxIaYGNWTzndU0BsavhI/uQWBIZe+55R0AHZQeTmToO+GVoUsNWzP2qHQp4ALKCUiPhhX2xuhWYZNdskOpxVi7LG1nU63jdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743105; c=relaxed/simple;
	bh=ese1+4j40eJp2AwtraWN3oNSU28pNJeigM7TDFcCfdY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSwgz8GzQ2WSRDELpkZ1s6TM0FjblZ1CJdESWvPEbioB9ffnsKwKj6/TDXjJKvOb+3filo8IftEq2nY1voXyQ6Ai+25LWsuxu0m1GwLD5v2+vbC1CssGN9DfZQ6OpvldxzgR0vQkOX+2OmeChqBFdW6D4ZdzDrJB4GTXMhk08AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kJnnl+iS; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kJnnl+iS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783743089; x=1784002289;
	bh=ese1+4j40eJp2AwtraWN3oNSU28pNJeigM7TDFcCfdY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kJnnl+iSeitkffzUrASUn0vPI9hvU/kGnRheg9wK/Er+4+M+cORBMdIBiZy2SnKwJ
	 jJs4v/oz/HpPrS2tVf54bu98VNW4z2t/BulQfP2Fbq9TkzJVcME8g5fjKy5Qbs8HAt
	 amt4JZOUW0MyfIS9p/N4o5klIWE2TY9V1Spvj+wc806MejHNN6N+/fmXovFURCi939
	 fTfcHcmwWnzCY06X3m7GtDdmmhxK63ue6oxfNmPqjl/Lslmtw3SeMdN1L8X0NdaLEu
	 mDtHyiIbCNd4zbW+DvKj50OQZQBbr8/jkJ7XFmewwNUs4/MG8sRGPobHB67wJidQC6
	 thjK+D4pRz59Q==
Date: Sat, 11 Jul 2026 04:11:24 +0000
To: Alexandra Winter <wintera@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: sashiko-reviews@lists.linux.dev, Hidayath Khan <hidayath@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in afiucv_hs_rcv()
Message-ID: <20260711041119.12764-1-hexlabsecurity@proton.me>
In-Reply-To: <b524ae17-9fe5-4270-bb8d-3e411ef683e5@linux.ibm.com>
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me> <20260707032441.B1FB31F00A3A@smtp.kernel.org> <b524ae17-9fe5-4270-bb8d-3e411ef683e5@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c5f3cba50907f255572fb8e0a3c3396c31708b27
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

Agreed -- and thanks for the pointer to f558120cd709. The reference pin
closes the lookup-without-hold free in afiucv_hs_rcv(), but sashiko is
right that it doesn't touch the larger gap: the receive path changes
sk_state from softirq without honoring sock_owned_by_user(), so it still
races a process-context lock_sock(). Same class as the close-path UAF you
fixed.

I'll take a first pass. Plan is an RFC that routes the softirq state
changes through the standard sock_owned_by_user()/backlog path instead of
mutating the socket under bh_lock_sock() alone, so a held socket defers
rather than races. af_iucv is s390-only and I don't have HiperSockets
hardware -- I verify against a KASAN model of the receive path -- so I'd
rely on you or Hidayath to validate each revision on real HW before it
lands.

I'm already in this code from a separate severed-path UAF fix [1]. If
you'd rather keep the rework in-house on the s390 side, say so and I'll
send my analysis and the model instead.

[1] https://lore.kernel.org/all/20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea=
@proton.me/

Thanks,
Bryam

