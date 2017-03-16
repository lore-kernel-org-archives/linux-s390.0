From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v3 00/15] basic vfio-ccw infrastructure
Date: Thu, 16 Mar 2017 10:25:16 +0100
Message-ID: <20170316102516.706fc6d6.cornelia.huck@de.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
        <20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
        <20170310114605.1353e810.cornelia.huck@de.ibm.com>
        <20170313071652.GD6756@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170313071652.GD6756@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Mar 2017 15:16:52 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Beside the fixes for former comments form you and Alex, I will also do
> the following stuff in the next version:
> 1. Remove the "RFC" tag from the mail subject.
> 2. Cc the s390 CIO layer maintainers for patch 1 and 2:
>     Sebastian Ott <sebott@linux.vnet.ibm.com>
>     Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> 3. For the new created files, update MAINTAINERS by adding:
> S390 VFIO-CCW DRIVER
> M:	Cornelia Huck <cornelia.huck@de.ibm.com>

Please add

M: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

as well :)

> L:	linux-s390@vger.kernel.org
> L:	kvm@vger.kernel.org
> S:	Supported
> F:	drivers/s390/cio/vfio_ccw*
> F:	Documentation/s390/vfio-ccw.txt
> F:	include/uapi/linux/vfio_ccw.h
