Return-Path: <SRS0=2iIM=SV=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 19 Apr 2019 22:12:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
In-Reply-To: <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
        <20190417110348.28efc8e3.cohuck@redhat.com>
        <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
        <20190417171311.3478402b@oc2783563651>
        <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Apr 2019 11:18:19 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> 
> 
> On 04/17/2019 11:13 AM, Halil Pasic wrote:
> >>> Otherwise, looks good to me. Will queue when I get some ack/r-b.
> >>>
> >> I like it, but I feel weird giving an r-b to something I suggested:
> >>
> >> Acked-by: Eric Farman<farman@linux.ibm.com>
> >>
> > I think r-b is fine. You did verify both the design and the
> > implementation I guess. So I don't see why not.
> > 
> > How urgent is this. I could give this some love till the end of the
> > week. Should I @Connie,@Farhan?
> 
> Having more people review it is always a good thing :)
> 

Hi Farhan,

I was starring at this code for about an hour if not more and could not
figure out the intentions/ideas behind it. That is not a fault of your
patch, but I can't say that I understand neither the before nor the
after.

What understand this patch basically does is make us call
cio_disable_subchannel() more often. That is what you point out in your
commit message as well. But I fail to see how does this achieve what the
summary line promises:  'Prevent quiesce function going into an infinite
loop'.

Sorry, I can't r-b this. Maybe you can help me gain an understanding of
this code offline.

I guess, the approval of the people who actually understand what it is
going on (i.e. Connie and Eric) will have to suffice.

Regards,
Halil 
