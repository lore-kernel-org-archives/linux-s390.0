Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778843;
	b=lYo3IFqQ6uCRsb4KOl3vnRNeinRlOJmM34rn0GjqIgpTDeyfmjGJCCL7fV65C9uAI2BA
	 zqRiK5EH72iwv8Mtpn5soLvUyBk5QXGnZS/MlYItSwJoISAO7BfM2b/Oiban9dslkE5w2
	 OlzTUWQorBi/iLI7ajcwFserJM4Q++t7aP6Y+m2KSrj0eRzpW4UnP0LkdXDtzsH6MdjUm
	 rx1ftrAPr/bDBtpYnNtlENdtM83v00cLABnocJiupPDGtKmBF46/y/8e9dW0U6wujNsKx
	 JrLihn5UFL4dedvcW0WKfMZw+Mfi+JlGWsSDp1Uu4zlBjs9SdQTRDoCB5O8aRLYvPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H2u/w77W0AYVfVvnjxUQyr4kBFTg3oIuBfy0kyNqO9s=;
	b=FKOwERkVbtOTEXyLJ1KmmADp+Dd9f1tcpAiIPLAm9TK6Fr29daX20Qn+Sg22RPOY2CqB
	 CX5qpjn/cqhgrO6vXOAU6GzZR7PGrsohsJDntHffaMANUgUsAy3xiIo2vcbJgJW6+dKHd
	 HymdEC0ewVls9APyXVpEYse3/WE9tKF7L10niYwXh/9Y46TbGAr/kJSwIvsX4vDhywIYx
	 2Hp+mXogBZ7OayR+gTgrGaNiuLe2Kw4hP0dtmWOosSPMIgfDdune+d9L10iN545s+DVJI
	 b1mTbHLkC8//R0b3u6AvQVZ7x2mG2z6BXfb+BRGz5GubMyWxTpK5nQwZyz+84caWw4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5Fp41ck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4637606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5Fp41ck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EAD1F01825;
	Fri, 23 Oct 2026 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778842;
	bh=H2u/w77W0AYVfVvnjxUQyr4kBFTg3oIuBfy0kyNqO9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5Fp41ckWk+HG1CWlGlmTA5ZvmKkc3VtMy5htsUJAyThhYDMAQrwzpcvZ2S2l5IHk
	 NOvDI8WEE8tZmFJm7YPZYpsHPE13byMk6VuaQVnUbqumwOelOsQ5VLaxyya7kJBvOA
	 mZsulPZhFiL8iQR4BFI/0SUSsUirUX7Lol1RVERLO63tfguCkqPacG/hYP93EeIZkU
	 tBZ9zWNzPD2i79hmrsMwBj9hmxVR1UWXzrbs60zCc57Rchf4yBMNtjrG3VVT3b1Jny
	 6g5bG6T2kBJB0mx84+4zf7NVlk5n9E+O+iLHCSx2nO4W7jDi5/CkWFiZBA4SqqpQGQ
	 y8RrR/sqtQmmw==
Message-ID: <sashiko-outbox-183044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/15] s390/vfio-ap: Transition guest migration
 state from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-7-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:07:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
> vfio device state. The vfio device state is comprised of the guest's
> AP configuration which specifies the adapters, domains and control
> domains to which the guest will be given access.
>=20
> To begin the process of saving the vfio device state, the VFIO AP device
> driver opens a file stream that will be used to read the source guest's
> AP configuration.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the read operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D6

