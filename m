Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618F385539;
	Mon, 31 Aug 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211938; cv=none; b=YySRRBqePYSbQRPKKuA7r6boGpB3yP2QaLJb633X+d5Y33xPU67/8P6pTV3vbjL1OUW+LsCawOdI/OIPTd9T2mD+fXG5xQFN3ADVfbtUe9OxM0DLtnL0/Oqs+V5hB4L6ApASHEYGzNBJGzh5W619Z699xSHFtESDzeaKuBPbQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211938; c=relaxed/simple;
	bh=b2Rj24FX4xcOqW6ct0ULU300n1M8X+X6SMlIs5M7oZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/tDQKZPzjRqzIEMKZFOBXVnz88lgnlQUsiOCQkS4kNN10VM1EmtRjT4NjpME/ox6AvwO9V2Jnu0WlJFebTuVZe85uXkxF/cMCL++EdEFz5eLcDv3JGuOdePPRcV6rGZ7lWRGocIp15VhmaAeXxenQH038m1pI7fEg8Vua5vGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqb7IylX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqb7IylX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7461F00A3D;
	Mon, 31 Aug 2026 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211937;
	bh=b2Rj24FX4xcOqW6ct0ULU300n1M8X+X6SMlIs5M7oZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vqb7IylXv01K0JwM8WmXyQN7234/X1vu+ndoeN2yeXnC0HfecDFh+vqQ+ZyGcWa8h
	 aOwnv5RHLAzGqZgxKZy8vT7tFRxwBAAfDNfY2TvF/n9t0KXt/2dnsWYx7hjaAQlm9k
	 k/to/w7ry6rrQ4a5iXBJUmWVVCN1/HBG4ku+YTbTqlt4cU9K2PlfglivLqHtpYkLVH
	 ql1tVAEgk4CXi8HMTeS86xil9t0bFUXoveqFyZ3w1cj2X7juCvP+XQV69e1Q/H1MAG
	 c3IhThlqnK0FttkmbasBhuvPzrFBh6O6R7jAZ1D8ZNtD3h22Dzfs7oF9IGEWhwES1I
	 1KdyrQHOjQIoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/20] KVM: s390: arm64: Use QAAF init save area
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831145536.913567-16-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:32:16 +0000
Message-Id: <20260831213216.AD7461F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use the (cached) result of QAAF fc2 (Generate Initial
> System-Registers-Save Area) to initialize the Save Area.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D15

