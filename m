Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 1 Apr 2015 13:55:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3 3/6] virtio_ccw: support non-legacy
 balloon devices
Message-ID: <20150401135521.767fe92f.cornelia.huck@de.ibm.com>
In-Reply-To: <551BCB0A.4060107@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<1427884468-23930-4-git-send-email-mst@redhat.com>
	<551BCB0A.4060107@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtio-dev@lists.oasis-open.org, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 01 Apr 2015 12:40:10 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 01.04.2015 um 12:35 schrieb Michael S. Tsirkin:
> > virtio_device_is_legacy_only is always false now,
> > drop the test from virtio ccw.
> 
> Can you add the commit subject of patch2 here as a
> prereq for this patch? This will hopefully avoid 
> backport issues on distros that want to take this
> patch but not the other for whatever reasons.

Seconded.

> 
> 
> this patch is then.
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

> 
> 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/s390/kvm/virtio_ccw.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)

Michael, I assume you would take this patch through your tree?
