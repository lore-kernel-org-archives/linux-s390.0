Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206022F166
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018679; cv=none; b=Svw5QhIOKrZHaM0Z6iIE+kaHrNKtk2jIJWxsEoBND/1Umlk85PXAoo66SeDAdAfit8p7MyMTLTKpZDWmylqya6ZVW5xdZltlr3a2IStRn+tNzD4HCK1f1pgyLLFLuY4P79f5/mEnjmIWAelvAj8LVKa+YznUJkP98j4DWqWpCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018679; c=relaxed/simple;
	bh=UYVpnQToVhKkeD2a7choe2evBwk4oKQuBCk3T1e9dSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAODZAIBszNVd9LZXaCnh/+J6yiKOMBmyIBP+QCxtkTj/Yq9rV5YEE+t9l7yyMUW98C9jXZRHOhM/zyt0Yd2vQEjVnEGJNwQs5NanuJ/7ox6zonipym1cIl2wtcTXpruixqUwt7K7/BTQsKFuhiOyEbyeuZcRyzhlUtboSmrXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rr19dGFZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr19dGFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744018677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
	b=Rr19dGFZIwezT+XvsKu7x9U4t2b5RQTXDH9fB+SgFdgrTCw4x/MxATb2deZ6dc4va8+aGw
	NM1tuiFlN5qI2V8TdQlb3CtEp5+lgQXB8uxk3oeapa9mccar43na8+fJT9uwNz2R+Hufis
	Phxd6QuDKqISycpEiSdfi4Z3EKnGwgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-7ex5b64aNmGbcEQdXc6Pmw-1; Mon, 07 Apr 2025 05:37:55 -0400
X-MC-Unique: 7ex5b64aNmGbcEQdXc6Pmw-1
X-Mimecast-MFC-AGG-ID: 7ex5b64aNmGbcEQdXc6Pmw_1744018674
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so27617245e9.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 02:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018674; x=1744623474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
        b=QyBYBiV4oAmCY5SItUCvNjYGoHvQ2nIdQIuVTREP+l0bRaWNd2BTyewDeZ+4q7HPn+
         96J3Tw5v+E+YvI84KkPKU0twfUd4zs7g7E320dZuhxZgGLMtbAD4bBXRpl3C8WHh8wFn
         W+d68WOVcCnNIHqC3tF5PWrxPCu1BsItveM1AAFq2bE6D0omeaWbOfPTcQwnJo+fHk2r
         HO4CSaNtMspZ6DYxKziftVYQljUwPDIBRAYngflhTMpmQpc9j4CriOGtQ1jy6zUXbhEl
         axG77JYC5qgwrgmke0MmOGphMH9YB7nlnLFLtvQ1DMamKzLdDuqu5ixxWwgD9+/z6Yni
         MLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK63YgDQSctQcxlRhWhTYey4ETwyQdc2cA7CodOa7jVcwjZnOA75S6XsVto/IABail4Ui0Gq5k7hdF@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG0mwiN/SHckFanEUKrPxVUQfIxONn3daLxj6/x5okHllRBzS
	clV1ks8BtRf6KTai+eUVKqrfxHMFULCYqB6L9IuVEtMFjpMIk0djwxT5PDEurxEj4OU7NxaTSNR
	nQkHXmHQYXkoE3aKbqtMzDex5dleba+De082HxpFNKSuiAyxSfyTQM53GZJk=
X-Gm-Gg: ASbGncvTRahNED512Bt2tsRPSk7t9V2u/Dln56CQCMLfEVKn2DU/f197OYYsnZa7eVH
	FfWBRJaaeEqYXxWyZaO/7H6n2rKBm3s3IH3sQ9pOuS4LWlnbkNn98WxZLttIuLaBzigSTONMjTZ
	RT1jAktL5xwGzKK/UEQxBGUFSdf4nVTmZxgpx7fDeAups2+a4GMf3JZRnW+c62Xfc2EzKH4/Hhc
	LvUxx1HFdwyvLUFeT7QFT/pZtS9A8jb2CWOv2ZxzYLsZUJ4CYddjcVCBtnLemDA+2XnfdnRk4gP
	2vNSEU87gA==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396915e9.11.1744018674547;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDexwe+g43YwqQL8SzrJOq1OlI7SDdhXyepzHhoBm7gIYyJsaf0/QWV3+ztzeILwqBFtKrA==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396625e9.11.1744018674172;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b33c2sm132022505e9.40.2025.04.07.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:37:53 -0700 (PDT)
Date: Mon, 7 Apr 2025 05:37:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407053037-mutt-send-email-mst@kernel.org>
References: <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>

On Mon, Apr 07, 2025 at 11:11:34AM +0200, David Hildenbrand wrote:
> On 07.04.25 10:58, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> > > On 07.04.25 10:49, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Whoever adds new feat_X *must be aware* about all previous features,
> > > > > > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > > > > > 
> > > > > > 
> > > > > > The knowledge is supposed be limited to which feature bit to use.
> > > > > 
> > > > > I think we also have to know which virtqueue bits can be used, right?
> > > > > 
> > > > 
> > > > what are virtqueue bits? vq number?
> > > 
> > > Yes, sorry.
> > 
> > I got confused myself, it's vq index actually now, we made the spec
> > consistent with that terminology. used to be number/index
> > interchangeably.
> > 
> > > Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
> > > with their VIRTIO_BALLOON_F_WS_REPORTING.
> > 
> > 
> > crossvm guys really should have reserved the feature bit even if they
> > did not bother specifying it. Let's reserve it now at least?
> 
> Along with the virtqueue indices, right?

Well ... as long as the implementation is careful to check that feature
is negotiated, reusing vq index at least causes no trouble for others.


> Note that there was
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html
> 
> and
> 
> https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=afb07613-f56c-4d40-8981-2fad1c723998&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT
> 
> But it only was RFC, and as the QEMU implementation didn't materialize,
> nobody seemed to care ...

Thanks! I will try poke the author again.


> > 
> > 
> > > So whatever feature another device implements couldn't use this feature bit
> > > or these virtqueue indexes.
> > > 
> > > (as long the other device never intends to implement
> > > VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
> > > the spec will also be a mess, because virtqueue indexes could also have
> > > duplicate meanings ... ugh)
> > 
> > what do they do with vq indices btw?
> 
> See above links, they use the two for "s_vq and notification_vq".
> 
> -- 
> Cheers,
> 
> David / dhildenb

