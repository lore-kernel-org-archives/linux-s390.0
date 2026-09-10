Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD43471410;
	Thu, 10 Sep 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039192; cv=none; b=jTDa66VmSVDwsENCC+/BSR0gJJQfiFRBPUMEcZ9dPbITGY4NPOjokRECbzT4TuXmAkToj6hUy+yoXN/Nqihk/TwXZTUIisL5tWtc7DeRQ4+BAk/Z876EJbBfFV88eWbs94hUTxn5t7QgNX5kPS4BSkhVHQac10vi3PrLMZnb9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039192; c=relaxed/simple;
	bh=jxu3v2QFCV9IUGoG0j9/Ea4s4XZ7IxfpGzHOthAj5q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCDVOz67QTy/TTvmjdp9IjooK4EF6OdVpf2BHnsdsXCZVaRvHgls09X+8e/zbJYS2aDle7OjKETVEHyPRCAsHJi7VM/fEdoHpigIsY63lqMCG8s4rgqIVTShdN+xD0jMSvFIXrM7cC1IpSdVoteSLck4C+jRbFAJR4IAkOY+3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoIY3w2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoIY3w2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159A51F000FF;
	Thu, 10 Sep 2026 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039189;
	bh=1ApEXUcpJ89jR6HctP+NREZMTq8XUQ1GJdVxfzj0gJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LoIY3w2Q2hnK2Z+LPSbGyj6isJCHWNGVG133iPvY+T+HZH3ou+n9NL5rR/NohPagI
	 8Xf5x9ee5hlI4mr/XISAK6NUN1i0UQHN60oaQxNHD1w2sTwAM1u6zjBQ9LFQXYY8Ae
	 Z5WZgBT5UASo53e7QI0dXJWoIY90gRuGBvQJcFQA+eYspmeMi3JqQkUxntN7q0NyR4
	 X/joJ6ALDVqVkSzGJuzoeKGH6tH5KPlPOKyiA+I4KyUx1dOiOOqc3ULC/5w8tE7q8W
	 DKlgJ5CGuVn1jrtaj5b0WXQOokWSEoSO+YUFft/uzY2m/oaylpnosowt+s7m/NS0Lf
	 9DvOhsNe+rfcQ==
Date: Thu, 10 Sep 2026 13:19:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Leon Romanovsky <leon@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v6 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <4kgsoygussviswxzlw6xeppexugrzigmjexpddqvlhg5ebokyv@n6q2fkz4orlz>
References: <20260807180127.62471-1-ramesh@linux.ibm.com>
 <20260807180127.62471-2-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807180127.62471-2-ramesh@linux.ibm.com>

On Fri, Aug 07, 2026 at 01:01:27PM -0500, Ramesh Errabolu wrote:
> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
> 
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
> 
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
> 
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
