Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 10:12:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 3/3] vfio-ccw: Release any channel program when
 releasing/removing vfio-ccw mdev
Message-ID: <20190412101236.4f753e6d.cohuck@redhat.com>
In-Reply-To: <7123f8b7-0348-4140-1b94-5d35ea1ef567@linux.ibm.com>
References: <cover.1554756534.git.alifm@linux.ibm.com>
        <ae9f20dc8873f2027f7b3c5d2aaa0bdfe06850b8.1554756534.git.alifm@linux.ibm.com>
        <20190411182755.1f3a2bd5.cohuck@redhat.com>
        <7123f8b7-0348-4140-1b94-5d35ea1ef567@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 11 Apr 2019 16:39:32 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 04/11/2019 12:27 PM, Cornelia Huck wrote:
> > On Mon,  8 Apr 2019 17:05:33 -0400
> > Farhan Ali<alifm@linux.ibm.com>  wrote:
> >   
> >> When releasing the vfio-ccw mdev, we currently do not release
> >> any existing channel program and it's pinned pages. This can  
> > s/it's/its/
> >   
> 
> Will fix.
> 
> Thanks for taking a look at the patches.

NP, I really want to queue them soon :)

Just give me a quick hint about dependencies: Do I need anything else
before I can queue patch 1 and 3? I've lost track a bit...
