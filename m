Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD6224AEF
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060226; cv=none; b=frr4+s8btEY3cxH99naXnklyJdEkpxa3umJl4PYW7oekQESBc3kbIlFAcdDCqQzITzhsQxLW4U/doPCF3pmWO3lQ5XvmzbHmJAg8kxJADJpwGYVeC5uY3BUBSSGsIOuX+0N1GNHetODTEfMXHAmKk9wLATBN0HVuDuw0w5pJhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060226; c=relaxed/simple;
	bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVfWAv5FaL0uMKecLsIFh/fmqqysDC1U5xISpKqDNHtVujMXraCK1STcx+odUlujKm2yo+0l+rtCwCtL0aG8W7oWyEPbzPzWymkSq1HVUSj8bJxMAvJ7rbsGuECsI3YoxyF5atce/ro/hJ+P++dMRfzz3rctzu3EltOs7mM9uPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mI9gF4Am; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mI9gF4Am"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73b71a9a991so183672b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744060224; x=1744665024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
        b=mI9gF4Amphpxu9BXLPJ7m3GniBhGepSvBPHeXwZ5N8nhD1XVRifX62cD9PeNEDUZmM
         2DVsl2jNmE2+l7tP3Y51wE8pp/ngQGJQ42VV/bmqZT8+4Cyz25Im9QKNw41WIB/WYlkw
         DvADkZqRu+r9V9Wj8No2qjMrvsz/lVeawgItc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060224; x=1744665024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
        b=HtzagaVBIjkexewgXQ1ipyd0j+hf25VohHz/s8AFDZRyFKyLENpGS3GKMGyUuD0oLO
         qrqZj7Xmj3QJl3biopw0147x3MLvZMfQWGFtgxLmcGZjPBC41JoZ6SMXR+x4v3e1fDEM
         VzV9T/my7pG8kPXyi2CIKavv71hTsGIOI99hOpuPgnd0zHsRHHQoTlt7xO5C99ga67Nn
         shJHLktpB9Exg7nymzOe536uubrHOuj/lzJyTX9Gb9Ag67hYryI20dbgxUGgzvilYIEu
         rWNOnGuwCtYamd1eovs6fSJwk7lpxcG8ZnLszioTe+CaOLgJSmtPMNMWmAt6qVwgGyci
         mgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOGhRjSjZPH88F7xg1QLtHp4t3IDH/Lk/rJ7begTDwtxzEa4J8H+f0gBy9t+D3gomhP1pGEutPMPIx@vger.kernel.org
X-Gm-Message-State: AOJu0YxeacgzwPTRCjhpXVXwfKQRO6Eo8wn30ECP0CHLlT8oni97F5u2
	J33zN2rzNUujulpPRP4gRFEO+8Rd6/c3+aJnih0v/isWPR0Ca9VDPG+BLv06nEK7sFwRFpaUU78
	K7A==
X-Gm-Gg: ASbGncvGG00XjtBQvWpXThdgxDbfYMgW/XoZsPG2f6+qSFaUhntAO99MQwepg9dW1MJ
	gjoi7QkMgLqoGI04rIyPiU/EarxCLYoqQdNx83CIdGqWzg5t9odHHy1gUN3d48Vq2hPMZc8GpYC
	pnXY09m804nZyYOgqcoJVxQMvXOa//sxwuj0oAUi2b8EiQD3OpevINuYs5B3ijaaC0B/ilfLgsp
	1lGrOJVx7sJUm/4j0VTb+0lKhMmVhPMoykl1v7SkEjqIHOniCkiTP1XB43i0z/6NSAPhiTKTS2r
	Vopvy/g10nYJtGIM226JM4kBgC4N15avFl3Q0wWNnwi+0/AqX/4BKVgICFPW/uWLCdJXIHljQS6
	YIz8NDgqCdLeI
X-Google-Smtp-Source: AGHT+IHeZS2qBYLzWmiYFwI8ybMViCzg4jUvS3Cj1be8bPktu8XTRzpRHoMA3U53A6s0a7uJ3FVsmw==
X-Received: by 2002:a05:6a21:8dca:b0:1f0:d1b3:7b39 with SMTP id adf61e73a8af0-20104456123mr7997388637.1.1744060223858;
        Mon, 07 Apr 2025 14:10:23 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9cc090c72sm6144548a12.50.2025.04.07.14.10.23
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 14:10:23 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af6b02d9e5eso3311239a12.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 14:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaa+WrmDxiqTfTZVfcNLAn3xxJ/d91FEFfYxzRKO7hTbnKnIMZBtk6CUsU+oy8deldi6cCFkcNiT8e@vger.kernel.org
X-Received: by 2002:a17:90a:d646:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-306a485e486mr21065018a91.9.1744060222504; Mon, 07 Apr 2025
 14:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com> <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com> <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com> <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com> <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com> <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com> <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com> <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
In-Reply-To: <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Apr 2025 14:09:55 -0700
X-Gmail-Original-Message-ID: <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
X-Gm-Features: ATxdqUE0HO7NR8RDwJ6zzKPsdwnp2tanOwCvCL2_IqsDFdqHWotUVnDaMU86evY
Message-ID: <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org, 
	Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:47=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>> Heh, but that one said:
> >>>
> >>> +\item[ VIRTIO_BALLOON_F_WS_REPORTING(6) ] The device has support for
> >>> Working Set
> >>>
> >>> Which does not seem to reflect reality ...
> >
> > Please feel free to disregard these features and reuse their bits and
> > queue indexes; as far as I know, they are not actually enabled
> > anywhere currently and the corresponding guest patches were only
> > applied to some (no-longer-used) ChromeOS kernel trees, so the
> > compatibility impact should be minimal. I will also try to clean up
> > the leftover bits on the crosvm side just to clear things up.
>
> Thanks for your reply, and thanks for clarifying+cleaning it up.
>
[...]
> >> IIRC, in that commit they switched to the "spec" behavior.
> >>
> >> That's when they started hard-coding the queue indexes.
> >>
> >> CCing Daniel. All Linux versions should be incompatible with cross-vmm=
 regarding free page reporting.
> >> How is that handled?
> >
> > In practice, it only works because nobody calls crosvm with
> > --balloon-page-reporting (it's off by default), so the balloon device
> > does not advertise the VIRTIO_BALLOON_F_PAGE_REPORTING feature.
> >
> > (I just went searching now, and it does seem like there is actually
> > one user in Android that does try to enable page reporting[1], which
> > I'll have to look into...)
> >
> > In my opinion, it makes the most sense to keep the spec as it is and
> > change QEMU and the kernel to match, but obviously that's not trivial
> > to do in a way that doesn't break existing devices and drivers.
>
> If only it would be limited to QEMU and Linux ... :)
>
> Out of curiosity, assuming we'd make the spec match the current
> QEMU/Linux implementation at least for the 3 involved features only,
> would there be a way to adjust crossvm without any disruption?
>
> I still have the feeling that it will be rather hard to get that all
> implementations match the spec ... For new features+queues it will be
> easy to force the usage of fixed virtqueue numbers, but for
> free-page-hinting and reporting, it's a mess :(

If the spec is changed, we can certainly update crosvm to match it; I
think this only really affects a few devices (balloon and technically
filesystem, but see below), only affects features that are generally
not turned on, and in many cases, the guest kernel is updated
simultaneously with the crosvm binary. I'm not opposed to changing the
spec to match reality, although that feels like a bad move from a
spec-integrity perspective.

Regardless of the chosen path, I think the spec should be clarified -
the meaning of "queue only exists if <feature> is set" leaves the
reader with too many questions:
- What does "if <feature> is set" mean? If it's advertised by the
device? If it's acked by the driver? (To me, "set" definitely hints at
the latter, but it should be explicit.)
- What does it mean for a virtqueue to "exist"? Does that queue index
disappear from the numbering if it does not exist, sliding all of the
later queues down? If so, the spec should really not have the static
queue numbers listed for the later queues, since they are only correct
if all previous feature-dependent queues were also "set", whatever
that means.

The way crosvm interpreted this was:
- "if <feature> is set" means "if the device advertised <feature>
*and* driver acknowledged <feature>"
- "queue only exists" means "if <feature> was not acked, the
corresponding virtqueue cannot be enabled by the driver" (attempting
to set queue_enable =3D 1 has no effect).
- Any later virtqueues are unaffected and still have the same queue indexes=
.

The way QEMU interpeted this (I think, just skimming the code and
working from memory here):
- "if <feature> is set" means "if the device advertised <feature>" (it
is checking host_features, not guest_features)
- "queue only exists" means "if <feature> was not offered by the
device, all later virtqueues are shifted down one index"

---

The spec for the filesystem device has a similar issue to the balloon devic=
e:
- Queue 0 (hiprio) is always available regardless of features.
- Queue 1 (notification queue) has a note that "The notification queue
only exists if VIRTIO_FS_F_NOTIFICATION is set."
- Queue 2..n are supposed to be the request queues per the numbering
in the spec.

This is how it has been specified since virtio 1.2 when the fs device
was originally added. However, the Linux driver (and probably all
existing device implementations - at least virtiofsd and crosvm's fs
device) don't support VIRTIO_FS_F_NOTIFICATION and use queue 1 as a
request queue, which matches the QEMU/Linux interpretation but means
the spec doesn't match reality again.

Thanks,
-- Daniel
