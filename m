Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8834C124;
	Mon, 22 Jun 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159728; cv=none; b=NB0Y/vKgUYIBN8hBgU3ta4dg+ZhQiNy/cHGntlrUvbH7vuefoeDQefICYRUUEY0YfjSIy58a8jimadl4QxlPipkUQzaSJSeutWYhxzTPHUIou2Y7ZtU4spg8NvebzUMucQ73j2QUGvVZQIZYGLZXwMQITEZAkmVxmICRC8A0dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159728; c=relaxed/simple;
	bh=GCtFmULYKD+9Z9hI01xWB9UebakyDEtYKrIqL1Jwccc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWylNH4WVBcUqO6UUd8rj0q7JSoHAyZ8VwIQEnnSPYXLDk7jzLxPL26dBqIrRsaAjGZwEO+noJkowFs7HAlqkvbjsKcS+bmfSuJ37tJsJm7iC6IjXDprQiiWHZgkuOy8n1KTwaKNg3WA6hK+LdWNXQtHLUvfVgIR4tb0bGrddu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RUZBDhtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZ04eb/K; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RUZBDhtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZ04eb/K"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 96C661D000B1;
	Mon, 22 Jun 2026 16:22:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 16:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782159724;
	 x=1782246124; bh=LIf5z7g2KV9aVvttux5XpB4RFQEvR4VVA2wKQKW6sPs=; b=
	RUZBDhtWuOEdvNmYB8wlp51s/poF9VGsVcvxAnSXgBie/6sKS+80kXLIW3e7WBKF
	7t4f6DbayddZeKy+ygAF7WkxGwWBeDIlgcytjR8TPcSInyo/lI01BkthqUJQk5bl
	Mk192dVOa7F4lFoQpN3vKe5StMk9o9gKxSOzqo1KUi1w/vTem9u6gyzYuxJiUsEk
	ZEZ6mtEmgPHAgEbWHxt6uZgYmzvYxSXt7eib8n2Yd++2e4iZABcZdcePOd4PBRRf
	E3tV9OyleF6B6UoIN0KXR1Ve/RaF2QzUQtOlnOcPOk00Ul2XRFeX3jTsVWiKcghn
	4a2az4DvapAVzYT0s7jImA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782159724; x=
	1782246124; bh=LIf5z7g2KV9aVvttux5XpB4RFQEvR4VVA2wKQKW6sPs=; b=G
	Z04eb/Khpm61E6gLkL7zqQSf4ebrgB3LXYbiXYPt1w5EnC/xCT1ecUUdLQfrI045
	kiJCAccahM6aAYxAHUOejIaxTAEWUf78BNZJg3J8quXO+IRllBdQMtlk+ZS/5X9R
	Y22DjjzgXo+IBVHr7s5/teQCOo894q+ZqqcRhHOhpN7WwT4eAd5ALtvPX2Tw4/gQ
	/ffoRMgrkOxDlmuuk1evBMPjCx2x9k+CPn4PVH+Th2lwlMKkQsu/81kxKmkuh3ke
	cfNvYD9+h7ycW0vEdk9vYCU87/leLALTaMS6J+fI38Dc6Xj+qesrjkqs0J2t1SGu
	aauPKAvn6H3cBHXXXuckw==
X-ME-Sender: <xms:bJk5agDPgxy-VFsICb6zYZNXUm3fb6-ym3S57pUQ_qNIVi_Sd4QovQ>
    <xme:bJk5aj66M8Yf0dTYbyndsRlZNwS26sjMXrS0Yg7YSWSN2CyiBDSMRx475JfNwr7TU
    ws70aYfkFNwMlanDLpVkcmzmZJdoSPF2OauslgQVG4Jyr_2YBJobOM>
X-ME-Received: <xmr:bJk5as2_OO7U7_vjo2s53RBVBsIU7VPBLVUkx3KgSFhawYWl3xIrOj9LqhA>
X-ME-Proxy-Cause: dmFkZTEvD4og5o6Q/2uXbEmE1nBFPBKJTA5Vek8OJ1OCZ2549yLD4EDpRTX17EICqdpXAa
    6NJsuZVVJGjLOXuIQJtetqO71elTaSKXXc459GUN1ivE6n/MkylPAPsp4c4EkzsjrgUqpb
    m6uCU1c7Evnwem73o5cIgqoQ1tffvIwRTBzMagcbpwrasiS4YlcSP4o23sJX0atgXInbH7
    +7Aid3FNCcDfjVIwyAS7grhiB7aOp0XUMN1WJG7dJvWK4CIh7UYSKBnIWsHOKWg4eXNcSz
    rtdh4BpsBFszDc2oXK3Q4Nwxe9UKUBkB48TpEnkKO5mDAbp3I0Gazi3JkwlpNknKBSPuVT
    9jxMyMEq8C9faHhzWZT8A2lFo0lo9zdCLvNLMjS9Hbh61nXUA9jG0q0ztWpYhauJrODkYN
    I3n3JcZsipvMFX+LV/2/LUIGroGMIWouceISt5VvDGRzJoKAXFKwNhRy8DsRc/gC8KuYt4
    LNYhQyXHvPMRrf/9vivbWy+/0JtEq956z8srHpFwNkl21ibX3jLqfMRt8Oy3zEeI95dKC0
    IvJmkq6xEanyQ9J0eIHUlSB9nG2HGBwqtx/A+Ho2PxiGQqB2YgEpMR+3U0c0Mx4VW5TMYI
    +6pAaJPG2KeMxlN9oKIqslHNeiRgwjYRtMADrMGlr+GitgIWgN/izEsb5QOw
X-ME-Proxy: <xmx:bJk5avCObgV5shioFmIGDOXA_mFhHGW6csKw71dwmBL5TxwHhxDAkw>
    <xmx:bJk5asGFZJ_SFG-n5glqoTHmfP61YTVVbqVozBMrIYQP8sE1YiGfug>
    <xmx:bJk5asS2x-6An5y8A-MivoOl7P2YpE8ohRsoIPrn9KfIqNfNtYQhtg>
    <xmx:bJk5arM73D8gAJLIOnpHFj9BvB8tgnpYv7kOAcmq2MrKf3oLFfn8cg>
    <xmx:bJk5augikNhnWlaflzxZMEhkULQJv6BvskOz1PhxCSliSa1XhXqKZMGr>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 16:22:02 -0400 (EDT)
Date: Mon, 22 Jun 2026 14:22:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v4 2/4] s390/pci: Preserve FMB state in device
 re-enablement
Message-ID: <20260622142201.3d5da194@shazbot.org>
In-Reply-To: <20260612181048.91548-3-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
	<20260612181048.91548-3-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 14:10:46 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib = {0};
> +	u8 cc, status;
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd = zdev->gisa;
> +	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
> +	 * because we are re-enabling function measurement for the same function
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> +
> +	rc = zpci_fmb_do_enable(zdev);
> +	if (rc) {
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb = NULL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);

Why is this exported?  Maybe this is leftover from the previous version
where it was noted that the API claimed a failure on double enable that
didn't actually occur because if used reenable.  Now we seem to have
the alternate inconsistency, that FMB is automatically enabled as part
of the standard PCI enable path, so the only initial operation
available to userspace is to first disable FMB, which is an awkward
API.  The v3 problem could have been solved in documentation, noting
that a nested enable resets counters[1], while a nested disable
generates an errno.  Thanks,

Alex

[1] Also note the sashiko question whether reenable actually zeros the
current fmb buffer or only the internal counters
https://sashiko.dev/#/message/20260612182632.E4EE71F000E9%40smtp.kernel.org
