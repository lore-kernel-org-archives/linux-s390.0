Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662350;
	b=zcaX152Ke0Ek4Mg3ci8J3kGfwyLtmqvnNS1rZ8Cv+6bDNPa44wuPSBjZDg1CUEdOmXWb
	 9Rz4mY/D0KZopwZAyYF2HBrlufLe45aoFp/Rf5pteeDL8+iM8XEOBjryB+RFgvhSjUAoU
	 DSFEMEAGQRcr9WZx0mbXkVxiLPT3deOr6CYnyh7GwzE6BjKu7RI8YeMlO3R9yhDF+WbaJ
	 AsyqLq7Z29TpYjuMswUrnrUcnr/9B1I06ckm1exbJSc2MHslDQklf0BBuDbwPYNMSI4GT
	 4f/EqR/is4nEI4Bqaqr4TnV8O9rac299D+ua1iVrCY83h9/wWSUtloekn3rny/Jtcrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3+UcBkCW54uOz+sesHJ6fimUTeC15Cjfvu3IfOb/l1I=;
	b=EJN2n/480uIIwiE5uiGJelUJAmg7OcvpuY5ncs5PZsvdGt0/XRNIcz3YHuhsJuG3gGW9
	 ocI5rGQb+jNhmnFrLjf6Un1fjz8QKHdXy4U3QfvZvnV1hYgpp0LVlFu86ArUWs4F634Iw
	 qNHiw+bQ6DmRwFwBhGrs4/s1efWlGgc8OYFToqAhPVcS5rwaqgXQTyW6fs7LpRevfWoLB
	 1kK69JLo9+V6lh2r0VdUCyhz14/75N5sFxLwvAbqtyIj/LNAgPog0ioAjIEJ7ew/6ISFq
	 DXZtb6211EdUWczPixQMD/W0cKiXsUX/Y3yaPTBLNOFnEb8y4cGpeEKJrqUM8/bpJqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TBUBt/aP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2699606A335;
	Sat, 14 Nov 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBUBt/aP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366F81F000C5;
	Sat, 14 Nov 2026 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662349;
	bh=3+UcBkCW54uOz+sesHJ6fimUTeC15Cjfvu3IfOb/l1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBUBt/aPkk1YEqCbyPYJyfuYA3QepJLnyAhynIe/8V7isHblSoXz/9ySZbKTIt7Ax
	 rPB/soSMvveGoZJ/Dgt6JyLzo9p5n4z4jqpZWXGV1eYHdMcIa1EvZf7gXEXHCpMdDE
	 EcOhY3C0hOVGTcaYrwHpTAhaJQINncMOCBkRpOZvctGPNXhKzEKIHRVyjzwuI42GW5
	 5TX5DknE6hjsQ4/xLCNiqACLhv+lgr3SEjqKfL82ZBEdICWfAH0GRQFaBdgghGPmz8
	 mBXTH/8rCqt+XOjUNw0wVGOP1DYKfH9ioRwR0haFhIQXj0spHPnAeh/s6cDr61SJuM
	 79eWwhreKWudg==
Message-ID: <sashiko-outbox-214538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 15/42] tracefs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-15-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-15-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D15

