Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0430DEDC
	for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877996; cv=none; b=GZ9Ueb3iGBiZtPwFXprrpt89wSI3ncpy5EdjDK/h1vl7SW7mC24aU9uqGfdOjJrL2nxmaNIi8D+9MzW5H6w/lod+St3pRvjRdFcXTCTw1gkWz5bdT2w5EUJkv5vvXqT+mP0ECA9LkCYs+Ay/mqkB9bzxaTJrJRrIc2KQjzReEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877996; c=relaxed/simple;
	bh=52ACKqtJPNU8J7IzyA8jZwWgrUe0P6rodTQxUqKSM14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of0Q5SLwA/gIqijjlsqG6DjAntsNt8EpafG8EsFUseWy80JHu5sI5awBWyPN6bF5a4waj33cCNnePETeJS00bYZX8gfjFHRYynDA4GlUsE2kasBoS6Yqs/xI2g/tCwHpvEQvNykQUTfNGsVlYHkSx15lTkUnfodvJc9bJnQb0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so5171500a91.1
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2026 10:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877994; x=1777482794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7OLq8sGj5BrTnHpABdVqreRTaKZmGbdWyjjPj4eOAQ=;
        b=mem1U1dHCbBE9fvLM2SSZ77pVGE3W0jyBXwZyQkellffgkuzNZiEGYAEiDmm8dSYsS
         BhsChlSF+08G7FGV2GU+M6p3keC0/ueLlEWy8ATM5q2ElFSr+fQ5JnOjyYNWCj0OzH2u
         rhz7XLizVHkmMziPJEClT/Jrr5PoM5MD90d/1O7aM83SCk/06Znt2qh1AsP87vqCftPy
         4aTLMOaRr3exUwt1LEid7RbTdqfz+wiMWqqiH+/VIrsOvGFrPWTUqCKtc5n9iQYjSJhh
         lstMiRdhDMrMZxbSC6F0sfTs3dSN0s5M1MF2jpmaop+/5YNRyMagEtqBqEkXS9Qyjt4s
         fiqw==
X-Forwarded-Encrypted: i=1; AFNElJ+NuAOcSuvWbMGnP3Ie0+oFN3tdS7Flkoc06EcpvQSauJUv+MyIsCHCExrCmtUlkugyk3R6FOzb8zmC@vger.kernel.org
X-Gm-Message-State: AOJu0YxAah+D/9zXMuv0l/7IaC+SyXAwgxXBYdnbnKYrWW35s4R5/Sq+
	cc1zYK4NkpgFITV8B+Mb5a2hto6Em8c+ObFGXsZpFUZw9kwJ0Zl1xX7S
X-Gm-Gg: AeBDiesn7TI6+R3k3jRnnpXTPS1XEWbLdT1RZRSz5/JkqHboDBLrdFIKIOfUf+devmt
	CVjgHw74HovbpX/eBgQUrj3bRaoEdVMP4ji3wlzxf52LxTZG4+LHEFM5wdNL+irooF3Ruf5tMBA
	yc/U/GW9glq+NbFuL9py8fh6Rxtlk973l7LhdHWPeSOca9HzPyJRUsg7cjwGchVkb6KZhWpAMus
	dHgDPp5YfyKXRMxx8AYuixXf2qJQOwmThyYGt1tCkPo86WR1d1npQOCGc/jP5svlK3dqjFw3G45
	Z4qCpMuVA3tjpxZagKxzUfT13achD/8uWju/LRW40Y9m/waG6D0gnZT/MenwTU0rsKD1uJ+74nQ
	A09HoFqObJ8UWKh1pDHqFKfyNUhcDjKyAVK12A29dlA7y0Fqj4jQMzZg9/4vnVLBicMxVXJ/zpH
	QJn2XSnI2YvaC4p0f/WwInC08p2/xva3uOF7rlLRAAZn29lspXFriVNRXKuxA9PAbvAloMG8Gkg
	xGYGcCi3Ts0kIdw3UceNQE7gdX8kwOXccXn87C284RVc9ya/IDjWX3Nhdi01+3cfXPJ+Y6UJHbg
	Xo6zQiYQ3LQgSdtaI7qS/petcl/qHh/Yi1cZD9KDjQ==
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-361403b18c9mr24815197a91.3.1776877994335;
        Wed, 22 Apr 2026 10:13:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797704b575sm13710354a12.29.2026.04.22.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:13:13 -0700 (PDT)
Date: Thu, 23 Apr 2026 02:13:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <20260422171312.GA410657@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <20260421171334.GA1684602@rocinante>
 <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>
 <20260422044450.GA2544787@rocinante>
 <742b8820-4bfe-40ef-85a9-5704af038ee1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742b8820-4bfe-40ef-85a9-5704af038ee1@linux.ibm.com>

Hello,

> > > > > +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> > > > > +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> > > > > +	.show = NULL,
> > > > > +	.store = uevent_write_file
> > > > > +};
> > > > I think, you could use the __ATTR_WO() macro here.
> > > Use of the suggested macro is not appropriate
> > Just to expand on the "not appropriate" bit here.
> > 
> > Not wanting to change the name to have the _store suffix would be fine.
> > 
> > The __ATTR() would work here.  But, this file is old and wanting to
> > keep the style aligned with rest of it would be fine, too.
> > 
> > So, both of these reasons would be fine, to avoid using any new macro.
[...]
> 
> Hello Krzysztof, let me first apologize to you in the way I said it. I
> should have elaborated the reasoning the way you did. I am open to making
> the changing if anyone else feels it is a better way.

Oh, no worries.  No hard feelings. :)

I just wanted to add a little bit more details for posterity. 

Thank you!

	Krzysztof
