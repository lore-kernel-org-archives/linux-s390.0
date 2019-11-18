Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Nov 2019 16:17:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V13 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191118151706.GA371978@kroah.com>
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118105923.7991-7-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jgg@mellanox.com, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com

On Mon, Nov 18, 2019 at 06:59:23PM +0800, Jason Wang wrote:
> +static void mvnet_device_release(struct device *dev)
> +{
> +	dev_dbg(dev, "mvnet: released\n");
> +}

We used to have documentation in the kernel source tree that said that
whenever anyone did this, I got to make fun of them.  Unfortunately that
has been removed.

Think about what you did right here.  You silenced a kernel runtime
warning that said something like "ERROR! NO RELEASE FUNCTION FOUND!" by
doing the above because "I am smarter than the kernel, I will silence it
by putting an empty release function in there."

{sigh}

Did you ever think _why_ we took the time and effort to add that warning
there?  It wasn't just so that people can circumvent it, it is to
PREVENT A MAJOR BUG IN YOUR DESIGN!  We are trying to be nice here and
give people a _chance_ to get things right instead of having you just
live with a silent memory leak.

After 13 versions of this series, basic things like this are still here?
Who is reviewing this thing?

{ugh}

Also, see the other conversations we are having about a "virtual" bus
and devices.  I do not want to have two different ways of doing the same
thing in the kernel at the same time please.  Please work together with
the Intel developers to solve this in a unified way, as you both
need/want the same thing here.

Neither this, nor the other proposal can be accepted until you all agree
on the design and implementation.

/me goes off to find a nice fruity drink with an umbrella.

greg k-h
