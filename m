Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8F347BD4;
	Tue,  6 Oct 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303747; cv=none; b=IPuZsmhuYxpdi9QLo6Im8ftlN/DJDzdRcvOge6mZnEpeCFyoGXhV2g3XVTHSCXed1nDx/fZY+rzaoMraQFH64Ry+/YFHAnbeHjWA5q8OVWBflvIxQpYlO9g5gOml/WnyTC6FUM5+oEYLdgYki6PRARZBAcxvuU+hATSHY6X2umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303747; c=relaxed/simple;
	bh=zvIdI0cKgIowBzsS7w5iX312awX3wNOmdqCjqdVtCPU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LwWe34xGZgS+6k2tHALevEPE8PyJn/jhkLGklysWCGet+8MNh2Sqdt8D06SkBvYphNltHtmOu9y3RuLymNEvDixse/7+epArC/BpVdHMMQT6dn/OLadrYpoSO11U3PCpNx/TFp4ylR4W08BIsZ0hR6nlmPedTdmdchC1MP8ypcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCIPTi8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCIPTi8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CA21F0089B;
	Tue,  6 Oct 2026 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303745;
	bh=+Yp0iPesSmWXN7H3HfFUAnUduF2FKo1o9qLqZwO/JgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCIPTi8aHLK+IHfmA+635fVNRbQhQU1clLjAbPc0X/V72ewRM8jsCHdo6MiTcsxWu
	 tyPtN4yR3+DQ111iHhUc5Rz8QefW66QuKP2SrWfS5TIvBQWaiTPi4oXk0ccQn05TKT
	 1AjwoT17OQQWC/75+NeVGCU2fOR/XHQ44KJFNcLEIti/dodRR1oVZRkI+HYZyfGQeW
	 qn0nqZvjjNY4oIb2xzMOW+RMaIXdEdsK+uupQ8iDvXuIXI6FC6FJnA9tep4VZdh4Dc
	 xQjtHAKyf7NBwabWQSHEGikJ9q6Tsm7Qs29nIdudKHehWofL+AW98lb4GwLZV/nbAe
	 se4b3Jbo+I+dg==
Message-ID: <sashiko-outbox-162246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261005154557.57801-2-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
 <20261005154557.57801-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:22:25 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci/s390: Race between pcibios_disable_device() and debugfs writ=
e leaves FMB enabled
--

commit 6846c80d4f9b53691af0a39418f819b11bc5390b
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Hold fmb_lock when enabling or disabling PCI devices

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index d64c544b32b0c..c055a9ad09724 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> @@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_disable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }

[Severity: Medium]
Does this create a race condition with debugfs writes?

Releasing fmb_lock before calling zpci_debug_exit_device() creates a window
where a blocked debugfs writer to the statistics file via pci_perf_seq_writ=
e()
can wake up, acquire the lock, and re-enable the Function Measurement Block
(FMB).

zpci_debug_exit_device() will then wait for the writer to finish and tear d=
own
the debugfs files, leaving the device disabled but with FMB actively running
in hardware.

Should zpci_debug_exit_device() be called before acquiring fmb_lock to drain
active accesses and prevent new ones?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005154557.5780=
1-1-oelghoul@linux.ibm.com?part=3D1
