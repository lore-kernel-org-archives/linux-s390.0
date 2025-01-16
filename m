Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5435968
	for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025439; cv=none; b=qWC4aGZge5ZHzJmf59VaVg6m1OK4sjNcM1C1VwhVn1FAjKxbR9Fq20c1hNZ5mnxli/IojKaGiuYNU2vu9tTvaDZ3CEFd3IYOkvtZA94M6qyymCFRpg9H+P6vtCce1QZqVciDWljJTA5g5e+9L9wp/p04Uqm9kZlGE029J2RMYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025439; c=relaxed/simple;
	bh=C45cCeDrG8vfRtk2jN2h8nbwhRujnplBzaJGVNw8sas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJXlKLCIJM3is3cyfBkK042P2vOq8c+DX60FD9CY9uMPRHuuEVM5lBNsyb9nhVQYNyQtYJSYqQ4eSE0ZwWv356XMFFsmCztyApyl6pniwvWqhwr1Qk8qfuIHgFNAKX4npnzWAK3O7lug+KbZiSdKZekdnCgxe/Hn7MC15ECQXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJlvJMlo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJlvJMlo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737025435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C45cCeDrG8vfRtk2jN2h8nbwhRujnplBzaJGVNw8sas=;
	b=SJlvJMlog50GODWZBCjX7ORHPoCfbRksTACUGkqASmFV8yqLCZ6+c96AAO8MjUcRpDmoph
	1f89aCcH+pJdm47Hc2ZNfm0SDPOSZ73sNmdoBRABGTo1JsDF9vVYMmnE7WcuxEJvSicC2/
	2Z7ACwtzEPblfM4MhBqaQs/MUjQGoNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-zmpev2dcPM-h2B7xdBFbCA-1; Thu, 16 Jan 2025 06:03:54 -0500
X-MC-Unique: zmpev2dcPM-h2B7xdBFbCA-1
X-Mimecast-MFC-AGG-ID: zmpev2dcPM-h2B7xdBFbCA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dcae001fso370052f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2025 03:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737025433; x=1737630233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C45cCeDrG8vfRtk2jN2h8nbwhRujnplBzaJGVNw8sas=;
        b=GBe4NqQSqNlZR4DyISEOQEF5a5uOXqs7EMgwfXBtrySCh6NsHHY7xIIL1Hu3zVoars
         /sSQA0EhqiaoHILfZTB4Vg/f87/RlAhCUxIQ9j5Dmx/k3HB27bnHGTZbvQKZ16XChIB9
         2VA/Aso3g/3BMmB8QqmxrukNsz7yF6bRcAaPgN5fN7h33gsjYCcDO+AzhSFtVd569Bim
         uM1Q0XK2HLeNbauLpWMYB+NpZxX8tiD1BLIhBRIzfrR5gVoEMO88rVbB2de4KxEAzqXQ
         WMEJdUuiXSrbxmo0UtfNpG842Qk9fnlsvIDFzoZPtUINmDTB5YDS9z/BK39gIB2iAj3o
         nvmA==
X-Forwarded-Encrypted: i=1; AJvYcCWH4mdosr12TkG9cgJFPlLheW8cLjJU+/Pm3Tu/SBTmiGrcd0spxjYU76cGeCDc681HYZD+tuIigm45@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpbny8F32V/ZROBm0TO7ASBaE0OG6mlFzskZ7iiJu2f9CLEzyV
	ei2fheWNuPhHvOBsZ0SSXs/zFLoPKHIsgzZFkT1BqtKGO8AGoVjjPYdfbLWX76F2ZGaVhM5/ear
	vtNFr403AVmoMhnTJdRW3Zm+DilKeNjeXWvjMn+8eqmbTb6rBfLvjgXG0fknrHOqJV6AsaA5eCD
	8Pgjf1RXMtpWSNlemLgNRDpcMOG9kToyZ3Mw==
X-Gm-Gg: ASbGncuJQKye1bsrPW4pDvz4AEPSigbhmHteSTJ+Z7sBus5Zk/pe5SUnLmrIQqZ6mhz
	vff/Jgo7qyENUO2NXPKVn52WJMUCygzBPwMwTaQU=
X-Received: by 2002:a05:6000:18ab:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38a872f6d5fmr29339041f8f.2.1737025432948;
        Thu, 16 Jan 2025 03:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaNTt1vHhOZzZWy4NQcmShM6eO4SuWbFunAa3Ot9r5t6bktaZBjgEMxn1TBFCcRt0yTKBP7igJNQ0at2y85dU=
X-Received: by 2002:a05:6000:18ab:b0:385:f349:ffe7 with SMTP id
 ffacd0b85a97d-38a872f6d5fmr29339017f8f.2.1737025432599; Thu, 16 Jan 2025
 03:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220-kvm-config-virtiofs-v1-1-4f85019e38dc@google.com>
 <9c04640c-9739-4d5f-aba0-1c12c4c38497@linux.ibm.com> <CA+i-1C3ncij1HLKGOdTC2FtpBY2Gajp8_3E3UrvNBYhs9Hu0dQ@mail.gmail.com>
 <20250116102733.7207-B-hca@linux.ibm.com>
In-Reply-To: <20250116102733.7207-B-hca@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Jan 2025 12:03:40 +0100
X-Gm-Features: AbW1kvYQEtwKNgsMaPFq8rJ4dvHM4rkUCrmKlPmsDFTXQmB104PnitEc_s71utI
Message-ID: <CABgObfYj3ou7Lc7Fmehz84DsFbNrKJNBd+yYZkLm72HWZpQf8A@mail.gmail.com>
Subject: Re: [PATCH] kvm_config: add CONFIG_VIRTIO_FS
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Brendan Jackman <jackmanb@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:27=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
> On Thu, Jan 16, 2025 at 11:06:56AM +0100, Brendan Jackman wrote:
> > Hi Heiko/Vasily/Alexander,
> >
> > I don't see any obvious choice for a maintainer who would merge this.
> >
> > On Thu, 9 Jan 2025 at 13:46, Christian Borntraeger
> > <borntraeger@linux.ibm.com> wrote:
> > > Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> >
> > Given that Christian acked it, and it's pretty low-stakes and unlikely
> > to conflict, would you perhaps take it through the S390 tree?
>
> Given that this is kvm specific I would prefer if this goes via a kvm
> specific tree. E.g. kvm-s390 :) Which means Christian, Janosch, or
> Claudio should pick this up.

I will apply it to the main KVM tree.

Paolo

