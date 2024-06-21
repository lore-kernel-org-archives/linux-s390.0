Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CB166317
	for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001055; cv=none; b=mQ6KYGnTpwvnTX5ukcRGZEryHD1xr3iYw4x3/FH/IrIYWlsnQ17nTMra2Yt6bOQdQyUAzNv5TkaePEChoGRfzpWStjcQ1RyrwgSs+Rn+NBbDVPT6bpD8EQwMr68ba25HII0fNMQKEgVYQeGk/bifkKXNyPFo5va9Rb9R1sDAO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001055; c=relaxed/simple;
	bh=1e30kVLyzFq1PU3An6ylOGV4PAe55sJot7fsu6AUC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFtXwLzAEdyRPvzGXHqTuUCaJex1ya17F+lkyR3yoaBWl6UaCEuwmoQX6PHLfLgR6u4r6TJM7WqmA9/h7tH4Cv6Djp5mp7sMI2nByHmpDT727Apw7TI5FvN5byXwYnIlH2D8OtFVvtCiNqCMe+Ey9f6ut2BwET02dEl6QByQ6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVwgbMCw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVwgbMCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719001052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um7T9PGjBIGkvoDVAKpflWXByq5XUAzYLuKCcXhMqaY=;
	b=hVwgbMCwhkwKuIcOyjkXknplbqMhIKIgMrF50UNzGAShjyxAvZ0eKSe5NRm5QJ/yQx0zwS
	iJHDsOh97udRRDBgdhy0Nd7ZJ3030jlmb3CR/D7PTGd0Uo2sJXZV/SzlnSwjvZg11kqsiC
	ZqVICQfaYiMVZzCSiL+7K4vmMoQ5FRY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-F06d1BXMP_yjzkJilrjnqg-1; Fri, 21 Jun 2024 16:17:29 -0400
X-MC-Unique: F06d1BXMP_yjzkJilrjnqg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374b2adee08so26910415ab.1
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2024 13:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001048; x=1719605848;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Um7T9PGjBIGkvoDVAKpflWXByq5XUAzYLuKCcXhMqaY=;
        b=SXjJ5KE4SjIlZmwyxukfw8XqxeNY3Qdmrd+8pE6K7HR2Q41/rNxDjOyfFsXExe80K+
         6Snn1ljqrsncyRokVWeevRs/YqeKc6dJ2MBSCq7FDknaOjg4JT8AF9njKqcZlVQMOK6P
         8PfN393Ktq4rj45kD+Yv2dS14kKOpda7KvSSOZqSzDbX0JsXHiu8ayw9GwgYaap3avIe
         zypJ961w3efDUsIyJHqFQhJRBLDIiZFcPf44wFECV9i9BGSmKHfH92oldWIXXSbJ2to/
         hDD0TwT+GEwmobhSohKsXAvHqjHXxNC4YBeH4O0gQ3BRKPbHoNcpA6iav8V68h3W128y
         v5eg==
X-Forwarded-Encrypted: i=1; AJvYcCU7x9y6CAcDeKVRrk59IkxN3uR91i+tnFg5IxK0CdGYskOYChF/wKAMwLeEW5wTGSvLdqRtzz4OADSQWLywG0q2Ev1z4r89cWrkWA==
X-Gm-Message-State: AOJu0Yy2f7P954b5xad8cKstzDImOLLrbHmaN8XOU4WDQAz/L66jgGLd
	twe6s/HyQkiSbL1OAiWo4Up+zSEOrn4ERGC8eYrCCOE46pKtf/HOfM4hwbPx4RRIGUYccYXahW4
	uBtW03o4ZV9nEv2N0QFwOhi7K10s2Iag0/oYSxwk5RkaBAtwEHWSe2oy9AFw=
X-Received: by 2002:a05:6e02:54d:b0:375:dc04:378d with SMTP id e9e14a558f8ab-3763641c664mr4276195ab.6.1719001048536;
        Fri, 21 Jun 2024 13:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8aM6CP7HpAsbVpMIZYwjxc8YU/y9+kdeZyEPluz+E05lG59Fcq21BUDsEiQMbh6Wj2GUsQ==
X-Received: by 2002:a05:6e02:54d:b0:375:dc04:378d with SMTP id e9e14a558f8ab-3763641c664mr4276115ab.6.1719001048153;
        Fri, 21 Jun 2024 13:17:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3762f3a6a76sm4855055ab.86.2024.06.21.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:17:27 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:17:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Ramesh Thomas <ramesh.thomas@intel.com>,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, Ankit Agrawal
 <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>, Ben Segal <bpsegal@us.ibm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v6 0/3] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240621141724.28fe0c5d.alex.williamson@redhat.com>
In-Reply-To: <20240619115847.1344875-1-gbayer@linux.ibm.com>
References: <20240619115847.1344875-1-gbayer@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 13:58:44 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

> Hi all,
> 
> this all started with a single patch by Ben to enable writing a user-mode
> driver for a PCI device that requires 64bit register read/writes on s390.
> A quick grep showed that there are several other drivers for PCI devices
> in the kernel that use readq/writeq and eventually could use this, too.
> So we decided to propose this for general inclusion.
> 
> A couple of suggestions for refactorizations by Jason Gunthorpe and Alex
> Williamson later [1], I arrived at this little series that avoids some
> code duplication in vfio_pci_core_do_io_rw().
> Also, I've added a small patch to correct the spelling in one of the
> declaration macros that was suggested by Ramesh Thomas [2]. However,
> after some discussions about making 8-byte accesses available for x86,
> Ramesh and I decided to do this in a separate patch [3].
> 
> This version was tested with a pass-through PCI device in a KVM guest
> and with explicit test reads of size 8, 16, 32, and 64 bit on s390.
> For 32bit architectures this has only been compile tested for the
> 32bit ARM architecture.
> 
> Thank you,
> Gerd Bayer
> 
> 
> [1] https://lore.kernel.org/all/20240422153508.2355844-1-gbayer@linux.ibm.com/
> [2] https://lore.kernel.org/kvm/20240425165604.899447-1-gbayer@linux.ibm.com/T/#m1b51fe155c60d04313695fbee11a2ccea856a98c
> [3] https://lore.kernel.org/all/20240522232125.548643-1-ramesh.thomas@intel.com/
> 
> Changes v5 -> v6:
> - restrict patch 3/3 to just the typo fix - no move of semicolons

Applied to vfio next branch for v6.11.  Thanks,

Alex

> 
> Changes v4 -> v5:
> - Make 8-byte accessors depend on the definitions of ioread64 and
>   iowrite64, again. Ramesh agreed to sort these out for x86 separately.
> 
> Changes v3 -> v4:
> - Make 64-bit accessors depend on CONFIG_64BIT (for x86, too).
> - Drop conversion of if-else if chain to switch-case.
> - Add patch to fix spelling of declaration macro.
> 
> Changes v2 -> v3:
> - Introduce macro to generate body of different-size accesses in
>   vfio_pci_core_do_io_rw (courtesy Alex Williamson).
> - Convert if-else if chain to a switch-case construct to better
>   accommodate conditional compiles.
> 
> Changes v1 -> v2:
> - On non 64bit architecture use at most 32bit accesses in
>   vfio_pci_core_do_io_rw and describe that in the commit message.
> - Drop the run-time error on 32bit architectures.
> - The #endif splitting the "else if" is not really fortunate, but I'm
>   open to suggestions.
> 
> 
> Ben Segal (1):
>   vfio/pci: Support 8-byte PCI loads and stores
> 
> Gerd Bayer (2):
>   vfio/pci: Extract duplicated code into macro
>   vfio/pci: Fix typo in macro to declare accessors
> 
>  drivers/vfio/pci/vfio_pci_rdwr.c | 122 ++++++++++++++++---------------
>  include/linux/vfio_pci_core.h    |  21 +++---
>  2 files changed, 74 insertions(+), 69 deletions(-)
> 

