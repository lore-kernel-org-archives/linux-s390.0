Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67043DB992;
	Mon,  6 Jul 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368755; cv=none; b=W1XzV0n1wClJ7XfapXzncgs2La3Go8lWh8DwgKqkApsiW6wLtSNagfEqyqb/vIqaIMIL//vyMlND2iST/YaUgjgzfExFyzcKlMducYzcUwqF22VDDKnzyKwTw0KZA4F6qhmVcNSz+Vu3xzCMxUOpZrgEKRqNGrDdmQERTXHDbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368755; c=relaxed/simple;
	bh=198kkjwdLvm+jgZOhFRiTNgrdS0886kJHSp+oMUxAd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XF5xd4pw4iFwxfsU1sAZqFPe1Wsav4OLarq6C+m3ff2wlEnRxiqm/jKREEglXTtBBByvhZErdHXQISuZtI7Lj7s6KZHhSPn41ooxhJYdt3MwH5s9kfqrNM9rTIYLYCtvLgbKb4FyvFyxqQEIzSyAQyk/pdxBb3yA22tpBxFlTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuc12lsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuc12lsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52771F000E9;
	Mon,  6 Jul 2026 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783368754;
	bh=6LzxoRPysS3e9PYbinI6b5iaOYUpOLco0I/aVcxYkQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuc12lsLZ5p/YoCgH9Cuz4LF219zwNJvNCSVJV6W+XQFS/zFzSwdU314xyge1sMds
	 jj0BvfVpPUexP/h/DVChVLZCRQJlcfn9i+PfQqXeLVXKe/tNb2SIScQwKwvu1t5BAA
	 xYwa/WFeQQfHrIeuqxMFNFEBmITNVBYKGb9bMQvPtcfRUHSFXYiWN15HGLaBd9GK0B
	 WXZ09uSNycOlVjrsziA1Z70MY9aSJ6631Zq8IZLfJYpC0brxOjmdRRnZIVEKmmEhhj
	 vIGIXq6Wk3V7DceT/7MG4B+VUJem3n7s/gpzE8Kos5uwu6p/Sxk6Gkmb3xaDl+kkoo
	 AwomPJ3Ou3upA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramesh Errabolu" <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260706200244.91130-2-ramesh@linux.ibm.com>
References: <20260706200244.91130-1-ramesh@linux.ibm.com>
 <20260706200244.91130-2-ramesh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 20:12:33 +0000
Message-Id: <20260706201233.C52771F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706200244.9113=
0-2-ramesh@linux.ibm.com?part=3D1

