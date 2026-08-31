Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634A43F4A6;
	Mon, 31 Aug 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201094; cv=none; b=pP9md0PYv1RzvHkxxXXV7Nsn4+UG5d+xIU6jJ5MXaZxB4iKMnqIDfctnGrlYpyCK1XaOd+MVLauDxCuVnlyo8FDtt5LL2zFgIa9a1zeU4VrTpQholW4kmb5JeWeXW93kSpuotMtsOmq+nCyhxWplD1gFrc/+1ML+WeBA1ffqO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201094; c=relaxed/simple;
	bh=HgM4xW3DYqKCIcEp9WREf1exvmSXtXkRb+r+5KhjeEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQbCVPuwGCjXzVgSwcHDg91EM0CWg9YGZaeu1okh9eGwakUrMJvuD//vtzb6vCKLUWmkB+r1yF4Q3UUR1QysNQEI2ixmK94o1esH8bp7e34SVpA0mUMmZa073gxkB59N6bmnq8eQsDaIAjj2fQbE3tNvLG7mA5gL2AHAZeXN59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow8liS0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow8liS0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF121F000E9;
	Mon, 31 Aug 2026 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201093;
	bh=HgM4xW3DYqKCIcEp9WREf1exvmSXtXkRb+r+5KhjeEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ow8liS0bBbs0vNjSB0N+RwsOBuQu53ESFdAItDWR77CV7MMr6ZDQ3XhiE8EZdnmsB
	 oRHKQgH99NvraIGgcrVoI0vZBbM2VKsHVL/s90vvFupYGKQIK/th9EVwzgxatUbLuV
	 lThvU8qPIWUIQFj3pm1hzYOU+PU4oMc9QVtNCQxBqG+iInWZLhz6q4PXsNgLQJY+xi
	 Jue11pOB16y560CFhHUqPwefaxy2Uj/IqdYXCoK9pw3dE4EXTswwkZG+XSrLWA4aUn
	 W017A8uYBvAsaH2MSmopQHt7FANBO2Fk7S916Rn6jyR8po7xQMr6gMPjWadZU8Euug
	 pvTC/E9zkI7GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/20] arm64: Share more arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831145536.913567-5-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:31:32 +0000
Message-Id: <20260831183132.7AF121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Mark more headers as shared or move definitions to an already shared
> location if the context is similar. Most of them are required to
> implement system register handling for the host.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D4

