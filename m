Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B323D290;
	Sat,  4 Apr 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775330424; cv=none; b=B3ugAX7882C0RZlGR6IB6GuB8wLx3N9rk/sBycIosKaEELWwIJRKAhRVHJZ/PsnTAc01qNupnAWGt6KkI/e5lO4pQNA5k/L9sFqmCya1+7sSCdzTDPOs15HOCN7zgx+lwhyprV1lxZQdry8Aj2cpUqEmspDi++uppF/HHuBRoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775330424; c=relaxed/simple;
	bh=Gm9FGkRc1QRpNSImSwgwSEPvOU2SLgI61ARuYW5LgUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AQJhvOyM11n4YH4IIwN6BBhqRE5jSAFZh1Hemvfuth+8hExzlcKkxUOjwOq9BNu6VWC0qbI4TmaZgbDOURP0AsJI2AmdX16GIBfCqKZ4GwLbbOCTKilDaJL/EORaRW5J66CvvMzkAB8/Lyo8OqosG7Eo+Z0GSDci0RBtlyg911Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmGUx9ea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmGUx9ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00214C19421;
	Sat,  4 Apr 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775330423;
	bh=Gm9FGkRc1QRpNSImSwgwSEPvOU2SLgI61ARuYW5LgUM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jmGUx9ea8KKZGI+yk4InrpqyltSpIFXbxzumeqJLrPMsCCsI1AmriWu84nJMybHDm
	 YQX3Ac/MMmi2g9ubzYQwGTmoLjoD5HvqXXGENZ7sZF+bdgDoJQgXEb5+YyoFBlZFth
	 rIDl6Or9j72Pxfg8gbRbLoxXUMFAACLFbQ4DfxU/vKJfbDZ88r7qcAUikXvNARJnPR
	 UKzC1aGXBRx4bgxjkQ5ETAqx1gHtveCsTmzJzi7+wf9pVTh4t9trQOG4pictre3Zqy
	 coxYtZTwXCoUTOSXcrTxyqOyBWyu2eDrD5N4/86+0enySLlkVbuU3KeCQL6A1XpL4u
	 dWWtgOZ4j3TJA==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 21:20:13 +0200
Message-Id: <DHKM3WP2ZJYE.84WX6IAGUH5@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
Cc: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Long
 Li" <longli@microsoft.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Armin
 Wolf" <W_Armin@gmx.de>, "Bjorn Andersson" <andersson@kernel.org>, "Mathieu
 Poirier" <mathieu.poirier@linaro.org>, "Vineeth Vijayan"
 <vneethv@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Alex Williamson" <alex@shazbot.org>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
 <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
 <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>
In-Reply-To: <a8c85884-e2ba-4a3a-a660-9715f0de2704@kernel.org>

On Sat Apr 4, 2026 at 7:09 PM CEST, Christophe Leroy (CS GROUP) wrote:
> Yes please pick it up as my tree is based on rc1.

Applied the patch to driver-core-testing, thanks!
