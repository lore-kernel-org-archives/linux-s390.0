Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B837474F;
	Tue, 17 Feb 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355489; cv=none; b=cYnsw67ZieRnH5H5xHTKQcmaACU0QvlXACDQF5bkhBfUcIDO26+c8RH4newelrYwZ5KlBr/hYSNUHoZHS1qRIMdc9XkdY4bgFv9Hq4QvYmdKQnMdoGs4rHP+I1IrePcEL6mkEfmalXDvlo52y2np1iTK+9mF3+Yz8tCvcrg7ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355489; c=relaxed/simple;
	bh=zqC/qwgJG8RYHRP2WndZeH/vSnyshZAupGGIjnFrL/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBPnkjL46u1xiqATcjctUaza/JjtfBE+FB5XfoVy1Oe1SNabnWv55c6xD93Cua/FBUIc7fN9CmjnSGd+lMrwRSikgLOetTrEWKZfZn1/lwK4EAXV6D3GvdfdN3H93dWhsQK4ITtcvAROGrqDJSrz6IWTGAbxjnvWW71cewoQJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgyUiOyd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgyUiOyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4363C4CEF7;
	Tue, 17 Feb 2026 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355489;
	bh=zqC/qwgJG8RYHRP2WndZeH/vSnyshZAupGGIjnFrL/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgyUiOydhHH5iZKZUjdpTpxOoqtylAKCnbEv7PCfr3vVxKd2O6yGvumIIgvQVa2LN
	 7xBcmaSQl1fOD00Ny1A6Q+FJx+2ENdSWk32swoqKRvck75Kcp4OiQmDh/qVhutl8FY
	 +uUWNVymuPxGkH1kWrUo6QR6nUBhRgf7UJFBnjD0+M8ZfFjffcyuoXtywWSG0TaWk2
	 XfAO/MSPai77of6FqV5OZxcdihIq+3txgCO0vXm+cy/S07CvKer7ixIenxkaw1U9rq
	 QnQ2ZEunOZq3nVH/Vq//J8HpxTaJwS5KPwybK0zwM4TOR0UoRnK92BOSf/aePlnO38
	 +zs5yx4wcUMoA==
Date: Tue, 17 Feb 2026 12:11:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
	alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Message-ID: <aZS9X_CQBuo7gQpC@kbusch-mbp>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-4-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217182257.1582-4-alifm@linux.ibm.com>

On Tue, Feb 17, 2026 at 10:22:51AM -0800, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However errors may occur unexpectedly and
> it may then be impossible to save config space because the device may be
> inaccessible (e.g. DPC) or config space may be corrupted. This results in
> saving corrupted values that get written back to the device during state
> restoration.
> 
> Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times"),
> we now save the state of device at enumeration. On every restore we should
> either use the enumeration saved state or driver's intentional saved state,
> never a state saved at the unpredictable time of an error recovery reset.

The vfio driver calls pci_try_reset_function after pci_enable_device,
but before calling pci_store_saved_state. Won't this change, then, mean
that the PCI Command register will get restored to the wrong state with
the resources disabled?
