From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 07/12] vfio/ccw: vfio based
 subchannel passthrough driver
Date: Wed, 18 Jan 2017 11:22:23 +0800
Message-ID: <25362.3019591489$1505296743@news.gmane.org>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-8-bjsdjshi@linux.vnet.ibm.com>
	<20170117154928.6b7886fb@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170117154928.6b7886fb@t450s.home>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, renxiaof@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 15:49:28 -0700]:

> On Thu, 12 Jan 2017 08:25:08 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > 
> > We use the IOMMU_TYPE1 of VFIO to realize the subchannels
> > passthrough, implement a vfio based subchannels passthrough
> > driver called "vfio-ccw".
> > 
> > Support qemu parameters in the style of:
> > "-device vfio-ccw,id=xx,hostid=xx(,guestid=xx),mdevid=xx"
> 
> Why not adopt the same syntax as vfio-pci with mdev devices,
> sysfsdev=%s where %s is a path to the mdev device in sysfs, which can
> be /sys/bus/mdev/devices/$UUID or as you create from the hostid
> below /sys/bus/css/devices/%x.%x.%04x/$UUID.
Ok. This is a good point.

I will change the cmdline interface to:
-device vfio-ccw,id=xx,sysfsdev=xx(,devno=xx)

Since "hostid" is removed, I will also rename "guestid" to "devno" to
make it looking consistent with the virtio-ccw devices.

> It seems if we know where
> to find the mdev device then we can determine the parent information on
> our own through sysfs.
> 
This is true.

> > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
[...]

-- 
Dong Jia
