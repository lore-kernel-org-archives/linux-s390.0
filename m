Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF962222A9;
	Fri, 21 Aug 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342626; cv=none; b=E0bbJVOus2nPiPrKD6m3ycePsvoYYz9uvSWDtqg0Hv9BoJSkOOCzjdlG23SMUx/OFUYzEuKpj+cuLgJ97Ir4CKqw0tLhL9tikYW0qUHpimbhPvZUOLh7nB1GSVM3T8gPO9udDb6LCquqsI4MvDVnDAWwbGN1cGOOiqabd9yW5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342626; c=relaxed/simple;
	bh=R9q7ruuhryKinMa5FLg1lRTqoUTmSzGU76W+eWgqqKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9oeZtW/0NwrZfakniAcV/OuAhswHdrr1DNOUT4tOPXwjUOmIkTI5TQChtKoaZvv2yfUcV+4pUYXFfR1tPGuhaqgeAriBqYgBTzma6N7kANgHL2w+Kk7nDLG26iksFu0rF50Nume8N4NMXrfXwTgA/DVr49yfF7AgrFKYQFG6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MibtfTcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MibtfTcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5AA1F000E9;
	Fri, 21 Aug 2026 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342624;
	bh=HdfvtvYPMrFT5OC9MSMaQdtdWBU+zkNaBqAFzWpxBHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MibtfTcMicJIMiOi8G0UcHOiiij2jWU7UXqfomnnYgOn63/sGqZQH6F6yG6OY7JM2
	 hNq2TZu34NIbUWmlFZFT/arUK6p3+lpNSrPouIprIH5ZU1h5jEIJYEtYXCKzyjqMhy
	 1USi84hBtnXivcNCE162PEOQ9qZ6FeIRqtDIj6hKnnbSo99Fq7d+kLbtnHc8b5lJFb
	 uOgN5GIrcIVH4AWT22GEHeHZLEK4sVHvQIywqsSDpGzS/J8mo4S6a9rql1KIKuFe55
	 3KJ+cy3jMhVntvFr7jL3dC4T3sPh5A96Al5vlzby8TFuRLv7PeUhjUDJrnJ/+C2sV0
	 euLO2ccDuxsIA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/24] unwind_user: Enable archs that define CFA
 = SP_callsite + offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-7-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:03:44 +0000
Message-Id: <20260821200344.7E5AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Most architectures define their CFA as the value of the stack pointer
> (SP) at the call site in the previous frame, as suggested by the DWARF
> standard.  Therefore the SP at call site can be unwound using an
> implicitly assumed value offset from CFA rule with an offset of zero:
>=20
>   .cfi_val_offset <SP>, 0
>=20
> As a result the SP at call site computes as follows:
>=20
>   SP =3D CFA
>=20
> Enable unwinding of user space for architectures, such as s390, which
> define their CFA as the value of the SP at the call site in the previous
> frame with an offset.  Do so by enabling architectures to override the
> default SP value offset from CFA of zero with an architecture-specific
> one:
>=20
>   .cfi_val_offset <SP>, offset
>=20
> So that the SP at call site computes as follows:
>=20
>   SP =3D CFA + offset
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D6

