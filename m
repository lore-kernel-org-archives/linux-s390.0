From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] virtio/s390 patches for 4.8
Date: Mon, 8 Aug 2016 13:39:10 +0200
Message-ID: <20160808133910.0bb69cea.cornelia.huck@de.ibm.com>
References: <1467904077-1887-1-git-send-email-cornelia.huck@de.ibm.com>
	<20160707194246-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160707194246-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 7 Jul 2016 19:42:52 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 07, 2016 at 05:07:55PM +0200, Cornelia Huck wrote:
> > Michael,
> > 
> > here are two virtio/s390 patches for 4.8.
> > 
> > First, Jing Liu noticed that she could trigger panics while playing
> > around with hvc0 as preferred console but no virtio console: This
> > can be fixed by not discarding our early_put_chars after init (as
> > the minimal fix).
> > 
> > This made us wonder why we still have that code around when no current
> > host code supports the old transport: We have no idea whether this
> > still works, and it's probably a good idea to put a deprecation
> > message in there to check whether anyone screams.
> > 
> > Patches are against your vhost branch.
> 
> thanks!

Hm, don't see these in 4.8-rc1...

> 
> > Christian Borntraeger (1):
> >   virtio/s390: keep early_put_chars
> > 
> > Cornelia Huck (1):
> >   virtio/s390: deprecate old transport
> > 
> >  arch/s390/Kconfig                | 13 +++++++++++++
> >  drivers/s390/virtio/Makefile     |  6 +++++-
> >  drivers/s390/virtio/kvm_virtio.c |  4 +++-
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.6.6
> 
