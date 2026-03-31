Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8DA408239;
	Tue, 31 Mar 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971804; cv=none; b=WaHf9Pq5f13OfoNj/jgAVrkbOA4FHqbAG392QCcal9zwvWnLFzvCaVLae2YZhXVIc5JaknWVgpmvqAJW453jeEojgzZ+hcMmlSYjLZSpWM+E/CJzxFtBKjP4ymublRniWjkhQmzcG08ngEcAZSy+Y0SUc80VI2BdVUR4g8K820Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971804; c=relaxed/simple;
	bh=6Sh+nuXBMcAFDxKLCKsR5cDxicblUVjm/StrUH5xvws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5lM5LpgCz/64ex00+nUtKgzT668GIlCd3LmlEl4qk2Q4ZzscyXt0xn+VnS1pLhLH0yYmU+CYfFu1LhkWDdvG4tG+5rHiU4M2M4QIalvspQEBkI6V+W993xsZdUce6Kstg8GZFD3aZ0c2nr979E2Dp7Fn7xcCKh/4jfrfYZl2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvEJIy/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvEJIy/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763AC2BCB1;
	Tue, 31 Mar 2026 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774971804;
	bh=6Sh+nuXBMcAFDxKLCKsR5cDxicblUVjm/StrUH5xvws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AvEJIy/r0i0fIT0q1b7k0uixxXSVC1oh7xfO2lmos43V1mEkh9/oCyjjM/NIlIzDR
	 G4ToLsOxBoNZj9eIXjRIfgaF1JLikB4FAvsXjSce8BwELH8sXRPMxKzVfwC18KZVLM
	 xvaZCSjKCWIMAF0TL0BKofu4C2zQpBgPhfjifUkEE/91cdaFO2EcfVtNgpPrO7Xulf
	 fYkRcb4pifGLoTxuUkNA9ffXMCz8PqPYdeYYDg7woAcRkIdsrLp3N/31BR3QOWYwl8
	 kL1fnhPJvjBetXgl25fDvOAS7XsfRd59LIFlTx8YTswK4vMykSPYpL+e72NUmtvpp/
	 OhFF1YDMIAkew==
Message-ID: <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Date: Tue, 31 Mar 2026 17:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org,
 Gui-Dong Han <hanguidong02@gmail.com>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-7-dakr@kernel.org>
 <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 5:02 PM, Ilpo Järvinen wrote:
> I tried applying this to platform-drivers tree but it failed to compile so 
> I ended up dropping the changed.

As the cover letter mentions, it sits on top of v7.0-rc5, did you consider this?

I can also pick it up via the driver-core tree.

Thanks,
Danilo
