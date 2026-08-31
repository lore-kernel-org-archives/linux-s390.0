Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F74309EF4;
	Mon, 31 Aug 2026 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201528; cv=none; b=TcicwRpvusqIP8qwxk2lqhE3cSnGUBwNJb1H0yTiihQElJSR+zg4aCfL6f6zX5MHCP0VmHBJbRQWzMd6I9jewToRXYiisFlt5YdidnKWEeT4wBskUioWoQYJsIxHhKjPGHW83ZKKY4/mglzQuji4iHMfRTPtz6G0heo0X6rN5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201528; c=relaxed/simple;
	bh=rb9NzY3xCBuPba3CMICA3BFAw2hiC+d5z6lt/n8OlqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PokEGqkNBr0mYGa/KttC79Uf3uPNaeB6KeFjqIF/GExgkLSn0kMbM4oivevFQQcTVxC/pYjUleCmKRJgUXH53mSW12sZUwM0qv9r5usVWRvGKWxr1GvOmfi07hbDk/Lg00GWZwh2RXYfsenHejNrrPSb4mId5e2NBdnkKfbYq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmETlkFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmETlkFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0014D1F000E9;
	Mon, 31 Aug 2026 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201526;
	bh=rb9NzY3xCBuPba3CMICA3BFAw2hiC+d5z6lt/n8OlqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmETlkFYBAegzMOxnKzh2XRhd3gOGtdpX85knyWObp/keO/Tmi2bx7QiB3Q8Qu1Nr
	 jkxW8Pjl9HZS5Y69JCpOtOs8uaQ9S8s/OOImzJVLQ3SR/A8BsnoiF2dycRbbJOiD+L
	 NY6EqGO3FlhnzB///X4mtqJ8OaUFaHXCOe/DyFSW7vKceXDfyf8HlfIy5u7QUYHQIf
	 oua4jIkGKZyZzt39E/TJZqGRdpYbpQ45b9HdihdNJpTtv3Bdzg7joSzeykiQY50WMK
	 TT+2AWXRAXkVQI2CfJ4pnSjxeeOMStY2djZnpKR0zxP/Eir63p47B+KkAzvoBXzbg5
	 Fohz7l50fldIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/23] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831144802.834315-7-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:38:45 +0000
Message-Id: <20260831183846.0014D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> DDIO616 2026-06. No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D6

