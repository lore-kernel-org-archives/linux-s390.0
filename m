Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5C20DF7
	for <linux-s390@vger.kernel.org>; Thu, 28 Mar 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600954; cv=none; b=nRBYQlHpvAdyCfha120eX+pmCTG5TjSgzDJNm0TN+z02Sn0qyrVXSZ5D+zcaLwk1y4AKjLpuqa+BL7+o8FoMK+vzNcBknepdEs088aUicEawWCEes5v4S8DmAH3K8mETcyLAPUzgsW67EgrnvyxAliJynp7SzvbgNXOm+4Qa8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600954; c=relaxed/simple;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhWrOD7DqQLvQ8c+w6TXwmxuZTBpIpijHAD05QdXLYmf/a/eooWMJQRyYrPwnrVIpWdYjGUQMZ49eSA88QvVLD0aR76+chS9aurF773en4Ycg2GP9PE/5WFQpRfE88arKgcgPEmc7OAzxPyZwkorT/nX4rvlAx17hgxhIUGpu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCGaibyA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCGaibyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711600952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
	b=XCGaibyApwe7F25EwGldeH1FUYiSGF6+X0z1Q0Zvl7s7ZisaovfM3W6OlPon0qlkqd56lX
	D0q7SADAhAmWGX5kzAO6VPmff8XhYqRABzNCvZnt5qS9Z4rtWqwUMAevuiIltnXnLfBoIz
	AQGAZyQoSHLiquxLELeylCvvs1GRf1g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-NEq7m3NfNoCTx33pU6RZcg-1; Thu, 28 Mar 2024 00:42:25 -0400
X-MC-Unique: NEq7m3NfNoCTx33pU6RZcg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5e5022b34faso564405a12.0
        for <linux-s390@vger.kernel.org>; Wed, 27 Mar 2024 21:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711600945; x=1712205745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
        b=s+NnDIuDA/Op/kYAbkQ3q4rHPXzqchw92J3/HoP9Zhgy+KV9evkHjZLR3J4UQ6o3mh
         BAMHLgmMhKWspQzC1FXDe0WoDaDHhro7P+9c29Wnzd/i2LFt8RywmaKfT00sQoJTFOrs
         NdJ1WnaYQhpV2DflPtzsyVa3GpL75+aE/A5ZgjauK3ED9KRAJf1PDCbGHxeYvmKLk5eD
         GuLPGY4NYw+NyM3nRXBAl/ij3c3WC01mEqX9LXTfcQPvzr7IdFGmEDthc51wzg02naKB
         F+se+CP8ydIlVz0et7GZ6cBHYYtFe9+N8p7AtrMNxHeHsi3pp4HeiH1Z5qw4T6dzBT4A
         ApOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL+8vv7Bobsh+j5GCp3a6Glu3TX4KuLgMKPT+xTDS9B+MSiIlf698vK3yhNGzUGY6HuyL/LmxAJULROHppgq6Xi8j7pmIW7YdTzQ==
X-Gm-Message-State: AOJu0YzuQQMqPLbNYlPgVfi9XmrPK1Bo76Lz+AUugc+hgDqCdRRt0cdD
	uNxq8eL5eVdFf78s3Vuv1bVpr8y9dOXMtgCwicDNJpKAYvt+6P64zgKRDvSD/ds47xG/VoGWHSF
	2d5GBuCTMHahqE9u3XPyqdaGe9DzJICk2IbU3dsmmWbF28gXQh9OzRD3UxDofJtq1glCsg7cpAB
	w26rSdnU5Pbg53h1WXRfavZdQZoCTykrYJSQ==
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id r3-20020a056a20394300b001a3aecbdb60mr2612154pzg.9.1711600944743;
        Wed, 27 Mar 2024 21:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGqMeGlScFLGjuf9ntL+wJAbmcBUMH9qH8VV+quAV82wNT4oC4BMh5FM/UUwwoJlJBLwmVhiSP74tk9QYL8V8=
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id
 r3-20020a056a20394300b001a3aecbdb60mr2612140pzg.9.1711600944494; Wed, 27 Mar
 2024 21:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:42:13 +0800
Message-ID: <CACGkMEsViOCh-DGuRqZr=XGT+wJcG68CFAdiTcLc-q_2CtZ8tg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 6/6] virtio_ring: simplify the parameters of the
 funcs related to vring_create/new_virtqueue()
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

On Wed, Mar 27, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As the refactor of find_vqs()/vring_new_virtqueue()/vring_create_virtqueu=
e
> the struct cfg/tp_cfg are passed to vring.
>
> This patch refactors the vring by these structures. This can simplify
> the code.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

