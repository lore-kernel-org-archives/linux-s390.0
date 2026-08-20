Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA911DED5B;
	Thu, 20 Aug 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229023; cv=none; b=bWOBoSqG0YLSt63UJK5v3detqpaE+Z6ikgabw0nLw8xT45ujE5ow4hkprb4U4fHwilssMD2oAlZ9MKq9PPKcrZljW4/ywz5zUHrO5AQl6ldMcvxe7HijyJvIa5M4Hil6snPKxiyiuXcr1l6mN4/WK02QmiZyLd5CyP7m8KmXk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229023; c=relaxed/simple;
	bh=u8r7psr0xSV9XbXps4qMGCFn3IkimKKJnzoD2qIEJm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MVQ4opmWXMlVmRUasIOkLrXeXUwxLb1rxZKXRhmOZOOOPGRg0O5dIIR6pijOFBsHGOzxohHjIqPkjin++D7po0fK0aqFS8OO3nxBOu+5Hp29wtnppBzGuu7TW5pNCaPClVwi/4bZEu1nDDkmpDdkRL3stH/D457JCwfoKT3Yodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STpUPvpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STpUPvpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A95F1F00A3A;
	Thu, 20 Aug 2026 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229022;
	bh=u8r7psr0xSV9XbXps4qMGCFn3IkimKKJnzoD2qIEJm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STpUPvpn256lxvuebfrQtp1ZdRSJ6AVJLRUeBR0G9PLvEh2pJPEqnO3/6xyK4YMg2
	 WdFFzcVQAhUyIEIhHQzA/YKbrzxMbHbQCsjT2dyDS01v5LxL92BJo97qH8UjORVAlX
	 myjrGAR3GGzwcooL2bGFlowlkcmu2O/is1VU9ApZvtYOrdtKW4r/S91gnE3Cn11ELW
	 sv4K1djfnezy2v2Nz97tK89FUMrExAciQqe7pKQcMQN46HZv8HKPmk2KW7QRYhKHjx
	 /kGYLJtAlTwdTLCiVpTwVVNe5T4DMDdCYTp1530mN6bNPThyFBb61R1QztxWyCYbne
	 buOFKnf75qhIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] KVM: s390: Kick PV cpus at the right time for
 service irqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820121546.24694-3-frankja@linux.ibm.com>
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:30:21 +0000
Message-Id: <20260820123022.0A95F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Service call handling is a two stage process for PV vms. First we
> receive the secure instruction intercept and then the secure
> instruction notification intercept.
>=20
> The secure instruction intercept (104) is analogous to the non-pv
> instruction intercept (4) with the difference that we're not allowed
> to inject an IRQ when re-entering SIE. We have to wait for the
> notification intercept (108) which tells us that we're allowed to
> inject.
>=20
> Unfortunately we never considered this difference and hence the IRQ
> injection code will try to inject on the secure instruction intercept
> where service IRQs are masked.
>=20
> It's time to move injection to the instruction notification and skip
> injection on the instruction interception path.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820121546.2469=
4-1-frankja@linux.ibm.com?part=3D2

