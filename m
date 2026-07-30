Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796443C7A2
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421787; cv=none; b=LyxvJC3xGBYeMiAprl+KyHg/CgXCmtqy25dosxRGYAhtEuk4U+4mvZa3KM5XpoPvFTucWh24ICKVSC7J+jOktspilxgY0MttRhHkBt5KQ7mnUoyvkVk8teHsoDfzRvRDR7NKLWTuf+Rx+y4mH9qflL312YvNXgA/zDo90h43E6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421787; c=relaxed/simple;
	bh=Xly7i/WaGSVKLDUY3f8fxe5BVo8OzwPF9PlNzoVk8hM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M7T2yxNbx+adavIAKpXF4KagnnYfkoxe8T3HPZe/rfEgn37tUeB6NjCwINzG6IXAw/tlCmY00M4mePCxpVjuc4IN6L6AJQ3SfakcdX+YJvOGfhi6SI+YJOFhs0wM9MYznLkZfLdCNKBrkDVogW3gBOAZ5aUXgJ6JvgxaMMzc0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ1F8Sd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ1F8Sd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE91F00A3A;
	Thu, 30 Jul 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421785;
	bh=Xly7i/WaGSVKLDUY3f8fxe5BVo8OzwPF9PlNzoVk8hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ1F8Sd7RXEmTBrl/TEcLNK2nqiqC+hyhhXEfsHywRWQpjXX14Mak3+HnOc6FB/Em
	 +QFkRQTxLM/p21t0djN0JMViTdYkBHDNwVTIudRZ4YW5U6L/JIqp9B+1AMTIg8wMwk
	 qN2y8ib7Pbgr7DxIGCCxyrhaYXgkZ41HMe8y2cZPrb134oVb8yP4wUuOlwI30gDO6J
	 d5Q2KJAoGvuEzXc9gPH3Q5ZNKlATxGdWJlynoYytQov4Txfu6QAnq9+352MYon93ly
	 OlqPJoJP0bI+mZSZUWaCxYaxtGFeVON9JJ2ZgCSRIwfTRfX0SidqQ3HJxKvPDrqWZj
	 pGs0m/Gv7BKdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730141509.205970-6-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:29:45 +0000
Message-Id: <20260730142945.A0AE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The both functions xcrb_msg_to_type6cprb_msgx() and
> xcrb_msg_to_type6_ep11cprb_msgx() copy the user space message into a
> kernel buffer based on the message length. But on further processing
> the message is supposed to be 4 byte length adjusted. Thus up to 3
> bytes of uninitialized kernel memory are forwarded to further
> processing steps and may unwanted expose kernel memory to the crypto
> card firmware.
>=20
> This patch contains code to pad the gap between user space copied
> message and message buffer length sent down to further processing of
> the CCA or EP11 message to zeros.
>=20
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt=
 device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730141509.2059=
70-1-freude@linux.ibm.com?part=3D5

