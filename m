Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697B3FE669
	for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535506; cv=none; b=WdKwGXEn0u02NGpTTSdkYCSTJuCLJA3Am2XiedAb0tFxD+b6mj9WBeUlI6wSRhQRa8hkBqEkXdpjaihcxT8qDHbfXBrP37v1UG3SjWQJRDSClQdrOQKz1SYaHouz/6LAcn1PM2tXp0094QMOwBTMug6+N7CeAK49Utr/M9WGX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535506; c=relaxed/simple;
	bh=WeiO/kvXd28sVryXwcleJRKLGxigXtK192g6LDV52ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBf4pcJr+1UdRn/ZdzF/lnrdfyi0Jsi3yMPxwAJeFgtc45jLYQLG8YdTAuu6qn1ycA7l3oLQiFCnbGxDz8Uc9KryrBFraD6JJrXsUXRcdTzVD/CWl+ZHJfb58SDi1x56mwTJHYv4ZGVXxvQz8cHV+JwlV/K4KBkY5DpQNW/8SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJ7kI1Kb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ7kI1Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781535504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxLpH9j4tyUwflqQc435PknR0znSRfDU7Gw9S0v0YMQ=;
	b=hJ7kI1KbUgJ+e3LDdsLe61fr1EHAjo1unYzjd+UoRKwb4Y1i4rE5AnUicNQz96aOvP502o
	5nm53+6DxanT2jIP9bdrN2z+0DTR01xdG4tNLKwyozEEAr4GW5dBJ8jSwEyiCYxZ1bJ8Nx
	/lB7E1Vj+IsHgc2Dk9h+rMq+CpGZUIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-_BAas8q1MpeI8JVeulqbkg-1; Mon,
 15 Jun 2026 10:58:18 -0400
X-MC-Unique: _BAas8q1MpeI8JVeulqbkg-1
X-Mimecast-MFC-AGG-ID: _BAas8q1MpeI8JVeulqbkg_1781535495
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63F8E19560A5;
	Mon, 15 Jun 2026 14:58:15 +0000 (UTC)
Received: from localhost (unknown [10.44.34.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB60D19541B2;
	Mon, 15 Jun 2026 14:58:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, William Bezenah <wbezenah@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, mjrosato@linux.ibm.com, vneethv@linux.ibm.com,
 oberpar@linux.ibm.com, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device detach
In-Reply-To: <20260615002309.052e0614.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 15 Jun 2026 16:58:12 +0200
Message-ID: <875x3jn94r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 12 Jun 2026 17:54:07 +0200
> William Bezenah <wbezenah@linux.ibm.com> wrote:
>
>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>> subchannel based on DNV"), subchannel behavior following a device
>> detach has been updated and results in -EINVAL being propagated
>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>> in cio/device_ops. In the end, the virtio driver has no ability to
>> react to the difference between device and subchannel states here,
>> and during detach, both -ENODEV and -EINVAL indicate the device
>> cannot be used and should not be treated as errors requiring
>> attention. Update error handling in virtio_ccw_del_vq() and
>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>> -ENODEV.
>
> Hi William!
>
> Are you saying that ccw_device_start() started returning -EINVAL
> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
> DNV")? Or did I somehow read the paragraph wrong?
>
> The funcition ccw_device_start is documented to return:
>  * Returns:                                                                     
>  *  %0, if the operation was successful;                                        
>  *  -%EBUSY, if the device is busy, or status pending;                          
>  *  -%EACCES, if no path specified in @lpm is operational;                      
>  *  -%ENODEV, if the device is not operational. 
> and the commit message does not say a thing about introducing -EINVAL to
> the mix.

The function may return -EINVAL for non-enabled subchannels
(i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
I'd expect it not to be enabled in that case anyway.

