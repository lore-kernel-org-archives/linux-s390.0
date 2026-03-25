Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95333FB050;
	Wed, 25 Mar 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458132; cv=none; b=si6QAwYNktqA7V14idNuQUfsEibAsTKcP7GXozFDWk5QaC2k9yWvDl7mBwd1iemAyP/1FPkYM3rJI5HTsIsLq+aziBA5sOZ/zO9diiwuqKDvAKGAbx121Q2Dh5LkUPQwd5XfWSuEWCRNyeH0tSF1/O3O0y9tSt4uEiP2qHreluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458132; c=relaxed/simple;
	bh=9xwFV/34vWc0fW4rHCKchPUCNLowKXyn7gM9kopjyRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgoKIxyrr3Xqw12yVOEQbWJrutQpttyqcf1mgUJg+VcBeY7nse1NKxcj02M9U2LTuYXEuGgXCTZwP7ZRP334HQSyC4glACbO44jgOT+IJYwgSSA1UDafNmvpD4ywitIfrLqUvomYmkr24aVn3it7Aezgc6RDrV+zK2lXNSC7IMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=CvZkdThQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvjlUfHV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="CvZkdThQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvjlUfHV"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DE0491D006D6;
	Wed, 25 Mar 2026 13:02:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 25 Mar 2026 13:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774458121;
	 x=1774544521; bh=KQ/FUXTZlQc0JVYF0A2Oq7IvUa3bsxqFLw7I+mLHQ2Q=; b=
	CvZkdThQ23sIYU+WQ/OI7i8f60lqHfM08rr4sGNXTcuz9trUatuc4Oo62/3nzQko
	wlqG0ku/SlQZnNO0rc25Z1e2TryGQNLyEPykwgz1IhwKvyHmq3+J8bn8Wr9gESpf
	331rfjidduIWshAkek8XoDmmZWh6MW2VreeyLTbHyLJmGTYqSWJVTVP5Ma6Pl7D7
	n+mQR5mqBkvtn8Q1KIH8z+KnQZ5USh7/m4pnsrbbs4tSim6fwIMRRu6NfEw8dtNr
	9KDFl+qgNtrbCCIwK+xtjAxQ2zJk+sLtlQmJ2Jo7Z6wWpaptAFHHxoguzB9B0NrL
	5iqLC7MtJKW/2butmoL5lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774458121; x=
	1774544521; bh=KQ/FUXTZlQc0JVYF0A2Oq7IvUa3bsxqFLw7I+mLHQ2Q=; b=f
	vjlUfHVdpA0yrmtU1dByliVVKl67ge+neImhQtg4RY+BAmjJ8xPP136eYme8SmHG
	Zbxl4la2Oq/vx9zvQXZTrQwsCvhVPKiR6Kz/hEwdHF6nhtM0XxcDYd6YtI06UB0S
	FJRwpnm5lCsV1MRu9d/1zeTeQNctscRsYC95h4eI559MBIe99OORIlLNEg2aslVD
	3kR59fsnkXmwlDg7QHTg/Fc/NX4uVEqA+8aoX0F9EHW8DGARJVRHx/j7FRrpWihO
	HVy8z0M2M1eVqNaXSirBhB0vwzbWYLSSOe35uA2knqDUVrX3hFFuUpIimcw0sPan
	OCCT3G9I2ojA2LB9madWA==
X-ME-Sender: <xms:CRXEaXhLRUg-dKjhduHS2DCdXKzuo469rwgqkpykIpNXBYTHZNm9RQ>
    <xme:CRXEaXvltEfdDRA2-xUOkSmLTpLcIzfy1JSVdVpokP3trIVw9BeAQHeVpIHvLnALi
    IsgnLfj7ahDWp8324NkvVvhN2JtKVutWdIphxnskLXYXb0XbPI01PA>
X-ME-Received: <xmr:CRXEafuEDQ0BX79Z5qvAzPZXQExDewvZOIhQqPJvjy7873u2DXL9iwj3n68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihhf
    mheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhope
    hksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlghesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CRXEaVpoHyYTDXtVJJvquPIhs8c84pIIbealM8W6oujyrN4scLdVEg>
    <xmx:CRXEaWLSgtGAbsroVSPjozbYxPGEXJmlYshOnGbJIFIGGLlJEYxljw>
    <xmx:CRXEadveLUopoRNGnwPq8Bcuk2mCqniiE3pj0rHJ-lYN2goKas_IYw>
    <xmx:CRXEabA4IAqptLTdIoieumUand1pLyPeA22tkcpsruQzA1hB16FcMw>
    <xmx:CRXEaXdEJ1CDFGqQuitTI6BuqswEFSjt63BSMI_A-tQU-XdZVEHCMUUx>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:02:00 -0400 (EDT)
Date: Wed, 25 Mar 2026 11:01:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v11 6/9] s390/pci: Store PCI error information for
 passthrough devices
Message-ID: <20260325110158.6ec66502@shazbot.org>
In-Reply-To: <20260316191544.2279-7-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
	<20260316191544.2279-7-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 12:15:41 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      | 28 ++++++++++
>  arch/s390/pci/pci.c              |  1 +
>  arch/s390/pci/pci_event.c        | 94 +++++++++++++++++++-------------
>  drivers/vfio/pci/vfio_pci_zdev.c |  2 +
>  4 files changed, 87 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index ec8a772bf526..383f6483b656 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -118,6 +118,31 @@ struct zpci_bus {
>  	enum pci_bus_speed	max_bus_speed;
>  };
>  
> +/* Content Code Description for PCI Function Error */
> +struct zpci_ccdf_err {
> +	u32 reserved1;
> +	u32 fh;                         /* function handle */
> +	u32 fid;                        /* function id */
> +	u32 ett         :  4;           /* expected table type */
> +	u32 mvn         : 12;           /* MSI vector number */
> +	u32 dmaas       :  8;           /* DMA address space */
> +	u32 reserved2   :  6;
> +	u32 q           :  1;           /* event qualifier */
> +	u32 rw          :  1;           /* read/write */
> +	u64 faddr;                      /* failing address */
> +	u32 reserved3;
> +	u16 reserved4;
> +	u16 pec;                        /* PCI event code */
> +} __packed;
> +
> +#define ZPCI_ERR_PENDING_MAX 4
> +struct zpci_ccdf_pending {
> +	u8 count;
> +	u8 head;
> +	u8 tail;
> +	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
> +};
> +
>  /* Private data per function */
>  struct zpci_dev {
>  	struct zpci_bus *zbus;
> @@ -193,6 +218,8 @@ struct zpci_dev {
>  	struct iommu_domain *s390_domain; /* attached IOMMU domain */
>  	struct kvm_zdev *kzdev;
>  	struct mutex kzdev_lock;
> +	struct zpci_ccdf_pending pending_errs;
> +	struct mutex pending_errs_lock;
>  	spinlock_t dom_lock;		/* protect s390_domain change */
>  };
>  
> @@ -331,6 +358,7 @@ void zpci_debug_exit_device(struct zpci_dev *);
>  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
>  int zpci_clear_error_state(struct zpci_dev *zdev);
>  int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> +void zpci_cleanup_pending_errors(struct zpci_dev *zdev);
>  
>  #ifdef CONFIG_NUMA
>  
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 87077e510266..bc253cc52056 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -915,6 +915,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>  	mutex_init(&zdev->state_lock);
>  	mutex_init(&zdev->fmb_lock);
>  	mutex_init(&zdev->kzdev_lock);
> +	mutex_init(&zdev->pending_errs_lock);
>  
>  	return zdev;
>  
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index de504925f709..5b24f3a9fe23 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -17,23 +17,6 @@
>  #include "pci_bus.h"
>  #include "pci_report.h"
>  
> -/* Content Code Description for PCI Function Error */
> -struct zpci_ccdf_err {
> -	u32 reserved1;
> -	u32 fh;				/* function handle */
> -	u32 fid;			/* function id */
> -	u32 ett		:  4;		/* expected table type */
> -	u32 mvn		: 12;		/* MSI vector number */
> -	u32 dmaas	:  8;		/* DMA address space */
> -	u32		:  6;
> -	u32 q		:  1;		/* event qualifier */
> -	u32 rw		:  1;		/* read/write */
> -	u64 faddr;			/* failing address */
> -	u32 reserved3;
> -	u16 reserved4;
> -	u16 pec;			/* PCI event code */
> -} __packed;
> -
>  /* Content Code Description for PCI Function Availability */
>  struct zpci_ccdf_avail {
>  	u32 reserved1;
> @@ -75,6 +58,41 @@ static bool is_driver_supported(struct pci_driver *driver)
>  	return true;
>  }
>  
> +static void zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev = to_zpci(pdev);
> +	int i;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued",
> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
> +		mutex_unlock(&zdev->pending_errs_lock);
> +		return;
> +	}
> +
> +	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.tail++;
> +	zdev->pending_errs.count++;
> +	mutex_unlock(&zdev->pending_errs_lock);
> +}
> +
> +void zpci_cleanup_pending_errors(struct zpci_dev *zdev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
> +	if (zdev->pending_errs.count)
> +		pr_info("%s: Unhandled PCI error events count=%d",
> +			pci_name(pdev), zdev->pending_errs.count);
> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +	pci_dev_put(pdev);
> +}
> +EXPORT_SYMBOL_GPL(zpci_cleanup_pending_errors);
> +
>  static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>  							 struct pci_driver *driver)
>  {
> @@ -169,7 +187,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>   * and the platform determines which functions are affected for
>   * multi-function devices.
>   */
> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
> +							  struct zpci_ccdf_err *ccdf)
>  {
>  	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>  	struct zpci_dev *zdev = to_zpci(pdev);
> @@ -188,13 +207,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>  	}
>  	pdev->error_state = pci_channel_io_frozen;
>  
> -	if (needs_mediated_recovery(pdev)) {
> -		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
> -			pci_name(pdev));
> -		status_str = "failed (pass-through)";
> -		goto out_unlock;
> -	}
> -
>  	driver = to_pci_driver(pdev->dev.driver);
>  	if (!is_driver_supported(driver)) {
>  		if (!driver) {
> @@ -210,12 +222,23 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
>  
> +	if (needs_mediated_recovery(pdev))
> +		zpci_store_pci_error(pdev, ccdf);
> +
>  	ers_res = zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str = "failed (abort on detection)";
>  		goto out_unlock;
>  	}
>  
> +	if (needs_mediated_recovery(pdev)) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +			pci_name(pdev));
> +		ers_res = PCI_ERS_RESULT_RECOVERED;
> +		status_str = "in progress";
> +		goto out_unlock;
> +	}
> +
>  	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
>  		ers_res = zpci_event_do_error_state_clear(pdev, driver);
>  		if (ers_result_indicates_abort(ers_res)) {
> @@ -260,25 +283,20 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>   * @pdev: PCI function for which to report
>   * @es: PCI channel failure state to report
>   */
> -static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
> +static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es,
> +				  struct zpci_ccdf_err *ccdf)
>  {
>  	struct pci_driver *driver;
>  
>  	pci_dev_lock(pdev);
>  	pdev->error_state = es;
> -	/**
> -	 * While vfio-pci's error_detected callback notifies user-space QEMU
> -	 * reacts to this by freezing the guest. In an s390 environment PCI
> -	 * errors are rarely fatal so this is overkill. Instead in the future
> -	 * we will inject the error event and let the guest recover the device
> -	 * itself.
> -	 */
> +
>  	if (needs_mediated_recovery(pdev))
> -		goto out;
> +		zpci_store_pci_error(pdev, ccdf);
>  	driver = to_pci_driver(pdev->dev.driver);
>  	if (driver && driver->err_handler && driver->err_handler->error_detected)
>  		driver->err_handler->error_detected(pdev, pdev->error_state);
> -out:
> +
>  	pci_dev_unlock(pdev);
>  }
>  
> @@ -324,12 +342,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
>  		break;
>  	case 0x0040: /* Service Action or Error Recovery Failed */
>  	case 0x003b:
> -		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
> +		zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>  		break;
>  	default: /* PCI function left in the error state attempt to recover */
> -		ers_res = zpci_event_attempt_error_recovery(pdev);
> +		ers_res = zpci_event_attempt_error_recovery(pdev, ccdf);
>  		if (ers_res != PCI_ERS_RESULT_RECOVERED)
> -			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
> +			zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>  		break;
>  	}
>  	pci_dev_put(pdev);
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index a7bc23ce8483..2be37eab9279 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -168,6 +168,8 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  
>  	zdev->mediated_recovery = false;
>  
> +	zpci_cleanup_pending_errors(zdev);
> +
>  	if (!vdev->vdev.kvm)
>  		return;
>  

It begins to look here like the mediated_recovery should be protected
by pending_errs_lock and perhaps there should be
zpci_{start,stop}_mediated_recovery() where we set and clear the flag
under mutex, while also clearing pending errors in the latter case.
The various needs_mediated_recovery tests could be pulled in to test
under mutex as well.  Thanks,

Alex
