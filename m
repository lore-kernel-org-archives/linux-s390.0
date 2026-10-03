Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D63372045
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991189; cv=none; b=P86eegUzyRCaUzXPiIQNzFmZmNNu+aoze4ZLuCvxXKOD6xR3Yw5esXwGIclnspZaQS3T56abSY19iYzh3FqrhWQ/nsthuJi8wWJ2IencJ49fUqQbz8OfUoW+2S7DyA4dv+LH2S6MU+D+pYcEFdjoYieWFU/dtxniI4AagB5i9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991189; c=relaxed/simple;
	bh=evw9W1woSPuj9eHTJAIs146yKTxLHuF+tJqMaRPndaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q1DOWStanA1OVWNJyNClCeIJ2vckHLJjkQXOZo0aaqNCNKatLKfkRyrlCtloI7yNqxgHyZK3wQU3gv3bJRVJhRevmqz+sP8SVe4RH/hQtAUoWn28/mb+BmoZs7Scv2RyocGuvLzYGOFErUlIcIrlWSH05oZ61PASh05FTU323Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGzAKk/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGzAKk/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61681F00893;
	Sat,  3 Oct 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991188;
	bh=y/5LgFVxmCMFa3uXc+jV3gQaISw2e/FrCjdOP+rWCxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGzAKk/qAzwrBGB6rj8cHnSquBnBGNSb3KrhUurFtqJZSB90N9SBrePdHLEtzMGhH
	 otoDzuvgLMQ7rmRB69vTfUkmQgvk999WFm4g7IqO7k2PM4iKAFBRrOBgGfZAfk6wKp
	 ZVtGKMRnjtOqxndAynoNFQfCP6hhpcAqvRSmexrU6apW8slIwLeKLRBbFL8u9ryReF
	 3Wo73JRXFOqJiQpPx6GuduL4d7sCbkRC0nSAKUdVIRHl7Cz8bRTx1jh9+7hEzrupWv
	 GuAk7pTEH8xx5CYo35oPWKTaemt/EcHXn9LOrSDHKfjQXenpUqIeJSvn0lpEvyRNaX
	 EiGeZXcYxqsDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/entry: Last breaking event vs invalid kernel
 stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261002152055.3305184-2-hca@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
 <20261002152055.3305184-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:07 +0000
Message-Id: <20261003013307.B61681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In case an invalid kernel stack is detected the last breaking event
> address is copied to the orig_gpr2 member of the generated pt_regs
> structure. Correct location would be last_break. Fix this.
>=20
> This adds help information to the printed messages:
>=20
> Before:
> Kernel stack pointer invalid
> ...
> Last Breaking-Event-Address:
>  [<0000000000000000>] 0x0
>=20
> After:
> Kernel stack pointer invalid
> ...
> Last Breaking-Event-Address:
>  [<000001b802c1ae1c>] proc_reg_write+0x5c/0xd0
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002152055.3305=
184-1-hca@linux.ibm.com?part=3D1

