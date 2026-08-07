Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A87285CAA;
	Fri,  7 Aug 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126461; cv=none; b=e3f34voIq5ta+1ttvhUH5iUQd321J3hCM3tULH0gKZcZ+GaMGRVgk00wECOT7cJLWqOe8Wl03Oe6OnIy3GPvcXWri9w7RzClq9jT3fJ+KQnzD7ozUNfWy97cDd9ksvVpf3Ii6hlXLZv0RUIZMk+2Fnn1gn051pgBJVxr0KacWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126461; c=relaxed/simple;
	bh=8sBbmdpN07NQCoem/A3TUVh/4gFbx900DNmK21kSw+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OnD/1PQ6lSqi7veTT+TgRVPq8L6DKaeVVYRRmf1DwpE5pguetZrG8ODH212aZrLaeStzgxvMgA8PVX6aK136gSwt6F0HrcA0sP1HSelYNLZa6kgGpY1ai9+4XKGQxqssoCTc+EajhxhyjJZD2aMdZh/ODi9eyBbQQWMxcLy3WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIGiGF8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIGiGF8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809021F000E9;
	Fri,  7 Aug 2026 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786126459;
	bh=Cn35ipzAgCLlVPJ+/3Zs0Mr4XQFkD29m50MZiMZY3mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIGiGF8wY90e267g6jUguLX/PhAQAaK/X3uDXL6hy1t5E8uO2+hbR2ty3NfMqkoP8
	 lq50oqT+CLc6rBQdlphbEtxqJdJkDTsxHmqnd0ofnVSsizLPR1YqepnEWmlj8tDrLq
	 M83bBoH6HQbpEAYqp5VfPtzHHfaDEvFj36NmGIInvmmSmKAZJGcqNzeeAJmaYxrz5c
	 zDr/KfeRFe7uedWL0glENzQosWPvCkGqb1AJB6w8LPdiUUtluXp2QmonrIBiFTsRqx
	 LJoh9wAptLapMddDdRCq3XBQfD9j/xpaY3oGAEf9cq6QxT2fQUKgVSCiO0uCUpkKGI
	 f/KOFHDHRkhxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramesh Errabolu" <ramesh@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807180127.62471-2-ramesh@linux.ibm.com>
References: <20260807180127.62471-1-ramesh@linux.ibm.com>
 <20260807180127.62471-2-ramesh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 18:14:18 +0000
Message-Id: <20260807181419.809021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
>=20
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
>=20
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
>=20
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807180127.6247=
1-2-ramesh@linux.ibm.com?part=3D1

