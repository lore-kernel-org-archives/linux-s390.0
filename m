Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662405;
	b=p0kDfzL8ll3fTx7+lKCYJU1IrhgYPffcHH8f9b9LP8hKjd4xYFoVSAew/oxe9o+sDaMO
	 YpEufji83GuaL50LM0dBDRcr72UcugQMIwLOn3t9HHOYi3RHjlhKe2RlTT2S8T183rjCa
	 6uWTB1luCYByc9Iy7aYSHzS0FH7mzMMlMVslEBN5YS7OZ54S2AHuwL3kW/qng3n3FpuTT
	 0qtZ6AJeQG4chkvRjC+hSHWMeTK3JYP915H/pD9jQdu6QXCr7tVdWz0LlrpAkZN4LmU2S
	 MucY28+EdqXCEa2Est4rn9lZSjF25hMpoVQD+xDCN1053cci06XyO35Z3RZpemT1ySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hieCjosN2qRC7XCcFKrMrTnZTgWp9veYjeR7TUSosYs=;
	b=gyrncW8dhz1wxYpi9GFptJ5qKRksoIOFagYaY++X9d3hCpF8GgvuLZsxrV9o3ngw4gx2
	 Z39I/uYUv+Mo+sJcuexMrCCPYmuInPyvvwanL6BH+EhMaHA3wiVL3lGQNp+8+Z4YTKRgC
	 Yam4ulxd/RUQ8euvQVh3qJB3TxpNk9wANZfFSA69ltX9s5j5NGfi132rNUlkb6mUSfz79
	 VxnHAsaXRXIlyGmn8dQNUPXY+Cg1Lfsymq0J4Y7Ch++F52Iq6VopuJrvjb9MeJJ65Kyc6
	 +2bzcUtWbzxsXkygnvPTqD8VnZLeY5g4GQSZhlJha1dmgGBzCxnPz6aSTy5zozWeFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQqE6U6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3738606A335;
	Sat, 14 Nov 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQqE6U6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E370C1F000C5;
	Sat, 14 Nov 2026 13:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662405;
	bh=hieCjosN2qRC7XCcFKrMrTnZTgWp9veYjeR7TUSosYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQqE6U6qeu01tygOG+sNk/O8hkdTk7nwZwcww/XRn+kOlxKXqCURbnSn39ig0DHXD
	 KYzHi9cXdRsto3OP5d6tIUNmmAn69XwES+hABe9NquZQ/j90foPkz4FDImgBy590F/
	 D6nW0Xy1vIXgfhxIEFel8lqSFvhseLu3VwgYjrFe3PU2XV+5r8gpcpmfvfc1u50O7A
	 uyVMMdVjuBk3/CNe5Wji8leIstKTIekoX3F6BbNIVMcRuS69rB/25i/qPyCUbvo25A
	 AJQXDX4ZqE79ci+HHkqKnWkLOQYOPo8M3q06NpMYQNwOmN2+ncLmeXcH+AvOnZ1XRd
	 kJSVTJzovBh7g==
Message-ID: <sashiko-outbox-214548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 27/42] openpromfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-27-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-27-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D27

