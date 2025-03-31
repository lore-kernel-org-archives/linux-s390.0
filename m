Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D911DE2DE
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415802; cv=none; b=EdJ0zUbGkD9P5v930XXNfv9k8xTNvS9M7frZ1cq1KTjab9Ckiq5veb/dsEARywqMS+ohED6ZL7/iyMoj88mPkc9HhMP/CYwXpTwM1PzRnisVnbnq1FTPNM5uP9DvD3oZiWJY2RAO0gseeRYuxypI1CMLLUBBRnLyP984hnAdtW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415802; c=relaxed/simple;
	bh=2C+cFpwYqPuZBl966ZPAtxohYZBT2XF7gdhgJCqoZ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbqpCtvK3Nx5FKxh0oa353ux1XCAfqWEgMhd5qzBKcRn5BlwvH8U7L98xIzYZCcSTtm6v+vafcv+/B2FPTp+TGbdwP+XZEAEktGcYclPjyhoJym5RyFRhJA9iCG4xHfk04cGWzhWFpaa5VK6uFbKmh7Bba5BvKwWy9BeEM1ov/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grNu4ap2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grNu4ap2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743415799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2C+cFpwYqPuZBl966ZPAtxohYZBT2XF7gdhgJCqoZ2M=;
	b=grNu4ap2icB4CCnbLWe6ng5NIdIvRoaVeURmRHb5wbwlM8LX24YflV7BCgWV/v9uN2L9EJ
	VCaozKUOBtGCZhluRuIR6VCiVjPP5l0SvMSUfy1NiGJcD8NgwlGDrX09k2Hl9YRvcZpdEs
	b931NpUoXt5/QD+xo7AnztzU2WbxeGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-_fOU98xfP1iKmTb2MmVEVQ-1; Mon, 31 Mar 2025 06:09:58 -0400
X-MC-Unique: _fOU98xfP1iKmTb2MmVEVQ-1
X-Mimecast-MFC-AGG-ID: _fOU98xfP1iKmTb2MmVEVQ_1743415797
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391425471d6so1907628f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 03:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743415797; x=1744020597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C+cFpwYqPuZBl966ZPAtxohYZBT2XF7gdhgJCqoZ2M=;
        b=vVxElr4SdUGKTyogStM2AkWF+NWAPMCMODPae+Jehla8RJwacpgbnT6Nc3YfKMhBjL
         7cwGY7w2Z2eFtktZDUSkoAAZj/RN7e8bIkKUQWqVMUtXR4c7HFYgaqIuqTV69ojkkvzI
         TNHSgJMWIT0Cs/qfKtgFj6fTBPyF1hg8vyzkaOToR2ecaGQl59wF8j9wz+WQq+AEUKXw
         RjX6VAWGXDSggCauqoWo50w1LRJB0Jl6A/bf9phI8J27hokGhr0w4GsFRu9N9wAuvPux
         z3jA5GAVshso4jKe0dy5IyIXdfhhz7XUeyXKeJhCNuRdxzPaJ9pYOCUFzsGiy5iGJdLr
         bifg==
X-Forwarded-Encrypted: i=1; AJvYcCUhekdgJuZ5D9fc8Xyc4ZFKyJQfRAA6qYyNTLKpK3lVignAdlQWJYoBXwRckbT+WcoZJIj4yl/IBCyD@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHqE4u977QtXJCMsa4LH1UrSeQFwDfHCjYLORj4c4/bW1NAz/
	65D/zFhMJS5H8a6gJMUxcd2fzAtNj5fsRytsiCtqwcW6sjiYYZV+hWl9808/qxCrzlNtJAPg5Q1
	2IhjP93r0B/TEN6MHhLwtBE2A55d8eicza5Dog5qtcRS8MGoHxlRPRfCT3Q3p9rnrlvecnEirHf
	hzhw3FLWaeMze3b82McKtgh1DVnqL37cKp0g==
X-Gm-Gg: ASbGnctEZjyA6wyJorPgEBq8h7PMjFF1jW0UxdktjUpWdRfr7rBjWXwFOokGSGLzGXi
	NVIWoVsRijxga0EqYokbtxSxd6mvege/vNqHC8k3O37H9kZifFJ8Q2e/3xKoKI/pBXMO3tVQ=
X-Received: by 2002:a5d:64e8:0:b0:39c:1257:c7a1 with SMTP id ffacd0b85a97d-39c1257c7c1mr6595067f8f.57.1743415797313;
        Mon, 31 Mar 2025 03:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZJk6h5lJDDWBOtazw+tCAeqH2OEGLjA3uXm8fAYK3lITvQem6Jy7CuY03JRzh1ZQXa3lcXdTl3nBe47JoQo=
X-Received: by 2002:a5d:64e8:0:b0:39c:1257:c7a1 with SMTP id
 ffacd0b85a97d-39c1257c7c1mr6595047f8f.57.1743415796957; Mon, 31 Mar 2025
 03:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322111119.24548-1-frankja@linux.ibm.com>
In-Reply-To: <20250322111119.24548-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 31 Mar 2025 12:09:45 +0200
X-Gm-Features: AQ5f1JoXsB2OfNE5y2Vy3gJtj9d-q7iVYfi_bwY9LhJIR_SI8fVtayetOBGbXgU
Message-ID: <CABgObfb6gYHCjNBxL4c3WpL84K60LEvGsSaW63LcDW8aVC=vSg@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: updates for 6.15
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 12:12=E2=80=AFPM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
>
> Paolo,
>
> only two cleanup patches by Thomas Weissschuh fixing our pointer print
> formats in s390 KVM.
>
> I'll be on a conference next week but I'll check my mails periodically
> and I really don't expect problems with those two patches.
>
> Please pull.

Pulled, thanks.

Paolo

