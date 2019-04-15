Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 15 Apr 2019 16:44:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 2/3] vfio-ccw: Prevent quiesce function going into an
 infinite loop
Message-ID: <20190415164443.4a418f97.cohuck@redhat.com>
In-Reply-To: <7f1f3844-9108-fea8-a723-1d1d5c0047cd@linux.ibm.com>
References: <cover.1554756534.git.alifm@linux.ibm.com>
        <2c17cf29fbce8fc1cfbf60cfd04559d00c8eeac0.1554756534.git.alifm@linux.ibm.com>
        <20190411182434.07d5f685.cohuck@redhat.com>
        <ffcffd06-5bbd-a97c-021e-855b2240982d@linux.ibm.com>
        <20190412101013.2bf4a5df.cohuck@redhat.com>
        <396cde69-5c1d-b9e5-aaa2-248cf91e6f60@linux.ibm.com>
        <20190415101332.7ebbe5ad.cohuck@redhat.com>
        <00c54029-9f60-4242-8a3a-a87bf1e0434b@linux.ibm.com>
        <20190415161841.75aa61f4.cohuck@redhat.com>
        <7f1f3844-9108-fea8-a723-1d1d5c0047cd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2019 10:24:53 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 04/15/2019 10:18 AM, Cornelia Huck wrote:

> > Yes, please do send it separately. I'm currently testing patch 1 and 3
> > on top of my patchset, will queue either with or without the halt/clear
> > patches proper, depending on how soon I get acks/r-bs (hint, hint :)  
> 
> I am going through your patches 4 and 6 and hopefully will get back to 
> you by the end of the day :).

Awesome, thanks!
