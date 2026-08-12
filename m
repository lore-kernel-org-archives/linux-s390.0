Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2B375AC6;
	Wed, 12 Aug 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550082; cv=none; b=FJmkVvCyn2ba74OqjHPKakgdZYtdIFGDJsqwaYA6MwE5hoJP4HLFCVxqGhR8s8j/LfZ/0r9/4slArz1erwYSbF68FGrhDIloSK4l3alBCa1sJtl6NiamDmlUYAsv5atncoQhvxn7UASVlinP4VujYxxCj++dvqDvQn3jHzHhc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550082; c=relaxed/simple;
	bh=h6CnhjFdnTybYSWisn3K1GiO4M8UDime1+pHZMWs0zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=scQDzFo9DioA+Gzz3pRRsIpkGsNeK/yh0Zya2QRbjIlAmx1AeSoduUVhGGn/Nm1B8453eQ+UZWUa60B7QBU6LOcgsGJYfYiLPXZR6JmfIv0xMvPFe+Gg2FqtDP99LjDOGeuQo8ccboB/P9Wk4p0u/dOzwWRl/z6Qyzzn2j/Nixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyv6YHF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyv6YHF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2356B1F00A3A;
	Wed, 12 Aug 2026 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550080;
	bh=h6CnhjFdnTybYSWisn3K1GiO4M8UDime1+pHZMWs0zQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pyv6YHF9o4d09cdr1yQBTOqgPK8Q/6UC+6kiWhoCeXsa4KV8NBanDd9QIFMV+KAOT
	 Orpn89rMXOsRwakPziz1jS8Zv8KVFWRp1+GQwuJq6jehAdhVq3pfBkl4/ddId8Ux/v
	 XLusl/wmrjAusJxeUNyKOCfNjiF7OY4Iqy7zlCGcZC2DtRC7r4l9I3Gn8So6tSf4h9
	 12crZVuJM2zlOiWaLyLsoImVL99ZrmL3FAD46iXxvAXYG77u8iGlB0Oj60U1zJiCJx
	 0oP4SNz1i18kJrXzxSY6kMCYnV6cU4P5LMkKZGw1OThpi1K76bmZ0YcfvnbXRLqEBM
	 MLMWF7i3la9kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/33] KVM: s390: Move kvm_host definitions to
 kvm_host_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260812153631.3376090-16-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:54:39 +0000
Message-Id: <20260812155440.2356B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename kvm_host.h to kvm_host_s390.h and kvm_host_types.h to
> kvm_host_s390_types.h to distinguish s390-specific KVM definitions
> from the generic kvm_host.h that will be used for shared definitions.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D15

