Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DE36F916;
	Thu,  4 Jun 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597687; cv=none; b=iihdf0TDgqggUpfXwY0Ire79ugnsiFImTSzbN/E2Cbp0Wala4/It5vRP+8iett82T5DXCOUcqxmVSEko/69GmBVDaF1S4LbrKw3ajIycZMSQFvJ6IVhvhjGfn1TQxSi2SHxgiGiCMR6wVqbI2bfatdEESsqEBefV8u1f6+G564E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597687; c=relaxed/simple;
	bh=Ik4mCn79H08NfxjQwYhmsPj5gW25lcs/pBKsKAuaa6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubLI9mr0eQ05HL+eYvSHvriGfc1soOClnMa7V+rfxVHMeKu/pcX7u8PwHwFqpPdIQaZ4L/GPTFfR13U6aJosXOpqGV/lB4EBV5M8KmkYoeW4MevCbmUY4qM7VEfQLaF4YLJt4hz4HatkaOp2mtoa5ylSYIjH7ivh+mpbl2xGDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iVPGQJAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYFrRm4h; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iVPGQJAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYFrRm4h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74D681400112;
	Thu,  4 Jun 2026 14:28:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 14:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780597683;
	 x=1780684083; bh=YLuwcShMcdzzUSh2tbyuyXlsX4IxkjRP5LzQXfP2jlU=; b=
	iVPGQJAV5AoVf+8MweyfeB0XS5NMEJCtByqeHjvRIU0PfqDSAX0dE0e2LtvX3ekg
	y326NNIsHFwIldsvofF3IxRLBUed+GzP9bbIWD++pHrAN+i/Yfe9krKfbSy1WtFY
	WzA9LF2dZen36Wlvl/chAnE4N/dEpON8ClITI5XoJ62YNe9QNLpxpAVzwX97dUWO
	+rgeuRELwd2+t15IKTxzwAOG53b0Vd4kbxv7FQkPlqiUasBSFeKjldPGpWnlQiAd
	JikOQSOyXGzWeeeplgPx4Emycom8tBgKzTYE/8d3KEd5kR2oEpbQGhO8B1Cce58+
	AjAqOveRzQq9PSvp74Q0Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780597683; x=
	1780684083; bh=YLuwcShMcdzzUSh2tbyuyXlsX4IxkjRP5LzQXfP2jlU=; b=H
	YFrRm4ha1iIAg2ufJvSfU2srBncNdZks/EEW63P7VtYJ7mGbBCoMwB9qmyz1Zm4z
	0c96RihYJdx07H+xWUmcQXO2BVBlTJ1qKk5WguyK8S0M/UEDyh2t7hK2Uvii6U1I
	IfRvXG4m7FwwqMFQAu3rqAS33L7oJ5MsXJ3/VP0QO1ZKsKN2Qtp9FLFUk48ZfvRl
	tThH8XBjETQQfQLZchnRFsQcry9BpNs2gYo7CCJLue23KAfjIERiH4Eco9pZ+Cz/
	XQC7d/Oi8ZpnlJttOirbSOSdGDT3Fm6qNCHR0At7NXvTobUlcP+8PSgljKE2W2No
	9P2PrRW8LBQ8L4OYfCdow==
X-ME-Sender: <xms:s8Mhaq_z-DmrlZ2QKmfSzOOKI-ejSa7spYg8AL_ZYhNuh6tHVfFOjw>
    <xme:s8MharKx5NJjFaZ6Jsm4-eWOiuWh4oYzY-4KEs849skkkxLLD_pP268nD-9avuY_C
    8nf3Vxr6TJjPn5W80Vl9kH5_mVn_-iMD6LS2Nem7pPWd6VJ59M2HA>
X-ME-Received: <xmr:s8MhaguRJDgEx_mM22dd5N4ouB4G78WLcIbH2xUzUhoNnDUqwc2_duNck48>
X-ME-Proxy-Cause: dmFkZTEyunn1xCydYZioEvQrQ6JJoJPvVC6c95rueJ4u1Jw6cf+NIQ9dS1De7en0/I9A7G
    CB7izDe5vGrKLXdND1nmOouahFS8AXzWff589jg98K4cPfON1s+E0ytn7VpnDjm2ovs3ay
    iXP1nzZtNnSnI2AWyrBSHpQytfFzQqYasdNYRA3XOvu+6bzSiU9vEtCK594/5l9QVCIKa3
    o9ANQekbYW4Fj6NKnWAuc0TcR23nMGauTXDrTNrQFuBN15mwvlD2ATYBzmgRdFOqiAZRbl
    LXtl667/Aj0ak/ZNZGpwONfGuMAF2fKp6rZnnapFIrOfdx0+PdDlC0zTGhGqpQjSKhO8KR
    NQK/jvYV8elr52lkXg/Y544DzysstPs+gvWBVMLId2EEgPF7awLbbei1e1p1jAnP1jH0Ig
    RGfmhe8WwiIIy36FKzk6itAHSGeaq7bczbvHzYN8m7pbjuvkns4BRStJw/p7csQmNo7vLA
    8L0XD0bdhvExI7aVRD/wWEzpGKLeYFT2eJBxFxqasAr3KQ4/VS/t468zUrZoGNzaJCtv7C
    8WefMPXt2d5PSw3p1r+C7gOMLMPmyDeyJCWfmQuciyIo8xcH2VtF1U0DGJocFtVTs8tOvn
    AicH2a572pVUIBRi3xXhcUfh5yPVy+7pMgIWQbzDzhtVC7hzRtx2BIQyfPEA
X-ME-Proxy: <xmx:s8MhaqCK0XlHZwyyverwQSTof4lPMI4nL9nfVgSvSgubc3imCtQMTg>
    <xmx:s8MhagP_6R-WIbZQM8Mfws4trgWUw4i4IxIW9GcFAErBCd_HYqgiSw>
    <xmx:s8MhaqBH97JrAvic4agShzFnszzvTphsbCvbmQ1n40iFBjoC7NByog>
    <xmx:s8Mhah4XQYGf10wDBFoXn0Ho0zk92PwpV6CpeGtJeQcXN8EyT-Wz-A>
    <xmx:s8Mhag2Ip_r7Vs12m4vTB3JARaPnkW7NaUsL0dd632Mz6dijuaM0Yovs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 14:28:01 -0400 (EDT)
Date: Thu, 4 Jun 2026 12:27:59 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v18 1/4] s390/pci: Store PCI error information for
 passthrough devices
Message-ID: <20260604122759.34f43e25@shazbot.org>
In-Reply-To: <d352f011-3c47-475a-b0a3-6005e56ef21d@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-2-alifm@linux.ibm.com>
	<20260603162006.27b78de5@shazbot.org>
	<d352f011-3c47-475a-b0a3-6005e56ef21d@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 16:35:11 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> On 6/3/2026 3:20 PM, Alex Williamson wrote:
> > On Wed,  3 Jun 2026 11:24:12 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:  
> >> @@ -266,25 +286,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> >>    * @pdev: PCI function for which to report
> >>    * @es: PCI channel failure state to report
> >>    */
> >> -static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
> >> +static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es,
> >> +				  struct zpci_ccdf_err *ccdf)
> >>   {
> >>   	struct pci_driver *driver;
> >>   
> >>   	pci_dev_lock(pdev);
> >>   	pdev->error_state = es;
> >> -	/**
> >> -	 * While vfio-pci's error_detected callback notifies user-space QEMU
> >> -	 * reacts to this by freezing the guest. In an s390 environment PCI
> >> -	 * errors are rarely fatal so this is overkill. Instead in the future
> >> -	 * we will inject the error event and let the guest recover the device
> >> -	 * itself.
> >> -	 */
> >> -	if (is_passed_through(pdev))
> >> -		goto out;
> >> +
> >> +	zpci_store_pci_error(pdev, ccdf);
> >>   	driver = to_pci_driver(pdev->dev.driver);
> >>   	if (driver && driver->err_handler && driver->err_handler->error_detected)
> >>   		driver->err_handler->error_detected(pdev, pdev->error_state);  
> > How do you intend to stage this versus QEMU changes?  This seems like a
> > big regression if we're suddenly triggering the eventfd that causes
> > QEMU to halt.  Do you need userspace to opt-in to mediated recovery
> > rather than automatically enabling it on open?  Thanks,
> >
> > Alex  
> 
> AFAIU userspace registering an eventfd to receive notification for error 
> events is an opt-in? And yes for QEMU the current behavior halts the 
> guest, but even today on an error device becomes unusable and requires 
> manual intervention. I am not sure if we need to add another opt-in 
> mechanism for QEMU.

Yes, QEMU is performing an opt-in, but we're also now calling through
to that opt-in in more cases.  Arguably this is coming more in line
with AER handling where I believe only uncorrected errors trigger this
path and we signal through the error eventfd for all uncorrected AER
errors.  So long as you've considered the implications for existing
userspace, I won't object. Thanks,

Alex
