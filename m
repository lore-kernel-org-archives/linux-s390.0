Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567175;
	b=iY77CXTy2R3fGIkOx06k1dXJZzzmNXdNS1VuSHtLiSPkV8rZ3NydgBaTxijErNOZpnwy
	 ejPJ6BTnginulmxVhHwfkeLpz/yhvF972fwDKQ5RWcSG1DGl5Movbde+XeKqMYQX1fIhi
	 UpsrZ0OyCeCHLZibyZOfFIq3lQGS/RVEbuooC7UKoTNMphPvuwF8IHBqoA8UDWK6WwdCj
	 h7P3/xGsDUmW3paemamzOS2MSTtcu/QeddmY3U8GtNUR8qSpYU/vzWB7jY7jtZDyNiQXj
	 RGqQmyUCrXCSch0hcXBmyltAnoU98X6+rU2RSDhusXsjs2bH908WnxNPkdE7mnHKqBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VArTMlv2xxR014a95XjvmKwsrpD5EzwlDOHh7aaTIcI=;
	b=XvbFpGyeBsY0nSFMddFyzoEK+DXHcz64MefegIPLzan112EcScgFQkuWDXOHAWhR9HAh
	 J6cRe4UtbvnZJ/BCR0jI0642MJrIPCOeVnuz+NioEnwSPXIOBaocRleeVD20IWj9/2Bu6
	 +u65rvfYIGNoiY+6kv34CUNZdgYdemgmvjw8WtdQ0IKR7y8AKYdx3tHLTsb/y8qr2dU3g
	 LrMBNEBOZQK2eWJswYXwX1Jfen18vLIWAdrcM539/KE1CnNQy8qKOoR8dvi2Kft9OXRHs
	 iWwL+E82d57IKxgkyglpNNLQiX5m2SmyuFeGubzCYp/ESc8+QBBnApQ8k/t/suDTX0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXt++U+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A21606A31E;
	Wed, 25 Nov 2026 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXt++U+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31B1F000CF;
	Wed, 25 Nov 2026 00:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795567174;
	bh=VArTMlv2xxR014a95XjvmKwsrpD5EzwlDOHh7aaTIcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXt++U+5pAdcPOi8nH5hWDbmZDirZJ2ybLgSqVq1MQkbPJfNOC2ZO71GdSzhb6zhb
	 M21boAUKzrUh2ljvNiesMXzNUcU7md6emKc37iHP50fkcZ6smqAiwVxMthJCR7Y1kL
	 hZ7qkPxEzbLIwTAHFE5Mxle/cYNPl5O4N+a8mLOhUd6VJqWNNi/3E3099hih6bqJcM
	 AkLAn/MU8EqrIzMRcblJtubG52ShZDVC6C8jd5oSTaO2lZ5uDyG5tHtI80ZYgOqr7B
	 5dV/1q/YxLPZQ/Tl6UbWHGhCKcSHpIvB5nVnNLMXXoQhplYQD4PVAkM8piUF7UgKAu
	 U9nHUilesKC2g==
Message-ID: <sashiko-outbox-232298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 RESEND 1/1] PCI: hotplug: Add 'uevent' sysfs
 attribute to trigger slot events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramesh Errabolu" <ramesh@linux.ibm.com>, linux-pci@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <12826c88951e0a19cbe56daad681bbe750ac01e9.1795565279.git.ramesh@linux.ibm.com>
References: <cover.1795565279.git.ramesh@linux.ibm.com>
 <12826c88951e0a19cbe56daad681bbe750ac01e9.1795565279.git.ramesh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 00:39:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
>=20
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
>=20
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
>=20
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795565279.gi=
t.ramesh@linux.ibm.com?part=3D1
