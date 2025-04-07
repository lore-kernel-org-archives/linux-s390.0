Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E05227EAE
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015314; cv=none; b=FFXPYZsiYKTCIuH/ovGN5+r1x/EEb/v85+zeJY0mPT6V98DVFoIQqlbv/VdyNBXfSTf0ssJjTQsgMYhhR4SQZ2A3dqmi1VS0Vi/jLphtcfxcJLNjJmN/XWkXo2BOVBeLxwWF34HB43YVWm3H8vlNv26lx5O89SCs68WGVlT1tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015314; c=relaxed/simple;
	bh=dubat8tCLJKpXwu98mOgPZCaGLWjN3X5sHoHO7zCnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4uyc9e0TiCdv1jfbYvQQK4rIZi2RfVt/Sltk9ZWeyw3hI0TpatZLZtqOXEYEzz2CcchmcIN06S3p2EbwP4q2e/4XsmYHeqsAt22IONhc9gxNI4XcISUrbikoLDjdGOanQK9ijmXUHdEuboSl4GzkE1BATwhDr/Km3cPR9AUDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GukkxUjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GukkxUjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
	b=GukkxUjYjF9wKQCGEEiJZDYlfQ4LnZiZkTR/kaL/kW2YhaK4aAZ0aAbCgSXs/5C4tilk5K
	XiNAK5QIJkqwRMbEB+HmCZdyCeoGcimdeowITR6d3Nfrs/B+o+Ma0DJQwxijP7Chu7lTyV
	FKo6XUfSmfu8A1Tj0lo7JpQRVqHiuFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-s3TDXEPPN-qcIX00ylQB_g-1; Mon, 07 Apr 2025 04:41:50 -0400
X-MC-Unique: s3TDXEPPN-qcIX00ylQB_g-1
X-Mimecast-MFC-AGG-ID: s3TDXEPPN-qcIX00ylQB_g_1744015309
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso24459315e9.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015309; x=1744620109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
        b=nmp7vgOLK0ueSx6tQXRcW/SCpVBe/yDjAh/7a+s871zssvRrCXo2kXN2F+lv6jRd0v
         jW6RtJL3IELG05mZo+s9mCcNm+RY1HoQemMmeCV8JtRxCuvdsvyCYF895tmj7tBWm9uw
         lGYmHBEhT+PFd+yL4YkEkmUthtddn4PqgqkZOTdnPjJI0b5gjm6rGviZCdUfZiFU7iQQ
         eXauRj98jsbvHhvutDNuZTnxF19MOiRNQACovLF1p9aMSjCa3ZWGmVr7lTKlIrx9rXd7
         K4N+kvY4rjc+OcW9BzLhjN5/bwT3kDoY2o6EW4udbFq7TRofjZMdSdqdis1jgOE5EZWn
         mkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvccNKEw8BBsDfxSywqupfOOhUbsHFs78DMT1KEUlc/nKwwiYV05/B+B/xRYpix6QieVjNSkb73A5B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vJVHjN3ecbTh6PPDjVw/ILCKIR3LbDWpVqKNI8a/Azrwn+TQ
	ZaJdYzn7GVD9rvWe6YOoP091ckHqezQ+azHdzniitfIFO8USqRCrGyeCgrcUpGSEVRN1iKQuq5g
	uoiJnDLt0cGzV3wonONWnwIsjhNrCGBRMTt9REZPABQvVpG9cC1GZSq8sRKc=
X-Gm-Gg: ASbGncufzDoHn6pzK0LSEnNOzQaaRkV/g19EcPh1nT+/npts2xGTN+HRGoeERI6DdxS
	MUDLLTALqAuaSHXNqkJ9WhAt9IjQ+eeWlwZXak3YCIbTHxpdK8hyF4XCdp1cPFryDiUJ9hX6H+j
	3YVqDH1qFtXcAGRM1ZXM5a1230Zc6Jlco5Ro5dyfJG8bRHZnnrOAn3eOt9nBJyWBTmp64s+4pKo
	pXrP8Y/QeuNhny6BgYtAB1GEcJTS68itNw57mBH1TD0WU94EZzHzAi+UMSTrYj5nbcAZcn39O2R
	mbpoh/ihrQ==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45333115e9.22.1744015309277;
        Mon, 07 Apr 2025 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnMOiX9O9gk9kURjhnnuCNT1UVrytArjtGV7ecRUIBKrJSc0PSzOsjWjaDnmkVaY/+rUOMfQ==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45332875e9.22.1744015308965;
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c302269a2sm11484143f8f.91.2025.04.07.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:41:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250407044029-mutt-send-email-mst@kernel.org>
References: <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404173910.6581706a.pasic@linux.ibm.com>

On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> That basically means that if I was, for the sake of fun do
> 
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1197,7 +1197,6 @@ static unsigned int features[] = {
>         VIRTIO_BALLOON_F_MUST_TELL_HOST,
>         VIRTIO_BALLOON_F_STATS_VQ,
>         VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
> -       VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>         VIRTIO_BALLOON_F_PAGE_POISON,
>         VIRTIO_BALLOON_F_REPORTING,
>  };
> 
> I would end up with virtio_check_driver_offered_feature() calling
> BUG().


I mean, yes, this is exactly to catch drivers that use
features without negotiating them first. 


-- 
MST

