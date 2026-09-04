Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3F424654;
	Fri,  4 Sep 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552122; cv=none; b=bddCZlvaMnlghxl1UZF2uJlUlddmivP8x11XcccYuhBkkWgQ0lY55mzX11tYvBAaAXaP1za4utFo0z3J18bGIEfPstfqQ1D1w0+Cu97D82OwowZGoorNkC8ZskM2b8MX1vN53uGcXtpKrTEmrHHI8wTxLnNFkh86bZ4KvcLdNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552122; c=relaxed/simple;
	bh=jOU0sre9oMl/M5oo9jNE1bA6DwheS6hYNT/z3OIHmQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQIDPVe3AtoUui9QqlOVSgI7fHuPVA3xALrtcOYXD6d/XQcO8Y23U5SzHVMzhayBIklB+iiYiTjz4S+uceB0/dOQp0p9jyWkdemspCER8ouXQbUNPrXpizpYtacoWyW9x70iuHGYwcdGgDTiO2eogGeTz6X7wQ7ylXq0cQeBjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKcE4Lkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKcE4Lkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30541F00A3F;
	Fri,  4 Sep 2026 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552121;
	bh=jOU0sre9oMl/M5oo9jNE1bA6DwheS6hYNT/z3OIHmQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKcE4LkgOxxJDhL7VkB9IEF9nNWLOnh8Dz5kPyb5TLSIu+q0LoGSETcMdiz1OAdVb
	 ywfqa9kC8OCTKgIA8gFvfpRnXUXDjCkoj1p1ShTbvuIyCNNkixccm2r/sxp04sSZ8J
	 U6FT8T43gkVEpGu2PvQMe4SmEVpFKX7wbTizkGUIn4k43OYAeyTkWQjUrCVQzLhLmR
	 c4MhLhHmGiElee09b/qSKUm2goPkth/MEET5kxEevbHSJfFcwljNqaGFFZJKmTh/3y
	 5PAQJ5VZ9WM/8JoGKT3yUM8UQ0IsFidcB0i+nRnFiePfAZtxL/KOFuc+7t7MsLSMld
	 eLBfc/l09QsDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for
 timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904195132.141068-3-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-3-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 20:02:00 +0000
Message-Id: <20260904200200.C30541F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset.
>=20
> Use the pointer directly rather than adding it to RBP. This preserves the
> private-stack address selected by the JIT through R9.
>=20
> Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D2

