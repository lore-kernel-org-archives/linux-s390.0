Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986460;
	b=1WW9SwDMa0pOdhPQ+YuxxcrWxh4E3S4gcG3PKProjv/8Y7BbRNUpG2b9Ql6CgZiFiGYr
	 swtwrGHmLfQJxS8wDqKQViFwR+e8xtb4pt6D0iCtAABvO6Wz69s0wKryfuZgecYLjp5tl
	 xP97ep/NZeGWBOXtY8r3DgDP/LKYc8qp60HHfIcbSFhycNv/4qpMUAp/BdKW9UTtViCe2
	 ZbqJ9VT7SoCrlxc9BGP3R5iM9h9Dt3NNDksV1JsA2l7MheRbfwOQB6WW6hdKPLeJb6QC9
	 LYZeSFc6b7MOEujKqnHGSuN+Frw0qD4hMBUTti+H2yHMRHiCgimVNBVy44brnlNRtyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5UVW+ELaA3GS2eqSBuQBTyZcvTHKfnAJBIRhb6odKTY=;
	b=twRuisQbJ9xh33DW28ts9lWJAIj6m4CmDGwL9pm6jvYvK6rrdtpTQ7QTdhOXpVRRGAII
	 rQr4wD08oQ3yPEnfC6rb/tiuY2Gyj28LBnuTa//Nsibs0EBF6RLTc3nUAFkOy83VkGANd
	 qqBAe9XR/qutBz1YnTiNNSy0v+9CUHiFT7uxqGuoR9ghD25mJvt7poo16wf9NdycYNSax
	 psteqHYDu0kWENhySairTKw7xyYEbpw333YgfKN27jLOac0JGYasrbN2jO3oQ1xcrJ1xk
	 FN5D1eKVGllBzPztMFjb88r4V3qr4ierhP1hfhlITflbKK9Te+BYqZ3IfEvKWHIuQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyvtO9tk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5C606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyvtO9tk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345921F0089F;
	Fri,  6 Nov 2026 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986460;
	bh=5UVW+ELaA3GS2eqSBuQBTyZcvTHKfnAJBIRhb6odKTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JyvtO9tk1d+8fd3otoeIa/pp8xMJudKgUIJv9YJlkuhDUWg9OoJ1sYCsUfuHGH1Ti
	 wlsO2cOcZ/+kbDl8nPHHbPHTG+XjPUkXnmFRxuqIFSxZXushSaYZAQC+Ym0KLTFbyH
	 lfg27vAEQsMgnLjtQObwwWeQQ11Uc2O4NhrsaKrGeDJ7RWX2rI6tm/RTTTtuT4HcTa
	 9IsibqURA9eN3gHWbgsydhvmvVZ1qbYWu9Ns6e1F+jV71MsDkYuFBcv/3GT4GJKTQw
	 vLjerdIPh6ivNM8JR1O1VgoUsYg2YnQYwdu8KI+ukBiSKFwGlmvu4i+bx9sHnDoINj
	 TNqieknvQpPTw==
Message-ID: <sashiko-outbox-201944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/23] s390: Read/write ARM system registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-11-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-11-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:34:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce Extract Arm System Register and Set Arm System Register to
> enable s390 hosts to read and write system registers for arm64 guests.
> The new instructions use the new RIE_H instruction format. Add assembler
> macros to create instructions in RIE_H format manually. Add Support for
> disassembling the new instructions.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D11

