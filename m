From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 2/2] virtio/s390: fix race in ccw_io_helper()
Date: Thu, 20 Sep 2018 12:15:23 +0200
Message-ID: <20180920121523.4177db92.cohuck@redhat.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
	<20180912140202.12292-3-pasic@linux.ibm.com>
	<20180918204547.2500c848.cohuck@redhat.com>
	<c0148f86-b7a5-0c66-146d-f2dbcd678436@linux.ibm.com>
	<20180919160759.731cb561.cohuck@redhat.com>
	<592b9fd1-0ab0-aa9f-31d7-a717610bd95c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <592b9fd1-0ab0-aa9f-31d7-a717610bd95c@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Sep 2018 18:56:45 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/19/2018 04:07 PM, Cornelia Huck wrote:

> > Do you spot any other places where we may need to care about concurrent
> > processing (like for the ->config area in the previous patch)?
> >   
> 
> It is hard to tell, because:
> * Synchronization external to the transport could make things work
> out just fine.
> * virtio_config_ops does not document these requirements if any.
> * So it's up to the devices to use the stuff without shooting
>   themselves in the foot.
> * virtio-pci does not seem to do more to avoid such problems that
>   we do.
> 
> Back then when learning vritio-ccw I did ask myself such questions
> and based on vrito-pci and I was like looks similar, should be
> good enough.

Yep, I agree. If there's nothing obvious, I think we should just leave
it as it is now.
