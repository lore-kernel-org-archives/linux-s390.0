Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE41A704B
	for <linux-s390@vger.kernel.org>; Thu,  3 Apr 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684330; cv=none; b=inLgBsdwkFKrwrBnLTFSlvAoppOFKntTD3YJijiBVLZ4ttXfwYN+uHeFt5RCLWfaQzPVQNfxuqeNtSM5OkSxAcUMKM/pvyW8juYUsC9IiZEHxrMmm/OAptPOnMfvEwUrlsrQPMt4BzoG50URT3V5hP6IgOhGrfAKKmLuUau69xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684330; c=relaxed/simple;
	bh=A6e81UtQYHRwDIYoR39khjOEwBu6hr4kRVxzMB4RqyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWv7WMAXOfKdxLy65ueKaHUaTktMIDsDk8A+CYx4V9BVWxl41uVMqnEm0qa2Vc2J95MxOCittA2qC0tKYAQv9gzSca04afvxUnYFT3o12ekeGATHCi2rai3l6MZY6RQaCVP5AoG07lAC1v+5BhDoG3MzOukvT3LNmHUAlszOM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOpvV9jA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOpvV9jA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743684328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zUuhfiHJkUSWQXDL0fBuXOf75iyVHdbfcp2d7edlyk=;
	b=HOpvV9jAONUJDYMJX3bMfWoqeCW42Nuoz6V6lQwtNrlnTda38dvZ7+gJViu7nKOzTPwv6z
	+JysWHd7GFN14V5ZrtbYjQweknokG6ebXXUXTMR+w3Ci5F1TU3M4Z9zgI+N9VAEL6NAvv6
	ihzjEdHYvTVw70LtyNDdoPEwmczZrGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-XxZIPzKVM3CiS8V4Zr-fDQ-1; Thu,
 03 Apr 2025 08:45:24 -0400
X-MC-Unique: XxZIPzKVM3CiS8V4Zr-fDQ-1
X-Mimecast-MFC-AGG-ID: XxZIPzKVM3CiS8V4Zr-fDQ_1743684322
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A43C19560B0;
	Thu,  3 Apr 2025 12:45:22 +0000 (UTC)
Received: from localhost (unknown [10.45.225.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36FEA1809B6A;
	Thu,  3 Apr 2025 12:45:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Chandra Merla
 <cmerla@redhat.com>, Stable@vger.kernel.org, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
In-Reply-To: <20250402203621.940090-1-david@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20250402203621.940090-1-david@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 03 Apr 2025 14:45:17 +0200
Message-ID: <87v7rl9zxe.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 02 2025, David Hildenbrand <david@redhat.com> wrote:

> If we finds a vq without a name in our input array in
> virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
>
> Consequently, we create only a queue if it actually exists (name != NULL)
> and assign an incremental queue index to each such existing queue.
>
> However, in virtio_ccw_register_adapter_ind()->get_airq_indicator() we
> will not ignore these "non-existing queues", but instead assign an airq
> indicator to them.
>
> Besides never releasing them in virtio_ccw_drop_indicators() (because
> there is no virtqueue), the bigger issue seems to be that there will be a
> disagreement between the device and the Linux guest about the airq
> indicator to be used for notifying a queue, because the indicator bit
> for adapter I/O interrupt is derived from the queue index.
>
> The virtio spec states under "Setting Up Two-Stage Queue Indicators":
>
> 	... indicator contains the guest address of an area wherein the
> 	indicators for the devices are contained, starting at bit_nr, one
> 	bit per virtqueue of the device.
>
> And further in "Notification via Adapter I/O Interrupts":
>
> 	For notifying the driver of virtqueue buffers, the device sets the
> 	bit in the guest-provided indicator area at the corresponding
> 	offset.
>
> For example, QEMU uses in virtio_ccw_notify() the queue index (passed as
> "vector") to select the relevant indicator bit. If a queue does not exist,
> it does not have a corresponding indicator bit assigned, because it
> effectively doesn't have a queue index.
>
> Using a virtio-balloon-ccw device under QEMU with free-page-hinting
> disabled ("free-page-hint=off") but free-page-reporting enabled
> ("free-page-reporting=on") will result in free page reporting
> not working as expected: in the virtio_balloon driver, we'll be stuck
> forever in virtballoon_free_page_report()->wait_event(), because the
> waitqueue will not be woken up as the notification from the device is
> lost: it would use the wrong indicator bit.
>
> Free page reporting stops working and we get splats (when configured to
> detect hung wqs) like:
>
>  INFO: task kworker/1:3:463 blocked for more than 61 seconds.
>        Not tainted 6.14.0 #4
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:kworker/1:3 [...]
>  Workqueue: events page_reporting_process
>  Call Trace:
>   [<000002f404e6dfb2>] __schedule+0x402/0x1640
>   [<000002f404e6f22e>] schedule+0x3e/0xe0
>   [<000002f3846a88fa>] virtballoon_free_page_report+0xaa/0x110 [virtio_balloon]
>   [<000002f40435c8a4>] page_reporting_process+0x2e4/0x740
>   [<000002f403fd3ee2>] process_one_work+0x1c2/0x400
>   [<000002f403fd4b96>] worker_thread+0x296/0x420
>   [<000002f403fe10b4>] kthread+0x124/0x290
>   [<000002f403f4e0dc>] __ret_from_fork+0x3c/0x60
>   [<000002f404e77272>] ret_from_fork+0xa/0x38
>
> There was recently a discussion [1] whether the "holes" should be
> treated differently again, effectively assigning also non-existing
> queues a queue index: that should also fix the issue, but requires other
> workarounds to not break existing setups.
>
> Let's fix it without affecting existing setups for now by properly ignoring
> the non-existing queues, so the indicator bits will match the queue
> indexes.
>
> [1] https://lore.kernel.org/all/cover.1720611677.git.mst@redhat.com/
>
> Fixes: a229989d975e ("virtio: don't allocate vqs when names[i] = NULL")
> Reported-by: Chandra Merla <cmerla@redhat.com>
> Cc: <Stable@vger.kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

[I assume that one of the IBM folks can simply pick this up?]

