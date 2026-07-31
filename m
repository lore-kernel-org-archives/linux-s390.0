Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651C3EF0C8;
	Fri, 31 Jul 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504094; cv=none; b=Xaq/CjVTnj2QEg6o4kUYshD1oL+vTsvsfeLg66hjM5N0/KLl3LyVHpp7t0TEKAmv5MvSAdOR7VYc1PLNj+CFXs98JBiHSmk7LV5Y9JxivuAShrHg/PJoMUI9MUyy2SxSoGgMaedJ61GkiZZ/u9vh9vSnB5H2CMHqlCax8c4gR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504094; c=relaxed/simple;
	bh=bYpk7qYSyjS7yCPzOOenakrIMCTpUDNrDueevRU8/gM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMVjZLhCLbZAqCpi+j3WlWyGdVld2AXCFYJyz+FuehHlKqmuLId6QFI34aUCXWkg+6pbO6digEUFQsaTcdvUmH2mUNZJQsRPotrL0xoMpuQr9RN3tQz5u+5duXfNkoLripAJjmnmtv60HdyNx/lGWVeBiOWuYhIJG1fnZ8gSls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSomi7bK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSomi7bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AA71F00A3A;
	Fri, 31 Jul 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504093;
	bh=bYpk7qYSyjS7yCPzOOenakrIMCTpUDNrDueevRU8/gM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSomi7bKr8Wyk3dHrGYpkVTEpPUPxR+4lWZwHN4mw2MeTxqMJtzTkLUbnfrRQMFkI
	 d/DmNwZMQrCm7F7DUDWz+utHIwbYQWyn44eniXDw7nrneRcN5PeGciINr+x2Y1Jrzz
	 q6v75VOMHHGCMlUqT2AW+nu37F2DQ9EI+VTWjLxJg6DyhRlEfKddaNDV1+cwny+jki
	 zF3tmeMFYqkTX7J2UuVgUxi7SZmyn2SJUe6Ry7q/hRyMnOTBlMWCqTPVRZc1m/gdVB
	 JobMTiQ/WbAvPNisAxIcEf5I+9C0q+uc0hPeEJtZX8Y2UydWzIGKNtRFB6l1RRobK7
	 3/A/ZgEVP8fhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/14] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130138.173983-13-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:21:32 +0000
Message-Id: <20260731132133.08AA71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D12

