Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E50360EC9;
	Mon, 31 Aug 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201725; cv=none; b=D5QBkUUXdtrw7uGfUwKaaHuvEDzzjSdHXqcS+6QEZY+a3hUTzsQIZTuejeHhu0b1/j/XELcu5A8IjinJRIs7moWxvD4J4i78nLRFVKT+IM71um5x6UVhPcEzZ7nQhPBk7/7IGaYbSN9DdbiwxG0+8ws9raG7sd27q7P/k5RYSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201725; c=relaxed/simple;
	bh=62Xmll4Jp9O5Wl3H61otgVdU2NDqpL17br3DqxmQXYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxqULzVWRkYdvayZyQsIwGtoSTuLvhRS1AAHf0W+uUrsW0FoHV3Gz0WTYmRDVzEejAu2iqZzMxESo530tiOELRo3OJEt4x7yweiHooQjMVJwJvSWTLu1BopkNRpOcC1iEpYaLqxfosvBghcWn6XWqfNucu4KAgcZCFFsStDvXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpwA47nA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpwA47nA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACA31F000E9;
	Mon, 31 Aug 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201724;
	bh=62Xmll4Jp9O5Wl3H61otgVdU2NDqpL17br3DqxmQXYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IpwA47nABSVEbtg85cswMVFPSrfTYzqsmDqR0NVinirv0TrwagIhuAEBcVRuhdO9A
	 l0wVajnr3yJv2p5PWUNmPGp2KAAr/IgzOy+cHFGjXovbALd/rv07Tfvjfs/FlXUoVB
	 Ee1YIaid7jadxkvnGAjnX5yOATkwyfjmMiYGU7Yj1eeJXxWTePQr5CdsuUho+ZooD6
	 ADTC6idFSFwMAb/K4A1RZdNwf27Yfa3RNbI3rNLh9umppV2L+cX+zRiMPmJ78agGrX
	 XcXV5LGxPEEZ8nQslpztR7eHENgxFsZiE0GnsuTTSmSm8IPWx4zKlW/Unqw4ntyV1R
	 UM+NStUwLfP1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/20] KVM: s390: arm64: Prepare for sharing more
 arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260831145536.913567-6-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:42:03 +0000
Message-Id: <20260831184204.3ACA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add required SVE definitions to the arm64 on s390 host code. The
> definitions are required to be able to build shared SVE related code.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D5

