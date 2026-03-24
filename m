Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148634753F;
	Tue, 24 Mar 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339796; cv=none; b=eKjeTilkUGUb54VrYJTr9e0K4JRaPl+04p1gHZ+hTOdipknxRDZI9xmO6PMtBqn+IrHhk8cd/3xD3k7OdNXxOOiUIG3RbK96ykYwjyWV/PLdOErxFW61PtS5g25wpp1uNMlzFJmpAxrNJbADEfynBCbnVEM+bnks4B+UjbOHmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339796; c=relaxed/simple;
	bh=IKKPJZ+MZDaoxP4vPPsLme6gW/n7DEGEiTEMcgMuYp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCstLSOCKQfQIGaM6HV7tt1KasuIH8E+yrqXSqmQoAQ2M0nlQdivOHAnptuHOs8xbUrgv2uHVABgExmtcefcsdmhCiUwI6TAdcfKHVR+O4nw1X5U7Qd7j25wcX4KWt5EeMmrLoP72FJuOC6tKq7fLB/E03U3WxVW/1CLncICSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0L8IR6Pk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0L8IR6Pk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B8C19424;
	Tue, 24 Mar 2026 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774339795;
	bh=IKKPJZ+MZDaoxP4vPPsLme6gW/n7DEGEiTEMcgMuYp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0L8IR6Pk68bAp9++dR6ItzOnWZf2MgvBLl2UV5zaHXNUbsVb9RAc04NnLuD2YNf+G
	 GmqZcQvouuvrdE0xPt4YHI6OTcY19NxN8kIn1pWJKzLM1zFnqP+nevgcl7t5hQ7vTE
	 9EDRgh/2RJsqQNRl7woh8a9xc4H6xKdllWSA+5ec=
Date: Tue, 24 Mar 2026 09:09:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/12] driver core: remove driver_set_override()
Message-ID: <2026032412-finally-lubricant-7fe2@gregkh>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-13-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324005919.2408620-13-dakr@kernel.org>

On Tue, Mar 24, 2026 at 01:59:16AM +0100, Danilo Krummrich wrote:
> All buses have been converted from driver_set_override() to the generic
> driver_override infrastructure introduced in commit cb3d1049f4ea
> ("driver core: generalize driver_override in struct device").
> 
> Buses now either opt into the generic sysfs callbacks via the
> bus_type::driver_override flag, or use device_set_driver_override() /
> __device_set_driver_override() directly.
> 
> Thus, remove the now-unused driver_set_override() helper.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/base/driver.c         | 75 -----------------------------------
>  include/linux/device/driver.h |  2 -
>  2 files changed, 77 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
