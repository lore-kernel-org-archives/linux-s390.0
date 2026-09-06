Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAA345EDA
	for <linux-s390@vger.kernel.org>; Sun,  6 Sep 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720991; cv=none; b=gG4d2YzVYiP4l58uNaI5DVjpruC2uh+dshXyvbmuWaZ5ZYI6fXbmpxLY9UdanUfU2E190mhT667UdpzxUOvNXHxRIK8GtnCaZYEMPWUqwGjF5L8mXiVmX1AIvs7uX2rm0vLG2HZ4fTmG9AFDKx+oLMn9vT8Bw5Lj8yWOEilhDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720991; c=relaxed/simple;
	bh=6a+HZ1EYXYHu9PlV9ZIMitFPuM02tFoBs0QnqvSqpU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShwDS8XqLdPmgJ+5i8Vs7aA69UgieAU4yIajAyuLXXRR0mIV59nQU0PEUSHIEX9y1jhX82pLxknjlsU2b7ubK1etwnG5ljFNdlzWP7EkKPCLR37Ggz6wtA3Q+ULtgoo5vgQ1F2b08DSNwO1wdhcRRG06exYzxEG2jP19e+PlwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTs0Dq6I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qAY1gG4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTs0Dq6I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qAY1gG4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788720988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
	b=NTs0Dq6ID7Utpl8vuq/dAPjs+dNnBvQiCCVqu4/+kh6I37jUoOBjwPz+gARVGZT7DEbGMY
	SeNCqj1pqObM7Q1xUl1k9ljmeR2btIP7aYpQL8y6KywPZyAPTubAiu68zYQ1JztrFXM6IV
	QJm4fZkYeTTB0rh3JWFtUOt617gmMBY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-h_Za-GNRMzSpiI1wiWMoYw-1; Sun, 06 Sep 2026 14:56:27 -0400
X-MC-Unique: h_Za-GNRMzSpiI1wiWMoYw-1
X-Mimecast-MFC-AGG-ID: h_Za-GNRMzSpiI1wiWMoYw_1788720986
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48436db95e1so1854394f8f.0
        for <linux-s390@vger.kernel.org>; Sun, 06 Sep 2026 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788720986; x=1789325786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
        b=qAY1gG4+yO5TNsgyDVxBEQ5IKAY697kE9ikocMWvlK39MGKHQ6VVqwtH1opDhpqerj
         SYhnChjpqlLxmgLslYvfLosbJcXzXRUcSJYNejP0HWSuGmFhFy8lDmWCO2wzlNJovqj2
         ZdhcTFbnbJMDFdFLq6/NRgGysqGYK3qIQnR/N5zs70tSsxVeRYfy/NlNO/MspDvJJk1z
         P3F9Bm3ETQhMpZ6N7NIHWNGzgaxh7SCbVsyGCMs+KNv8qg263ou4AZ+nBJdIw8A1nUj0
         OkmQItCtMTumqP3K3LDmziqqebMSUfDR0Gnp1HTEBQzgtrxUFRCMLkakHe39aSJxyvWG
         Aqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788720986; x=1789325786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoPs+GJMD19+2K8VaVNyBFab1idZZJbQk2Q9rWXgiCY=;
        b=shxNu/+JKB/Bv4gw27Wh937f1M+Qup4Xi/LoedqPCebUXuH7HnI9Xshg6cIVFcrVVc
         SHJSElyNmr5AFVJd4F7zQCxMM9ShP0Tv/peN2mwOywgFkLOygEoUlPijxRO4r7C+z4yj
         8bLZigEZs9NZIOCJCj54BOg5EzOTBPoUhwTcm6PwnNsWLXo2qhhtXhK7D6r7Vt5A8Jz0
         WDFZk95DMrCOecktX/EzQxP7GFaJl/vqYZhBEZi7MR7ikuBoM+OjHV0gGr6MVYuqNupK
         7v8yg7z0BkICByEyBt0t8LLUFpg7NA0/WsBJRlCtHTubdnSKHQmEf23P1cHKkUZARhMg
         h4SQ==
X-Forwarded-Encrypted: i=1; AKwUvByRInXqz1lhsk7L4j8Ryrw2xD8/K057gsS39YvuVZegmrJWpsajZjX1UZ+8hVQIeV4VlIxu6LIvt9kS@vger.kernel.org
X-Gm-Message-State: AFuF++l/nhJdmHEPK/fvzWbHPumWzX2cWiPIhORk9dJrJQ5moslNH1k8
	YfBU6nNF+3pBOhrJSQONZSeaaUOTn9UGT5VU+NLtdbIBRYr9XROG85PyY01mBgx0Xh3mryFEWW2
	xI//1E1177Rv0ho/FCwALFI70POmNZY9mDWUQYbCoOXZvNsmO+OHeuEOy6kvbht8=
X-Gm-Gg: AYBFou3GZiAUICapLQ+Q+s/IqcDAenIOOGuBG9c2Zjc6fjLtm72KrA+tJIniJTYvOYZ
	cGvfqPmTAVAgXj2DFexWhYzZ0tAMzKK8dZpbPILH18eaZCpmPe6hJTndDI1gMeAQIjhJ5V788fe
	xdx9zOlM+M11FnPtGsRDfZudoFS2ONZQ/i/1lf/ln1krxIv97z9MZtQK/3XavKI9UjySwK/8tXM
	gXZNx3Tym7UaGqigj5veE6crXlRf9mzAAvXt8wWboe8W49YxyaeZWI6N0AUwhEWBJX+8RegiKoK
	IUxHkGp5thb7KDqvMYmW/erAKqwCnajqZ3ITXnGLGuxoXUudbeBKHCLN83cISOfkT5wHPnFtsvP
	Nj3ADx8LhggoOHuFn5t7ybF8=
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196985195e9.9.1788720985755;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr196984675e9.9.1788720985146;
        Sun, 06 Sep 2026 11:56:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d084d62b0sm80311485e9.2.2026.09.06.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:56:24 -0700 (PDT)
Date: Sun, 6 Sep 2026 14:56:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906145605-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
 <ap2VJkoIsBbsqcNm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2VJkoIsBbsqcNm@gmail.com>

On Sun, Sep 06, 2026 at 06:32:40PM +0200, Karl Mehltretter wrote:
> On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> > You didn't send patch 3.
> > 
> 
> I resent it to just you now. Mail must have gotton lost somewhere.

got it now, thanks!

> If all else fails, it's on lore:
> https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/
> 
> Thanks,
> Karl

