Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=gxBvFDOoVnM9rVmMRTkb3g9y6IMvmaUBrwtwUeWQLu6cAlRk0LBnffi4kziGHcMu57Oo
	 LqvkXwo7xntQZdFFnYo5r4y/G9HVJJCQp6EggVP1M5Kcb5AaAaPbhUERQKQY5HwpsT0fs
	 c9aO6R+GNeqWOIG2op3LdaAyLILZ/ExhASDKiDdnxJvz/nv2QGUqAx44Liw9i/I39rqHp
	 AfqwEKsG+ZCfgQa3ihXWnLV/srl5xN1LYYm/Od0/9jt6F1UMOEZsDCMNRMuVYfhCr7vgW
	 gSqZf8ERjtHmjTTBoIjnv93WE3WgPhtheBUj3A9/IlQ3oBc4FDKtkseHNh50iizbA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=mZ4PPnixNCq0QUbC0QVvFSKpcoRza6ia6bPoMj19njWmLCZqPWwe2I65+c4JE7noyiU8
	 /MffSOsF7EG6wFmRes1Uc+l4H5ZI/Cy+a2ZPNBq/lUFULwlXuUQFvUegt7QBv16WKz3p0
	 NyRvzK8NxX7iz5KdMG8j4YiuLmcL+Tfbn4xx7Pq30bKjhuV0sI1TXAiRwKarXsBZJQrDP
	 RGyoml5fguLrIIP0d2pFNEcv7agFMLr7qn4HxtVwUHTxutcB1a3JAQX4dntr7CNK2B065
	 7KCiJi8V1k/PvhlG6vK1Ajz7AX/jxujUtAcww8nK+cAQ+TJr70YABMlrpOpjUWadf/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276E606A896
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D276E606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso1170685e9.1
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=vAUsl2z3Y5EAPDxibBq+LEkao+/SlmBhXp0tuNj5UvJofzc3C01AFMZ1oQjRjZzioz
         gObcDHn4T6eOiHLN0egAy50YMwJNm1YzbhfwfoiwtsALhmVkSJZFcHgUIaTCGi68djjG
         C9wX3hBBRHSNG7mtkfyHKGoWxQjObzVq1tSZNyTv1iF/9rtv2k+gBgqn8OH+aKDWkoO5
         96UMzL/bpng5UwO07L+kaCUS4Q/0Bv3ROm9u9MYAgDkN+6nWpaLdhQ0i8GDrPqATgShd
         O4wlrSSqFd2xrMSou76I+FSrejCOX+OJAr07SVrBHZx0a6GtBoTR1mMRfFiFte/wEHS9
         WLBQ==
X-Forwarded-Encrypted: i=1; AL+hErFM5h3f5dvY0pqwLg6eT2pE3mpwbrUSOS2U4zSIAJwtqjyknR4bfqfP/Uvr5xVd8SBjZVrlvZvOEovk@vger.kernel.org
X-Gm-Message-State: APuU4Z/4TXtL2542EA9P9yE0bLP9LGRrjrrdPWYCG8VccJb4dRXVl/b+
	+4x21mjL+jJ7e/raF27+eyQly7fHZkLopp9FKk69hXNly+iOcGIIW1DW5QkiGxsk/KAP
X-Gm-Gg: AYBFou0twOkG51k/BbhuEIQjSj0YIxp0tox/s4jP8IeacIUQBp2QJvLz+fAg8YA2gB9
	acX7s31RYvK4I0JvDpWpTlFXqG2R/KuX5GkIVY7AOott2EbEibULXeESJxPP5S/6hT3pq/Yxc0S
	/rgwleKQWcilVsu+mSmP9Ds/4wyvn4j330j57xToV4T0jILwD281f321q+F1a3FaDhTUcKDIXqt
	K5tGrVkYpuCFQ1K/og+ZyNMvA5qGDhPu27M7UfP6vUyZuOabXDtRbDxFXGHw8wrmXbYi2W8VQaQ
	DV9CVn1Ced+EBVCj1GCf5Yz1ebVw6F3Ym4FMxPJ5hDFzXnyFJVmBNh/rsawRhqfCh9E+eXOyDNA
	y1XZd40N8cAX88SzP961K1vCxCmPkmjXaTI149V0BY+W0iuWH5ylsbpIrTN2X2FHLgugDqSnA2M
	uUH01O4h1FpE9emZ+hEUEGcK8pdY39UGqdVpoVWpAiCL4IPHqq+WSJZhySlfPvkwhtqtdwaLzAt
	wQkKfxxiNjHdiXsQF+02UK4GB6sEQQi7tVPSXmlXuEMUdhiSaqzICHCIX1yb4HWpxZObZDinM3V
	df+ajE2eCnac7+9dSWjdoEGG/8djo9y1V48x4qNLK5lI95lEDPsiPjpX332kWzY=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
