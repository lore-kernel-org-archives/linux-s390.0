Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8C43E484;
	Wed, 12 Aug 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543073; cv=none; b=NNcpYmFlAqL5w0CFfR9MEG1iYVC8SGTu/Vvsxwe0c2cU31in771mQnPCQNfHYTZJ2rpA95TqoBMpJJJVRd4FULKLwYTHuBzQz/gzfR0k0HhwAelr2/ZJZeqLawI64hkxWDXzSktUCOwR7GWKO1itT/YZ7w/gNOeV9t8VyE5pze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543073; c=relaxed/simple;
	bh=YEbVKQ3i1Kl7WwUjoixGkYXwO1ET1e5mdgJgZSSUHCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VNFTpwzzKqygUGQjRjPhbS2mBVFczwpghF/DnePzWU7D2NIkUWackTH2C+b+TWQmoFjqheYVtT8ojYo74BQG4fl0a/cjbEIM1SSuYgQXhf4UNV/mYqZcJ1PLlfzXjdOMSKHA4iY0ovkVI5Q3dRBXK4HRjPqAQxtceymPTMTu4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez3xQz+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez3xQz+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2703D1F000E9;
	Wed, 12 Aug 2026 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543072;
	bh=YEbVKQ3i1Kl7WwUjoixGkYXwO1ET1e5mdgJgZSSUHCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ez3xQz+Yob/mvJ6VdeOBjtwhp3pqjK2xvhpEIOo6bzMDuvBvTQoGorcC6vjQBUtUn
	 iUrBfn/a55hiuIzRJx7ngilD6ZARAoiwnAX7bw5nn4Vf48fCJ4PPdl6zu/JUAIT3f8
	 2UNceDDE8pj7MScqHLBFkw23Ye5r67IEpR8i+82W7jvIJWwXvDT6WRkBScNJS0V0uY
	 PwUQgNijeOC8eAPPgUkvRbWSA6MuSlm3kl5/4f+Fx5cL65aBKE/AnGc7KkbAsLqEI1
	 w3/ymHUG0GU2BYTF6koowiPVX1eq7NAghaASpm+tNIMs8s0AKTyteosxyZadOrgUPf
	 LyaHt6b2RYoew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/20] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-4-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-4-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:57:51 +0000
Message-Id: <20260812135752.2703D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the required guest-1 structures for the ssca to the SIE
> control block for use in later patches.
>=20
> The shadow SCA features the address of the original SCA as well as an
> entry for each original SIGP entry. The entries contain the addresses of
> the shadow state description and original SIGP entry.
>=20
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D4

