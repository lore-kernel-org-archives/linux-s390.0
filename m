Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AC3E8356
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817287; cv=none; b=tGyI+2qmO1HA1kmJM2XLHrze+J0JqWJvPZ7+CFaE+nDHr3HJcotFusf9bW83LrwVHR4yDRjoE24ZF0M4R4+/4bfoKzkFHOx8LUHbW1gM2W9CRajpNF5eUjHv8pPAQohDGiefTcyeErJ8IZI3My0K2bXL4ldmNZXdtJfxdC7p9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817287; c=relaxed/simple;
	bh=1i31BeRMFT9Vp3AcAN/RmvKH0I2VjZNU1gijNLV1tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4ZrBk7kBIl5blZOmm05CFg3wa8vzp2XnyftIR/hbxigM7jvFet+pzI3COyWlVzenT7QGJI4a9sEWy5eSd/fKTNbrOQ6h+y49gLPV3Ot+gxDqw/cift65MWT4W5ykSXiA5jM8pjNG4/8gqz/Uvcsi3p1Y4O4FMbU3qrlqhC02+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAKIKa1Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwbZ/tou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAKIKa1Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwbZ/tou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
	b=cAKIKa1ZYohFm/NhUl+RG8nJyjM+r8RcUeq4UfqyixAgMboSjp7T8ydcjktr1rURruCSXP
	arTs/cHbaiFjWflxndWbwgjlJzxvq0mk/CX9uxR+cVjmx+l4n6FV9nzSv9IgReOiCTwXYD
	C20ACJFffn2Q91m/Oqniige6GyrYEVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-s4XwdDxlPiGyjttnRtJraA-1; Mon, 07 Sep 2026 17:41:22 -0400
X-MC-Unique: s4XwdDxlPiGyjttnRtJraA-1
X-Mimecast-MFC-AGG-ID: s4XwdDxlPiGyjttnRtJraA_1788817281
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499913d1a79so26388345e9.0
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788817281; x=1789422081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=KwbZ/touk+AoUhpw0CA+kuWP4KJaWRcAs0VioiQxmHKxPu3u2ryvllNKDnaMU1GWu3
         U1pvRlogoiJOzpRfgLS1XYugdwusm4fV32DY63FJwQOndhcRbD6css1FjEgq5muyJMrm
         rodi7NG6Vsxa71/PB6KOwoVUDzb3cka4Pobt+euydUgxhycKec9zbo1CuzwB31lHlO1n
         zIllMmJXB0vgkrY7Lw+Gu9QxW7QIp6z99phXK3b33/GVYptr4qxyC9lu8a1LKea3BcQU
         zk9Rs1JO8+xIPDqqhGuNW+Bk77hTMpTDUFbY5Hvl/YGOhhNpGV8DPQqARGwNiiyFCkcX
         1+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817281; x=1789422081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=oM42zFXPZVVotiV4IpmMY+cfZklpTgo8xvvGqXcFFNmEtwzcPndrjmeCKhM67PiHCH
         44OYrVb22MsVhkcdyJ2yFChmIq543rQ6aZIWbI1DxZZEGQ5MxTNvP9KCxb58cUGfQPMJ
         mWVnwwumJ0E/ioRpYH/YLr/VIAiipwoas3IoPfJyWbeg+2dtGISc4AM6n0Xin+7L4ozD
         pfY/uDO2E+4FrHfNQ14cAPadu0L1NUDJvHJfvPfQylqBXg19h5+eKudLhLE+x6B19NRi
         bWApIkl0f/VDFuwiF+BFmOWwKcfQHuGZeqgmbUgWNI0CsY5wgzPCMM2WLigCMLselRFg
         aMBw==
X-Forwarded-Encrypted: i=1; AKwUvByJejGyuu2RACCGqnRVgfqtIfRpz4p5xzA+k/5P+aGQhdfxBQKBK4TlmfcVaHTH3//cHt3h0rWtwLK4@vger.kernel.org
X-Gm-Message-State: AFuF++nrFEu2H+i27YblGRNcCm8mDsEkAoWkZS+iVCXovg++4l+eKjS7
	9LUVATo1jNPD078Z3qoRe6FbIVaMD+0Dy1VI8dNfe7ZnQcgKp9T1DK9hxmaWMafgliuCD3/kHea
	ZhML3m8rEeiTu5jknmy383omYVUPTGNLRFjtgYOthMXN5M93iF56EuCeGCcmM/hk=
X-Gm-Gg: AYBFou2gzg4ZK1pyXPr5Qjowgj8hMRwNB9q7xGavr0Hcc7+MO1A5XBriXab//wFw4/t
	GT9NXMMIeSMDj7ji1yT22hcA5326R/eGjItVo5xTqVvgrVi/4Q1RQ2nTW2JNY/v8SlN/ukFhnmY
	CzD4fNvZ/Y15U3xE3ZQKCKHPz+1BicG4kuxlePt285RhgZb28Z9GeW3lv/HpKs4vitdh/nOValJ
	p9den7fdw0o8n/qYu+O4bQmPeslPtmeN4/XJIzue55YN9L5tzzL7K9DHBmKlbwWFXVkX1ziX132
	ibXuOyuOzn5+Hgoe35P8DW7drR3EXur2l40lN7fk5HMU4qx8ALY1u9u0FP6VvkWUj5qxwljMsMX
	/a3Lzm17jgzTSTdQbZM9xdSc=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765805e9.5.1788817280975;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765175e9.5.1788817280462;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm892607965e9.0.2026.09.07.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:41:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:41:15 -0400
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
Message-ID: <20260907174032-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
 <ap8rCQII9fASEosZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap8rCQII9fASEosZ@gmail.com>

On Mon, Sep 07, 2026 at 11:23:19PM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> > got all 3 patches now. it's a good start, thanks, but they need
> > a bit more work, in particular addressing sashiko comments.
> > I'd also prefer patch 1 to be split: moving code from pci to core
> > is separate from ccw fixes.
> > 
> > Pls write or at least edit commit log messages yourself,
> > after reviewing Documentation/process/coding-assistants.rst
> > 
> 
> Thank you for the review and feedback. I'll work on a v2 now.
> 
> Karl

FYI I picked the virtio input patch, no need to repost that.
If you want to fix the evt leak, it can be a separate patch.

-- 
MST

