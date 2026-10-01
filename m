Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63126FDBF
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851461; cv=none; b=cAtOKHXPYTfFmoDeAICLy5Aoz8Vgg2RT3zzxoqnlGfzZ5IWetzksm6TAf12ME8uAbjnWX4wsWXkzShI3Ykxs1tUt8YeHXeOXQ3MRFrF1oJvfG3MxOaSzaoqtY04XvoGVI5l7ow5pfcKmuUjYOfxdN6yPute1XRUM9K2lq/2Nidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851461; c=relaxed/simple;
	bh=rV8QqPzDTAkPfOOiqJWXo3IO/Ure1Mrmfq/eWWAVMfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBlrKFA0AhIxpDjQ/viw8NgGNyy/vM+wA0zLvi1qUE7+wWODN6s+vBcICka3AGIeXithw2/LHcPPIJPivP04L+obi8bj3tf7Whjh/6YTL/EbYH+qxAfuoZHPupGnRfkKK4KgqiJ8NlfcmblZdo0tmUwtv96ABHtr6+c1TlBtWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVPSq3Dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVPSq3Dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762751F000FF;
	Thu,  1 Oct 2026 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851460;
	bh=rV8QqPzDTAkPfOOiqJWXo3IO/Ure1Mrmfq/eWWAVMfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVPSq3Dnk99AQKqlO3xtiskTGlo5JxOgJtGNjAERAvo63mkqF4sTrCrUU9NbVFvhR
	 6x7AAqBff/KP3XDTgq/p810cJkhf0H+8UlUE/nqi5fQbD1g4aTBL8lifS/mCIVqqfw
	 aR8QfXUW4fC3u9ranfaqmLbCzfu/vXCwFnYB3eAsZGaTEFaYQ4e6uCFnUplHkL4igF
	 0ZszaVSxW3ynBUYAQXdFf46Sh7YuncKVjN/isicR5RaKqIZYKPT8lo4NGcwm9ytGMq
	 xaNHckjZwFJcmmYEqJh7rVnc3C5iMfQi+vi6iID9X/oqbdOYubiLKh6IYctislMS79
	 WbP4eOLZhIbQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/32] s390/boot: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-27-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-27-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:44:20 +0000
Message-Id: <20261001104420.762751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all boot exception table entries to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D26

