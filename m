From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 26 Feb 2019 18:13:34 +0000
Subject: Re: [PATCH 0/2] Fix vfio-ccw handling of TIC recursion
Message-Id: <20190226191334.32945589.cohuck@redhat.com>
In-Reply-To: <45702003-613f-92f7-ee4f-b2cf572bb446@linux.ibm.com>
References: <45702003-613f-92f7-ee4f-b2cf572bb446@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Feb 2019 19:39:39 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Per the discussion [1] about a problem with how vfio-ccw calculates
> the length of a channel program (specifically when using the
> forthcoming QEMU BIOS code for DASD IPL), I present this fix.
> 
> Patch 1 fixes the problem, and is over-engineered
> for readability sake.
> 
> Patch 2 takes the functions from Patch 1, and refactors the
> existing code to make other areas a little easier to understand.
> (I hope.)
> 
> I've been running fio for over 24 hours now, and have seen
> zero hours.  Previously, I would have probably seen "a few"
> errors by now, where prior to the original fix I would've seen
> "many" errors.  Further tests are still ongoing.
> 
> [1] https://marc.info/?l=linux-s390&m=155063096321940&w=2
> 
> Eric Farman (2):
>   s390/cio: Fix vfio-ccw handling of recursive TICs
>   s390/cio: Use cpa range elsewhere within vfio-ccw
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 55 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 

Thanks, applied.
