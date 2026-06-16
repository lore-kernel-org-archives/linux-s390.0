Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A980366055
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601377; cv=none; b=KM8kWBtcEVYaS/N01n0ZcsqnxNTeDUEsZt3uRF3NIsqZ6q/0ZFlrK/FL2w89DcbQeHzSIq9Myi2oa2p2CAVwtSZI7eFfARQmmfO3vX+U0WjJ+NrTTohv2OafORsGfpG6N9PJSEcQQxFbXfuXl4O8gHkKf21Lf5u/mXB0KIfzqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601377; c=relaxed/simple;
	bh=TznTWtEsTXwfynno4JjQTZakvprLhmN+qNqGOjoQhVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYZwrhLwVjQuGcTQQC0dFfm0gGTryHyh/m2vKDrlpjEdCedealHB5np/kpaWq/Fyp9Wa9tnL34kJFJzZdQho9WDQSp4NRjNypIFgyk47tTzLTaGI+C1ks1D9V3o6j9N1mxVuDCVBrv2tyKiPLX4PwiLU2ryUgGBVuqmG/+mdg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2I6gJNB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2I6gJNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781601375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcaNbqZ+folpc8zogdsUetTn5R2c9+8hBEKj5VOQTrg=;
	b=e2I6gJNB1j06VuqZMHz1u6U3NcXu4FUNmCH0f7RK0ORdj2DikTiQLzacDtKqdT8AWU3X5W
	/Lq8+JBRi1lMKBjHN6eqzEOKNAeR/HjR2D5aU8h7/FSL1Vl/+UL5jS7kx0WIAnZ/CKkWyp
	xHaMYjHpu5pPW3H3mzMohzVTCjiDfDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-m4e4fe0-OUW6PMPrmhMxJA-1; Tue,
 16 Jun 2026 05:16:11 -0400
X-MC-Unique: m4e4fe0-OUW6PMPrmhMxJA-1
X-Mimecast-MFC-AGG-ID: m4e4fe0-OUW6PMPrmhMxJA_1781601369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7038E1955E75;
	Tue, 16 Jun 2026 09:16:09 +0000 (UTC)
Received: from localhost (unknown [10.44.49.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFD75195410A;
	Tue, 16 Jun 2026 09:16:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, William Bezenah <wbezenah@linux.ibm.com>,
 vneethv@linux.ibm.com
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, mjrosato@linux.ibm.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device detach
In-Reply-To: <2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com> <875x3jn94r.fsf@redhat.com>
 <4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
 <20260615234246.0ec5d947.pasic@linux.ibm.com>
 <2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 16 Jun 2026 11:16:06 +0200
Message-ID: <8733ymn8vd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jun 16 2026, Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 15.06.2026 23:42, Halil Pasic wrote:
>> On Mon, 15 Jun 2026 16:01:55 -0400
>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>> 
>>> On 6/15/2026 10:58 AM, Cornelia Huck wrote:
>>>> On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>  
>>>>> On Fri, 12 Jun 2026 17:54:07 +0200
>>>>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>>>>>  
>>>>>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>>>>>> subchannel based on DNV"), subchannel behavior following a device
>>>>>> detach has been updated and results in -EINVAL being propagated
>>>>>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>>>>>> in cio/device_ops. In the end, the virtio driver has no ability to
>>>>>> react to the difference between device and subchannel states here,
>>>>>> and during detach, both -ENODEV and -EINVAL indicate the device
>>>>>> cannot be used and should not be treated as errors requiring
>>>>>> attention. Update error handling in virtio_ccw_del_vq() and
>>>>>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>>>>>> -ENODEV.  
>>>>> Hi William!
>>>>>
>>>>> Are you saying that ccw_device_start() started returning -EINVAL
>>>>> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
>>>>> DNV")? Or did I somehow read the paragraph wrong?
>>>>>
>>>>> The funcition ccw_device_start is documented to return:
>>>>>  * Returns:                                                                     
>>>>>  *  %0, if the operation was successful;                                        
>>>>>  *  -%EBUSY, if the device is busy, or status pending;                          
>>>>>  *  -%EACCES, if no path specified in @lpm is operational;                      
>>>>>  *  -%ENODEV, if the device is not operational. 
>>>>> and the commit message does not say a thing about introducing -EINVAL to
>>>>> the mix.  
>>>> The function may return -EINVAL for non-enabled subchannels
>>>> (i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
>>>> I'd expect it not to be enabled in that case anyway.  
>>>
>>> Yep, that's at least how I've come to understand what changed. The
>>> function ccw_device_start_timeout_key() has always returned -EINVAL
>>> for non-enabled subchannels (pmcw.ena == 0), though it's not
>>> documented in the header.
>> 
>> Wasn't his -EINVAL actually introduced by commit:
>> 823d494ac111 ("[S390] pm: ccw bus power management callbacks")?
>
> In the context of virtio-ccw added in 2012, an EINVAL return code
> introduced in 2009 might be considered "always" :)

:)

I'm wondering whether we should still expect to hit the "ssch with
ena==0" situation, given that pm support has been removed again in the
meanwhile. (Well, other than in situations like this, where it is a
follow-up to other problems.) IOW, can callers expect not to see
-EINVAL, unless they are doing something really stupid?

>
>>> What changed with commit 8c58a229688c is that cio_update_schib() now
>>> updates the schib even when DNV=0, rather than returning early as it
>>> did previously. Somehow this update results in pmcw.ena == 0 in
>>> ccw_device_start_timeout_key(). Previously, it saw pmcw.ena == 1 and
>>> moved to the condition (cdev->private->state == DEV_STATE_NOT_OPER)
>>> where it returned -ENODEV.
>> 
>> Sounds fishy to me. As far as I understand the DNV takes precedence over
>> all other pieces of PMCW.
>
> And you're right about that! The Principles of Operation states (p. 15-4
> in SA22-7832-14 [1]) that the contents of all other fields in the PMCW
> are unpredictable when DNV is 0, therefore 8c58a229688c is in error.
>
> I'll work with Vineeth to determine how to fix this issue, potentially
> via manually clearing some relevant SCHIB fields instead of copying the
> unpredictable results of the STSCH instruction.

Can't you zero the whole SCHIB, or do you still need some of the
measurement block things for cleanup?

>
>>> So the commit didn't introduce -EINVAL as a new return value, rather,
>>> it changed the subchannel lifecycle such that existing paths now
>>> propagate -EINVAL rather than -ENODEV during the device detach
>>> scenario.
>> 
>> I'm not convinced returning -EINVAL in the given situation is the
>> right thing to do. Peter, would you mind to chime in?
>
> I tend to agree that an attempt to start I/O for a subchannel that has
> DNV 0 should result in ENODEV rather than EINVAL, though the latter is
> still valid when a driver tries to start I/O on a subchannel that is not
> enabled for I/O.
>
> We'll make sure to design the fix for 8c58a229688c in away that ENODEV
> will be returned when DNV is 0. Assuming that this is the only situation
> where virtio-ccw's ccw_io_helper() receives -EINVAL from
> ccw_device_start__timeout_key() during detach, the subject patch should
> no longer be necessary.

I agree, I'd not expect to get -EINVAL in ccw_io_helper().

