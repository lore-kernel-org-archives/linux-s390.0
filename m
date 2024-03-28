Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBC51028
	for <linux-s390@vger.kernel.org>; Thu, 28 Mar 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613214; cv=none; b=Gu9MURosHZ5HXroiiGk6QrNWbDDgPcnJgciZydF2C1aUoLwc/o0OQiSEwgrLTUQzuSB/UKno9gXbGRW77Qukhj72qcW16++XKZCc1wxL5cC6OYJDvnWBEyLUp234RMoQCnC/ULFC98GdWFEwNKjmTBRx4hxFhqSafKu0uCbokIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613214; c=relaxed/simple;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ani9IeNkm32FMTujDAAktRslisjlfe32l0Pyo6HdZErPWmGZlB+I3I/Ljb4u1fTNZT73rG5kySz+AkkCqUCmeDxwS4DsvAkGQKVvHHNIPL8qqFyIjFGlUHTYDFylJyRE8KHVSbwvZGuP/MqYJ+2wvjnRb62e5bozBJQVeCV6d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2y4PDtP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2y4PDtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
	b=L2y4PDtPbUMy6OEF7iZciOm2T7jugmA8ghoVoqV+ibdcb0ePAd2erRo47eJ1I9USGTC+fy
	tNwd+cYozVGj/zhDZFI4I9G61NU3E7P2Q6YbUAqocQs74Mpb+UJwNpPNVIy79tgWj1EHcH
	qvF+epPy0qr0WAGha4cHgFuhOxB7zac=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-TKPK7tDPMvWHnqIGyqfggg-1; Thu, 28 Mar 2024 04:06:50 -0400
X-MC-Unique: TKPK7tDPMvWHnqIGyqfggg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df180bedcso691675a91.3
        for <linux-s390@vger.kernel.org>; Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613209; x=1712218009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
        b=hED9WGjtP4DdFte9bKV5S/srlFvyNphy695BqDdx3Kqe8GLlRGH580p6nGN3riPRG1
         7DlHxVg7fs0MdU/QWOs5xQ//GHRPeyT0djGHKSC6Dhj8tYjAdST+eEMnrNcC8AYewiFJ
         G/XkCFXPupuGAGZ1m+SWphK4ai41U49jd0aj1n+zTti18IDEtSv5RBM2Rl+sUutGi1dG
         MpWc9kCiJ2TAoKwL6DwwSnJI523j6DNDM+k6ftIEP5HG/9Iet1SXtFr8Yk4OBK9LnjSl
         k2o7J5WLhLcZi4yDBNymSBZjibyL0AroZF4w08dODk3OzEmcknXMpoqjJAcnVSPNZeVS
         N+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUhMhzyKsbCt48YSOFj1EDVMxB4icHoOkjyaPysbLNMeYJfQaeXd8j6jn25xcSzfDYfC7j1skK6ayN9vF+LAX3jnKhzTBslzTJ9Yw==
X-Gm-Message-State: AOJu0YybrXFyYk+PIZNOzNqe1zPZulOiKpqKRxy67mDTInIu1+cZ2MrQ
	eeiOS2cOBxUCVe5pu3coA21RprbddS9kYd5yuyAIyTq/fYQ3CRR2RKklOEM2m9d1HzjadJyLDp8
	wKSrSwwgjpZydWvKT0H9haX4x1gg6ralcNoMr7cmI2RYVzFTKrNay7PhC+JyJuffHanThAsTal8
	wCDO9UTzjwDCDfRxWKQPoY+Cys1f3vRjHTcA==
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id i8-20020a17090adc0800b002a04c3b3454mr1573898pjv.47.1711613209131;
        Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr3cKtOM4ZCyHExJ4R7r8BZoA5SFTXeHHD/kYgfJMhl+KEh6JWHIkXDQz44FirN0E+6Cmhpkbslv31U6+rB3Y=
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id
 i8-20020a17090adc0800b002a04c3b3454mr1573868pjv.47.1711613208786; Thu, 28 Mar
 2024 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com> <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:06:37 +0800
Message-ID: <CACGkMEvv5UdAEC4N_AfQRM5TeVnPLC7PWpBvURxn+wSUhjFqrw@mail.gmail.com>
Subject: Re: [PATCH vhost v7 5/6] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we pass multi parameters to vring_new_virtqueue. These parameters
> may from transport or from driver.
>
> vring_new_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

