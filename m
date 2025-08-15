Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA201EB195
	for <linux-s390@vger.kernel.org>; Fri, 15 Aug 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290945; cv=none; b=a3Lz3HxuMwdC/mfiTB/+w2JVL7tTbW/rh51B6skuyuI898jFUIQ6fXN5WNN7JihHl0tnrr8K4aopl7/6VeC6HcfZOx77avAap6+oMgYhGw47jniJfWVmLBCKUEYkKex75EP13t72q0vQwzDt1OYoDpock8IPHUAkShgNMvwZRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290945; c=relaxed/simple;
	bh=coJD5zt20O9N4j84lqFB3HeMlhyWbtnt7oF12zKdrf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFQCJMmcHgpXcdOVIXnfTcL9BvjMtQJEWPM5ZcbB73UnxuxsjkNGmPcFvVWbemT2LRnMSx4Kck764+9xjxBw5kmf1IQHUv3O5UQYseuxlFVzTIP+gEKruXgExzP5sxr5tJUIp3ADr0J2/Q98xy+95Hh9vUgPcZ5CaqhHbbzegYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8ASGzT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8ASGzT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755290942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxQQKjb9DfbHLiLKKFOLHod9vjKmsoO2pBfbkqGt7+A=;
	b=M8ASGzT695HXFF41WJb4eAefqzxYQi2gph/f3BRoMTPq1CafQZHufSX35Mgbc1rXxC2H0P
	9j3ZOP/c9KXJwlOXUMELB/h2a1MOYoMzMb3miJuYDHb4P9RadVhZ2zBobK/bc+7yQ0cBpq
	qCt4ab4xs6IkZ2THjQ6tbsm0gx4pJwE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-FB17EkxBMX29xb2kUC2H5g-1; Fri, 15 Aug 2025 16:49:00 -0400
X-MC-Unique: FB17EkxBMX29xb2kUC2H5g-1
X-Mimecast-MFC-AGG-ID: FB17EkxBMX29xb2kUC2H5g_1755290939
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e570047004so6902525ab.3
        for <linux-s390@vger.kernel.org>; Fri, 15 Aug 2025 13:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755290939; x=1755895739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxQQKjb9DfbHLiLKKFOLHod9vjKmsoO2pBfbkqGt7+A=;
        b=fz3YgyRfgcDG2xF3ret6RzKU9O8IBUjAvfDYRr7Ml3HRiu6MSwAiV57ZSOZ/vFH6jf
         eXicAzk8WJ+Ac6lYzZEk9S8aELgdkPqD1BfQ/oWqLszuyxNGYNkE2WaFkU3j0JBYOk+0
         Bjs+DSYDrmxuYZ4pAlFF4zJM/kv2WGfJr6seixVYGtnOcUCiK09eK8e/2i+5358YKuEa
         aw9btXlA0pctIvpr7f4KgCQ7A/NhmfKNeL7kXxOY/zrEgnQFzdlkYzZOTj4GZsjy4f3f
         1CZ2ArQ23g9oslsVODRCfdEv3mgFlDA8CfFNpWZ2ni7AJoTGY0sAn2RJEK24B0H/PpMf
         OGsw==
X-Forwarded-Encrypted: i=1; AJvYcCVosODyeCTRN+a/Y5nAEIazcwDmXmRizJVXjrq9ehCrIFDXWQzEwrGKG4I8aZ0ijO94SH+v5Qvrw3lD@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSb2eg0lcW8d8wf9Eel4tjixUs/Y7d5zNirplJW000OVDw6Aj
	VrRhTVPcejSFa0Ht6oG42AHA2ZQJsKy0ByYtQikhotPLjV3cGqxm+2E5S99+GgdzWd3menxGqS+
	AFhVPk1FfhrMv1vylIOg4sybQcQay1P+Vb2IqWU4ACilH8gJi2Dz+o2kHYGMHT14=
X-Gm-Gg: ASbGnct+oPJBIF2jqNkNhD4lwPzCI92xaz4MRj7h1GdAC/G9a/VWiQHOHhtnKpYntEv
	ExpI8PmziSwu7fyHzkufaBz/+zXkvEA0/KByXVCPcQdgoa6xbqghonCqpoTnihF8H1yMQkuZjpE
	Hb1V5vu9ettd0ha+naCpNci8ouQJnAd5LQvqUTrzTB3V3htvxVRkEWp4iVc2Vwd7mYZJxryLNm4
	S2oy5mkyMAiEyjdqVnktKHQMC8X2jc2vbYP0fVeVXLqGNY25nCiDP7pyRfOorMie9Wvhn02fZvt
	hfrE01/7Dff8Fj/9KYe861cPDZ+nSvznMdtiUK4HLj8=
X-Received: by 2002:a05:6e02:1889:b0:3dd:c947:b3a7 with SMTP id e9e14a558f8ab-3e57e9aa92cmr17440435ab.5.1755290939245;
        Fri, 15 Aug 2025 13:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBEqL66ko0fvzn8eomIswOaFBFnW1Yg/xfXCXQYEyBW1J3DP6PPCIr+IIvwunh1IfBSp5G0A==
X-Received: by 2002:a05:6e02:1889:b0:3dd:c947:b3a7 with SMTP id e9e14a558f8ab-3e57e9aa92cmr17440355ab.5.1755290938868;
        Fri, 15 Aug 2025 13:48:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e67ab0csm8796525ab.26.2025.08.15.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:48:58 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:48:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 6/6] vfio: Allow error notification and recovery for
 ISM device
Message-ID: <20250815144855.51f2ac24.alex.williamson@redhat.com>
In-Reply-To: <60855b41-a1ad-4966-aa5e-325256692279@linux.ibm.com>
References: <20250814204850.GA346571@bhelgaas>
	<60855b41-a1ad-4966-aa5e-325256692279@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 14:02:05 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/14/2025 1:48 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 13, 2025 at 10:08:20AM -0700, Farhan Ali wrote: =20
> >> VFIO allows error recovery and notification for devices that
> >> are PCIe (and thus AER) capable. But for PCI devices on IBM
> >> s390 error recovery involves platform firmware and
> >> notification to operating system is done by architecture
> >> specific way. The Internal Shared Memory(ISM) device is a legacy
> >> PCI device (so not PCIe capable), but can still be recovered
> >> when notified of an error. =20
> > "PCIe (and thus AER) capable" reads as though AER is required for all
> > PCIe devices, but AER is optional.
> >
> > I don't know the details of VFIO and why it tests for PCIe instead of
> > AER.  Maybe AER is not relevant here and you don't need to mention
> > AER above at all? =20
>=20
> The original change that introduced this commit=C2=A0dad9f89 "VFIO-AER:=20
> Vfio-pci driver changes for supporting AER" was adding the support for=20
> AER for vfio. My assumption is the author thought if the device is AER=20
> capable the pcie check should be sufficient? I can remove the AER=20
> references in commit message. Thanks Farhan

I've looked back through discussions when this went in and can't find
any specific reasoning about why we chose pci_is_pcie() here.  Maybe
we were trying to avoid setting up an error signal on devices that
cannot have AER, but then why didn't we check specifically for AER.
Maybe some version used PCIe specific calls in the handler that we
didn't want to check runtime, but I don't spot such a dependency now.

Possibly we should just remove the check.  We're configuring the error
signaling on the vast majority of devices, it's extremely rare that it
fires anyway, reporting it on a device where it cannot trigger seems
relatively negligible and avoids extra ugly code.  Thanks,

Alex

