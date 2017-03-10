From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v3 00/15] basic vfio-ccw infrastructure
Date: Fri, 10 Mar 2017 11:46:05 +0100
Message-ID: <20170310114605.1353e810.cornelia.huck@de.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
        <20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 9 Mar 2017 17:25:25 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-17 09:29:24 +0100]:
> 
> > vfio-ccw: the basic infrastructure
> > ==================================
> > 
> > Introduction
> > ------------
> > 
> > Here we describe the vfio support for I/O subchannel devices for
> > Linux/s390. Motivation for vfio-ccw is to passthrough subchannels to a
> > virtual machine, while vfio is the means.
> > 
> 
> Ping.
> 
> Any more comment for this version?
> 
> Thanks.
> 
> [...]
> 

I just walked through the patch set again and did not notice anything
else. There's still the area of channel path handling, but I don't see
why it shouldn't be able to fit into the infrastructure you introduce
here. (I'd expect most of the interesting stuff there to be handled in
user space anyway.)

You should update MAINTAINERS, though. I'm not sure the s390 cio folks
are prepared to handle vfio-ccw :) (although I think you should cc:
them on the patches exporting cio interfaces.) It's probably best to
take vfio-ccw through the kvm-s390 tree.
