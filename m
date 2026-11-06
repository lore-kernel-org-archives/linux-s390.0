Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997220;
	b=vQaeTeHbFjzmSvQ6LEkVd6Hl8bI2oi2IaUmUuG5X7eBgFl9/x/jD4eEa/CG7SLVGSkwZ
	 mL5OCVdei6J9Zbp1rzygZtBYBJRHYZIF9+OGaBQeTKnwjjzhVwGq8T8xlG5sLBQDnW+Rc
	 QBnD+0e5M2T8VQpNbSXmOg/CBj1mfEk7g+YqkU+AWM2XfsQnYGh5Ga0Yly/bRPqDC7AAU
	 cIVg8B7rdn9EXqGBitk3V3jP4iqwikbNR5IKziCuz6zrcw/OhQGZTPunphmyNJ6NiPe9Q
	 7golmfRnY7Aw1ZdU9kH6D4KpxTyZ73VwgprPd1mq6/0XdzqKBAxy2MTg7LdRMqb9aWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ETXWqCYwTJxNlIdZUFU/U1sOGXLIx1mx8BIepMgjMgU=;
	b=uX1drZqebyjlhuq/2AVYXBgd1MMwmgy8X+6csu/Rr3QBP/fT2SzAKA5UgF+kIVYy95jF
	 1SYQevLgqGi5EDpc/1/AguBONVaeDsNjY+XDul52bXkDaTRjyiU4tFyLYdG3+2CVb7w3L
	 w6krb5NvtyrvOjr1WAnozouMfFEQqKWGO9AXHZbcc2Yq9qq3X/fcOp0+ytu58EynXIKn6
	 gr8nwc9WW3h9fJcrKdrYqMNYpdItv3t/vWCDff5y21b5O8+EbB0Vir1+4vZesm8DDgahN
	 5n3j7ivU8V6wWnNlnaxFq//K402iwcDE3PWfZI+nuo+RBg8P7XFcjH3PxN/bH8diatA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At6LEXZe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D7606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At6LEXZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA411F0089F;
	Fri,  6 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997219;
	bh=ETXWqCYwTJxNlIdZUFU/U1sOGXLIx1mx8BIepMgjMgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At6LEXZeI1c4W4TZiC03UMiUUDcCzw8VqmaO3ub1nWy1blU3Pd/2B/SWMRCayk2O9
	 hHb1szqiZltEJEm86RQp/ch+xylV8hN0k5k4CK+3FIZV+LqjwqjNpr6hqhOQnEmL1C
	 9qQSsc00AWPsXTEoUTPiun4S1HxsZk1Sblixq7AIVc21oGdh5zZOYTs5BOZpesSyQI
	 /OzWAErVma5VFIMigRsodA5s+iNTC0Jikt22Uaji0F74V17EhTlyLEEgaSS91KxnDH
	 6bcVhEdDcVWmpEAG0/EcqG7UPt0DFuy4RpGtOCdx7KFmgV5IqjTNj/jw4T01Hd7fmx
	 7iT9+HAZKZFXw==
Message-ID: <sashiko-outbox-202220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/15] mips: Get rid of custom mips ABIs for syscall
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-7-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-7-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Get rid of the mips exclusive ABIs for the syscall tables and replace them
> with the common ABI names, replacing n32, o32 and n64 with common. The
> common ABI names have no advantage for this files.
>=20
> No functional change happens, but it simplifies and helps to unify the
> tables.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D7

