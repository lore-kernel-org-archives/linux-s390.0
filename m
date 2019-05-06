Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 6 May 2019 17:20:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 6/7] s390/cio: Don't pin vfio pages for empty transfers
Message-ID: <20190506172054.612fd557.cohuck@redhat.com>
In-Reply-To: <20190503134912.39756-7-farman@linux.ibm.com>
References: <20190503134912.39756-1-farman@linux.ibm.com>
        <20190503134912.39756-7-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri,  3 May 2019 15:49:11 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> If a CCW has a count of zero, then no data will be transferred and
> pinning/unpinning memory is unnecessary.
> 
> In addition to that, the skip flag of a CCW offers the possibility of
> data not being transferred, but is only meaningful for certain commands.
> Specifically, it is only applicable for a read, read backward, sense, or
> sense ID CCW and will be ignored for any other command code
> (SA22-7832-11 page 15-64, and figure 15-30 on page 15-75).

This made me look at QEMU, and it seems that we cheerfully ignore that
flag so far in our ccw interpretation code :/

> 
> (A sense ID is xE4, while a sense is x04 with possible modifiers in the
> upper four bits.  So we will cover the whole "family" of sense CCWs.)
> 
> For all those scenarios, since there is no requirement for the target
> address to be valid, we should skip the call to vfio_pin_pages() and
> rely on the IDAL address we have allocated/built for the channel
> program.  The fact that the individual IDAWs within the IDAL are
> invalid is fine, since they aren't actually checked in these cases.
> 
> Set pa_nr to zero, when skipping the pfn_array_pin() call, since it is
> defined as the number of pages pinned.  This will cause the vfio unpin
> logic to return -EINVAL, but since the return code is not checked it
> will not harm our cleanup path.

We could also try to skip the unpinning, but this works as well.

> 
> As we do this, since the pfn_array_pin() routine returns the number of
> pages pinned, and we might not be doing that, the logic for converting
> a CCW from direct-addressed to IDAL needs to ensure there is room for
> one IDAW in the IDAL being built since a zero-length IDAL isn't great.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 61 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 6 deletions(-)

Looks good to me.
