Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE7378D74;
	Thu, 27 Aug 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847135; cv=none; b=lPPp8L9HbZSG1WiBBKwFR59x+gRWxIfax7+O1YOB7XgQhJ1568vtnrnk+E2S4XiV5H2D8VlEponSVE50OL7QkVqhs/i2MXoretcT547qfDBbKk6KaRjuaPBvoxN+9cfxpL3e/ZB2IZ1hy7KWaiybiD6NbTAL+4+lz81kgOYCrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847135; c=relaxed/simple;
	bh=ynYxSAXzdH47McdaNmisSgjNUxPnnXVQXnOQY8nS670=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KpFNAHhO8Y1orlL2klrrrAGsjhMYb7vDzNlmaNqTNTDiyZ9SbiVki1bZS/yiJ50QTZjYOmzqW6d/3VEVvbNZPDDIcUU6aSA64jSlvyuYcXiMy+EMGTQG/xFGUKiN0vA64cu+fPSizruSB2GqpCN+Ft3XhcYvZo7q6ERjkIXeBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMOcBnJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMOcBnJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ED21F000E9;
	Thu, 27 Aug 2026 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847133;
	bh=ynYxSAXzdH47McdaNmisSgjNUxPnnXVQXnOQY8nS670=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMOcBnJ/Ao6V05A4LvrDd1GEL55fKbYnRBDB+0FYYzzZ5c4/hfJnm7Pcnz1mAjMCi
	 uF8T5P0x6SOETnig5dSutZ5ViQ3kVPF3zUIvf7syXnNDWWLmj4cfz7bTLJzIK1pwKU
	 c5cyew/iybUbIcvied9Gxll5JS5+C3O80SFOb2OjX/XV16o2N3HjTnJISuX2OGM5kT
	 ongTmF9e1O3rA5vrA539XfylmFPos+jOO6qQHgsSkNcQrhs5oI1XgMkVWfWZ6WIyqX
	 G6x8xb9FgAIqnbULNccE64nrVKPtuXMHZhpZ3EYF3K8WWqfMDwCcCP52HM3Z67A7AM
	 wC8YMuPK2ok1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/21] KVM: s390: vsie: Add struct vsie_sca with pin
 and unpin methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-15-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-15-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:12:13 +0000
Message-Id: <20260827161213.72ED21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce the struct vsie_sca to hold the SSCA and required management
> data along with alloc and free methods to use with the struct.
> On this basis we can also add methods {,un}pin_sca() to simplify the
> pinning SCAs in g1.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D15

