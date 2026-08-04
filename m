Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10653DAAA4
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847688; cv=pass; b=iV/ilLKkUjdd/jRM5NA2F6uL1zGmvnakXIF8YGW8D8OpILsGd+7czo++myyDTFFN6bFQFKES5Tis6TpC5ZNKcaTEIKH6WZk+oOEsxWxciLN5IDwIwJnUwN7oY5wfXIEI/aAh9LQPyM+tq18z6zp4JkWIEJuLYxJTWFk5Y/EnUn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847688; c=relaxed/simple;
	bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+FU43BSc9X5MBrthlfkjSvQDgYEq3Z4/d3ilfK77OSTAKFY5+cDUGBhpryxw1Rd2laihDwX8O9ISI00S9HaXGqd1/K4uYRvjekfeR779/y3DvpNcTU8Z+E8hn/FnWrbA4hyYjn0opB/7g8XPL/6YiXKAJgRxhc/3gMk9CXZ2lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5HGzORx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfIWq7Xu; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5HGzORx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfIWq7Xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785847685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
	b=c5HGzORxZ9zK3MZ5oRK6UPSr9PKBWNHKdixROta588TKM+RjrjM5cCa9pOQeH9ebW3kKdI
	Ba5ptNLZ1ptjjezrAaikFgClLJLjyvj4N2TLmlSuyWU6a2jKkwLtceWjYmYkn/E4+RfjRY
	5LFX8gFg6Oez2OqyH7EKGe4gUzd6MEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-eTSA6_8sOM25aI4WW33kJg-1; Tue, 04 Aug 2026 08:48:04 -0400
X-MC-Unique: eTSA6_8sOM25aI4WW33kJg-1
X-Mimecast-MFC-AGG-ID: eTSA6_8sOM25aI4WW33kJg_1785847683
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f810c8aebso2786512f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785847683; cv=none;
        d=google.com; s=arc-20260327;
        b=WzbzWqzs+7K5L9IJ9MWObefL/V6K/2akv9DtsGvqk57Z7Uc/Fdfmw32EhxhUUmiPZr
         KSIFJgWfKgmGO/5Dwlu7Ki+wYPYB4xeoQn8LAHgoSDLc+oFH9c6lXPslPChBFaIcRLQj
         l5RWBaEVkqMQk+L2UvqcprqUtAXAbda4wB8i1ab7z64q+MyzdO0uuVFPQ7RgpaND3AxD
         sO3cvEPgQrnX5CEgxXNZtRge6jjuTRd7qLo3gxXoMntQJyTeKyzlgeqTBv70z+Ty3/ud
         yWGzZg0FIOVYoVyRvg53bZzlGTETCRfWK9y/snzVAVZmrg1FnEbTwvcWVrOCUQ5oDAiq
         dlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        fh=nH6W43cbnpfKCHaLineD/lsz1XLMptBco3Evz4ucsCw=;
        b=SUopXEWPGAXaXPn/Dw3GQCgmtZxqANNyfTk32yIxmndRdCBla5M/wxm3bUf2AoLwnM
         TWazwAJfhaIcmROvhdwZmrfz1Gr06riGWMCCdDeUi520S53PzcZHspSJYkZ96uS+7CwP
         fUuu0jwYlEZK38CwYmLONEAnmOtXXXJa0RkSLgRmwDWMVCig7/HZFwrEt3xew/Yzj90B
         ZNMygbLydL1GiN2KVh5N/9cbtj/j6u0Cbc1sI+6WyJQLP4Bn31bDz6vSYsJSGG9yNE3A
         pls3aA2xPeEEFRJfSfSPKdzTb1yOXs7WZxT3dBck5HLnn4QRq1EKRw2xOgTM0uTbn7mS
         SmAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785847683; x=1786452483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        b=tfIWq7XuVfo3Z+PpXyCPMzqZW52bZxDVQqzC6SvXen6tv2vLpPDs/J1TmU68MCMGUU
         FJZu7QNfqbv2L4TwdIJBpXfLf9tSpfiUNiuZ1pX57NCabFIxlKMW67zKDMBv3yQdMnZq
         46sza90hZuh14teC7t9FuVASWB/V8KnR+slCSPtSxDEXJ4sozgmgAhZ5844OtOJXtiGG
         gKJ3Xu/AWuhpfkNSMMKpr0oKKbgfx0f99xiCEcTVOz3e8CwgeHVguOmNQO9eqqYyBZNV
         eDIGj2imlVOaSpsqJ2Z+DJptaDaor3xIEZZcXAFuHs2KrJRUm7JSDfMV+8oaDlRHlieO
         Qmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847683; x=1786452483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
        b=VwOuBUOrFOZy9lxyTimAR7+0XkcPs5knVimIgpf65h3gHMAGO8uBqv6wAWGHKyKP+N
         ZKmDv6App3ZljKqSXqkknCmO/ECnFNkkXQ5Jb3gLxA6BAo+P3zcIGoN0WDS/lF0rIMhW
         78EjnG4xl4iC1f38JNDHMowTT3M4lb00gfoIZkj0XwuDf09BuaaSTypaoEzXSvZe81ih
         sby+QQj9BNLapcF2jmFLvn7LRpWyaGsFCMqMurPGyn+EkPnVX1meFB0UzNW8aledIxJ1
         HDdalv2g4woqeBJLGWdzlBIK18lrDqKBbeSNA2V+erIon31ieOaaD/kD42rrjRQi4Yxf
         pU3A==
X-Forwarded-Encrypted: i=1; AHgh+RriKyxjRMxpL6uN5wcK2xlou6Z0OJTF/pX5xiE+4WVsSTOGTbatmy9EQioddC69dyqfdSBNFw1eA03x@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBvss5e2bxsF/+TafoMLK3ayxWz8vz92U7DBFeenGzv+JdlPD
	zBNLIHDzJI0vUjs82xRB6CZtLE3gd6skOD1XQmJTVB0CbeS9h3ROWH7/6MuplXa2stl9hzZlgHT
	sLYXy9h3DUOf1PREZ699vp2g1OsBVZmctT+f5D5W+mQfegfB4tLJK/9NDhDbnme4lrT5jdKF/ko
	hXxPE+hQJ2ejanCy2Wp9lq1xzVEOlt+9XmXbj0kg==
X-Gm-Gg: AR+sD12zgG2tWH0ZtrUur2oSemYnAu9f7rtHS6PW+5JZm/iuDhauy3o/93WCBVGNwRp
	mdgoFE7ye2t7qexFdQqvgUBsMjwT+uQAa+3GiZNFfgimsRWXB6dBCpGvcafOk9jQudr5aJXj7KL
	TR6/e3vup+qIXeLim8pGp1Zkhlq4tdxTAPRmSnnRy71++TU18o3tPBBMGoEF6seeiVZd2Owal1p
	xgtrNTACLhDMjJiosN5eXNP+DDS9T04xw9gk0hx9QZ3wcrK7rBys+Dh/Yc=
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-47fd72ba981mr33399485f8f.8.1785847683369;
        Tue, 04 Aug 2026 05:48:03 -0700 (PDT)
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-47fd72ba981mr33399406f8f.8.1785847682947; Tue, 04 Aug 2026
 05:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-4-pbonzini@redhat.com>
 <20260804122128.838941F000E9@smtp.kernel.org>
In-Reply-To: <20260804122128.838941F000E9@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:47:49 +0200
X-Gm-Features: AUfX_mzc1UECOTjr13bdYLDwoSBcmazBIfNKBtso7fBXqj8NWhSnjvnTNjTJWfA
Message-ID: <CABgObfb9-cEUykbZD5C5LMz8Otk8hJk-OCzgRq=HvU3-s9NSVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:21=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Missing dirty page tracking in vmw_bo_vm_fault() when prefaultin=
g fails, leading to silent data loss.
>
> Pre-existing issues:
> - [High] Inverted error handling logic in ttm_bo_vm_fault_reserved() hide=
s primary fault errors and propagates prefault errors.

Fixing the preexisting bug avoids the other issue - I sent a patch
separately at https://lists.freedesktop.org/archives/dri-devel/2026-August/=
586696.html.

Paolo

