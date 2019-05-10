Return-Path: <SRS0=etnf=TK=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 10 May 2019 13:47:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
Message-ID: <20190510134718.3f727571.cohuck@redhat.com>
In-Reply-To: <5c2b74a9-e1d9-cd63-1284-6544fa4376d9@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-8-farman@linux.ibm.com>
        <8625f759-0a2d-09af-c8b5-5b312d854ba1@linux.ibm.com>
        <7c897993-d146-bf8e-48ad-11a914a04716@linux.ibm.com>
        <bba6c0a8-2346-cd99-b8ad-f316daac010b@linux.ibm.com>
        <7ac9fb43-8d7a-9e04-8cba-fa4c63dfc413@linux.ibm.com>
        <1f2e4272-8570-f93f-9d67-a43dcb00fc55@linux.ibm.com>
        <5c2b74a9-e1d9-cd63-1284-6544fa4376d9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 May 2019 11:22:07 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> For the NOOP its clearly stated that it does not start a data transfer.
> If we pin the CDA, it could then eventually be the cause of errors if 
> the address indicated by the CDA is not accessible.
> 
> The NOOP is a particular CONTROL operation for which no data is transfered.
> Other CONTROL operation may start a data transfer.

I've just looked at the documentation again.

The Olde Common I/O Device Commands document indicates that a NOOP
simply causes channel end/device end.

The PoP seems to indicate that the cda is always checked (i.e. does it
point to a valid memory area?), but I'm not sure whether the area that
is pointed to is checked for accessibility etc. as well, even if the
command does not transfer any data.

Has somebody tried to find out what happens on Real Hardware(tm) if you
send a command that is not supposed to transfer any data where the cda
points to a valid, but not accessible area?

In general, I think doing the translation (and probably already hitting
errors there) is better than sending down a guest address.
