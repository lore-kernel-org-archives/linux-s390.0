Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D96175A60;
	Fri, 17 Jul 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784323618; cv=none; b=K8yijzrQhO4zIcufk6cTM+DSlV6K+efXPCxzwV76HhY7w+w/+VytZmMqQjbrl3Sc3bQDMvF0Wmjqm1kK5bVCH2EDVyHq64SYa3/l7RVaINOZ/5e/SDsg/z5H+qxAgR1LaHPoKmPz4k+xj60yX2SnonDHQbgndcRNXdurbsLfNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784323618; c=relaxed/simple;
	bh=WRo21tuBs4OXgxJUolfMP/gyj8Tnu3aUwH7kLghZHzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eizmWPevydp7fhQOnlG1VVzS7ujGNRzdw4ZYHSpVyMeKPlJX2CxtXy+zUqylbfRuHa5MJjop4RNLZzTReccpPAXYfwKBHKgu5RJksSs98dsN+qFpnLhff4zgqRCdgukuHlRSVYF9LtxDf3rGWnEtu6NaoOgVrcgOn6jATMWEsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=C3Czv3yx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rEDi52Bu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="C3Czv3yx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rEDi52Bu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D31E7A010C;
	Fri, 17 Jul 2026 17:26:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 17:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784323613;
	 x=1784410013; bh=eeWHQD2AYFBFSMjRiK1uv2wR0q7xPl1Xc5RCGX4uxCw=; b=
	C3Czv3yxLvt077+WMxsq6tcvKLwrXOPtoMUW9vD4ixC0uyNNKT3OPnXCOahH/Vxo
	ewLMA41q9cGWynnAa5VO0vbLILCWRsNnmKrdJoM/EY6p5wDAzBnPlAgc3wFH61cW
	Sr55DhjZ9HCgQdwhX3qmN48EaO/3Qs7kMF60pe5vw05jynr+lbzwQ3YqczLIgZD/
	k7A1ZHqkkwKA1XrXIqxEDc1MC3z0XuDWmsOa5mUfZdkBk39OBnwFZsbfdafAvgF7
	eqzQzDgEmhAiFDDbgM2R66R+xM+PFK1pXKamEVRmV5EEZ7qko67ZC0lgvsn8tALV
	Yiiv8XWzrFPx9hZksHyc5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784323613; x=
	1784410013; bh=eeWHQD2AYFBFSMjRiK1uv2wR0q7xPl1Xc5RCGX4uxCw=; b=r
	EDi52Buc6VN4BDg6+7fX5tQfD+J0olwYqHi3SfqCjPnh53A8tGVd8DVIM394saMx
	V1MGjCzuaBQ/IhgGRDBFV094RkZSIfcnIeuRbwghlLtOrJeDz76mO9Amf7x0ZvKE
	hvJvEGnKEkU+s/qonn3sSEgLw1URUy/Q9h9uK3yZnkTp1PaqmyIxUr+zwtgF2jzU
	BtVaS93IetlsDzKmfLCA4tLhvhJISx3cqdbTM9DtUa2vmHBif+FuQtK4gc5hdIlT
	A40JCqcm+ngiPyXtZzn25LPzIPVU3MlEu8ZZeDJ7FmPedIpx6jFHUL7aNeMm2wtr
	JwU88kIx68cuISW3fscLA==
X-ME-Sender: <xms:HZ5aaoTPJt15R01iZzHHWjATMJL-j1rQm1iFbe43z2xtu38LqgxQYw>
    <xme:HZ5aanXvrZbiu-lU0bj9xUQVifHspqgWm2b6bn-A8QjBCBsgV6KoM54_mXMUsrmuW
    g4F3c4pguLhSU-wr_iTgv7t3CkAAlfiq0pnnFMK1k_5RCl6lGNnqg>
X-ME-Received: <xmr:HZ5aasL52RoP8EyqLjCXMJi-4p8rMCIJa0mxHqIACrLChBy35B27eq9Tjs0>
X-ME-Proxy-Cause: dmFkZTEz7pjAUecrHvE1kyqQzWT7rGXWfz7Q5pmVw05qIT18Seci3DhxhvPovL3SMkYD2i
    AA4YkNncWtmZoIciVTSogFqHGSuHn5a0+qZcCRuHL95YDu+DTtlG5tR4/VXSTThiSUfCtG
    HRuH6yZHADv7x58sNbKEtc1ZoeHe3SRYGDMNpCRoxyAWDm76RPDMA20nP7v4vd3HQP/6Bh
    8H1A3e2E93jaqIZmeIrZ1kd/UenrILW1bOuCTEyUouRzgTg3fYoq35DTR7tD8jOK9InWxi
    kvV9+zczKyvjEZ3maXxDKEcibGGuapfFQ6qYZUBUIWIO45bMDccRNOkc81AyS9st0vmbBB
    hSOGZub7SNGdn3SXOo4Nk9psvV+i3WzCTl4I6bmtR1AWtA8tWD8pvjgTQDij1CTNeqhK76
    iOAFqCgqpw6DOAqmAH2Ox+PEfc4delJzXgVN+ci89oiwPQNJ8a4by1RtScN+VAcWPS7KzK
    5KzLXeq0EYo7ryNRrzJN9GNWt+NpXIx//fg5kgQU2OparMCvNFj0JjrVzMktbhgUWt5wLy
    KVQ0rqlEqPi+OyK9dy5pSKBM8XrPHuu1gwOhhvO4bZmJjw4UC8qMskSrdqQ5qZnk7K/aw1
    XBq64XjaBn6NtDk06Y2m/dbP6+UswpuOcP0YZnvPOg++WKnRJiIAaF5btLjg
X-ME-Proxy: <xmx:HZ5aan3csTPecHmlsrkLjvLNq0hYMepyql7VFlOxPmTAvLdZ0P4OhA>
    <xmx:HZ5aapIwhKhogXJTe_RBFES7Xsdff67wf8yypQhmzagBTUQnYZLNXw>
    <xmx:HZ5aaiiyoULVEI43eOd9DHhRz6ZMPjRPyWM2mzQNz6EImwrSOnDLOg>
    <xmx:HZ5aapBCy2r-gBek-gif3r1nD1nj7hZSQjIRj47tNNynSEP8fJFmJQ>
    <xmx:HZ5aapY3hCDjxUe39PLVx_CpBVdA81dqmwW0FRueweP3Pv0MYJqK0rVW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 17:26:52 -0400 (EDT)
Date: Fri, 17 Jul 2026 15:26:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260717152650.3cfc2d10@shazbot.org>
In-Reply-To: <20260630165553.725-3-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
	<20260630165553.725-3-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 09:55:52 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Userspace needs to be provide a buffer of fixed size. This size is provided
> to userspace via the VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  2 ++
>  arch/s390/pci/pci_event.c        | 19 ++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 45 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/vfio.h        | 23 ++++++++++++++++
>  include/uapi/linux/vfio_zdev.h   |  2 ++
>  7 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 016386f7ef4a..88a125b92bdd 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>  int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>  void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> +int zpci_get_pending_error(struct zpci_dev *zdev,
> +			   struct zpci_ccdf_err *ccdf);
>  
>  #ifdef CONFIG_NUMA
>  
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 8934b640a095..3ad16038e005 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -77,6 +77,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> +int zpci_get_pending_error(struct zpci_dev *zdev,
> +			   struct zpci_ccdf_err *ccdf)
> +{
> +	int head = 0;

Nit, unnecessary initialization.

Otherwise LGTM and I can drop the initialization on commit if there's
no other reason for respin.  I think we just need a branch from Bjorn
to base this on once he's happy with the PCI series.  Thanks,

Alex

> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +
> +	if (!zdev->pending_errs.count)
> +		return -ENOMSG;
> +
> +	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +	memcpy(ccdf, &zdev->pending_errs.err[head],
> +	       sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.head++;
> +	zdev->pending_errs.count--;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_get_pending_error);
> +
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>  {
>  	guard(mutex)(&zdev->pending_errs_lock);
