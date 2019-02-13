Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 13 Feb 2019 14:44:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio: hint if callbacks surprisingly might sleep
Message-ID: <20190213144414.6543cd22.cohuck@redhat.com>
In-Reply-To: <20190131102713-mutt-send-email-mst@kernel.org>
References: <20190131125314.29647-1-cohuck@redhat.com>
        <20190131102713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Jan 2019 10:27:53 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 31, 2019 at 01:53:14PM +0100, Cornelia Huck wrote:
> > A virtio transport is free to implement some of the callbacks in
> > virtio_config_ops in a matter that they cannot be called from
> > atomic context (e.g. virtio-ccw, which maps a lot of the callbacks
> > to channel I/O, which is an inherently asynchronous mechanism).
> > This can be very surprising for developers using the much more
> > common virtio-pci transport, just to find out that things break
> > when used on s390.
> > 
> > The documentation for virtio_config_ops now contains a comment
> > explaining this, but it makes sense to add a might_sleep() annotation
> > to various wrapper functions in the virtio core to avoid surprises
> > later.
> > 
> > Note that annotations are NOT added to two classes of calls:
> > - direct calls from device drivers (all current callers should be
> >   fine, however)
> > - calls which clearly won't be made from atomic context (such as
> >   those ultimately coming in via the driver core)
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> 
> Makes sense to me. I don't think we should push our luck in
> this release though, better defer until the merge window.

Friendly ping, as we're quite close to the release of 5.0 now.
