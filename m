Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Dec 2014 17:19:00 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v8 17/50] KVM: s390: Set virtio-ccw transport revision
Message-ID: <20141204171900.3c31bfbe.cornelia.huck@de.ibm.com>
In-Reply-To: <20141204161022.GA23199@redhat.com>
References: <1417449619-24896-1-git-send-email-mst@redhat.com>
	<1417449619-24896-18-git-send-email-mst@redhat.com>
	<20141204161022.GA23199@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, dahi@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 4 Dec 2014 18:10:22 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Dec 01, 2014 at 06:04:11PM +0200, Michael S. Tsirkin wrote:
> > From: Thomas Huth <thuth@linux.vnet.ibm.com>
> > 
> > With the new SET-VIRTIO-REVISION command of the virtio 1.0 standard, we
> > can now negotiate the virtio-ccw revision after setting a channel online.
> > 
> > Note that we don't negotiate version 1 yet.
> > 
> > [Cornelia Huck: reworked revision loop a bit]
> > Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Looking at this some more: to me it looks
> like this command should be repeated whenever we reset
> the device.
> 
> No?

It should, when we re-setup.
