Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC7421221;
	Mon, 28 Sep 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601095; cv=none; b=JrHZPuVjaQeqlYwAEsiKVitJyUVAnZuHWySDhVsyhIBOB0XLOnpibPUtxDvCte0EYuNLsNPp5VWOI1T+MlaG/p51zfiPV4GefzeNH6DITX+1MthSKZCLZkGGI8b4CQf1kJCT6G3YRFQ5/y+Bni1gyWrMink+PWKwNdTucR2KF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601095; c=relaxed/simple;
	bh=Fn/pQ11yOvg54F6jHNXnreqD+QDXYFMChAUcp0bhYWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QCHycgXCDm3FVUFQDtXz40OGIJ5mnkdTn3bAk1w2NtKkh2vYv1BerkXykvImy1ciFWOzKypszoPOZsmt5UggozMI3XuTZYo2fV0hpaNTcJvKkl9BkCODHLClLW8c9jNK9I1VDsnkB18e7+KvDCh4o2Xp0+pt1TcGVMemJNH1TT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqSaBOJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqSaBOJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B701E1F000FF;
	Mon, 28 Sep 2026 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601094;
	bh=Fn/pQ11yOvg54F6jHNXnreqD+QDXYFMChAUcp0bhYWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SqSaBOJFeMFypzqTBWHk2wDuCNX2e3D2/dmFY2ZDCSsEQeUibA1krPidHnjQtZDPp
	 fAKA0000gkjJC2JUUtPtFYmMtqrZbdYO5phWneBJrmkst2mNNKZm2pNr8TlBHSm4RC
	 WXSIhYjRzLckEF8hHfhZrgZRh5Hq6nXqGLx8h4F5GvFIGVuUrDhEbyCIVV2ZIvzs9j
	 BHpGiKw9vz8Lszei7GL8rNkHDmHr6pelg3rZC9Z76+kDU5KN5iGvqP/B7vnQmOrilM
	 qyhmqxLFeqeWDdGDQZuLn4Z5fZMIcJEqD8sPaovfB+NZL6zatA3DLRjCz5MMvvi4fM
	 SZndviKs6fkUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] KVM: Remove unused file_is_kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-6-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-6-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:11:33 +0000
Message-Id: <20260928131133.B701E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove the now unused file_is_kvm function.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D6

