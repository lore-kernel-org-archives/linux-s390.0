Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263312;
	b=PqLQWiAheLvTzZykRbZriMnOTgNyuh5/sqhBEcmAPiTxvUcE8WDLMTQ4C96f/M4Yydgh
	 /96HMcPXWRehCMiVRGVGbGVMS0NztiWoTFaM8V+oOy3VuldThZFy8IFqs6bgdhRErbiwF
	 i/rwxmOTKN9z6BMLEJ6GruSfXCF52QKEroAU5Ku92qq6KpuzNm6g8XyK9Nm06bBOLFIgE
	 cQwxGoWHcpKmhaQm6f5zQyTUl32LADw/FwrV+mA595+QWg9wvofro7tWhjYMdWhKg/v/p
	 jJavlnBd/22i42VVyZLxTfFHXDJV28QROj8WSnT1myAjsYIyw3fOPR8/91Fl39vNK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5RwfBUm5zcsDVtkSuz8oVENZstDEiy38uEK0TQGNXSY=;
	b=LO/Y9k7WRgXnv1xOJ2NIDcRhv4m3OUVE7t9YAAhpZMN12DYPTGyjTw4kkLLfGxpXB0vf
	 kR8H7yZ5osaqFbxZ5+cPWQbRhI3mSqZ1HA24tHhCId7xzT2n+I5q/YgrGtnFXoUD4zMcj
	 K4zJ2NoGNzrM1kcJIfYcHjJP9U28y15iqgEe1HQ6uvyJ6lFrjhOthPv1PUEIHAtz+bNbe
	 hrOTU0T3f/I17PVBeTUmmLRXLQgaCWmy4v5G2OlWGlIwhHiRQcgRpWfm5lnLHwGWwJiZk
	 s8NHDYRY83l47F0MwjNe6sCRPJjE29et9zOo1/fNmvLhm8loR5ZBAASQlRvh1vB1vaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P6q2wZ/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1F606A339;
	Mon,  9 Nov 2026 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6q2wZ/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37B21F0089F;
	Mon,  9 Nov 2026 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263312;
	bh=5RwfBUm5zcsDVtkSuz8oVENZstDEiy38uEK0TQGNXSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6q2wZ/i/++RXlkujSqc242bKB9lmSe/Jh0rcobuWCtHHBibJRcermHuJr94mSibO
	 +uOhadSVgHw7MEcYe2LHiX+LgHBspt1ec3+KRLAdMALiLw7iHXxgmS2s02UdGHpb5H
	 GRdRTZ2gGsWBlnay0pcYh+a/fn9ZTbGl++2LFzOHXiJ1HYU0oALA60rnLOyuYFv5hk
	 8qfChQaLr2GReWwbglUQFa7TflH/9glQEPcAtEblZqkFaFHoxtAUuK+k6zxHx3ZQGO
	 Ehl0SZ/CcGkyvOJN00H/+ypenD3rjY1qvFrCCNJRdhn1g5hary5xsIrsngC8X4FbNo
	 nqMijTh6OhSMA==
Message-ID: <sashiko-outbox-205735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] rxrpc: Move key types to their own module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-10-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin the kernel module implementing their key type, hosting rxrpc
> and rxrpc_s keys inside the same module prevents unloading the transport
> module while keys remain in keyrings or cached connections.
>=20
> Split the key types and their preparse logic into a separate rxrpc_keys.ko
> module that rxrpc.ko depends on, and flush key GC on rxrpc exit.
>=20
> By doing this, rxrpc.ko can be removed while the persistent keys pin only
> rxrpc_keys.ko.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D9

