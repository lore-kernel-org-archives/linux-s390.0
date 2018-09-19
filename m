From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 2/2] virtio/s390: fix race in ccw_io_helper()
Date: Wed, 19 Sep 2018 16:07:59 +0200
Message-ID: <20180919160759.731cb561.cohuck@redhat.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
	<20180912140202.12292-3-pasic@linux.ibm.com>
	<20180918204547.2500c848.cohuck@redhat.com>
	<c0148f86-b7a5-0c66-146d-f2dbcd678436@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c0148f86-b7a5-0c66-146d-f2dbcd678436@linux.ibm.com>
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

On Wed, 19 Sep 2018 15:17:28 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/18/2018 08:45 PM, Cornelia Huck wrote:

> > We basically have two options:
> > - Have a way to queue I/O operations and then handle them in sequence.
> >   Creates complexity, and is likely overkill. (We already have a kind
> >   of serialization because we re-submit the channel program until the
> >   hypervisor accepts it; the problem comes from the wait queue usage.)  
> 
> I secretly hoped we already have something like this somewhere. Getting
> some kind of requests processed and wanting to know if each of these worked
> or not seemed like fairly common. I agree, implementing this just for
> virtio-ccw would be an overkill, I agree.

I've encountered that pattern so far mostly for driver-internal I/O
(setting some stuff up via channel commands etc.) Other usages (like
e.g. the dasd driver processing block layer requests) are asynchronous,
and the common I/O layer uses a full-fledged fsm. Much of the trouble
comes from implementing a synchronous interface via asynchronous
commands, and I'd really like to keep that as simple as possible
(especially as this is not the hot path).

> 
> > - Add serialization around the submit/wait procedure (as you did), but
> >   with a per-device mutex. That looks like the easiest solution.
> >   
> 
> Yep, I'm for doing something like this first. We can think about doing
> something more elaborate later. I will send a non-RFC with an extra
> per-device mutex. Unless you object.

No, that sounds good to me.

> 
> Another thought that crossed my head was making the transport ops
> mutex on each virtio-ccw device -- see our conversation on get/set
> config. I don't think it would make a big difference, since the
> ccw stuff is mutex already, so we only have parallelism for the
> preparation and for post-processing the results of the ccw io.

Do you spot any other places where we may need to care about concurrent
processing (like for the ->config area in the previous patch)?
