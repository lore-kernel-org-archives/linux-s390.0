Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130F74C11
	for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135012; cv=none; b=JXkah9Sq2TUruXLfJ1KbFSo6X3ulsx020BorMNE7Vmal/Ox/3rYsJYKJHRApIukDbHWWWKxbiz/l2x5qlgw3sYwyxBu3K/T+iiM1zIR5rW4jPlU9SL/bpGeLmJTBPSM4glM3Ch5aMw+28uLOaVfoE1Jb//nBGhHUBVLHeF7PdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135012; c=relaxed/simple;
	bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKzCi/NAv/LDXxaZkgG41HWNW9AUelJ6liA5fTwWvI77QaSyCjnRfhxyBzWUqh2WO5NO5G3yhkSHpgPwvqeA6cXiWwoQDAhworfYfyL7zP4IUePRsTVRe5YrWrZG4+FukD2USU0tRw9l0bmqV9Of8/uvts6CvBEKqLxMKRmzh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fV5Nu6U9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fV5Nu6U9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so1309749a12.1
        for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711135008; x=1711739808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=fV5Nu6U9sehoF+KMYfumSllhxrrznZs7jSNQt5/OGoS6ZAdobhJ8iFEv2gSLePMh6a
         sMk6xtA6ma1bc5Z42vo5h+XIYZ3tmEbYMDEjw/6xvOALrgDOoiwTZtg/0rCDBGYJkbmt
         K0LCFhJY3Bo6OQ+lT9eqIe+OSxL5VSUvbagl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135008; x=1711739808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=pyp4qKR3Gt5JQGYtl4VgEjapfn6ZpeelcaI0T5E76cLmhk5K834277TJrHq/tPYyF0
         1M0GcplEmiqczU+e+LxpC6Z3nCDTMueEAv3bd9HJK0hQHKsuo6y/qvuQAQTP/HYs4c3p
         mdvgTycusN9/iLbPXOGah+pVVGJjTw63DGhVdYc4X9znBaYu2maXK5QzudlmJvA3eBfD
         VVN8l24UfDMHxcpXRTp2L5iXcl5epIDU2td776AN54qjgzrrIXniDOqHFX3z2smOHfsE
         rUgmrPQc4tBJ9lsbYQjL5WNw0fpDRBy2gI06UUa32Yyx8VzG8gwoDl4wI1bs7V2sZuGS
         7gCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo+3dNUcxqFBosdFbYHmbZDaBb4S9S1KnyYxzyMisuwuvEz7HkToaNjCgfTT2apUeU54pJALphxLum3jE+a9gMT6FSygSXV6jcTw==
X-Gm-Message-State: AOJu0YzjHwUPPcWZrqnm0My2M7bwpZmU/FRqFsRCklNNoZqHckYxkowb
	vnX+DgMftMCZxOCrnmcUcH6YysUUiC9BRjSsL0dE2k2PmWz7CBErkhn5dWexh2EdzR3Si6dJQfh
	S5A==
X-Google-Smtp-Source: AGHT+IHsj0rwwQqh3t9r4/paGatTmfLNsIBozUptlVhYJGvg6SwncbRMj9U550A6/WQnfZchK7GB6w==
X-Received: by 2002:a50:9f4b:0:b0:566:18ba:6b80 with SMTP id b69-20020a509f4b000000b0056618ba6b80mr316322edf.31.1711135008680;
        Fri, 22 Mar 2024 12:16:48 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id es9-20020a056402380900b00568d60cfbccsm122368edb.42.2024.03.22.12.16.48
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 12:16:48 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4146f2bf8ecso18515885e9.3
        for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 12:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa418meNnVLW5ZdzAfmEoFOVvV/Om94H3I4Y9jp9nbO2478MmGFZhVBcmBrFIftVP/2bd51L85e50a98bwBQNygeh4VoG66NMesw==
X-Received: by 2002:a05:6512:32b2:b0:513:4b90:ae9a with SMTP id
 q18-20020a05651232b200b005134b90ae9amr255604lfe.67.1711134987739; Fri, 22 Mar
 2024 12:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com> <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 22 Mar 2024 12:16:00 -0700
X-Gmail-Original-Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
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
	David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.

This is a behavior change, and I believe means that the driver no
longer follows the spec [1].

For example, the spec says that virtqueue 4 is reporting_vq, and
reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
but there is no mention of its virtqueue number changing if other
features are not set. If a device/driver combination negotiates
VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
that reporting_vq should still be vq number 4, and vq 2 and 3 should
be unused. This patch would make the reporting_vq use vq 2 instead in
this case.

If the new behavior is truly intended, then the spec does not match
reality, and it would need to be changed first (IMO); however,
changing the spec would mean that any devices implemented correctly
per the previous spec would now be wrong, so some kind of mechanism
for detecting the new behavior would be warranted, e.g. a new
non-device-specific virtio feature flag.

I have brought this up previously on the virtio-comment list [2], but
it did not receive any satisfying answers at that time.

Thanks,
-- Daniel

[1]: https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01=
.html#x1-3140005
[2]: https://lists.oasis-open.org/archives/virtio-comment/202308/msg00280.h=
tml
