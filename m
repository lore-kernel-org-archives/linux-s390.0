Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3317756
	for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581933; cv=none; b=ZNgBr3zxsi73uL2GQhlaI8vOisSkMNp5W/GJTNHv80DN7/+oeKpcBdLh5gIx1u9Sk8Fm0REI8eUGkjwUfFPSg+CcNK9tOrNFR/Zq5slNcYGq2pBgpchVhkyF10qw9jx9jxtpB2A6jfRtFr2XWJNmO7ZR8ERSDgMGVp9sJG1qZbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581933; c=relaxed/simple;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDxdVd+A44PqbUTFm5uXwId8MO+QGCYPOJOUvKp1SAqy4eUUWY+LuZ81ay3HcPA6q2wYLQL61Q194Vi+6GyYBxRFw/4kdyuSRnLYMS5407Joj81J1fxdw8zplIDQiMaJfU+gnkzsjXgLoTi5hKS/amwRZMHv2IFRyewDhK2oEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9+gW/ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9+gW/ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
	b=J9+gW/kyku5xY2J5dOvBApjGnq5sERW/z81ud9o6asJToE1L8TmPbeJ0ioCAj4/oEOdgQF
	b8M6MKImF1v6S15mJ+SiP1tCeYxwRE9HAdOJsttPSRdCaqbFsQUpXjdTwHDt+vdBe+L4+d
	/VIKsfoOgvCfTiHB5URXENTNWVaI8/8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-tVZ_HR5uONaVXT5WSbNNoQ-1; Tue, 09 Jul 2024 23:25:25 -0400
X-MC-Unique: tVZ_HR5uONaVXT5WSbNNoQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3835285561fso66184225ab.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Jul 2024 20:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581924; x=1721186724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
        b=uLJoLUru5aigebaE/xP3+oqwB2wBcr5GXODW5jUTxYnUPGgy5/7lBAEgs2syBlpqKp
         rBuSBKCg5fMWS61GCdBRZXX0OT0WbhxnVRg58YxMCsWNhhVYFtdVwJwKOAxxpMbg+8H1
         4n6P/O6L0rOzuWGyqITVihbvQERenbr/jTklxnb5JZK1slWoO+3xdeARYxNemqRmPstU
         TKvCVtmdcdZg5Q7i7K2Dv/jmElS9J6aHtwgbTSfsVkPEVhdvoqs7fLjAi2WfIAAT3JoE
         3Gf+cjWuewI/yPuRQSK0GBPKNMrW9VNYlat2mepFEIpkTkjehsmeyWPQy5ES1kY05g2D
         A4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkVTQUCWzQcqENKJSPiJR5ZqCctIwvTEqnRDV5KIAfA/Y9mUh127Cal8b5PrEpNCghrg6Nfn5rGO22/a8v2yjCBk4hZdMbnuB1HQ==
X-Gm-Message-State: AOJu0Yxi0b+bXyQt0RlvG7fsSeTeDpwqUqlXRJ1M00M6+cB7HA23fY2T
	23mLPsYDeylnJ2SGnP21AOXFGJWiBO0z5UvGAwBrnmWlryec/uJUVUrmsZDzhKVfylhRjih3ODV
	1K3I0aRchxFyw1UwpeST6dcfZ2O+ai5jb8NKJYo3UeKT+Mhq5BN/k/fMD+Ka7UgurMzqbbmBvmx
	Q5ufIUZQKvNsW4sQBNg7Izom40KZqoTMP92w==
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id e9e14a558f8ab-38a57bcd755mr44254565ab.11.1720581923955;
        Tue, 09 Jul 2024 20:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8tp760Eusr7cpOewOOzt8KywljVE5imblpi4EA9nOMhtnhRxpdbKT5KwR6ZV/XXWj53jrT/VMHmkMmslXtc=
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id
 e9e14a558f8ab-38a57bcd755mr44254435ab.11.1720581923592; Tue, 09 Jul 2024
 20:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
In-Reply-To: <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:25:10 +0800
Message-ID: <CACGkMEsg0+vpav1Fo8JF1isq4Ef8t4_CFN1scyztDO8bXzRLBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio: fix vq # when vq skipped
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.
>
> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

