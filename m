From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/16] s390: cio: introduce cio_cancel_halt_clear
Date: Fri, 17 Mar 2017 10:26:51 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1703171023360.3003@schleppi>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com> <20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> For future code reuse purpose, this decouples the cio code with
> the ccw device specific parts from ccw_device_cancel_halt_clear,
> and makes a new common I/O interface named cio_cancel_halt_clear.

What would the user of cio_cancel_halt_clear be?

Sebastian
