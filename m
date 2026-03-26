Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9329ACDB;
	Thu, 26 Mar 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546726; cv=none; b=liLgENEAE/l8BkfUuZm2eDH4WFrZRq+Eku8Osw9fN3/m8MoHGxEXFRdL5S6UvAJMXqDDmvCU/Ru0ifW4ziHzfK6tT/KS+3Obgkr7BS3gX1LUP07uRq1a6xq+emogMkEUY88aR7ujjRD6fb17BEGMjAcoDogTsbuZlq6P+HU5zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546726; c=relaxed/simple;
	bh=hAAiF8xSgL3z4E5G5/XmRxGLgvCy/D0+zQfYgHI39gw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=IFxkvGTbEJ0T/UTVgRt9Bp2fvNusBmVhr3bEdRFBHnWbIavF2ABHatZSrw5TcXpU4z716hR8uxZcZNKMWUMfOKX4esWlUobSA5O1qzL3oJO1x5Q6L1hn7qKO+fhI4rfFnFwzBX5OESMzKajmksfNixdku8LlsU+HHXH2jfXBoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArEAbT+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArEAbT+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF3C116C6;
	Thu, 26 Mar 2026 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546725;
	bh=hAAiF8xSgL3z4E5G5/XmRxGLgvCy/D0+zQfYgHI39gw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ArEAbT+s3n7x1zNm2qUyfultheclQsMn7Cylk1mxfVokFRrNp3WpcDfI8mmayZ+0h
	 m2cGLs0n6Sh6ZCu8EvHXqLDxmAX8LMqlZoRnQEfHReuoiYU3xPG1brRn0xv/B7nG91
	 dfctDdAzWRRIBz5wDeTdWGKHbyzznewMhiup0tTEhLqFpUABWkXccnP5fkKD1V8bqG
	 AQrp8yU+1knEeWB4pCRAjqoVJNKbnXs/r4tup9fByZXD5EgZfswwbwv0q7Wo741gye
	 MvHPzW2Tb0nrON4/+fHRtWe9N46CjKkZ5ux8WM6YRAe6n1JfA4kFbYnKDRvMa6t1Pa
	 3vRMCPXPpyakA==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 18:38:35 +0100
Message-Id: <DHCWB6YQ7B8E.1I9WCHXJ6FBPH@kernel.org>
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
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Jason Wang"
 <jasowang@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, "Alex Williamson"
 <alex@shazbot.org>, "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini"
 <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260325052919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260325052919-mutt-send-email-mst@kernel.org>

On Wed Mar 25, 2026 at 10:29 AM CET, Michael S. Tsirkin wrote:
> vdpa bits:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> I assume it'll all be merged together?

I can take it through the driver-core tree if you prefer, but you can also =
pick
it up yourself.
