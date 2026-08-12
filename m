Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616F412C15;
	Wed, 12 Aug 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574103; cv=none; b=fRzThYJW17dyCgyFgnaSH3GJLIfLawDUxM0L+vLqmgtF7v8XAuesHBJ15uev1Yy5wwnxxxSycKwkiMuaraiSE2TYCx0GF7Unpf1tER04Dja+Z1Llg3pZXx6xmQ2ynZkukvBbRqmpQxPfPUx7uum+KSuVcgQp1tNpTtkC0Qdju2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574103; c=relaxed/simple;
	bh=HawDJjfZYPOEoVp49HtELDZ3DOAIf+dVEtv+NEH+hvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c4pbOV1H7RkUSYuDOtf/N7R8lPK5E8saiA94hI7Qierfk4MjOUzEAUtTLbvqAMMAWIENFuc+dSbTzlRqJffyoR2yqrhHMDkXfWqF8nm5Ui4bGCmdxreKQa+JMV/khPGaIqPL3qt1ej1h98nYFiSpolioZclXiSvS7eV8YAcEd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doBtZmeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doBtZmeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120801F000E9;
	Wed, 12 Aug 2026 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574101;
	bh=snB3+pe2j1lrjcEzXc3rQBnE8VLnoHqGgbpbnih9SBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=doBtZmePt6FrJerNi0PwUBqJFXOp3VptlFWBQugw3LfAnej109IH8rPMLI8DlId74
	 10KABuxiu8XY/m2MS0+kKCQry9Iif56th1B0tWcsTUOTlYZYg95IqDwjka6Tkb8nMj
	 m/BEKcP+OIN9h4JkaDnZXpUktmE+sA5IJquGjGH9KLLExKSAIE/Q7RXFIbJa0kMl2K
	 SyNF/Fim8d3uZAvRVAvVALtz1oKHAz1CJF5kx9h+yCgZXn16ZRNEICFDmmqBBAuqOW
	 5oOdL/aAfYc+WIo7qVbjeE0UyqQgXvugqoAZYYWmsskSbtVeeiMhBFp+plytn4r+aW
	 2Rrz3eYVQBhtg==
Date: Wed, 12 Aug 2026 17:34:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH v23 4/5] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260812223459.GA1087632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805165518.794-5-alifm@linux.ibm.com>

On Wed, Aug 05, 2026 at 09:55:17AM -0700, Farhan Ali wrote:
> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
> 
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e8d7de77241a..9a9d021301c4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
>  {
>  	int ret;
>  
> +	if (!pci_dev_config_accessible(dev, "FLR"))
> +		return -ENOTTY;

I'm not really keen on this racy check to begin with (though I know I
acked it earlier :)), and also a little hesitant about doing it only
here and not in a more generic place, since several of the reset
methods are susceptible to the same issue.

But I guess in your use case, FLR is the typical method used and maybe
we can worry about the others later.

>  	if (!pci_wait_for_pending_transaction(dev))
>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>  
> -- 
> 2.43.0
> 
