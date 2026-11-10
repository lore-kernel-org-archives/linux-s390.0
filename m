Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302994;
	b=Ttnq+ycXA/VVIHWdvSM4NMlB1bnZ3HMCFHqCH2FcuDzFqAJEI1LOveUZi2gzU8DJ7FH8
	 iZMQuASVDuvuryT7jPbSeM7BMFa6us+bA27NMjDW4St3jFS53AdTmxuffu20t1vU38aVu
	 +7F53W+8VQT2qafctDwvwSiiVE/qBPTpTULnVFdTiZDR5CCWn6gCakgqFkVRVHzWHlqPc
	 h8sdCvqGi31o825heimgJqohJoeQc4uVAIPme65M53u/AvPHoGoCt1GBoVsWCHbzJ3PjR
	 rPx+fy4WfAzCRl2Z3+2el+nH4WUUXb7gJYsNXKktvFlcsoUYc4Q1jK1YNf2KQU7kxcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7qmt9HQEm/IppW/oVVqTcUeulCdTgyeaOTDvG9gmZ/g=;
	b=LaYksfEAsP/IY0vKiRJ135hQx+Z6YMtkJJ2Q4HKXRaebPPO3G03LO8kHQ0gKz+7xdEbb
	 /bHpvyEKW3cEjSH+5ZjSrdvUnVRg4tMo2xGWlJgXayRsiPiWBdXRR7igX6iRuWzxYZlMf
	 2PV7xdCUU8tevoB5FUiqMSMVYCeg/rF1gSHvbmtrpUpxmQtv0pUXyX9fIVLNAQv8GytAm
	 qs8555lWETA7LM71r6epZNPyw10JAVigsBUL7VXR8uG51o44baJ1tls22hanNY3zWxOW4
	 d8KJRv1lD75fUA3x6kQPpHNEs4otV8oQmjDlEMyymqWchjVkfK6Tx1DhnRvysfp3RMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyfGF26H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D12606C66B;
	Tue, 10 Nov 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyfGF26H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2811F0089F;
	Tue, 10 Nov 2026 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302994;
	bh=7qmt9HQEm/IppW/oVVqTcUeulCdTgyeaOTDvG9gmZ/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyfGF26HWa/vp/eoTy2gQ2yWEKiWpD42wKeztrzUoEH01zUWdndlOAQ0FnZvaoX/P
	 vPm4YcQjlP0ba+CRReNsMh1C0vMQVrJjj8CspS/oWgImanEyT1Bxoe0eeKJsRkafG1
	 P/nMjS33Q5KcKUXdwN5H2ST/zcRYsITXeFTmMccC51PsU5pIDjBj4VmLAMsc9iavey
	 p13YO29YhNRjD1l8WF26R8CzNndn/brvAD9q4gEhG+X8ZNRGGaV/bpu/7Ek5oFLGYe
	 fulI7FDu/mkYX/VJWfdbIsjRrweuulddRqQ/bqXhM8uiEUwuODLTBfA9+6YjradyId
	 YxQJd3cjdZEaQ==
Message-ID: <sashiko-outbox-206761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 41/41] selftests/filesystems: add backing file tests
 for pseudo files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-41-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-41-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:29:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add tests that files on pseudo filesystems can't be used as storage:
>=20
> - a procfs file attached read-only to a loop device
> - sysfs files attached read-only and read-write to a loop device
> - a sysfs file behind a lower-only overlayfs attached to a loop device
> - a sysfs file as the backing file of a usb mass storage gadget LUN
> - a sysfs file as the source of a file-backed erofs mount
>=20
> And make sure that a memfd and another loop device still work as loop
> backing files and that loop refuses a backing file that isn't open for
> reading.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D41

