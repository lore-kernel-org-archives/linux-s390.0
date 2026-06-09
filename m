Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B62DB780;
	Tue,  9 Jun 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045533; cv=none; b=dX1VH2Y8jXK3OzTq6ab0s4YODOj0k2E+lxBpVqI9z129FpRHh9WpiHhRxkxvQcSd2kPcr8W3sWsUY5f1YRaJjP8cxjXUUTKz1Ds13xzacbZKehjWoboQeRTHi5pz3gIwjYFVt6A74R3tW2F1GWw1rp4BhfqZPeiwIIlpytImoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045533; c=relaxed/simple;
	bh=HUO5gewQY56DcrHd/3O1jNTbXwmLRjToFmR7FSXztQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtqThtzJfWfIVyqL3hfWCkAHH5ipJQ/U5OmbuuuBiR3ZgeVLsCufGXYKzjPg8gCPRlOzmoMhy6E0Dt4BZmmHumJApBT7bE90tojBD5Vx6u5iQvhxIdcyiiqgHW/M2fol37OSQYMRks7ymkI+V8+mxGsHFyA2OEdCC3ZNw1OFXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KvnQBF3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Na5CE7Jp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KvnQBF3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Na5CE7Jp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BB68EC0250;
	Tue,  9 Jun 2026 18:52:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 18:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781045530;
	 x=1781131930; bh=lezGPWteDB0DSQHVYhM8yGY37uLx4xqrDLgchSMVn14=; b=
	KvnQBF3DQAmgo6HhJT+USdWTD0G3nmrmQ5EvloWnVkHr7T/nBLDtDLmuL1oxed4Q
	CsdmStnUPu3blR2tFeiGdQvr0aIj3CzlAEkIcL/yhglWWWd8gVGVVCqLnJbSeOox
	IyuOJqDxG9lMzcRlkEQdylFokzicIX2YwBA73a4JzEk03/fPbAJa8jkG6egCAP7J
	P5D+0oIpx1w/iF84tSg6WsxkVBm0VRMTbf6FYTaPMny7lewvvgxmlJo5tMw2YU/A
	CCs6pcywXJNYDAaj/5ugGfiRXgb3Q6pyDqf6iCm+/xTK2wZ6yrR1gKtfTrljVG9B
	/bH41FfdgbTPuJHZ9oMftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781045530; x=
	1781131930; bh=lezGPWteDB0DSQHVYhM8yGY37uLx4xqrDLgchSMVn14=; b=N
	a5CE7Jp5LLIYj4+pL/49L9ZHqKXvR6264/l3qs9VaJ61LqafA9Oj6dcZnZRzSmUz
	Gnsyv9slZmFVlkE5JhY81ekgMldJ4Zjr36mqx5kBXPwcOmAJE4a64HqqkvLpLdaR
	AwKK189JMp2BafYpz7HUwUyduAlvrLyKHmLyBwEhdIFHGx92utTToNkdgdRR8GDn
	lneGvgu39nNUsIcvwI6w9oBnCySz2bDyl+jVa5PaZtXdqF2eMyjwYdc1UJUe3P+c
	q1svn1BNmeS6KT51urM0o5d11UVUf2BryyBuVZVBONZBxks9HeG3FXPP+UGyyHtv
	i45UXoe4QuWzcVJdm/mHg==
X-ME-Sender: <xms:GpkoalXnklTi6tTu9osOibNjV52LN_qMxlNYCpkVQtuOSUcE8P2V6A>
    <xme:Gpkoam902Vg9z8KiQZ07_z7axRagimrrWt5eO7WxKiGot3LOOmnU_EvQ2VvJGxKKZ
    2Lm2yHYMK-Ud42osaSWdmaChbc6MvAgeAAzFSlLOqTfHwEWz0OOYw>
X-ME-Received: <xmr:GpkoaqoMPWdoobIPFP0D8Ja4ERKvgMG8-xgHd4u4nLbIlaYFBaUCx6bXnMY>
X-ME-Proxy-Cause: dmFkZTEg+FRBWAghamkv24UmR7XBFwWi37MFXO6tXDG7ahev0BiGoFxZaOdYPRtnFrcYRE
    ykhxcNddB4ZUXPGqAU4c9NF6m4j/1U/5457M8bbDjPUoIJLMuMUGbVbB4HlgGxJ5kSmRB7
    7cANlkYilYA+yRTGNvPxsSpTF/tdUzR6d9pz+QoR99mkLBDGlzGf2QhAMNy78vk8VYvHUi
    TVO+U/mq+9cLEasKPwdIpAq7j2qr+Dk/+1bvFemEVjHebcpqsH8UR47G3TDJnf+psm5owg
    y4M5ARmMPw9luIpmqEYcsGHY6DfZgQ6kMRHcKYUrsdtBUxzeGc0zO0dpQw+T0tSZbgLLE8
    qXcC3ZWWC4El4srAFWKb1bNuOm4QPOG3uQ0sPvBzfxBh4oRY/Uc6nH8MfnZFZvaPdxtvVH
    hQlh/sG4P6v8Cu14CY56sfaP8C/SML7BnS4qhOcj4rHve+K9+yUBl4G5T+PXFUmkELxWjX
    mo5pJzztTbQTDH0NDsUNB/2pFUZaBK6te/kWX/YpVTwfLJoa264c9/VpiALYccMr76xofW
    q0+d7HtFZOY8IEbshQvuJM7A/KGatWhtSyTMn3wzKB9XveFnD7Lq9HrYD7glrn6rZYWSSd
    /jOWoHCQYqCDmCa8mwLv1GLWwnhMupCIJghrW9jc9V7k2qKftJBOMJMW2u+w
X-ME-Proxy: <xmx:GpkoagnXDetoFZSFhe6BsmY8TY28Lwj7NzmhUB9vC9w3Ctmvj1rbNg>
    <xmx:GpkoamauCKQSSRPNWqvySEbofCTugOlnR4YzykIsBsbb0YE8hxun6g>
    <xmx:GpkoagVDTfNzAZxlU4o5hJFJfVZywYbeLfLDLu1wgieHdnO3_3NK0A>
    <xmx:GpkoamBZp9I0e09scqNSiZEiiJXvpiWMhKulQ_lrFh_45WNUobaYoA>
    <xmx:GpkoaiVKLGeSnCk_9aaYB15HwSZqex7LnhUBdJN0PY4sYoimGJbxI3N3>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 18:52:09 -0400 (EDT)
Date: Tue, 9 Jun 2026 16:52:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v3 4/4] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
Message-ID: <20260609165208.6aba1731@shazbot.org>
In-Reply-To: <20260608171850.62829-5-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
	<20260608171850.62829-5-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 13:18:50 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> Introduce a fence over enabling or disabling FMB via sysfs when the zPCI
> device is associated with a KVM. This will allow a KVM guest to use FMB
> passthrough and avoid the edge-case where the host disables FMB while the
> guest is still using it, which may cause partial counter resets and
> inconsistent reads which have no parallel in the architecture.
> 
> With this patch, the userspace driver, likely QEMU, is still able to enable
> or disable the FMB using the VFIO device feature introduced in the previous
> patch, effectively securing what is associated with the VM state and
> isolating it from other processes on the host.
> 
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
> 
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_debug.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..a2dc79418c21 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>  	if (!zdev)
>  		return 0;
>  
> +	mutex_lock(&zdev->kzdev_lock);
> +	if (zdev->kzdev) {
> +		rc = -EPERM;
> +		goto out_unlock_kzdev;
> +	}
> +
>  	rc = kstrtoul_from_user(ubuf, count, 10, &val);
>  	if (rc)
> -		return rc;
> +		goto out_unlock_kzdev;
>  
>  	mutex_lock(&zdev->fmb_lock);
>  	switch (val) {
> @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>  		break;
>  	}
>  	mutex_unlock(&zdev->fmb_lock);
> +
> +out_unlock_kzdev:
> +	mutex_unlock(&zdev->kzdev_lock);
>  	return rc ? rc : count;
>  }
>  

Why not also use a guard for the mutex here and avoid the goto
unlock... also moving the guard below the kstrtoul_from_user()?

The fmb_lock could switch to a guard too, but that's existing.
Thanks,

Alex
