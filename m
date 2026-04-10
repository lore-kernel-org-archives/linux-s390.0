Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1343E3D88
	for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844611; cv=none; b=JHoZ9Ba0qfoQgtrLLA4RO1+yKUG7U7n16O7raLBU6l6pQqKpizhhwuoi3yniS/5JIeR0Z+8wfT7y6U57llfuz8H5khC4pl/2OI+xpHw/NJJO7FPc02RoyszIngJHq5sMHzj65L3RBZMUy8NcWWP5sQdOH9ZEv3vIIoKq+wWe+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844611; c=relaxed/simple;
	bh=RiAMebESLDrerCCB8z1EG9HuC2bXXUuvqFJqYdbBxEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu7syox5GsK0bfBYz/m9OhDobkj70FR8XkKbECE5+CueX9eF2ITjjJXMWCFzHS5YOMpz4Ao7XkEhDFGI+fD4metZQKtdP3IrhXpR0zxBW9KBoXrKDfhL4SBzX0zp+Fk8/kJt2x2K/L2MKGjX6tIoOUAlaXHYRu3DtA3Tn9930I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AeFrUdlk; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AeFrUdlk"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso26345436d6.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2026 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775844607; x=1776449407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qcUdSYVXIPHlYutMHlgKYsq8bY8kP9mulymhE30xKo=;
        b=AeFrUdlkTUWparOrp/LLvrX2gTzgnnJjKnTLtA8SoBZvRgJUICoIyCLNsCA5nl7qrt
         2oY/fQIQj1pczKtCbLO8Q5J4jUjcj75aXnD6tH8xKPL14AgKh+MF8JJj5clQE9E238bx
         CWtDoGD47gzmF/HKFJyb6F9R5tjF+Cy1ZE/gMQpP0m19NKkZs14WlGN4I7QwE8zFiiEj
         1hiILgRugrHGsa7XP4MxUkbYgFFkxHo5cZBfX3foX3uhWFXmgzmuQ6fSgpbU9qX6wRHp
         veTcmZGl73SVPQEeHICJIXXuFJ6/8ZYL7tOHDfGB9mi7MCwqF+xTXlqWQiIphlVzyTkH
         F95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844607; x=1776449407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qcUdSYVXIPHlYutMHlgKYsq8bY8kP9mulymhE30xKo=;
        b=Qpg4C6uP9PutvOUyQTj+OSQpnqf8MSqh2GVljH4PZulx1qGXuwgg4bQpDRuQHR78lp
         jw+P7dY66fGdfLMxAIR9wcPOni5/RsLacmwytYLsIjTu7rrIPK1aCVOpFRUsiv1AGwaX
         VCa4jkrHAGpfsdjOLrCFAfg3mVvmK5eEyd0DmVWZ1tthKX7DS3ibJLDGzLEByDUCEiSX
         2t2owPKrjGwC+yQHD1BZ3e6r8/+mMWsHOCy3XeCTZJYTt6kezyJgbX32xiI+IZ9U5jlK
         213e+jMatZEGRwHzTp8XETIkN4V4uIs0343sRBzAdJXmEStTiQN5KkcDlTQgNCOozdwR
         tldQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB6JVBFWc6E7bBlgpc1tKqeO0SoiI0I88xz2C2y+0ChZg4nWDC8CEqW516bkC5NOtJZOV74102w7AJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQ7ZXcqu2c6dI4eAj7MNfrsl2cFYr6Om9Fc7qr3VKOFgsCV2M
	Wsp16/kfpxsc6dyDoXylXamaj5dAE+UZr6B0zxxd4hcHmfBNubQmeRW147aOlEQCBj0=
X-Gm-Gg: AeBDieu3JrzO6yc9VOypKbU0EP7XRVZvaj7fA/4h05d4Emrbnk9JrRm5bRibbodqR+9
	V/O4lKNew+b1KPo4wEiWf2BIJmyOyIbNec435GnPqEJ6Ln6hX0G1bDvPaN2c104urfz0LsM1v5n
	AC/vqepEQ3W1eUHbLEI6SR8Otf9neru2uzi38Uf2Pc0+Hw1Fhqc/or70xA/6lfGVmlKu01lU4kG
	G/n3neZJBTz3WjuFMVpYB6v2kn6Day3muAiqG/gbdxq8ub0PNoBTVxfS11AD5VBIwgosATnaFxg
	zygzF4Cor5if0kJZse4C7pguSCBajJ5ptp5m8Mdze0Xol1PmqR9Ri4Zn0Zo87tIWOqS7DGFJzu3
	Pawk3Ks/FTmYZlw1WS/t70mJRM4QavshFHAzVK2dHIFp+wAvVlVnQnAIwXSp9eNQMLb1yw8JhLP
	e6zQ9uMrxGqp43TyKNy6wrSNZmkdY3misP7P9ey0uJ4zZJ4/aq4dAAIZTOg0B67UD2yRpcMw==
X-Received: by 2002:a05:6214:311e:b0:8aa:7239:b027 with SMTP id 6a1803df08f44-8ac860eb50dmr69122416d6.14.1775844607550;
        Fri, 10 Apr 2026 11:10:07 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a4355esm29526906d6.19.2026.04.10.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:10:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBGIw-0000000FPVf-23hv;
	Fri, 10 Apr 2026 15:10:06 -0300
Date: Fri, 10 Apr 2026 15:10:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	akrowiak@linux.ibm.com, alex@shazbot.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] VFIO: remove dead notifier code
Message-ID: <20260410181006.GF2551565@ziepe.ca>
References: <20260407175934.1602711-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407175934.1602711-1-pbonzini@redhat.com>

On Tue, Apr 07, 2026 at 07:59:34PM +0200, Paolo Bonzini wrote:
> group->notifier is dead code. VFIO initializes it and checks it for emptiness on
> teardown, but nobody ever registers on it or triggers it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
>  drivers/vfio/group.c                |  3 ---
>  drivers/vfio/vfio.h                 |  1 -
>  drivers/vfio/vfio_iommu_type1.c     |  1 -
>  4 files changed, 6 insertions(+), 17 deletions(-)

 Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")

?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
