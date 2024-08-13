Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF7194A68
	for <linux-s390@vger.kernel.org>; Tue, 13 Aug 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543661; cv=none; b=b6OVp7JlXRaYJBE3XTC8Mmw/n6pB/QJTyL+/3nl6N+yYVRxDoCv8+TFXwggWjesNZ8IPwA/6oosi4HfZjtW6eQ1kdD8lJFJ6mgoLDQP2H5Ktg03G38phnFudw8fLHH9+OhuC9vLatxEEyomaTs+MrWbgoVSIzdCT3fDW3XgG/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543661; c=relaxed/simple;
	bh=cA24tO7i9G/GDE1s5IJxXRUiN/TXziKBGY9w7HFZfUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF9upU2RhmLpoHNIZB3LWLbLQTL3l/enXTbqnW3C4p93p35bI4l36IoKrj80IJ/ag3qQ+PkeC4aLtn1pnTQHT8toPF9R+PeiZ/H3ZXN35WI2YPqVYyPZhD604vjeuU2gBlIFeOVUFxWFb+Y9ywG3aD6jcDW2zcx2hlMvAC7XAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJBEWGUx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJBEWGUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723543659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayrcUa2Cjj1GR8I5DzWLOmLEl44tVeoFpEY59iLG3hI=;
	b=AJBEWGUx248iAp6uW9ImlzLQbTVDjrx43v9ldu74goEQIUHMf48kS+7KAPNq0+m+xmzGts
	E05ZijGQxXZDMDw1YNjPQIuxP2XyZQwpvubHElImKCEk3eDt73LzEhWE8PuEdW5qcCZbMa
	k8i8WsveQnPmJukuztkMo44TNBTqdZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-A1gpbjQMOWaTSohnybBGig-1; Tue, 13 Aug 2024 06:07:37 -0400
X-MC-Unique: A1gpbjQMOWaTSohnybBGig-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso39376005e9.1
        for <linux-s390@vger.kernel.org>; Tue, 13 Aug 2024 03:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543656; x=1724148456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayrcUa2Cjj1GR8I5DzWLOmLEl44tVeoFpEY59iLG3hI=;
        b=OYVTgcqgzpT4CBbTbAJCntCahCJM88OZi48crYyfY/jd83utXxVH435x1sf3YGEjcB
         wY6mD/VThIWC6h0+vInzZQrBWfCtwBnm1uRvN4xly2vW25unUJj1Hnj8Ciec8MyKeirg
         xWGbZsfTG9JrV71h18eqGSY/Kfcs/+4QHC7jzwf+7ULyodoc3AtP/Wd6nz1z+JB/coe5
         hOeeP+pv7taeN7NB0oTtYW5kiJDVyydwH9rniTBn1U7FskH+E9gw/Yq/ekYd4LDUerwL
         NvRU52XZp3Dn9DmSCZbiH6lwP0JUsudz84vn3gTvkvYT94r+ZfFBKOC7eBTjzL9UUS6V
         lW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbEilsi8Ma3kIikgzgl5u50UAlRidoQ55GEXAo15ss4P1Qq/LZxA5NJCQBqzfYUy0NAhjQSub2ajhJaDC4O5zNMzk6xXmRS5oxvw==
X-Gm-Message-State: AOJu0YwwAb4kDnVjt/UM2+69oz0dhtLVOHZlqMilatf5f9X/KZHZIPLM
	r25sEMETx1wL9HOWfZGksnr3f0yhco9ixQbA0Za+WCo/IIjnGc7xnj2jc9utKkxGtb53xzNOfmO
	+V1S0lOFUxiNFcJg0S1h/hsxSbWXq5aURtmkIZ2sSO5Mmwg0VVp+kD9PVc1Swa9SzmBT1BzHKD9
	7jsweNX0gSQnJ3GjT59HzVYFBoRO3cDQyGWA==
X-Received: by 2002:a05:600c:4584:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-429d48993e6mr24093205e9.31.1723543656530;
        Tue, 13 Aug 2024 03:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0A1+m/OfNnQkWW+DUzpN48HQJNeC102IZvxAtZTbl9fqTDMfEUwcze07w2IIual22FG3gtXHXVlFqSZqNiRI=
X-Received: by 2002:a05:600c:4584:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-429d48993e6mr24092965e9.31.1723543656095; Tue, 13 Aug 2024
 03:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808150026.11404-1-frankja@linux.ibm.com>
In-Reply-To: <20240808150026.11404-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Aug 2024 12:07:24 +0200
Message-ID: <CABgObfbKUKeE89OeZe0HM+iYy7vDGpn+BPUgWMadtE=LnXVD_w@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 6.11
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:01=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> Paolo,
> two fixes for s390.
>
> Turning gisa off was making us write an uninitialized value into the
> SIE control block due to the V!=3DR changes.
>
> Errors when (un)sharing SE memory which were previously unchecked are
> now resulting in panics since there's nothing that the guest can do to
> fix the situation.
>
> Please pull.
>
> The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28a=
ed:
>
>   Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-6.11-1

Pulled, thanks.

Paolo

