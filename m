Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440E86354
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180931; cv=none; b=J5IAm7/e0rIQz3LgPoLdU8zw6rbT3nX+7Ccq6BO0v/rfAYE+AYL7RyNcFsrXOrf4kAWRwJnQ5jgA8YF8f2i8WE5JYLdv0NwLMmtZikw9uDXlAKhiu75m24RprDUe+28mn5ujceoi0145EBo8/oCb/OIsXoFdQTcA5f2RJV5VhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180931; c=relaxed/simple;
	bh=bqA1UybnyzZGHI20admmSzA4zWOEjPM4b0uF7KYKxt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUL9WOR/PyOtdj50V4Q/AWi30j+zRUeNLnKXgVHU9e9JgJU+8YWiil9ncXd2/jYpwDpQYnc7FiLNjZdlG+1KM7hg5MgUH2VTlwLBNTGJ09vPLfl+X+vBrcVGl9X2thMBxgZlmDbOBKbj6p+uocqmQxTeQvNhI+WJSYkFIkRsENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul2bZa2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul2bZa2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736180928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTSPijXcjiAMCVDWekBe6V30dPAU6QGdX7quKRrwsHs=;
	b=Ul2bZa2+I+srfJYZzltv0oexiSSSmdEiXJA48cTfEuuGcAYDvfSAVTUZRWCpIqmo0cziUU
	OwiWNbbqtLU30llt1dWM2cc5AgZTGCEp+h/FYXDddWzw8Eo4Gwhu/BweV1AmnwmiCZsyc3
	q+a1jbH72dAYUF3OGQzaGhfQPjBi76k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-_p1XBtmEOFKJWdxgEzX3cw-1; Mon, 06 Jan 2025 11:28:47 -0500
X-MC-Unique: _p1XBtmEOFKJWdxgEzX3cw-1
X-Mimecast-MFC-AGG-ID: _p1XBtmEOFKJWdxgEzX3cw
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-84cd123df74so630739f.3
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2025 08:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736180926; x=1736785726;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTSPijXcjiAMCVDWekBe6V30dPAU6QGdX7quKRrwsHs=;
        b=Qt3XV5oL6Fa3MFnexFiB2554/j5Ck3auUiY2Q2EQqFZx0rUK63fbuYiTJjshrfQM+U
         O0UYARlI7W4B5mpkalmJ/mACRjtRO29FXopFYy1nms79w7Tbo5Ud8lcrW5DUwMHV8Ihb
         x4hJRL3eU7Q1MRxL+4LGwruBdZuW5DpJkcY5ydi53A9Gw0AYNnXnKqb22b2E9mMmYY7u
         6oGILsloxuTh5pER8pZ8LeJ1Qso/Z80a7dLmEaWTQQEpScdHMxf0OuIbRnCnkmI1XI/w
         ah5dPbyAeQIZqcYUR9adeisFK4MwCwb5YuTikHC/FNSBw4erNYYL8O+XwjtAcMVIX9iU
         J/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD28osmtFFvjs1cPq26pwFVed4Gqo8FMHeLicjlfgg6NnbHXhdzjkDF2QtniYRbQcADr/7/kAXEPL/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tLrVzmyDYH3Olr6zP2UCovkICsvMGOdwiygwivsVMZxbtOx/
	/e7Gx2OzPwqbS/ETv7mNp9gt0sUGH0+ocwfF4mnHe7XjCA66iyWxQO1NZKgzbUse0JQCJk0wI4V
	7gH+cgcEA8PUSOE9ecru7FJJm0kkrp9gnZKundT6jJ9Yf4JMcUzTMozZwk3Y=
X-Gm-Gg: ASbGncs0M8wTzcbcCLy073dfBS2wo39db3pvCZMjx6fT6OSqnJaFBCH2m9aH4lxN6Ur
	DVHeg1P4Up0vGX7pgUcQRsR4kw/dK7+c8VYWwZmDoLGHJB7Fkf+AakNBtcxmpv+XLJlWcYcJWsK
	K0YbYWAsQrevD+7zZIfAPDA+Znxchycy8PfZmr2wJdokXxm4fykLQf0/49yyb8xuclZgDw2UcsF
	1WrYjms8f9WvxHNM7bkbhQuw0gZwoGU+9H9YWv+XfJpyIx3HAyVcZuHrIST
X-Received: by 2002:a05:6602:2dc2:b0:847:5b61:636c with SMTP id ca18e2360f4ac-8499e4c8cf8mr1605756339f.2.1736180926523;
        Mon, 06 Jan 2025 08:28:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhi2SYCIWSDt6cklfzahC0bZr7S4U+xeNewvxNt7RadojvE0j28xssj9KSgjAMXq4it3yS9g==
X-Received: by 2002:a05:6602:2dc2:b0:847:5b61:636c with SMTP id ca18e2360f4ac-8499e4c8cf8mr1605755939f.2.1736180926206;
        Mon, 06 Jan 2025 08:28:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8eb32asm891093239f.42.2025.01.06.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:28:45 -0800 (PST)
Date: Mon, 6 Jan 2025 11:28:40 -0500
From: Alex Williamson <alex.williamson@redhat.com>
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: jgg@ziepe.ca, schnelle@linux.ibm.com, gbayer@linux.ibm.com,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, ankita@nvidia.com,
 yishaih@nvidia.com, pasic@linux.ibm.com, julianr@linux.ibm.com,
 bpsegal@us.ibm.com, kevin.tian@intel.com, cho@microsoft.com
Subject: Re: [PATCH v3 0/2]  Extend 8-byte PCI load/store support to x86
 arch
Message-ID: <20250106112840.423340ae.alex.williamson@redhat.com>
In-Reply-To: <20241210131938.303500-1-ramesh.thomas@intel.com>
References: <20241210131938.303500-1-ramesh.thomas@intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 05:19:36 -0800
Ramesh Thomas <ramesh.thomas@intel.com> wrote:

> This patch series extends the recently added 8-byte PCI load/store
> support to the x86 architecture. 
> 
> Refer patch series adding above support:
> https://lore.kernel.org/all/20240522150651.1999584-1-gbayer@linux.ibm.com/
> 
> The 8-byte implementations are enclosed inside #ifdef checks of the
> macros "ioread64" and "iowrite64". These macros don't get defined if
> CONFIG_GENERIC_IOMAP is defined. CONFIG_GENERIC_IOMAP gets defined for
> x86 and hence the macros are undefined. Due to this the 8-byte support
> was not enabled for x86 architecture.
> 
> To resolve this, include the header file io-64-nonatomic-lo-hi.h that
> maps the ioread64 and iowrite64 macros to a generic implementation in
> lib/iomap.c. This was the intention of defining CONFIG_GENERIC_IOMAP.
> 
> Tested using a pass-through PCI device bound to vfio-pci driver and
> doing BAR reads and writes that trigger calls to
> vfio_pci_core_do_io_rw() that does the 8-byte reads and writes.
> 
> Patch history:
> v3: Do not add the check for CONFIG_64BIT and only remove the checks for
> ioread64 and iowrite64.
> 
> v2: Based on Jason's feedback moved #include io-64-nonatomic-lo-hi.h
> to vfio_pci_rdwr.c and replaced #ifdef checks of iowrite64 and ioread64
> macros with checks for CONFIG_64BIT.
> 
> https://lore.kernel.org/all/20240522232125.548643-1-ramesh.thomas@intel.com/
> https://lore.kernel.org/all/20240524140013.GM69273@ziepe.ca/
> https://lore.kernel.org/all/bfb273b2-fc5e-4a8b-a40d-56996fc9e0af@intel.com/
> 
> Ramesh Thomas (2):
>   vfio/pci: Enable iowrite64 and ioread64 for vfio pci
>   vfio/pci: Remove #ifdef iowrite64 and #ifdef ioread64
> 
>  drivers/vfio/pci/vfio_pci_rdwr.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 

Applied to vfio next branch for v6.14.  Thanks,

Alex

