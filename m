Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966934C9563;
	Wed,  3 Jun 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525223; cv=none; b=Z5Fyiyr2wxzre+lka+9GWa3W/HEuEfTkI6ZKjttFgWP3nd8a4AsftrIz4adXYhnnH4TIZIySlfCQlF3UiyQOWCp23J6cfGE6QjlYD/44FHAzS99kPLw1g0CLpxm7uDa2yb1p89exASBqywgkQnOXKpdNw0NGt1EeRMQ33fdqPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525223; c=relaxed/simple;
	bh=EhlBlQFfgXncPqsu9f3zgRymJFfQVj5WLn7oHMFBbr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MS5AeaYK4TIBmbeZWb2Kotj4PZwwSRbnzvI85i7g3R9z1nksq88YwJz6G6UVHBJgPuxxJFMtE2gpKLswt5R3LP+zDkKBpTj32Z7+0kXQOdUfFf06kKh18jJYC4FJ8B6X3zTD1Rcdw8HR5trF3zxwPUsvGQiGiTOR8R0Ybp/FwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YqS5V9JK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nc6dHaN3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YqS5V9JK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nc6dHaN3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B12B1D000FB;
	Wed,  3 Jun 2026 18:20:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 18:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780525209;
	 x=1780611609; bh=9kZhKZGJz0v4KTv+sA6NCtH1KkRlsAFv9a7Yznk7BYU=; b=
	YqS5V9JKO7OB67qFV127l7bRjJ0WMiiGfiwXvOejk+Hbz9ybMgWD4xGTB7g5Hqx2
	OISg+eZS1GpKhH4+FVCxu2aKT786f2+kq2EX0trMDhnywnLaJ+F/FHHyYck0DFfE
	AScsW6ZnDBqNopgVLSiXfYI9rIY3p1nOqrZhINefD6qkOGMCCuwrNYTGM5UEL+h7
	m98jdqkBuL3Fjs7j/vkXGHPvyFsjioMFujBJ9c6hpmNn6hwZagJDWAA3joMMiJia
	hF+05nlb/yx/JwFAItpKvs8hWQwmKtdUuc9m0eXs5z2DDuSF6eZQWvF50Cl2DeOE
	6iDlw+nRaPo/lqxB8Ne+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780525209; x=
	1780611609; bh=9kZhKZGJz0v4KTv+sA6NCtH1KkRlsAFv9a7Yznk7BYU=; b=N
	c6dHaN34QMQ+VQ2ivmgOiBdOAWYOzDX5fXZSXgRZzSTfRQaKqMJoGeGJ0k1IBVeX
	lfsFJx5Q1Zl9RrQ2XxWGwG3y4nPv3gCxAgOJBL5bXK2xwyDC95ywgPvUPWtcPo13
	RemqKormSyvM/LvM5AIQZ4DRNbfQmuhUJ/gGEY7FhaichIn5kNSNpZZHGrxuTTw0
	OcUhrZ9gtW0/AyCAmcKSW/qVlP9hp0VCaFdy/s+nDSxxi5hS26ExGzt2ROzY20pN
	CNYeKPv1vKhk88sXDiv+3AuucbfastkouMsHr367NBrVUF6iJPCvvLQtGRLip6z1
	/gKcCcv3ONCQumrDRo9rA==
X-ME-Sender: <xms:mKggapdImNWyI9Xl6LZdFDazKuLQFSbO2BIi04xDVzn4aST-2GhHhw>
    <xme:mKgganpI5LGoYA8s0JhV6OEpdx-Z8PnLrww1KZQHO-aEVUJ4cB5fXdQrKBzJfnk4p
    TpuuIRQZ2q8cLsW41oF9BLR_JZEEUSuJ5bb5NL9mOLFqx7nCBDB3g>
X-ME-Received: <xmr:mKggajN0zzwoT4_mSGYbjp4Y5OZQ1Jxdacaya2z-x2SkfJDxm1ujUoidlkw>
X-ME-Proxy-Cause: dmFkZTFl48SMsTNMd/jGCpgDHRd9W6JwBWzYhz/u5NgrllOUiKDSu/jLbzVVJxAxkxsy+H
    WOGl97jH4VSfLNdbHN6iFYwqsSywnmLCPv5AHo7gSBanjdPXPDQDvhrgfkkRWmzxHbI5g6
    LtZLq+K5UHmO8jNgjTSuquPSQXzTRQR35DRU5WI8X51j45RoTTEfnSchk5NLPMDo9BFdYU
    hBgJMIQbCNdqV3Czu4JwC1b2yryst0rUIXeaGXWDBnhkm+hVi7hHPDHsOCBjVKWZ0/m5H6
    y1nO+RF4lh2NIvr5ojdHyXCG6we4DVdzWuBcefasuOZHwByJ2qqyLy1ncsiPi8zj4I2zec
    tsKD3WEBF6cfWfQvMD9vOcPcyxZwauiLEyGTF9YdEh0GlCTY+mPLyAJ0QctpJWtigOcQYw
    fjUR9xB87HoPszJJuB3+7a4YlEpzdjrMjbiFvua/QNXHKngmSBn0324rpe6waYD15jng8f
    g5bJXHi+eYaTF6oJsLkcgwkv4ka02ecjnntwmT4HCEeiz5qidpqxbv4hkqUmzJx0egdNCB
    vwLheARx46jPgJupLG2hscG7pI1A8xi2oF20M8UcP6tGeM2wlrG7Gpbh1KqXppD/ysIhSt
    HUlW2IV+1ZvGXoEWnpFMwmUILoce3mFFaTYemJvd+vipXhcRUtsxXd6rsGOQ
X-ME-Proxy: <xmx:mKggaqgyihdncXwQ8sniFF1nAGXQq4d94WEqZG_GuxewBth5k6Fe8A>
    <xmx:mKggamu64AW6LJHiuy3mC-2jB3z2kjRrbyJ2vANRn_owm5W1ke3zrw>
    <xmx:mKggauiCRD1wSwtCQ5753LGVgF5Ggn_5d4TzCEMs-yV7gCnD9jay9g>
    <xmx:mKggasYExt0pKvljDYA_kaddUzINOnDnO6Jkwj9__EN97AT_qKI0VA>
    <xmx:maggalVLtb_xkm0VFr95t5nb92KYaArCPBNDQO4TUunO6qMtiqIiUBl5>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:20:07 -0400 (EDT)
Date: Wed, 3 Jun 2026 16:20:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v18 1/4] s390/pci: Store PCI error information for
 passthrough devices
Message-ID: <20260603162006.27b78de5@shazbot.org>
In-Reply-To: <20260603182415.2324-2-alifm@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-2-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 11:24:12 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> @@ -81,6 +52,47 @@ static bool is_driver_supported(struct pci_driver *driver)
>  	return true;
>  }
>  
> +static int zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev = to_zpci(pdev);
> +	int i;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	if (!zdev->pending_errs.mediated_recovery)
> +		return -EINVAL;
> +
> +	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued\n",
> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);

Is this really an err condition or just a warn?  Nothing is
fundamentally broken here, the queue is just full and we're losing
errors.  Maybe this should be a warn?

Can this create a DoS if a device continues to generate errors and
nobody is consuming them?  Userspace could ignore the error.  This
should probably be _ratelimited.

pr_err + pci_name suggests this should be a pci_ or dev_ call and since
the pci variant doesn't exist, use dev_warn_ratelimited().

> +		return -ENOMEM;
> +	}
> +
> +	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.tail++;
> +	zdev->pending_errs.count++;
> +	return 0;
> +}
> +
> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery = true;
> +}
> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
> +
> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery = false;
> +	if (zdev->pending_errs.count)
> +		pr_info("Unhandled PCI error events count=%d for PCI function 0x%x\n",
> +			zdev->pending_errs.count, zdev->fid);

It seems like there's always a race that an error could occur as the
user is closing the device.  Is this really worth logging at anything
more than a dbg level, pci_dbg() in this case?

> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +}
> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
> +
>  static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>  							 struct pci_driver *driver)
>  {
> @@ -175,12 +187,15 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>   * and the platform determines which functions are affected for
>   * multi-function devices.
>   */
> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
> +							  struct zpci_ccdf_err *ccdf)
>  {
>  	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>  	struct zpci_dev *zdev = to_zpci(pdev);
> +	bool mediated_recovery = false;
>  	char *status_str = "success";
>  	struct pci_driver *driver;
> +	int rc;
>  
>  	/*
>  	 * Ensure that the PCI function is not removed concurrently, no driver
> @@ -194,13 +209,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>  	}
>  	pdev->error_state = pci_channel_io_frozen;
>  
> -	if (is_passed_through(pdev)) {
> -		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
> -			pci_name(pdev));
> -		status_str = "failed (pass-through)";
> -		goto out_unlock;
> -	}
> -
>  	driver = to_pci_driver(pdev->dev.driver);
>  	if (!is_driver_supported(driver)) {
>  		if (!driver) {
> @@ -216,12 +224,24 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
>  
> +	rc = zpci_store_pci_error(pdev, ccdf);
> +	if (!rc || rc == -ENOMEM)
> +		mediated_recovery = true;

This is a convoluted way to get the state of
zdev->pending_errs.mediated_recovery, which becomes invalid out of
pending_errs_lock anyway.

> +
>  	ers_res = zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str = "failed (abort on detection)";
>  		goto out_unlock;
>  	}
>  
> +	if (mediated_recovery) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +			pci_name(pdev));
> +		ers_res = PCI_ERS_RESULT_RECOVERED;
> +		status_str = "in progress";
> +		goto out_unlock;
> +	}

Since zdev->pending_errs.mediated_recovery is only valid while holding
pending_errs_lock, this is really no better than the
is_passed_through() test.

> +
>  	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
>  		ers_res = zpci_event_do_error_state_clear(pdev, driver);
>  		if (ers_result_indicates_abort(ers_res)) {
> @@ -266,25 +286,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
> -	if (is_passed_through(pdev))
> -		goto out;
> +
> +	zpci_store_pci_error(pdev, ccdf);
>  	driver = to_pci_driver(pdev->dev.driver);
>  	if (driver && driver->err_handler && driver->err_handler->error_detected)
>  		driver->err_handler->error_detected(pdev, pdev->error_state);

How do you intend to stage this versus QEMU changes?  This seems like a
big regression if we're suddenly triggering the eventfd that causes
QEMU to halt.  Do you need userspace to opt-in to mediated recovery
rather than automatically enabling it on open?  Thanks,

Alex
