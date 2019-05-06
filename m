Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 6 May 2019 18:31:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
Message-ID: <20190506183152.53cf9d32.cohuck@redhat.com>
In-Reply-To: <d6f28324-846f-54b6-84f0-c97e474361c1@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-8-farman@linux.ibm.com>
        <20190506173707.40216e76.cohuck@redhat.com>
        <65313674-09be-88c0-4b5e-c99527f26532@linux.ibm.com>
        <20190506181850.4b1b8300.cohuck@redhat.com>
        <d6f28324-846f-54b6-84f0-c97e474361c1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 6 May 2019 12:25:01 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/6/19 12:18 PM, Cornelia Huck wrote:

> > [1] tcws are a bit different; but we don't support them anyway.
> >   
> 
> Yeah...  I'd like to get the code cleaned up to a point where if we want 
> to support TCWs, we could just up front say "if command go here, if 
> transport go there."  Not that that'll be anytime soon, but it would 
> prevent us from having to dis-entangle everything at that future point.
> 

Let's see how much work that is :)
