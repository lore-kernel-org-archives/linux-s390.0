Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DB3EA66;
	Sat,  4 Apr 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322273; cv=none; b=GanQToIoPhS5i6l5ajQGs0uKOBLh38T8J8HIaK235wjrwFLrv3hOsdPeU7wHobQAGpsXWVbtOo9M54ucJSAkwG7KY0NcizjXFWzAqe0qsk+Zabv7qLgfUttcXm90VrOx9VltoyA1oXAXNVDzgUqbWH4JhIGuG8atJMXAoyA5vAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322273; c=relaxed/simple;
	bh=7PzP6n6U4E9ZflmrRkBSMwOeYsGN0d+ge+8bYc26zsY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Eh2MJgfWv1cMfW9W7PauqAEZcesa6jE0UisVbmzc8lBXfXaSz0y0mAofwa+gDGfo4b2lbps5ZHKlwk49VC7lvAdpauxoNPBK9ZbsZjYXFqk9vIxIjC497IC9f16N/D9nyqz8t+8PmQYx819a/YsyGZkZsJh1a5YgRs5wf0A1jMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe5eJq1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe5eJq1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6663AC19421;
	Sat,  4 Apr 2026 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322272;
	bh=7PzP6n6U4E9ZflmrRkBSMwOeYsGN0d+ge+8bYc26zsY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=fe5eJq1d99JHNmPB8IpFig8PRyyyj5sltf3KPYrDsk0N8TKZGpBePJLkrkPDItx5u
	 OD9XiP1BsdzxhDnieDTpdRavUaIxIOsfwema+FPuAf2OftNWG3RNzfc/+E74+vzYXL
	 hr6gl/9eoMudVQ+SB7i9KoJ64jNeCH7KBFn19c9SoYtuyJxnlnjg/gnFezKFCEM8UT
	 pXBEauClp409xFE/+hMuTZWOGegzPULPyvlbewkUUrLyfkmmluI/xnbmAAlztMocbH
	 5TCceEPtW/9Z41b0BUe5ZnMFG66SCb9IcaE5AfJKxdvb9nrxftJLbDrCkbK9ayIBu8
	 7zufDNhS7HSYw==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 19:04:21 +0200
Message-Id: <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
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
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
In-Reply-To: <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>

On Sat Apr 4, 2026 at 6:58 PM CEST, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 04/04/2026 =C3=A0 17:07, Danilo Krummrich a =C3=A9crit=C2=A0:
>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>> Danilo Krummrich (12):
>>>    PCI: use generic driver_override infrastructure
>>>    platform/wmi: use generic driver_override infrastructure
>>>    vdpa: use generic driver_override infrastructure
>>>    s390/cio: use generic driver_override infrastructure
>>>    s390/ap: use generic driver_override infrastructure
>>=20
>> Applied to driver-core-testing, thanks!
>>=20
>>>    amba: use generic driver_override infrastructure
>>>    cdx: use generic driver_override infrastructure
>>>    hv: vmbus: use generic driver_override infrastructure
>>>    rpmsg: use generic driver_override infrastructure
>>=20
>> I have not picked these up, as they have not received ACKs from the
>> corresponding subsystem maintainers so far.
>>=20
>>>    bus: fsl-mc: use generic driver_override infrastructure
>
> I droped it from soc_fsl tree, some dependency must be missing.
>
> Feal free to take it if you can, it is acked-by Ioana.

It is based on v7.0-rc5; if you want I can pick it up.

>>>    spi: use generic driver_override infrastructure
>>=20
>> These have already been picked up via the respective subsystem trees -- =
thanks!
>>=20
>> Thanks,
>> Danilo

