Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684940;
	b=Fgue1CXuLqSgeivLZLhbEDiwTBgRs6L9vle84gXbdJMXlQYEpQbIf/itw9O2SfsV+s7u
	 E5nr9BZeyt8LcoytPUfErXi2Y1IhRkDYfQuUh7fSYBLPZbdCy064FUcE7/Yx2A0lEkPAT
	 Dfq02Swu7vZrI9yOE4VZQ511HUPjpvScn7/z3ZUI+tky7c9dfqfc0MmUSHM1PSivE6PE0
	 VOWZIfTMl9I6X3L7wQHZBASqIL0sn+RfjyfxQiubJZessYZBnI1qSJ2yOO965pvPITfY2
	 Cp6BAY9z8/vQBoUHpHaaCQnFkJ0hSoAR/aVP6UHCQg4zP2ihKmYOxsltTYskAjSsxEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4LuOyYCGj1ik7hAaPLf6dj5rsECaAyLA37VLs1KQ5EI=;
	b=WuNim0efsL4nnAvQDbHguDVEXvo9dxivQf21MqHlHs4kTF6f45d/YoZrPVl4Cb7xFq9M
	 yI4mrNCL4nbgKte93UPNC5G9+xo/w3SK/x/YcGcFO7Z6l4ug3AbBIQZ8HAq9Raf3s8uKD
	 Ef1BYmw1AIpqvTXP32f2fLuVzuJoU3IMtl5Vek6oXcDRYeZ7BnEPjtP0IyUE7t6FU6Z8Z
	 vmKlAVvPiIuAe/OnbGlBiaUuHbCnOrqbxGSQMYti3g2dDlHmyiHTFRIkSWAf95gUYQmNe
	 Mg40/nq32OOKDHqjmm5hTq3mHCnOttFaZRzEUoRqfQc2DbROxnxeW2NSHQpBk68yr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7YAVOTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677B606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7YAVOTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4951F01825;
	Thu, 22 Oct 2026 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684940;
	bh=4LuOyYCGj1ik7hAaPLf6dj5rsECaAyLA37VLs1KQ5EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7YAVOTZmytW+2/2NqEzy1xrNl8vOPCQ02BCxOCFBW1WkLlg1uXJFUiS6NT4MFePX
	 dkRi4/metp2FiSSH1uWixPH8ozu6xAHmE9N9JiwRDjz/3hkkIOkc++lWfMpMJMliIJ
	 aZzQLu/rOHWjYJPNhZzLyi4oPMY0rh+9eyH8pKwxd+fzTEELZpmWKEqggrrVfjwnSW
	 r3J/dhcxXsBPrqFMvLs60OPsJIXOfNmvx3sVQNgUHX59lO47gTnzq/E3++YjosfaFr
	 mr7OUDK5p8Y515VVRYYe65uLTJFJ+7UIOITs4dFfNgRJM+EMn1MNZWHjurRFJR+CGg
	 gGaY8kIqzD64A==
Message-ID: <sashiko-outbox-181750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/10] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-10-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:02:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
>=20
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
>=20
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D9

