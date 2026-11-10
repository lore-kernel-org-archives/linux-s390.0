Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309872;
	b=rr6/9okc/roRJxvyUrJXqbEyLHnRBFp8hAcr5TOKg0rjyQvb4vNNYnKE0FxPsXmkUgXg
	 o23/JfA2v36eItRxiDEnDLriida0X96XWX3rMrrNZ/UPzN/4pO4oXczfc7TpdZoWMmXkX
	 3qbkqgSyjFLY7rKtZlGJsEKW/e8TTL+uw1QyuUAaJJDmoIqoIeGS8aykYK5gvdB/AvEhU
	 9JKZf7alOcDEKsS/g7xO9VtGBnvk5DAQzlaSU7TLUj68BDzwX1qTwFYYhfoK9unz9KQjs
	 UUXaEsx0rOn7TX4owh3I71qAEJS2P28zUOjoCzM6VJfWi/7lDBvI4GeNp85m86WD6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9j3eCLKAKkw+5LuHyDglVyZBnkLyUIuZaOQetR/dLJ0=;
	b=gLgiCmLvdsCZeGgBQ/u92kKp7tqruhHGkB3edI74itQkfwyNEgJwXdlq4U7frOYTqCqn
	 uwL6+6jqA9iwn3hJN3r1dwwwq1PwHU/IXEErxdlYXYxxAlOXK/UbST22X+OXn1lIgmCst
	 2C90m5cpIltV3BJ44+vQLid3UxwBYwTw8TON4j7u63iCx5n/oF51Nehgne0+ZQnEBiBfZ
	 JCHzogs8ogsayVRWcUkncdAnhdsKbUsPoFzaRlzlW0uXf6yKoXV/ri5sK6QvM6jXSEZRs
	 plgaGg4kZJ/VhnHmIaDXj8E5iEv8b4hTVfvNc7oFMeAcjKzt7RpBm1oWAime9CWfheg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLsAaQil;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FE606A325
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLsAaQil
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5371F0089F;
	Tue, 10 Nov 2026 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309872;
	bh=9j3eCLKAKkw+5LuHyDglVyZBnkLyUIuZaOQetR/dLJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLsAaQilN1Srdh3KSog5q8Dz5BZ4WKUdPSAkzSOTps5vxHE8tAXaGGhevQFGkcDHN
	 Yf9YmYkIgNMZqUChdRlXSYTATZ3AqbIeaKRisjpk20rq+txHt0c8JLpeJ1PNfwcevG
	 rJz+WiZeBBPmhpVa7rdkMTRQdbOVKK6gOjDs9d18/fG/nhs2J7Fmr0MYbwJMneQTYt
	 x1S7f3QCeiWORJ9zgPMnxCLFl4tHCBZ1SenOWwTPOAicM+QpH5Rav3UM0u7ny1fbUe
	 GUAkuU4YXtOaYNTM166tuhZb1dPA1dxKij8195IObv0dvR0zayEm9JgNjagmLGz93j
	 FWw/j6zVjirAA==
Message-ID: <sashiko-outbox-206934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] KVM: s390: selftests: Add ucontrol helpers and
 instruction tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110111619.61760-5-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-5-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:24:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add helpers to run a guest on a ucontrol VM and use them to test
> instruction intercepts handled in userspace.
>=20
> manual_kvm_creation_execution() creates the VM and vCPU, maps 4 MiB
> with KVM_S390_UCAS_MAP, sets the PSW and r15, and runs the vCPU. r15
> must be valid because C guest functions adjust it in their prologue.
>=20
> ucontrol_available() checks KVM_CAP_S390_UCONTROL and CAP_SYS_ADMIN.
> Tests that need it are skipped, with a reason from the new skip_reason
> field.
>=20
> Tests added: STSI, TSCH and STSCH. Each must cause ICPT_INST with the
> expected opcode.
>=20
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111619.6176=
0-1-aaronmbr@linux.ibm.com?part=3D4

