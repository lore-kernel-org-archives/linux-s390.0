Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620440;
	b=yqarC8WUiF3/nd78+12dbTyldao+8PHCQOnVFgbkl5KK5986WYqm1x3tgNKl3f/yx4bO
	 4MUP6dhxc8OWNvYtlL9+gHElo3T5OpwCnjMDMTvFMGoX0M4DXcd3wGsy8fValJvj9xemJ
	 y9UXU0cKOLilQ2TjlVPJzwLylWfhbvjRFG2ruiMIMSb9yR93vEoc4nOZY2rdCLAuk0cH+
	 JSzRqw5qxDG6ya89et7TMPMgulEgKGp91FQRflAvtQ4kxUgtkxSXu3somJGsH9VdrY8wS
	 D8zlkuEGkzW57Vli9atziggm2n3qF06nqPBEGKIPGg9gTgroe1e3h/daiHshIpBGfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zcg7NDRYVyhpLWRf5J3VKzNI/tbVaMbEfFZv58qStS8=;
	b=ikrzojdwf8848AlKZj54J8emO1UVgyH5SWFbhYThKkLrXqN2A1uv7qlHD7oQoi0qOJTT
	 ovFf9JOy2xBxYF6P89uDqZLG+VAiy58tpIwLtWLqKx+Hr1f2iYjvZv+FVNHqtlCU3Jmvt
	 eK5v1EqBkolacAYiZKX9NiPG/spWtbkyOxnGFQXfVJOd992Tlx3AVLuzIkbgfolXJyG9g
	 dAflmhnunuw1QJeGOSq+dhdsuid6dMlYdhSw14633cuExXmPl8kweAfDjFmS8fISpa/xa
	 +8L52t8Z2kue0KLhAwtYPscRZ6QmiYcNvvqi29t8ogeOU/cfVmvJPHxd87cZw5IrYDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxLIBiPk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D9606A31E
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxLIBiPk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB40E1F000D1;
	Wed, 25 Nov 2026 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620440;
	bh=Zcg7NDRYVyhpLWRf5J3VKzNI/tbVaMbEfFZv58qStS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxLIBiPkLQhuHPYGBwwofWKtVmbd0IHEBXi4lmsJYutAtPWL4U73Ba2AKadhlpc1k
	 RcJgQY19Gz5Nm5Szj6KcjeaSOYClCE3/+cusip86ECd87msVOOl/QUszGEQEvgHTCh
	 BUM39xdoxGcwJoAAQnXuHSUCRi03qIxYdQIXAvCO4G3ouVWb9wAyXcrJDA5wEtMrdD
	 ZS7DJRlvWDVAhsBB9Dfzx3yignSMohQn6msdxNDJ8zpdzeXLHk9R0rFMyKIRBA8lxM
	 KUgS+693wHSBY4Ife91UOxoIfvqPrUvUjwL1YMBGm2GD/Dwochym0RjnReyBqo/5OC
	 NuowVqrs1E6lg==
Message-ID: <sashiko-outbox-233651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] KVM: s390: vsie: fix instruction retry for nested
 guests in ESA mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yvan Janssens" <yvanj@cyber.gent>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261125151607.3039477-1-yvanj@cyber.gent>
References: <20261125151607.3039477-1-yvanj@cyber.gent>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:27:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125151607.3039=
477-1-yvanj@cyber.gent
