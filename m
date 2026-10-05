Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303E4766A7
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202110; cv=none; b=gdIoMCP7uwfVF76+RlTjo+/YXfcPKN7+AWXpCW16lA6d+4k4pn+H1HHkv2Va10XYuYq0Qa6eQrercLkh7stEWUVqcMEX4ODe30rVD+CiHSRXTYjJ30MhsDGG4WNZG9EknBbxWJm3MCOOpLlhIhAIRHZ3ZltqQaOZXBxQ0D63bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202110; c=relaxed/simple;
	bh=fcb00VtBHfUSTOVt0ffFHbUnFaCxRH+GYZ6YeGTckn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxBcZKi9wycx2iyfUDmJRHmbxaDJmn/phsJ/edAiJy01tklANSpprTFigxpOruefUZkb0iEvCkqastOUMzWQ/PzVS1D5ZlrpbPaZsR+zNQ5MeY7olVWTcIK+g9OCzRdbDYpXbBBET+egOo+z5BGFWn15QupMdasf6/iGG77nw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL7ALJ2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL7ALJ2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA8D1F000FF;
	Mon,  5 Oct 2026 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202108;
	bh=fcb00VtBHfUSTOVt0ffFHbUnFaCxRH+GYZ6YeGTckn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZL7ALJ2DqWze16wmNwnKy9rHiB6TIBy2MepWHEAVCUBNd+VHv9DQV17i9J3I8dvv2
	 wLvPseKqbUNQnBllm9fVL45tQaaJK5c9LdtKDxDZU3JFqbKnmXo2HLD3N2fodEkbSh
	 f4nLtExUIff/fhlcVhye06bQJmeSTROgVmQvFuBo4fbMzbKz70WF61JRO2twUiOSBD
	 IDzZqIwid+QbGqj5b7NIxADa5jVOGTV9nHOWA4QFmoT8hN9SucWKr8O5OBnHNv0DHZ
	 mMqxPyPuMuHQUC6+vNbczka2/Qwmd7YJRQUnSGIhiBF96WxHyITNVWlsTVe3sDAM84
	 5UTE2K7wQedyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] s390/pci: Drop the unused index argument of
 zpci_msi_clear_airq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-7-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-7-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:08:28 +0000
Message-Id: <20261005120828.7EA8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zpci_msi_domain_free() passes its loop index to zpci_msi_clear_airq(),
> which adds it to an offset that already accounts for it.
> zpci_msi_domain_alloc() stores hwirq + i for each vector, so
> zpci_decode_hwirq_msi_index() hands back msi_index + i and bit is
> already zdev->msi_first_bit + msi_index + i.
>=20
> The doubled index never selected a wrong entry. An irq domain's free()
> callback is only ever invoked from irq_domain_free_irqs_hierarchy(),
> which walks the range itself and passes a count of one. So, the loop in
> zpci_msi_domain_free() runs once with an index of zero.
>=20
> Drop the parameter and the addition.
>=20
> No functional change.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D7

