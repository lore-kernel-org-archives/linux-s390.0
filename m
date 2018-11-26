From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
Date: Mon, 26 Nov 2018 13:57:06 -0500
Message-ID: <fb3c895c-3e3a-8588-5fee-85910840a794@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181122165432.4437-1-cohuck@redhat.com>
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/22/2018 11:54 AM, Cornelia Huck wrote:
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
> 
> This patch series introduces capabilities (similar to what vfio-pci uses)
> and exposes a new async region for handling hsch/csch.
> 
> Very lightly tested (I can interact with a dasd as before; I have not
> found a reliable way to trigger hsch/csch in the Linux dasd guest driver.)
> 

I was able to trigger the guest DASD driver to issue a csch instruction, 
and from my brief testing it seems to be working just like it would on 
the LPAR. (I basically tested with 2 threads trying to issue DASD device 
reserve and release ioctls, on the same DASD device, in a busy loop).

I am going to spend some time doing a deeper review.

Thanks
Farhan


> Cornelia Huck (3):
>    vfio-ccw: add capabilities chain
>    s390/cio: export hsch to modules
>    vfio-ccw: add handling for asnyc channel instructions
> 
>   drivers/s390/cio/Makefile           |   3 +-
>   drivers/s390/cio/ioasm.c            |   1 +
>   drivers/s390/cio/vfio_ccw_async.c   |  88 +++++++++++++
>   drivers/s390/cio/vfio_ccw_drv.c     |  48 +++++--
>   drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++-
>   drivers/s390/cio/vfio_ccw_ops.c     | 195 ++++++++++++++++++++++++----
>   drivers/s390/cio/vfio_ccw_private.h |  44 +++++++
>   include/uapi/linux/vfio.h           |   5 +
>   include/uapi/linux/vfio_ccw.h       |  12 ++
>   9 files changed, 509 insertions(+), 45 deletions(-)
>   create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
