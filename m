Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596773;
	b=GveExwhGVZEcs52sEsLURYUNixlu+3aip4pnFY3ThmXeMpKF/gfev20ARrbTLjDBMl1w
	 yDh39N5LYdvrcW1cGFlwwiru8zoHfRriFK7sNovNvMU3xOWmXesCZmHU8loQJ05Ncbi1Z
	 edw7sdO5/u80EYl5SEXtEkza2ME0BpHO06OzCXsnVeX7XtpbFZNrihdWJrIX5y9ktHBO1
	 LsyVSBC2ujwViHc81b0ql7of91CNhhENOFDAq15/2DDjdRZELFiVOoE0/lxuqfUhfCoaf
	 6AuxPOF/M9i3bPs/vggv/OUjn0qUo136U2/muPD1IlI9FaEmPzgI2E1aYYSbQUsx8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v6YhF2Pm1rDRIySBaSZfXpEMV2WCAXaB6sscabFN3EE=;
	b=JsfKVyVv/g68xmetWZRtY7okkeLFgDpSW083K13qnixgqbXuPSkVdPpEfOgJGsncEBVF
	 CbtL4NkLQzpXiHdRRrGF/NfO2QhqCzjqbQQVwARGi8WsUSpgNMY0hOmuAuvh60dBUeb2R
	 iqVUHZRhB0Me6/HFa6wG9J8Z2NTHfpm5PnyVIGmiHi3A9Of2FQsClcOFQFrtLkQjsmt3E
	 f0oUUjdPC7i3rMBhbJWmOrOrfiGrKVvNGkAJji+h9pPhgOZVj0fwYK5RNFHVOdULy0pPT
	 3vl9JbDKgrJECl3mAK9UvEQDT9orcXrvrkMptR9ngm0oswfsNT5yNx9fZxWOLybpM3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQcJRgmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B57606A32D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQcJRgmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B61F000C5;
	Fri, 13 Nov 2026 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596773;
	bh=v6YhF2Pm1rDRIySBaSZfXpEMV2WCAXaB6sscabFN3EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQcJRgmV3kAg6nxCwozwsU+4KchYx/3Sc6Wu2SXRKtEpFGr6SbJm1GQzVydPLTdEo
	 8nnIWMcwBQkWQh1j1GbqgK35wSTWUwDrQCxS4eeM4fNb2yyu0wWM8qd1k0aMFv3JTs
	 jbplVoQ3WCpIhE6Q9HhvdgcvxaB4C6OBj27u2pLsWyIO2Q1mDtZAfbdaz5SJSvrlWV
	 G0sgQTz6oF4rUNA1IfYZ86l44ysfqptSabBlOhP1gK8X74rEbvH7e3wtGlS681VGWp
	 tUTfS/jLmZZEj/oOI2dsbSXWSi8U7vc+Lhv+n/vFIBSwyEKgHfKB5k6WKulszzU8Ra
	 Xzr9cw9PuOoPA==
Message-ID: <sashiko-outbox-213501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] virt: steal_governor: warn on unexpected preferred
 mask states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-6-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:06:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Now that preferred cpumask access is properly serialized, and CPU
> hotplug restores all remaining active CPUs as preferred when the
> last preferred CPU gets offlined, the corresponding logic in the
> driver is redundant.
>=20
> Instead of removing it completely, add WARN_ON()s in the corresponding
> paths to harden the preferred CPUs mask management and highlight that
> this condition is not expected during normal operation.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D5

