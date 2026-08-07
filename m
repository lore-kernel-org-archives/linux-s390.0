Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B83DFC92;
	Fri,  7 Aug 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096929; cv=none; b=jfiY+fjOxwknxwIZ6YlCv1u0dVh5yT25RIb5TkPKTeLegPBcKb55IcHhDL//JFXyDw1XHajm4Ip0SEpyj0sDyNrjId7uH71mQkCNw4zrvN+iVcU7kXmIWfrnOwAfXY3BxQ0duIRcWOklchEs0vwcIf73Njpa1JDOPL24gnrHmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096929; c=relaxed/simple;
	bh=UXOE3QtaUhhwXUhZBFWFjLZegMgaUqmGXiDpXaUfadQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cqtdINv96tEdAu9jXKug5j7ur5dx2MtoScgSXNd8Z5qMCT/ExfbuZaR5rxusr05nNkPBESa7BV9amW24sLIspq2SrCOYnnq4ubWcN/TMKH0tXCoaAPkhX6hq1f/TDEvTlhVEFEwI0czjzC6ZG0rtgSiOfDeWrhrjsU3H4Jdxsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4Xbsfpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Xbsfpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBAF1F00A3A;
	Fri,  7 Aug 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096928;
	bh=UXOE3QtaUhhwXUhZBFWFjLZegMgaUqmGXiDpXaUfadQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4XbsfpcSFh4vVVRMVKgKSK8WNCndhJ2kilUWGn5UrgenhWYV29KrGLg29sJUXfvz
	 rfUHI4i8cnOuYvHhoMcdtlo66qxzSGLZqFcOSl36YRxTi4tKcs/cciXpiWNdHsHu5W
	 mKnDjYRYxxEEmSKDhpi4ubg2j1PeQ+84FkAM96+e0/Udaq2jvPJ6nGhsp2/Y+v0UX/
	 WYsBCcAq/OU6T0PjiMR/RV/eXgRxCRAbaeMGD0h2j76EkOYbVimH6BCkYrrNRCB/N+
	 a/oWNmMF7HQji7MSFJDiAAlVqQYWrH6y5iM9XJlgiFWH9XtyHkKpAh8cqljZZqrq3s
	 uLBORsYuXTTRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:02:06 +0000
Message-Id: <20260807100207.6CBAF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Make the code slightly more readable.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D3

