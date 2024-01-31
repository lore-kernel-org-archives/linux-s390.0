Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8C79DC4
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692400; cv=none; b=koboInCjD6pl4Tlmijy8Qpc55qoeb2OHeurge/kGMrHnz/GBqoKTKy7AlSuudhfG3uBGD9jFRkxsVZk7t9AHpP6ZpYP5AVPps8IQlbAc+JA1suBLK5/GIp1gAJdbHK0Kya9szVPyG7qofTLMwwgESHIEHZBA9UgKwev4RJYjsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692400; c=relaxed/simple;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7v7uJ7xTOUbjJCj0tFBfTasMwBbl2ziB+RZ34pcaRu+w5XJYHlCmUXOH1pfGvTl97YIEnihB98OPNdHmvujPM+qn6+5UGobQhigJkJg6jQVUAnyGHuutudklm/XTPMChNsmFHAIlkTnHWwz5Oo/Ix8oZ24r2d7TGNmothTd5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNhod43E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNhod43E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
	b=dNhod43Ejz9Mb8oXENtKKNS0jt7CSQqdFDFasc0HOjXWZOV9KgUnEFoV9f4iTdAoQrRl85
	k1rlszfDhi/oHPry2wTGI0W24A3mEZlwTXXAOtzOZ+Bklfsq7sSXb9OWSvRsFihiwsSqt3
	upwQgaofncC5BMMuKJu91OwoDoMHQIA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-LGGwBhUCN-eGWTtGptL65w-1; Wed, 31 Jan 2024 04:13:16 -0500
X-MC-Unique: LGGwBhUCN-eGWTtGptL65w-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46b51ba4f38so1056310137.0
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 01:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692396; x=1707297196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
        b=XuxNRioxmn1hJEgPbk2fFxBRWFDKUo3g3+SmgCVb6hEqHRbzlBuzNpsOEO6gNoS2KD
         9MUjqHDAJDnnzAJgP5JdjgvKBmfQgxOYSVwYtZzYd4K5dpBGjOQ/McP3XfkK5NQtYuBT
         7Hmwj6CNV0lvEChZ73K1OS1reU6U/TyoLpziSl3i6KUsSxlHv4q9sbfUYZ0d736M/YEo
         EcP1XM6+JSMWZfMkLphaQ2bQxHiz345hGbtrfcbtuzLuLfBhQM5GLZAPv/JBfKmhsK9X
         3dwR0Ts54bydmnyhcDSEjO3+yVMFPsBLM9LvszexfLdhKJFckBEVlndtDSthqM9n/ZdX
         qZqw==
X-Gm-Message-State: AOJu0Yz0MFELCFACnvjoAe951QatUbiATHt1ip8EXrTreVSvuBf39t4d
	+M4yQTK81UBmmTPvwMAziRYEkEKB4OZNiN2HCb40Tm2XrhNfEccFHBCUKhMZ+688+Zaiuu6x70D
	3WJlV0Cpfu2pE3oJnetT1jtu0Ow7JCp3D7OHyAqL0svwsj+D6zARfaP2JXkpQOeWDlVOBbAx6eo
	z9ho7gvejj9ZPE9fsdiH0uVF5lIT3wn/3r2g==
X-Received: by 2002:a05:6102:2753:b0:468:90e:2c88 with SMTP id p19-20020a056102275300b00468090e2c88mr691971vsu.35.1706692395773;
        Wed, 31 Jan 2024 01:13:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlqIGzGC6WJa2cNQxkOvPsG3lWuLc6yY/NsL+Ul0eahHSt+TTWHH5K0CdWrrzXTYNRodEQ2LjsVmuQ6Q+WlRc=
X-Received: by 2002:a05:6102:2753:b0:468:90e:2c88 with SMTP id
 p19-20020a056102275300b00468090e2c88mr691962vsu.35.1706692395533; Wed, 31 Jan
 2024 01:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:43 +0800
Message-ID: <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
Subject: Re: [PATCH vhost 11/17] virtio_ring: export premapped to driver by
 struct virtqueue
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

On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Export the premapped to drivers, then drivers can check
> the vq premapped mode after the find_vqs().

This looks odd, it's the charge of the driver to set premapped, so it
should know it?

Thanks

