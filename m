Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824367E98
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692347; cv=none; b=LoD5xLV1RfPZl3HMSkjjsQ2H9hqr+YhSLsQ6cKGpdpctyIlix6XCuhDMHkqsSmxphjpHIkk3KtHi/VyqQ8nUHZMmzp5/SrPSfec8fkUvfu3Zdp3Px+WRXO6i/nbmSUG/3cQN2JbuQ1c+l/RioIEWa1oM7B2H6Uz3wPIwRanPkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692347; c=relaxed/simple;
	bh=F+LXEdvariXw6k3eT3r4qbtwZoi+V/LnKUO9+lO8CbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJanJyTyvb3lVkiQ58vkcBCly9Mu0zp9RRVBdkzL940FqwhDjMANDX522uwUt/AYDuk9onJU7XdGCv6/XLDj0cP+auE+LS2RcDbi4jXzYD5QDzoIv6W5ntyKCtRRJV2JTrBW0FraiaiH7UH8qXB8RloesmnCgcFQU3NC62SMZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLdFFyAA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLdFFyAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=RLdFFyAATVZnifJho4EO4QUpbD0nSBvubu9SDH/OWU108O0G7lIr2my3P8g1GkrjwwgTTD
	ZHw6nM+z4nDaYBqLHdBXTaBNXXkyBzfm5BNlgUtv0qAS5tXcanRR33AOt1i+xDbEJ5opXc
	a4u0o9tYBHkAaVNCkGiCuGWdvksMoH4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-njOkTLrjMnaeISzUG4dJxg-1; Wed, 31 Jan 2024 04:12:20 -0500
X-MC-Unique: njOkTLrjMnaeISzUG4dJxg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6dd65194396so799187b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 01:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692339; x=1707297139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
        b=JhnL2BHQ+UaYua9N6rJCAWG7vC+IfK9NHb5IbxytoQkFY2zhyDxJAvvJ/wju7WgXEV
         tscBpF5Nt2EshICjZni8mFRz1Jt/08akWlChc3AeUJrx9GTlSpBH4a+j49gJZ/6rFyBf
         HKq8oI1AGUlzVTFfuDxtgCTQ5CjkgI+gvSBsn3gnmF8H+H85V9ePaVv8E+zrDh2/bkTg
         c7ZVyCFqZWROWIFAuZYhBjyfmIZUuz0xRryXfkengYzt2Lmgrb7X5GNVdfnw8gh0bDic
         Yx9nvXW1go9wVcQf5qegMYccpvrOWAfbXF+Jh7iqF+0og2BYFFb8whzL0/66+cHMpUVv
         p0xg==
X-Gm-Message-State: AOJu0YwYN0TaDE5i1tXRzSrEo7Mznxpq9VS1QDT4k+TMvARfZXd9jWMq
	7Mmn4YMBiFEw1Yy9J6mTsUtPXuTi2ZumWknEAF0reEwWZeeGbVA+B5LEmAHkc2jYCPwZM9dPdj7
	nCkA8SzAUxwjWQAl/+FKvAO5Z8hkowtzuk5xpYzfIGLfpqR+bwEr4LhkX5R1gfVVZRjkYXWCNdW
	gMzq1wlqBkBkM3Y3odd7A0qST5Q+n4oKgQ4g==
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id mj23-20020a056a209c9700b0019c93eeb0admr1177494pzb.31.1706692339191;
        Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmM479Cl5hy9Rh2S2MeFkPZK97XeCIQ/W+WuJDw6bc/3YGrYz5ABB3TPxpsK6OFnyn5gpDGlLKohRyPGIa5F4=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id
 mj23-20020a056a209c9700b0019c93eeb0admr1177464pzb.31.1706692338808; Wed, 31
 Jan 2024 01:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:07 +0800
Message-ID: <CACGkMEsi4B7Rz7Uu-3sTEH=9XRBRDmNSacZkVt6zxaC-FbYqhg@mail.gmail.com>
Subject: Re: [PATCH vhost 01/17] virtio_ring: introduce vring_need_unmap_buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> To make the code readable, introduce vring_need_unmap_buffer() to
> replace do_unmap.
>
>    use_dma_api premapped -> vring_need_unmap_buffer()
> 1. false       false        false
> 2. true        false        true
> 3. true        true         false
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

