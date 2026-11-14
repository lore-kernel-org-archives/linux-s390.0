Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662604;
	b=S6EethMSrie/O36WabJYllfjSKXYuEb+HwbMqENfK2YzWD6bpdaC4O71oSSamd2liHNw
	 vK5tqiOi1Po9iMR7seEbKOwK2C/rZ1OThVNVm6XUxz9MwG/XVkaJ7jyarvSs9ntYO9MmE
	 f+SBKJNukEGsf2Bl2bSzSM0sBOLy9urYDPu7S1LBOs8u23krQChHnJxmjTJLM9+ggQe0K
	 yEE7HzNpqvw6YqgQHWZF+VK1Mlytdf4fP9dPsmNxae2aFBhgk9Vkx37cTbYGx27EqdQLo
	 m1Qh7tfoVAxyj/YP/TjP/eC4cjitWMZc8t9DRAl1DAnYtlRdI3VpsVnkLjx9ey9YIYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=19vjs9a2RUKjraPE6QwnhfZHxbHVdNU03CngUvS62vs=;
	b=BOK67c+B45nDeaE78YdEYQn5zKUgsVwnX3fCLA6LdgsKCFd6X5Anyak8Uok8tGeqoR95
	 XT/rbENaokVKWtne4wMaS4eEZV8976WoUoc4q4y9DbhrdDjiSH92f98T+4ZQ1Ls62Murx
	 lkMcVgpCVjDhuiI0ijBde3Cf46DR2W+d29r5hPZk1o8kAKjmV1suU1VwEOQ5aYNbpEz/z
	 rvj0wxH1vWg1kObpPIipkP1LtL8t26Yn1OxYYOmFsMXhcIje2reK5bsOY0rTUxNwW/d2x
	 FAo9yVdc9x9pGTGxyIJVQVaB26hQ+3jplQsCg5CnBAzq4DAuPIZ03WOy1mc44G/GW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFUdTaaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA019606A327;
	Sat, 14 Nov 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFUdTaaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144681F000C4;
	Sat, 14 Nov 2026 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662604;
	bh=19vjs9a2RUKjraPE6QwnhfZHxbHVdNU03CngUvS62vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFUdTaaDnd+cgi/mrJ85t84woiUJ5diI1YCrjt3gNSZkewbedoDbV0slBnp/XI2I+
	 2yxRAm5GoN/6u41J4bpo/IVcfrJM6Yw/+TC4qS6M95alde1UMP2Wl0tsQ1cbDQMfVC
	 57sWGA/Rhtz+S7QDwluWcKVMRF1XorofWBqS2EaWfFYDHzlBMmYXDwkzb4rOoX5RrP
	 DDH+TfQemj1pJSvTxAjkmjWA+bpU87Gwbq86enruu4H0ztYgk01SleBYJ8UatU4BMf
	 hjLaI2eXjN1KVZz+DKjDkqvvkOX8OLXTtJ7eG7IHY3TW/fw6XjD8YDdF3fe+0tmURw
	 VAgkbM61q3tWg==
Message-ID: <sashiko-outbox-214559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 42/42] selftests/filesystems: add backing file
 tests for pseudo files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-42-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-42-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:23:23 +0000
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
> - a symlink and a magic link to a sysfs file attached to a loop device
> - a procfs file as the backing file of an nvme target namespace
> - a procfs file as the backing file and as the protection file of a
>   fileio device of the scsi target
> - a procfs file as a zloop zone file
> - a sysfs file as the backing file of a usb mass storage gadget LUN
> - a sysfs file as the source of a file-backed erofs mount
>=20
> Add tests that FIFOs and character devices can't be used as storage by
> loop, the nvme target, the fileio backend and zloop either.
>=20
> And make sure that a memfd and another loop device still work as loop
> backing files, that a regular file and a block device still work for
> the nvme target and the fileio backend and that loop refuses a backing
> file that isn't open for reading.
>=20
> The nvme target test uses buffered_io as asked for in [1]. Most pseudo
> files can't be opened with O_DIRECT and the test would pass without
> ever reaching the check.
>=20
> [1]: https://lore.kernel.org/r/71f76e5e-ce24-4a71-863a-169ad262c510@gmail=
.com
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D42

