Return-Path: <SRS0=e7nO=SU=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 18 Apr 2019 16:36:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
Message-ID: <20190418163643.14bf1cd4.cohuck@redhat.com>
In-Reply-To: <20190417171311.3478402b@oc2783563651>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
        <20190417110348.28efc8e3.cohuck@redhat.com>
        <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
        <20190417171311.3478402b@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Apr 2019 17:13:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 17 Apr 2019 09:58:24 -0400
> Eric Farman <farman@linux.ibm.com> wrote:

> > I like it, but I feel weird giving an r-b to something I suggested:
> > 
> > Acked-by: Eric Farman <farman@linux.ibm.com>
> >   
> 
> I think r-b is fine. You did verify both the design and the
> implementation I guess. So I don't see why not.

+1, an r-b by a suggestor is completely fine :)

> 
> How urgent is this. I could give this some love till the end of the
> week. Should I @Connie,@Farhan?

I plan to queue this early next week, so I can send a pull request mid
next week.
