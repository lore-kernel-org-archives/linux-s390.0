Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF63009F6
	for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121367; cv=none; b=eVloWgW/dB1AduD43B/zGguLKkOSKkZvvMdi8Q3yHgPMr0Jigw3WC/i0I0Ak9Yt2lOV/itThHPeLiHEO7DQJfAgSjFFR1CFQ+Zhf1doYKf/HpexIo/iuQb3r1bzTSlhP0wne6Ad7taYXWLc6SQ0c8yH2o+QbBn1dvhHTz47lqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121367; c=relaxed/simple;
	bh=tZkeNJG/k4HgzLYqAar3VskqfPv4lb2PhM0I5jaFVro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fucOYZ4blND/MYZvgZav6rJFk9PGm3YyhaPOe2uWgF6hstu9ZpJaqIABWNZ3TCQWn+iqdNdA8tiirL2z5WL5/qjR3QaANbfpaBR4nJ0yxes6mW56yqz/JT77MxbBdVL+HShOW/GZUzRibIaDFKae2/HzOXAdIS5qPgdpVp9zneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnBw2Suq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnBw2Suq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755121364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTAMoi7NWHH5SP+IGuvihL6yckezTSZsu/o/az3fetk=;
	b=EnBw2Suq6KM4W8lgBe8I1D0WhPyJZD00JenfCux3y4YL7Z2+zU+snwLrsmUrRR7Xr3maFm
	FELyG3uOMYhHyjN7CFlMmpC1iay20lONRNUn6pk8efzA3pj5FcWcOnxPJm+yCOvO7z48k9
	wfIwXckq0TZW8AatxJ4DX4MglA70GU4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-yOIagNnJMt6euZup4Gilcw-1; Wed, 13 Aug 2025 17:42:43 -0400
X-MC-Unique: yOIagNnJMt6euZup4Gilcw-1
X-Mimecast-MFC-AGG-ID: yOIagNnJMt6euZup4Gilcw_1755121362
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e5700a5525so849385ab.3
        for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 14:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121362; x=1755726162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTAMoi7NWHH5SP+IGuvihL6yckezTSZsu/o/az3fetk=;
        b=K8MZ4thxRmtOURtoc0xtXzI3sJbf3+o/t9jTQ3FWzNREIx6Wr1tjwRapfJI5Zevlhr
         uGOucDylTR/c6uG5OkU/YCWP1NFNTLMjUUjTFXvM6nWpW0omNg6g3BVJSAJr+gY4iktY
         aj3N/LGBtweKM2aaXXt1Ct6SQx+O8dt1pRKT8pfYaFU7Vb2K/JA3BWuITqACiTXBe07l
         umjajX8X05Yb6YnLJYW8MdkDlpErr5GbGCztanrd9IjRWpdFMChF2erO0k3cSnVIZfAH
         f7R5tpMXBQxp0H/WDHMcXHYBvFmKSQv2m247aUwbJhk2loeIGlnDW9XJevLgjrnNJiWu
         zRBA==
X-Gm-Message-State: AOJu0Yz8G2Eqs+g3Ud3KmfNv0974spCeknX+0+SZd/8orfvnC29AX79A
	oPy0sbP1zPm0o8XHe+XmhvWn9X39qbzcR7ywGkcbuhXY9mBVQUSrM1RKQEOyaMtvepkIS9vZKIp
	ub685aXT7PMpoyD0HRSw0HfOKSXYINghsBvVCskoBKd97OC8bN8GZQxEYPLyHeNE=
X-Gm-Gg: ASbGnctBuFAMOQ8sOuQirzisJe1pcoVEJ2CRquqOYY7u/xNcIZVO/NgpOMYiU4yg9DB
	XCbRLdR+49ZN95NNdVoo5eZM4EKVRbfBNp17KIrL8Sz1l0tDgF12j+0Ocnx5xXbLqvd061kqXow
	+RlkbtNUI1DK2wK8g4H4np+a4HBFfQ/6rGCV4HMFkUqLmzGfNtqeSJKLQ+H5CEKQB+m8zQ2Sma7
	Z3tdk3rx0q/CA85pJWsGw6KCmlUTWvJJqIS8U6iQkXQnh7iBLXgnXOLAo7R+C1CQ4dtZWA14p+8
	4MrRO/NXYq14fex9F1Pwt5nTCUChMxDtXm1VPy7mMZQ=
X-Received: by 2002:a05:6e02:2584:b0:3e5:4844:4288 with SMTP id e9e14a558f8ab-3e5674d49f8mr22044875ab.6.1755121362409;
        Wed, 13 Aug 2025 14:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDHHohC14gyeTWmYipxt4qFzm7xDJM1ET5AJFLlN2JDY03n+D1PVe+fB7ttkokcVWM8OBRFA==
X-Received: by 2002:a05:6e02:2584:b0:3e5:4844:4288 with SMTP id e9e14a558f8ab-3e5674d49f8mr22044765ab.6.1755121361989;
        Wed, 13 Aug 2025 14:42:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e53e6f9c4fsm48989665ab.41.2025.08.13.14.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:42:41 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:42:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 4/6] vfio-pci/zdev: Setup a zpci memory region for
 error information
Message-ID: <20250813154238.78794b31.alex.williamson@redhat.com>
In-Reply-To: <f18e339f-0eb6-4270-9107-58bb70ef0d08@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-5-alifm@linux.ibm.com>
	<20250813143028.1eb08bea.alex.williamson@redhat.com>
	<f18e339f-0eb6-4270-9107-58bb70ef0d08@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 14:25:59 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/13/2025 1:30 PM, Alex Williamson wrote:
> > On Wed, 13 Aug 2025 10:08:18 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:  
> >> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> >> index 77f2aff1f27e..bcd06f334a42 100644
> >> --- a/include/uapi/linux/vfio_zdev.h
> >> +++ b/include/uapi/linux/vfio_zdev.h
> >> @@ -82,4 +82,9 @@ struct vfio_device_info_cap_zpci_pfip {
> >>   	__u8 pfip[];
> >>   };
> >>   
> >> +struct vfio_device_zpci_err_region {
> >> +	__u16 pec;
> >> +	int pending_errors;
> >> +};
> >> +
> >>   #endif  
> > If this is uapi it would hopefully include some description, but if
> > this is the extent of what can be read from the device specific region,
> > why not just return it via a DEVICE_FEATURE ioctl?  Thanks,
> >
> > Alex
> >  
> Yes, will add more details about the uapi. My thinking was based on how 
> we expose some other vfio device information on s390x, such as SCHIB for 
> vfio-ccw device.
> 
> I didn't think about the DEVICE_FEATURE ioctl. But looking into it, it 
> looks like we would have to define a device feature (for eg: 
> VFIO_DEVICE_FEATURE_ZPCI_ERROR), and expose this information via 
> GET_FEATURE?

Yes, and there's a probe capability built-in to determine support.

> If the preference is to use the DEVICE_FEATURE ioctl I can 
> try that. Curious, any specific reason you prefer the DEVICE_FEATURE 
> ioctl to the memory region?

Given our current segmenting of the vfio device fd, we're using 40-bits
of address space for a 6-byte structure.  We're returning structured
data that has no requirement to be read at arbitrary offsets and
lengths.  For example, does this series really even handle a short
read?  We adjust counters for any read, it's more prone to those sorts
of errors.

Maybe if you actually wanted to allow the user to mmap the error array
buffer and move the head as they read data while the kernel
asynchronously fills from the tail, it might make sense to use a
region, but as used here I don't think it's the right interface.
Thanks,

Alex

