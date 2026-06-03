Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCE38734D;
	Wed,  3 Jun 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526227; cv=none; b=dyj/CU9kdo1TJmtpvMPhS7hPeg/iDJ5ney8tLwtulEE7rB/cpHCcHWmS+mzzG8RmltAjxBIs3SgIhxE5XTRPm//pVfxxLB5Fh8f8pIP0E9Apt3LYsm4vtq+XDGo53RaENmw0tdb2JCpzPDSorWDuOAhAjuNcyVi4drGYQctCnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526227; c=relaxed/simple;
	bh=MpeMAhWEXS2oZlzr1sqGIsm8HzDwZUWYYcKLOhjSmsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHY/RCrOFIgv4I9WdbKWvtAlvpPZtrASc5Ao7a38AO0+WcrmgFvr6by03uAPOp1MMujgBbPGynPFG1gc2FUQ+N4fHYzlNaX+FXZ0lPWn2sRk370RJ4FhhJ2yYIjnkeStQ5f6sEQIhyOAs5qwAARZ4eEhiyWJ+o82A91uGljWdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=BkAZtwfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUhNWP5G; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="BkAZtwfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUhNWP5G"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B4157A015A;
	Wed,  3 Jun 2026 18:37:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 03 Jun 2026 18:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780526224;
	 x=1780612624; bh=XB2ZF8JxzumGlC0NB7vOHSmkf7DvNPLFttrpDIjbtlw=; b=
	BkAZtwfA5eA5+cmDWJk17huwvQl3F+EESxUh8NYVCoPV5lV+FB6QNrahLyCh7Y22
	+Ouo21GXfRk/fk+SXloSq5afIlM+4a8liqSDugAhHlNISxmuw8HrQznwHukWpXXe
	CLxaJtGqWYLb2e1670ELx5VqZ72UzVbMGhYdYTKbZsr9b67QU7Vr1goEu3qaL9N2
	oXYLwHlrjM5SNcx+byav0LJnl4IhiY9SxBCZ3HD7x0g+XMq7dqMe3XuSURyPRIzU
	TtJ3DDFrSkKOhj3ethQc/DNLgWS1NaDK0Y3qNwup5KvpVS2rXns6+GGRdaQmpQ3/
	GxpjvUJDiLaoqNdNB2wLAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780526224; x=
	1780612624; bh=XB2ZF8JxzumGlC0NB7vOHSmkf7DvNPLFttrpDIjbtlw=; b=R
	UhNWP5GWXs0NS23of2ag63j4iPEFn/1wFzmVKffgitlrbsmnpyuAA58GUvkxAEVs
	QZMEKYkmd9fxQtQDOzOsnV1ab6XG4DVNrHMWQYTf1D0FXXX3PFlADoXsFtBz2sC4
	M1q6C3qeu7BzvMG3RFVTJgk585J4gj0YYSzxZM3vTAC3A1YTif0xY85ESNkiOQwq
	YSBrIBr8/V5xsQcmfLtZbGaW1lOuHP/cW7zIFZx45KryvdV0nkQO2uLkVN4sWK9K
	ugq8KQE0DGqZZKtSNt0VExpi9OerZLPwF+/Rc8Zr0N5bCDLHR0Czhc42WXmEMPGP
	F5vBtoT/RpCZqAQyTJzvg==
X-ME-Sender: <xms:j6wgaroojDsl4eOLJ4QsTNl_g6jrmzsSGcrJN6fZNXXxPdAcVWYnnA>
    <xme:j6wgamEpXjDY2eueyaq1HNiywWUkxvmQaeLwvxvvXkuhR1KV0U0JemQCfbrwoJTks
    usS9Bh9fhrOjacdUhVoNvF4byL2gL-FtLwD2mn2xbObKFPbOYTT>
X-ME-Received: <xmr:j6wgao7Atz30Ep_xLbgbZhCfcNCfvoeOMx0va2iosFDkAq1_cSwmfqsH5a0>
X-ME-Proxy-Cause: dmFkZTF4/LnBRh4yFTbBO8ZXHKLZ2zFAA6gWuTcvfOodFtDGy4dncFLEdhlLGLla7d8eTH
    6QxKdMGc3EC4hX2r/VkqH+iHqdg/2EoaFjpSD4k/bva6K+ufGxIswXmYME/0+D+MCG6ENB
    Ft6T0g0Q2IURGo7wws0UW5t+s0+0kAItMbnOmwFeUc6PqI1vTRu8KLGk2wCTANdj7K42NP
    XiEBgds7KNhS+wzMh1A6nCl9tmWkOeoTMZbn+rDA/c3PFusI82V9Z3qyXKyjSa8/IJgM4j
    wuXhSCMGpXr/ho1YdW6n+rZfP6vPxGlwgJVWHvg7zKFKwRSGoODgOmMACfRts0Fj378fnW
    1rScFDlPc/Q4BPsSv0lVEX8W3UlLMAjjVMwRt0PEQSUWuENKE2QwJak5rQAvN2upG16Ro/
    C9DKxbMU7pTaJ0SAH/YVCrfo5Tvs+pt5NKV7zbdLncqLCi3Z/Z1KgJw3sANfl7Z1IEF16C
    o3pOfN3B2LiY256kroiN3IuMLBtGWLnBP7NfzdxXRyAZ8EW8qB8qaRXvCDr/GV6vAJAOgE
    gBTjxU5rOFy25kNjQoX2Aw9i0v7lQfqo3YnkjCYjKaBw996x88uurv+Y5+Jmao7MnN/8i2
    jV/NO1jGq0IpqAOVMaHgIMMZsSJDdHyKQf6v1AI7OSB9FggJrrNLJmvDb77w
X-ME-Proxy: <xmx:j6wgamd38HzRccXeMqRTzXgLfBdmRw4_Et2eCd1nPw9-krXfP_cYtg>
    <xmx:j6wgar6ZQxYIvA_aWfgkBMU501-Z6m7-IUqnrxQjkaxTlPZ22PUPaw>
    <xmx:j6wgaj8rhuYKdbzcKrlbxTufBmKA3U4hlMbkfooiP3ouBpn-q_uqaA>
    <xmx:j6wgatHbLI7DuIOYN7dTz1Uon6WYaWOWgpkxHY-CeyWrb-Ct5mNpZA>
    <xmx:kKwgaqyi1MXIwgO8A0PEFtS_kGu84QIGJw7sGD-lMUptZ5vw_ZZIMEew>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:37:02 -0400 (EDT)
Date: Wed, 3 Jun 2026 16:37:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v18 2/4] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260603163701.2d96ddcd@shazbot.org>
In-Reply-To: <20260603182415.2324-3-alifm@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-3-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 11:24:13 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..3eead86a00ab 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
> + * involves platform firmware and notification to operating systems is done
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows it to take appropriate actions to handle an
> + * error on the device. The ioctl returns -ENOMSG if there are no pending
> + * PCI errors.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u32 feature_flags;		/* Indicate future features */
> +	__u32 reserved1;
> +	__u32 fh;			/* function handle */
> +	__u32 fid;			/* function id */
> +	__u32 ett		:  4;	/* expected table type */
> +	__u32 mvn		: 12;	/* MSI vector number */
> +	__u32 dmaas		:  8;	/* DMA address space */
> +	__u32 reserved2		:  6;
> +	__u32 q			:  1;	/* event qualifier */
> +	__u32 rw		:  1;	/* read/write */

There's a 4-byte hole here.

> +	__u64 faddr;			/* failing address */
> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13

Based on the discussion with Omar and FMB reporting, I don't suppose
this could also be copied to a user buffer as opaque data with size
reported elsewhere, could it?  Thanks,

Alex
