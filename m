Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBD46EC79;
	Tue,  6 Oct 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303529; cv=none; b=F68of6GRgzLz68Xruurnz06twIs4qq9g8luJFHB290nI+w58Fea3JiMg1qsUPzhjkk9jkL4KT9vMFcVgczX8k8M/pXrIOKSBk7DRzIPJiMEsJbmXE2W+FEarDBQyxzusmozKQcK/UpuVQSjXo6YC0crcxcouyVjwdogWO9AjogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303529; c=relaxed/simple;
	bh=Cq2bQQ8IA5ZWFAuXyRj/p0MR14DM59UVKYROUBiiRuE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OU7BFAUl2pKmAZUe2juj9mHIS8NMaP+n5aF+4gpKy6lemyUc4amc7tCsJcqIl/G4pbrhA8nR6bYvtrp3MH6eVNZk1bfFKeSUNxhB0lpFbsuFbpow4Cm2rJ+0FbFzf33asiR7TMWNecnNgo1HC/HpEojgq9mawjEzC5BIbXqvcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMUOB1JW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMUOB1JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3BE1F0089B;
	Tue,  6 Oct 2026 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303528;
	bh=Cq2bQQ8IA5ZWFAuXyRj/p0MR14DM59UVKYROUBiiRuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMUOB1JWt/U2R4Y6GrDCqeR8P4m59O61ed7XaL+OAg9rK0qy0avfSUjpYVkxUauDW
	 prFzSFDpIMsBKN7fUYbWj2BP2E+Qzsv9RCAB/CK+pYadRiyV3dePkVuGbS6CLi8LYh
	 3025taLe4ZPdlo5IGmSlHzElySVpiqW/cXuGvb7HXgmCTvPleI7xHKAy7TI4Ak5LmS
	 3ZjAluLka8Aiv2M5ROqGMhnUTk1OWGhnvOaHb/VBssmRdUTCnVPUMbyGnZ6uS0Wf6f
	 EFSds4vJpV8nw1jXqndehc9e2I8zlLyWUdkO8z/VHXajN0QTXxFEaQnnxCaGeeNxcd
	 M2+f7WZqNGbYA==
Message-ID: <sashiko-outbox-162237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005154557.57801-5-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
 <20261005154557.57801-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:18:47 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005154557.5780=
1-1-oelghoul@linux.ibm.com?part=3D4

