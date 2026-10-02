Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0D30D3E5
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939394; cv=none; b=QMt67tCiw8X9alFdQlwSeHV9FLKsMZKapZsnCFRB4QMd+UBIISHOZp6L9XCx1kQ0JRRrYTO6tqJ627ELfLw02BTCVYRDyPFxkXCWUfKOyna11c3aP+i6ADCzW5o9k9ahyrDmtv1GppC/RjGLrLxR7wAg/NYqv+p1t90RO4WK4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939394; c=relaxed/simple;
	bh=ea/H6bIFh7f+xVDEsLxF8v/JMxcAcpibtA+1MDMbTcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9aIGZKHKUi98kWI7Hu6mpmcOV8J6qWejlQvG3pTw2SL3QjSXlkxKwZsLAArKLE9V4c0qk22xzbXLJWCVOebvXYR94yLA2M2/2H5IHR73kW1oE3RMqWF5CgB9l2PfhN+vTiOcXZUoZ8vqStQedKaFizvJh2PtgqBHLd5GT9fn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM4HjuMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM4HjuMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDBA1F000FF;
	Fri,  2 Oct 2026 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939381;
	bh=ea/H6bIFh7f+xVDEsLxF8v/JMxcAcpibtA+1MDMbTcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eM4HjuMVHc8aPI5dmG00YjOpZ2bPXfYCA/wXZgVbKXU6IgyQNgiD8wWz059CCcVMU
	 OzcldBkzcGAdbFDZwPoNRGKe0yYmwjffeSeV/EIKH67u1MULNbkikz5xocgBkD/FCm
	 Tdqgk1UaNPNxsQIkGTlGWgJUo66qlZqIqrj6BlcYfHbkQn+CXNYtWDFvWCUDi4lFiV
	 EVmfchl4xA60Dbf68vbyhlsyq64kI7HJ8xz88O1pK/q4HaFdABOMDanRSRiSP8mVcI
	 9xXy2Xb71mdKzBt3PTIItKfHA9Y3PWuHc6rMF7zPqOiBqQ2nFL1qKjgdJAB7Vh9WtE
	 DJkvb4O4TtDLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Fix and improve zcrypt reply
 message verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261002105236.52049-2-freude@linux.ibm.com>
References: <20261002105236.52049-1-freude@linux.ibm.com>
 <20261002105236.52049-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:09:40 +0000
Message-Id: <20261002110940.9BDBA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
>=20
> Add length validation before accessing reply message structures in
> zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
> zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
> potential kernel memory disclosure.
>=20
> Also rework these three functions to validate reply lengths more
> carefully before copying data back into the request buffer. Use size_t
> for length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
>=20
> Additional improve some of the later invoked evaluation functions
> which further check the payload. Add comments about length assumptions
> and for the type50 processing rework the payload processing completely
> with removing a misplaced BUG_ON().
>=20
> Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from c=
ard modules.")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002105236.5204=
9-1-freude@linux.ibm.com?part=3D1

