Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216953D3D10
	for <linux-s390@vger.kernel.org>; Wed,  8 Apr 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659018; cv=pass; b=kKs/LTLM1NfKOjUsLBjPltji+BIr+mGwklttDBKvvON0Z06XgNz+b+w9os7mqicVxSW8JOoQI9+ijnzMo/B9SSsTMlV98s5FWigLUpURsD67DqMnZ/w6+PQCzcqaVR9l4Sigt+pwU86sCc0m6uHfs2g+ySf8oSTRciTfKnKSV5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659018; c=relaxed/simple;
	bh=qT1zHZCSFMPJrwZKDQHbbpFFBhz3FsCccEZdVXIfmuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxJ7UKKj/E5zqbRi8VM/Er0CvxAifbUtVZvomXeyxqhpyC4/C9nuIceeKR5B7gvIRZgqLgTdOC2Yi94k0mH7AMD9RYDip2DErRNZIBOlgJCSVAF1A4EgqmjMM6WprPkYOh1bPyHTvhcBg2AMOaiY+27HPbEH6WwJHjg0oUyr7OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqgwwfuS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rYVXSAWS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqgwwfuS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rYVXSAWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775659016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
	b=GqgwwfuS+zaBtvu0ePOvKT9twRSPq0OWkxmxr4nxhve/CEDmXSN4Mgd68SILkLqRqlc4QG
	CPnBhlQq3rs9BkklPaWij7Ht4Yfpx2GJiFDG72eAGZUCdUsloOUKfjnuoxISurAAeVdOi5
	2lrPq6OHktYoSwDshDvRJMPXn1Hj974=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-hYwrvtbxNfOTfPCOw3QryQ-1; Wed, 08 Apr 2026 10:36:55 -0400
X-MC-Unique: hYwrvtbxNfOTfPCOw3QryQ-1
X-Mimecast-MFC-AGG-ID: hYwrvtbxNfOTfPCOw3QryQ_1775659014
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so4162813f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2026 07:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775659013; cv=none;
        d=google.com; s=arc-20240605;
        b=XoGaUd+B9JGjjoLDe4glMJIDk6BSFbpJlW7FVVFt8L+JEuSjAEn6wYY6D4Hi7jWsEC
         DSROUXMxhSKOtBfZywQKKV2gkIQkIS1xfD/QmvJahj8W/FfrjdZbKyy+ZmkMBFjQNCBo
         Gzsc17tFeZ2dydayX53y/qCQSvao5GsZUcYk0tpPfDj0S6UJKvXl7uIQVDI9w6HX0eWC
         MfBQTOxqyk5hwHvRCZZBmlQGlPMOYM8Hp26UAVo+s8zGBUDHwya4uOc9nalTG/dSUKK2
         4BpjHQGMIswLSmnU3kvPJsHr9P3RmfyhTTWTuNMo3s9/M4R2+coCE/Y5d+qhX1lg3TIR
         3vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        fh=6GqU+jS2IoOPRs1MSe/34Kw+aGpBbIQ6gFGHj5gvzSI=;
        b=ekJks9vlqJQi9ceO4wmI6P+YOK/uvyyQVkuYoUbZWSpIaoMB4UBTMmrT0liEFiuaF2
         wv99FmyEit/ljtdft2b8/TphYNWu33DHw3zNHN8p2Jg7zcvu+iWLaxRae4KwQpLCyQBn
         YW3dgDF48NSOr5fMhNfT/9LRgcTySO6ThkKwdpqXeEKPMb8IZBEypMUaBqMoM/k6+nqd
         s4Fu2Nu9iP3EHQQSwUTlkGN3tyKQG8Il8d+Z5P4RIR9B46Lb/pF39kUv47vJnwbymyLl
         0TGLxv18qC/3fBNgYhOy2W6WKPl68kWoyFlK9gYHQ8PAQU5GGF+/HnsnwERtlKmWs6y/
         MGmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775659013; x=1776263813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        b=rYVXSAWSh4L0928kkHyBwsKIfWxI3ErIlb1y1Xx9rwtlnbhFLOSC4HnEJuJTODNORZ
         caCp4R+IEuteQpTK+E5oosQGLzsPq9qRna8r876j1dlT5bT/ZlCJJTGDOD2xAef03fVo
         GzBJMK1qv9+lZ5N3A2gKBXzlenMUR5Um6hEwQCl7BSMJ+hfg4Nm2UG+uEkwWt06K6wdT
         Zb5LU1F2QsYom2U1Vo+mdiX6YonI30tunXbuezTx9Ih55BJhelPMGoxE77ePbaSHPVxQ
         ZgDd6JY2LoNuWDayFM+TF++klQr0uM4hPLsOYdM2b+gSXMWHjWB9OqUey3wowLCzlSCp
         u1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659013; x=1776263813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        b=W58VeN1Fql9E4yDMr6wGDIEd1txKryZ++dmIudtXW4mRoN9wCzuzXdN50OhgZClcPp
         wa5116C2yj6MuuNWc+guKBdMAe3AHuZWA/MToBr9YegE65u2cmBD3PFV1MEn4NmAjnHI
         QrDndxgJaNT1GTAARDY/b5JtPmqzDqeZNHf7yWVFEvKlPtpR6ss4VELm8J+U2xRE101/
         AwwDa1Mur4bZAG2paY8ropDdkHvmjMISu0cRmKXs9O5bewrJRQMaD7OcGUDOjAdw3wD9
         s/DnJLlVDfwRD/T+uOgNWUj+gbjq0IYYhB6/r+E2ZXSVA0ALhgOlmg6VKje+j4VIUFbw
         VYgg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9soHaKnZ9Xre3jFjcNESeZou33WH4NrRjMJQiB5fe+Z6jwZZSGI1wVWVU0MvrwrJ9YW9v6HjNOuv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1VGvUvu9d5cb/WrzejXTlRHRP0xMFH7E4MVoxaIa93+U3qr4
	i7S19A1lsF8CamqkpAAlY9E80vudZOvYa+WSr+bwvYPqUCTR3zMhgzDsEo7Wppj2GzvXwxrXOKU
	X7Q6sbknDRx39kxPPTm7nH6ZWaj9KV/E4q9WtNT5SRkTBnPy3L8qg3k47COBFVW4tSG9zo9WyrL
	tnhReLwxe5kaa7eIitCC8Qlm91ADioMePLhMRQVA==
X-Gm-Gg: AeBDievRiPsxFoVhCbGCflXaKmyTLATb+IeCenJ2N948lhG+GYWXp1d6DVu8o7Ihff4
	fgcTVhYjUR2SFFFdmmAE5Jl65ZYarKbQSOCJfz67bDlwWhszHRtCC5aYItpNy4KtpFyErsmeZu5
	bcTPY4Bn/nTig9YbFNaU0zi8vhfiKJkdqEWl/OLdyqIHbcEREPtcdfHlNucirwwlIdcdXSe7taC
	n+2u/TcsuEzQMSPaQyVRzQAQhkPCPNbH3BLSSsnh3v2WVJdwGjkU1eC40zp0lZ054viWVe5I0gE
	izw7
X-Received: by 2002:a05:6000:230c:b0:43b:48d3:2a46 with SMTP id ffacd0b85a97d-43d292fc2bbmr31500621f8f.33.1775659013521;
        Wed, 08 Apr 2026 07:36:53 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:43b:48d3:2a46 with SMTP id
 ffacd0b85a97d-43d292fc2bbmr31500576f8f.33.1775659013061; Wed, 08 Apr 2026
 07:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407175934.1602711-1-pbonzini@redhat.com> <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
In-Reply-To: <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Apr 2026 16:36:35 +0200
X-Gm-Features: AQROBzB5omoJWYrrMqaSBonwZlBQM8vJiaSjlVlseeyW58fQ54aszgrPriv5Sfk
Message-ID: <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 4:35=E2=80=AFPM Anthony Krowiak <akrowiak@linux.ibm.=
com> wrote:
>
>
> >     open_device:
> > -    The vfio_ap driver uses this callback to register a
> > -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matri=
x mdev
> > -    devices. The open_device callback is invoked by userspace to conne=
ct the
> > -    VFIO iommu group for the matrix mdev device to the MDEV bus. Acces=
s to the
> > -    KVM structure used to configure the KVM guest is provided via this=
 callback.
> > -    The KVM structure, is used to configure the guest's access to the =
AP matrix
> > -    defined via the vfio_ap mediated device's sysfs attribute files.
> > +    the open_device callback is invoked by userspace to connect the
>
> Capitalization:
> s/the open_device callback/The open device callback/
>
> > +    VFIO iommu group for the matrix mdev device to the MDEV bus.  The
> > +    callback retrieves the KVM structure used to configure the KVM gue=
st
> > +    and configures the guest's access to the AP matrix defined via the
> > +    vfio_ap mediated device's sysfs attribute files.
> >
> >     close_device:
> > -    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback functi=
on for the
> > -    matrix mdev device and deconfigures the guest's AP matrix.
> > +    this callback deconfigures the guest's AP matrix.
>
> Capitalization:
> s/this callback/This callback/

Heh, I had to pick one or the other (close_device previously used
lowercase) and chose the wrong one. :)

Thanks for reviewing the s390 docs, I wasn't sure about the new text was en=
ough.

Paolo

