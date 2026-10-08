Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF194414DDB
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448823; cv=none; b=Qa2mPgQETv8nGki4ugA2YIXYMzLkj1MSKqYHL6KJNnu8btuBV5UafjEEblOH9AbR3x7qU1sn47LHaFajaWn2PUPGVb6SLiqNYsl7de6KZutNE2DOrVI3hDmf4Ghwpyc0JKgwficC2622+GGGD8Sm0+y7yi7CtcGKC4DV00lZpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448823; c=relaxed/simple;
	bh=Z27DfA3GsAY2WKnrNR2avRnafkAudrM6zfdF9S6GffQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IcKf5Pd/Eu28sVax4V4UiFe2zJ9FFGlpWbS6ZSXhlFbLfPI6BgEuqfb8MUnpxAX16TtZi80LaD6riwBrqe0JxcJZthyfN6sh3xMhZbQE/GViq8PbfT8C/DQTyz39619uPtPToJdFxxEFtrWdarw1Ca2mkaI5eF3bLP0cF5LBRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqXNfFS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqXNfFS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF61F00893;
	Thu,  8 Oct 2026 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448822;
	bh=Z27DfA3GsAY2WKnrNR2avRnafkAudrM6zfdF9S6GffQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqXNfFS05iKQm9j5KYl74e+T/bFALChP2cH+3L7hUYbALT5UBnixSZPdrZ7WDbeim
	 gSrJ8zROESdY8v4CEzjYkdJfH2+5OqgafspRtFr8MBJThTKCanbxgLGdR/x97JjIY6
	 xZ+2Ku8k5RdPDK/b4tWYw6J+5snJUMU+an7lTpkUpNZJSlTTBDWl3bYXnMSD6ozMp4
	 AyZQVIdZOqKVeb8vxTVooLfj8XtnMyymghmuDh9Bx+uhPxbUteGTUpbbu0KtE6I8LV
	 yt/ifsZ8TscLOJ1z5jmNJ/MaKhuZQMl+xucc/K1rOl9SwlCUjY1bQ6P3f+IZVmdB0b
	 9gQfv+yCdVkng==
Message-ID: <sashiko-outbox-163846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] s390/topology: Enable SCHED_IDLE_SMT_PRIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261008-hiperdispatchfix-v1-2-73fe41081070@linux.ibm.com>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <20261008-hiperdispatchfix-v1-2-73fe41081070@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:40:21 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On s390, vertical polarization configuration assigns CPUs different
> polarization values and capacities. These capacities represent the
> virtual runtime being assigned to the shared CPUs by the underlying
> hypervisor. Consequently running load on high capacity cores, even if
> the SMT sibling (SMT=3D2 on s390) of a given core is busy is more
> favorable compared to a fully idle low capacity CPU.
>=20
> Implement arch_needs_idle_smt_prio() to enable the sched_idle_smt_prio
> static branch when the machine has hardware backed topology.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-hiperdispa=
tchfix-v1-0-73fe41081070@linux.ibm.com?part=3D2

