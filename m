Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FF3CC323
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851322; cv=none; b=fMQ/Vgx1QVJUlg757KwmL8uKCciDPnDS+pqvPkU4WtLutgPtT+gyrkXFGKRG2xhpxgEWjtPDYTBGp7ZEXwfNT1YJhI1KyN7WSAWzV4N/jgsA652qNPz6DWC4b1xv9U+CtOR+NQnCktSu/kqJa0yqaTA3OuQkX2AZGm+egVm2+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851322; c=relaxed/simple;
	bh=JUV39W18YmirmVDRJpk2rzQG1V+w2BtmWTh4A5K71Dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABwMMFlqF1UsjgwKmaGAs0QRsasSDhmCjZMPginihn50sO/l9F2HxHvnurUnHV81grIU+RknQKeRTfcNhGJLz2Zcia/Qv6rH+6LyBEibkxfsIo1WM+i7CqXAnsJvgBwVN+wlLoYdPUqWSBUbF91naoHyy2L+ve3oXdlWf0RXLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRcZ+aKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRcZ+aKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8CD1F00898;
	Thu,  1 Oct 2026 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851315;
	bh=JUV39W18YmirmVDRJpk2rzQG1V+w2BtmWTh4A5K71Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRcZ+aKwJp1cJX/qoXxLl0xm/l6ELIIWX6o46pd79P3fUi76KRQ7IfvSOm9SFGY02
	 kw95IQ1FsB8oPjWqty4ih8aoBuGvZchVjHpqOwsZD3tYvAFFdxQOlvWNIr5kbKKUD6
	 MslW08X3DzT9CJbR6JEkNHKMaO1pBwajMXkmohXH6zdV7KKxaOhbW+p87Bj79M1wvD
	 D3i4k6gNYD0hZAU4vSWw/6HSNzBRaZlnFjBqiViJ2VTxjvb49As84McEzBs2ppp3I0
	 K8yJeoWwViyWOkbPlEpUF9CWPYVOdQ5bbu07/4uckrxRHUicmOsa+rpGJqLxsziwtg
	 ewRRxjj0hj5fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/32] s390/extable: Rework exception handling logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-10-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-10-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:41:54 +0000
Message-Id: <20261001104155.1E8CD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add EX_TABLE_INSN macros which will replace the existing EX_TABLE
> macros. The macros come with new semantics for the whole exception
> handling: with the new exception handling the exception table entries
> always point to the instruction which may cause an exception. This is
> regardless of exception type, and whether an exception is nullifying,
> suppressing, completing, or terminating.
>=20
> This improves the current situation where exception table entries are
> required which point to the instruction (nullifying) and/or behind the
> instruction (suppressing, completing, or terminating), since depending
> on usage an instruction can generate different exceptions.
>=20
> The new EX_TABLE_INSN macros are aliases to the existing EX_TABLE
> macros. The exception handling logic is changed to first perform a lookup
> in the exception tables with get_trap_ip() / boot_get_trap_ip(). If that
> finds nothing, it falls back to looking up with instruction_pointer().
>=20
> This is a temporary solution until all EX_TABLE usages have been
> converted to EX_TABLE_INSN. When that work is complete EX_TABLE will
> be removed, exception tables will only be searched by using the return
> value of get_trap_ip() / boot_get_trap_ip().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D9

