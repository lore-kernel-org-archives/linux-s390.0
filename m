Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82C13DDC3
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819823; cv=none; b=SFlmzYNXRyIRRfKk1/T3DGbiLKBkP2SIb/Ip2UUVQLlmcIEeK74Kp+WltZY6OKe+/XBra0Er2dYTjDb7ugVBDTq3NMb//kR0P5nstejauDecWRajjoQsL1LnV9/hk+wJCY83cavM9QhdB43HYXt2ZEE5wyK1zF5BKfBk3SEdRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819823; c=relaxed/simple;
	bh=QbAx7GoW4Iu7O1LbEj1grLkdWzKllhde2FMXAyD2bb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/hAj+USNjZGl4hJSdPJ/eBykufhnfaXuAAe2mN/NVqptMTZq3mU/9QlX/Bh35VA1kT1ISIlz+P6s/9DgMmJ2rmJvJEnuCPThRU+JL2y9C7nxb1VzMdOGscFzqYpA06n2e9uBrLB5bXnj8tlbUmsiJk6lXBj06y5aD8ZDUXJLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrCn8Vfw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrCn8Vfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712819821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QbAx7GoW4Iu7O1LbEj1grLkdWzKllhde2FMXAyD2bb4=;
	b=RrCn8Vfwhvi3U6uDIVuCZIPoGhOBj0IXpAlruDEB+29tqx+H6yEc7LFNfLCwIJGvPcfNYg
	RLntNoLmTZfybAJaJztRjMgupGjOHQUz5UeeXW2wrj/Sh84xCiqTxlQoKWIoJC1UeZrHTs
	dNeMWS/FQcsQMEmv3bVZY6nEyONVDw8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Zi3DsUbTPM-VKiqs93Rh5g-1; Thu, 11 Apr 2024 03:16:59 -0400
X-MC-Unique: Zi3DsUbTPM-VKiqs93Rh5g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d851a4d958so12274891fa.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 00:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819818; x=1713424618;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbAx7GoW4Iu7O1LbEj1grLkdWzKllhde2FMXAyD2bb4=;
        b=SyBHaViHE+AJrpH7ZvUHRO71JFliqEARzXxmbiiuVolSjwg0MO6VpDo3hbvLt7gRv9
         heHYIBVeEt0As6T4E8/3bH0fNdfHXOm+QpCge78qV4a+fBfFl9G6d8HnObjJmf0NLHm4
         KBMd1YyudzIFu5fAa4tz3Z7302fX6Q0dwPISIB+WTYPFqzPn6qVkTSKUGq8cgPaGiXdf
         s/rWzYX/RRNMOuyMvbQkHV6j+as5HkOPQA1QT3WLz+vXGQgpoBv7tla6fFVZimN1wPun
         8BUQjr5Z3ZFbHTVGbUaBaZ48gI0HsNyMIbLmBgzRcWy7Ts7sJdw76Qlov+PuHCZuh9Wp
         4dIA==
X-Forwarded-Encrypted: i=1; AJvYcCX6yfXxkH7yiP6CGtkzg3MJKgr+dPgpxyDtOM78bTMuBczJpRXZhF3XEE2z1HQSfNOXgbobWR6osw9e8+OyaB2xeB5bHTs/smSOoQ==
X-Gm-Message-State: AOJu0YwCuV50Us0L8qX6kao4Ec91yYbEZEQtEiW0uFnukU+Kog0emhHB
	7/SjJLKfkTn+Kh/dbB8YZIHB4wblNGl0yMURMqgE6AgD0DOAruOcJ1WcoU0GisTluDeqD2wLspb
	XR+Rws/HOmT7jNpDbrvB/v/WecI/xYd5bYrZoqiCPYH0nuZrE++7HYDOvp8g=
X-Received: by 2002:a2e:3c05:0:b0:2d4:7458:b65 with SMTP id j5-20020a2e3c05000000b002d474580b65mr3499517lja.2.1712819818290;
        Thu, 11 Apr 2024 00:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlDyvYjKXKAmcqybaUiKJecQCVEjasFTXdfWTApnJI34kU7BrYfh4DZTIkjwlveC1pZWzLIQ==
X-Received: by 2002:a2e:3c05:0:b0:2d4:7458:b65 with SMTP id j5-20020a2e3c05000000b002d474580b65mr3499499lja.2.1712819817910;
        Thu, 11 Apr 2024 00:16:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-217.dyn.eolo.it. [146.241.235.217])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b00416c160ff88sm1440877wmq.1.2024.04.11.00.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:16:57 -0700 (PDT)
Message-ID: <facf085f326813ec12566b3458650746e0267aca.camel@redhat.com>
Subject: Re: [PATCH net] Revert "s390/ism: fix receive message buffer
 allocation"
From: Paolo Abeni <pabeni@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Christoph Hellwig
	 <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
	 <davem@davemloft.net>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>,  pasic@linux.ibm.com, schnelle@linux.ibm.com
Date: Thu, 11 Apr 2024 09:16:55 +0200
In-Reply-To: <20240409113753.2181368-1-gbayer@linux.ibm.com>
References: <20240409113753.2181368-1-gbayer@linux.ibm.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2024-04-09 at 13:37 +0200, Gerd Bayer wrote:
> This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
> Review was not finished on this patch. So it's not ready for
> upstreaming.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

It's not a big deal (no need to repost), but should the need arise
again in the future it would be better explicitly marking the reverted
commit in the tag area as 'Fixes'. The full hash in the commit message
will likely save the day to stable teams, but better safe then sorry!

Thanks,

Paolo

