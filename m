Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rusty Russell <rusty@ozlabs.org>
Subject: Re: [virtio-dev] [PATCH v3 3/6] virtio_ccw: support non-legacy balloon devices
In-Reply-To: <551BCB0A.4060107@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com> <1427884468-23930-4-git-send-email-mst@redhat.com> <551BCB0A.4060107@de.ibm.com>
Date: Tue, 14 Apr 2015 10:39:55 +0930
Message-ID: <87iocztt0c.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtio-dev@lists.oasis-open.org, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger <borntraeger@de.ibm.com> writes:
> Am 01.04.2015 um 12:35 schrieb Michael S. Tsirkin:
>> virtio_device_is_legacy_only is always false now,
>> drop the test from virtio ccw.
>
> Can you add the commit subject of patch2 here as a
> prereq for this patch? This will hopefully avoid 
> backport issues on distros that want to take this
> patch but not the other for whatever reasons.

I changed commit wording to:

As of last patch, virtio_device_is_legacy_only is always false,
drop the test from virtio ccw.

That should be clear to anyone seeking -stable patches.

Thanks,
Rusty.
