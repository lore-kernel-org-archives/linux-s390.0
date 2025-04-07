Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE76C148
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047582; cv=none; b=F579u/0MJVDxG9E2/msh30TEgTyFkNZzTBvtD2KvgTGeVEGAqTyVdzej899NzFIYuuubBoFJLpDMsmR7ojbJjtzvyK2KSegIAIsgJcdAxaGuY1dnjJeO4kCY0V6yPm7uudSMpWrOCfyEnTxx44UOY6rvlJqfLYMI2nKzNlOzfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047582; c=relaxed/simple;
	bh=gk7Pms5ggU4Mz+jBefE6aQUbZOdAXgc3uKZ/o8JLcRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwZrrRxanJvDDVDgr8N6gzKL8LJrs4SGtjT0DlrbHUQ1eeeqBF4nZRz1ZWk8tHLYb4qwGUHssZ8JJjOvEWfcohMAZjyxSNMdag4h3U5TGVQfcgSydLF448Mdew83WgOmU1ECpHzI9tgVhX/oCP5QKHcv5ob86+xTlU9NFjTr89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQxc0De9; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQxc0De9"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2241c95619eso8378195ad.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744047579; x=1744652379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDFKuqPeswYIIkk2eM8stbEtqZO/k06yxbdJkpWX+KA=;
        b=RQxc0De9w7hArU7oJoscwkGBPZ87qz+4cm7nY1UG5C39SlZFz2Gn+vO7XcaLabqZM4
         CbgoBi8kAa9AQPcJdPrw64wIM0VFO2sPJ5rePwe0zeX7KsGOzNuojSH+U+ol0LQ4UEGU
         Q7wqdGanU2ehuMwmFsSfgzaIR3rCLtYBzb6cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744047579; x=1744652379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDFKuqPeswYIIkk2eM8stbEtqZO/k06yxbdJkpWX+KA=;
        b=ZeoYxyC0f8p3ZLYcHdKK9cBYey+efKNUaiZdbw1i0SGeEdX9vzTcR2pC3mCoxJsaWU
         X+DQKCRYGBNsjMsHNiiQ5FcfkdO8+fmLdA2MFLPInacewaJrxpFQW2Q/eupKxMPtraCk
         Gp6vu7xyIWAxL4J+8qJ0+hEHKy9gFbkt+OJhxKn8SQpzuEdLwNIq9ER9VveNvSqVahmh
         rUsx6OnAr8QknMjfJG08poqa4PG+JkXmtCp4bqpAxYwtd42Fw7lDeR1MfC9o3Jkvitv/
         f0XJbRtLx3joqca8BZqOM7xCFyaWwqFaAK8cCzTsGOKWK7JPNlQQG7Tm48eJFP251pL5
         QEgw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlHTcJzVHPRYebWAIQFvyYunzW7Ofk+ICtjC8lAyiq1tRxrrvydUy+IvuE8uuD86ByvVn6XVRPjwF@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9UQwOex7GLCbx6hKdbCS8LfrTeQAqjOBs+gn89VZhb6urAgD
	p81zKk5fOUvvyoBiuT+SJAPCYQmGUZY8YQYIJ2Ctdv4EkBIxOfPkzwcTAc+EKWFB+twft50kEHm
	zlw==
X-Gm-Gg: ASbGncudn9WLQNisHhaAbQ3otrvqztHHzNEnWT+9gGnGGqOMZdCzRCnHrZE2j9x9b9R
	VUOdTlqnpzaeSIyrHUsGjMMGNjSSDPs0dK6EZ/fFAQDiXiOQzSz7dwigprGa22OepjLFdqDh0Jh
	o3pTPW1N7wWiDqRYXcYX/CRI8u3CFyOrWGsb7JNqj0gMPdAsO1Ag37OmOybGAk91KAqVZx7OxCV
	nOIFh0PTGJO2iUxjdboU8kUvMaU1CArN5l2DSkdMOhB4cN3JObeEFN2OeXKnl5dC7i5qSAZ65X3
	6hNJsRz5b6sbyn3fhMGpILlyBHqZ1/EjWQhlgJXFVlNzg+OBETq8zZnv5YoXX2L8WeUUg+fn0kV
	+nnjYHbkc
X-Google-Smtp-Source: AGHT+IGLPGuz1kxtjYBgS9jxS/pGl4kcOjGEZ/leyNkYXfnFhQCMd3Sl34m/6h5cuRoMySvYNkcA6w==
X-Received: by 2002:a17:903:292:b0:223:4b53:7349 with SMTP id d9443c01a7336-22a8a0a14c4mr71919805ad.11.1744047579602;
        Mon, 07 Apr 2025 10:39:39 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad869sm84042285ad.26.2025.04.07.10.39.39
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 10:39:39 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so3498919a91.1
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 10:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+nmWH8VyeRQ20K5rwcHI26mfdAmps3Zd3k9aoUbK50FpAx3YUVQeAOnMIsJ26iEE0Y3biDwKZC999@vger.kernel.org
X-Received: by 2002:a17:90a:f945:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-306a4758cf3mr22729577a91.0.1744047578869; Mon, 07 Apr 2025
 10:39:38 -0700 (PDT)
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
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
In-Reply-To: <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Apr 2025 10:39:09 -0700
X-Gmail-Original-Message-ID: <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
X-Gm-Features: ATxdqUEz43TGWrMKYfRndFlXjP-cvulXZBTkkQ4WcXYsTky_PROiRhjDfo9dcJs
Message-ID: <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
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

On Mon, Apr 7, 2025 at 6:13=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.04.25 11:13, David Hildenbrand wrote:
> > On 07.04.25 11:11, David Hildenbrand wrote:
> >> On 07.04.25 10:58, Michael S. Tsirkin wrote:
> >>> On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> >>>> On 07.04.25 10:49, Michael S. Tsirkin wrote:
> >>>>> On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> Whoever adds new feat_X *must be aware* about all previous featu=
res,
> >>>>>>>> otherwise we'd be reusing feature bits and everything falls to p=
ieces.
> >>>>>>>
> >>>>>>>
> >>>>>>> The knowledge is supposed be limited to which feature bit to use.
> >>>>>>
> >>>>>> I think we also have to know which virtqueue bits can be used, rig=
ht?
> >>>>>>
> >>>>>
> >>>>> what are virtqueue bits? vq number?
> >>>>
> >>>> Yes, sorry.
> >>>
> >>> I got confused myself, it's vq index actually now, we made the spec
> >>> consistent with that terminology. used to be number/index
> >>> interchangeably.
> >>>
> >>>> Assume cross-vm as an example. It would make use of virtqueue indexe=
s 5+6
> >>>> with their VIRTIO_BALLOON_F_WS_REPORTING.
> >>>
> >>>
> >>> crossvm guys really should have reserved the feature bit even if they
> >>> did not bother specifying it. Let's reserve it now at least?
> >>
> >> Along with the virtqueue indices, right?
> >>
> >> Note that there was
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html
> >>
> >> and
> >>
> >> https://groups.oasis-open.org/communities/community-home/digestviewer/=
viewthread?GroupId=3D3973&MessageKey=3Dafb07613-f56c-4d40-8981-2fad1c723998=
&CommunityKey=3D2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=3DVT
> >>
> >> But it only was RFC, and as the QEMU implementation didn't materialize=
,
> >> nobody seemed to care ...
> >
> > Heh, but that one said:
> >
> > +\item[ VIRTIO_BALLOON_F_WS_REPORTING(6) ] The device has support for
> > Working Set
> >
> > Which does not seem to reflect reality ...

Please feel free to disregard these features and reuse their bits and
queue indexes; as far as I know, they are not actually enabled
anywhere currently and the corresponding guest patches were only
applied to some (no-longer-used) ChromeOS kernel trees, so the
compatibility impact should be minimal. I will also try to clean up
the leftover bits on the crosvm side just to clear things up.

> I dug a bit more into cross-vm, because that one seems to be the only
> one out there that does not behave like everybody else I found (maybe goo=
d,
> maybe bad :) ).
>
>
> 1) There was temporarily even another feature (VIRTIO_BALLOON_F_EVENTS_VQ=
)
> and another queue.
>
> It got removed from cross-vm in:
>
> commit 9ba634b82b55ba762dc8724676b2cf9419460145
> Author: Daniel Verkamp <dverkamp@chromium.org>
> Date:   Thu Jul 11 11:29:52 2024 -0700
>
>      devices: virtio-balloon: remove event queue support
>
>      VIRTIO_BALLOON_F_EVENTS_VQ was part of a proposed virtio spec change=
.
>
>      It is not currently supported by upstream Linux, so removing this sh=
ould
>      have no effect except for guest kernels that had CHROMIUM patches
>      applied.
>
>      The virtqueue indexes for the ws-related queues are decremented to f=
ill
>      the hole left by the removal of the event VQ; these are non-standard=
 as
>      well, so they do not have virtqueue indexes assigned in the virtio s=
pec,
>      but the proposed spec extension did actually use vq indexes 5 and 6.
>
>      BUG=3Db:214864326
>
>
> 2) cross-vm is aware of the upstream Linux driver
>
> They thought your fix would go upstream; it didn't.
>
> commit a2fa119e759d0238a42ff15a9aff0dfd122afebd
> Author: Daniel Verkamp <dverkamp@chromium.org>
> Date:   Wed Jul 10 16:16:28 2024 -0700
>
>      devices: virtio-balloon: warn about queue index mismatches
>
>      The Linux kernel virtio-balloon driver spec non-compliance related t=
o
>      queue numbering is being fixed; add some diagnostics to our device t=
hat
>      help to check if everything is working as expected.
>
>      <https://lore.kernel.org/virtualization/CACGkMEsg0+vpav1Fo8JF1isq4Ef=
8t4_CFN1scyztDO8bXzRLBQ@mail.gmail.com/T/>
>
>      Additionally, replace the num_expected_queues() function with per-qu=
eue
>      checking to avoid the need for the duplicate feature checks and queu=
e
>      count calculation; each pop_queue() call will be checked using the `=
?`
>      operator and return a more useful error message if a particular queu=
e is
>      missing.
>
>      BUG=3DNone
>      TEST=3Dcrosvm run --balloon-page-reporting ...
>
>
> IIRC, in that commit they switched to the "spec" behavior.
>
> That's when they started hard-coding the queue indexes.
>
> CCing Daniel. All Linux versions should be incompatible with cross-vmm re=
garding free page reporting.
> How is that handled?

In practice, it only works because nobody calls crosvm with
--balloon-page-reporting (it's off by default), so the balloon device
does not advertise the VIRTIO_BALLOON_F_PAGE_REPORTING feature.

(I just went searching now, and it does seem like there is actually
one user in Android that does try to enable page reporting[1], which
I'll have to look into...)

In my opinion, it makes the most sense to keep the spec as it is and
change QEMU and the kernel to match, but obviously that's not trivial
to do in a way that doesn't break existing devices and drivers.

[1]: https://cs.android.com/android/platform/superproject/main/+/main:packa=
ges/modules/Virtualization/android/virtmgr/src/crosvm.rs;l=3D1079;drc=3Dcaf=
f2827914c0918260ff76cd55f6e3dc6323d51
