Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0423FCC;
	Mon, 31 Aug 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202238; cv=none; b=RZE4miv+sBU4ODteO5l4HH/gPfQL0sQla0g5brU3OJ3QQHgWWrPKGN12bVkvZc+6XdsDvpuv9Kl0/UTXMiGjcwfjzezFhjeVSXVg9ajO8L3qNvxGZ4GdxErCYdqvJtidAwfGRo7cfaJTqeTmeYxg+ch55ZLS8K32jE/LHlQkej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202238; c=relaxed/simple;
	bh=DfhZ+ia/DljZVbiR0CTwRBh6o5xk5TgbIl5/OYrJT8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fFBYyXJoMSZN4F2hr7TNEO3PNj/3xkPZlrg9sNlzV1gybLMPh817c1se6evfuLlCQGObLbwHq4zDa2gCneqIJ1WRYNHx+1zaUnmlRuIzwS18IhjSgSSTi3UWNZF1souzA9fDxsnOcV7wqjm+PetsNoyyetYFV7w6IksEzFO5c8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXBfGlK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXBfGlK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C891F00A3D;
	Mon, 31 Aug 2026 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202237;
	bh=DfhZ+ia/DljZVbiR0CTwRBh6o5xk5TgbIl5/OYrJT8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXBfGlK0cB1+rca5anfnWPwVCUifurLH9ckp7l6KiucvdbgfrPfBlGXPEtpC9SWj6
	 8RqZzP10iPZoe4AsyDXEEWNadvx+5Qsq4bAKxufJyKxUp4T3zcOHCEeWib/6zQ5a56
	 +jJDno5xklEhOPbMrJY3HoaHWtyNhpQewfyk+5jIavZfe9O2B0YD6S5sSg8psmGtsC
	 PsctYcm5mh87q3QHv/YR0iY8TIDVz45D390J1xcqssjj33TdonQwEy7lkLvGIPQ+w7
	 Ry9tKKQ+x7s/AnLUFmoO9r9kca//4wUbsMJZtS1QrTcMEIZ77DUCeVcpot3AkxQahF
	 i/GIMYE9CqGxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/23] arm64: Prepare sharing arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831144802.834315-10-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:50:36 +0000
Message-Id: <20260831185036.D6C891F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Prepare the sharing of arm64 headers with s390 by moving definitions
> inside headers to reduce the number of shared markers. Clean up includes
> to further streamline the sharing of headers.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D9

