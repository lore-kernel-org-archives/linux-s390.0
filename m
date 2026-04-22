Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AE26461F
	for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2026 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833094; cv=none; b=uOgxH+rklZinICLMe3gpF60rBL4NrcW28GNIiaq2rxFZjbZ3AeSuaxYI/AY19UY8rLr605x2Di/2FHtKP2xczEWtKQ14AxUYblPYXtlY3ddZXeiB9v7XMmD83xGW7v8ZZnkL/OUOGc9Efm2S0lT3T7Dqc+Z1e2RfiHFysUamd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833094; c=relaxed/simple;
	bh=oOwDGIKkQYinZ6cEzj7x1hi+TEyEe7g2fiXeqCNMaws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLXaUHsqksgpvT48Lvi5hP2/4pNf+ohd7PFmQBhCSe+3IgH/tUS4PwMNHBvQgFBV7zetVm/+pXYyZGxu/3Ma93ZZRsbaAA71owzCfWDBrstC/G+XevkSIt6M9jhJ4+kALbrgGnBAxHUDfkZXhCknujUnTxYFjCo0QipNnAasANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2080106b3a.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 21:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776833092; x=1777437892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhIDpGgSMmQPWhVlMLk1NWm+UmS94pEyHKaTl2QDpX0=;
        b=rc5RnWUqTBahyGuEMwvtn7RF6cmymCFbc+Z93DP4hm9ual0K2HnTGKrTBc693OL4KC
         LMUQmy8GoVwW1zL2eD/gB+XCl6cbMnYKcEox9GmIGcJWOGwdBcmeGgOv+0uaFuhZtFIO
         QlL7f0zAIAIRh7EDTkVm+JNOMc0O0WDDa7m8c5hHUIEbrQT/oDZgw7yts70WjYD5GTDW
         98YN+MxYwk71S5F6xXFQ5S5mxXahPzKapwLugeGZVXts5ewpOxL3yJkzmE2dgSdCq1Zq
         dW2sSuvf5/JYW4YlIytW4xIrgR2sk1S1LkKAsOieLtLVrR7i7/mEXZ7Xvvxj0SLxBlKb
         6u9w==
X-Forwarded-Encrypted: i=1; AFNElJ+Srm/EyIOGHFzGu83LWCSlcFM52a2o+br2g5eJCW+eUEEdaL15NwbGke6pWQdSduCa/5LFcN3LiV1s@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVf/vxVpcSaUtvXMfOAgoZXbCtiiow949x9Ec9WZoFtC8rJXc
	vgnd6D6kh+/jiES2lK49uuvnPueinDBP4vYK2eW+9bAwImIX/dBcumJh
X-Gm-Gg: AeBDies078GZwkAnVltVdvz7zV/RhrIoaJGg0QvUjS5OI37a6nB38nJ3TmkXUPsI4oX
	9QgxOo0zMK+XSQpkGbNQ2pK46oH9WLgiIrtzlhNvrmLejrZqQKyWQakYltrlCLP/jVsG/z84enG
	QyzJEojwiGrLxvD0V9dR+INzEusR9hETtsYJQ2463uCK+vP9Q3tyRSmDttJqfKTKJimu3Z+0q+7
	8uaNEkWwww4fo05CdK6kcKXSSMcdfhigk2HIYGp9DPpdJyGVpBruDzFQkOtiB2iE+5i66wsqn2p
	uOnTdGD03EX4GGsLyBY7glRTXQn9hWQiqg8ORW5QXTfMClj1fphiDSw7Gm3Htu1sZMTzmpBAZDs
	OLlYjOFeGtlBFxVh/lgT6RHQKaThSg3IsjQBovpWhFJlUXXFgWkLmeUwFv+toaKuowt5rmilLfv
	z4arjVwcIfHv1IryIP7QjMY43x4Z3QchFN3wN79xwWmBfdkoSG1xb/AjP6mOh57BASgV79qFzG6
	Y+JPMFKC/zc5XS56wdH+u7bRKlWEkqhS0IULULLmgBVcHlevibz/NR1Y3jltcC2+cOSZSyNjAl6
	7ny2n2SNfyW241hvbzvj6/SNTWwKwAVeHpri/xCLww==
X-Received: by 2002:a05:6a00:17a0:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-82f8c8c8c5cmr22933258b3a.25.1776833092489;
        Tue, 21 Apr 2026 21:44:52 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d2f9asm16487176b3a.19.2026.04.21.21.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 21:44:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:44:50 +0900
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
Message-ID: <20260422044450.GA2544787@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <20260421171334.GA1684602@rocinante>
 <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>

Hello,

> > > +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> > > +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> > > +	.show = NULL,
> > > +	.store = uevent_write_file
> > > +};
> > I think, you could use the __ATTR_WO() macro here.
> Use of the suggested macro is not appropriate

Just to expand on the "not appropriate" bit here.

Not wanting to change the name to have the _store suffix would be fine.

The __ATTR() would work here.  But, this file is old and wanting to
keep the style aligned with rest of it would be fine, too.

So, both of these reasons would be fine, to avoid using any new macro.

Thank you!

	Krzysztof
