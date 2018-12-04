From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
Date: Tue, 4 Dec 2018 13:38:10 +0100
Message-ID: <20181204133810.66e8cfe5@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181122165432.4437-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 22 Nov 2018 17:54:29 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path' scenarios;
> however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> clearing pending requests at the device is currently not supported.
> This may be a problem for e.g. error recovery.

I'm wondering: what about MODIFY SUBCHANNEL? Do we plan to add MSCH
as well or is it supposed to remain 'userspace emulated'? AFAIR MSCH
may have an effect on error recovery as well.

BTW I would like to have the concurrency discussion sorted out before
I proceed with my review, because reviewing the stuff without a fair idea
of what exactly are we trying to achieve would yield poor results.

Regards,
Halil
