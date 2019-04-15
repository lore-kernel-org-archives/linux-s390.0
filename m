Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 15 Apr 2019 13:51:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 0/6] vfio-ccw: support hsch/csch (kernel part)
Message-ID: <20190415135126.2fa9b12b.cohuck@redhat.com>
In-Reply-To: <20190301093902.27799-1-cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  1 Mar 2019 10:38:56 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3
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

One more gentle ping for an ack/r-b for patches 4 and 6.

I could go ahead and merge patches 1-3 and then patches 1+3 of Farhan's
series, but I'd really like to merge patches 4-6 as well so I can later
merge the QEMU part after a headers update to 5.2-rc...
