Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 17 May 2019 16:06:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/3] s390/cio: Don't pin vfio pages for empty
 transfers
Message-ID: <20190517160604.62265254.cohuck@redhat.com>
In-Reply-To: <4e4b46e6-3dfd-9ef7-71e9-4859ace10d25@linux.ibm.com>
References: <20190516161403.79053-1-farman@linux.ibm.com>
        <20190516161403.79053-2-farman@linux.ibm.com>
        <20190517110635.5204a9e8.cohuck@redhat.com>
        <4e4b46e6-3dfd-9ef7-71e9-4859ace10d25@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 May 2019 08:57:10 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/17/19 5:06 AM, Cornelia Huck wrote:
> > On Thu, 16 May 2019 18:14:01 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> The skip flag of a CCW offers the possibility of data not being
> >> transferred, but is only meaningful for certain commands.
> >> Specifically, it is only applicable for a read, read backward, sense,
> >> or sense ID CCW and will be ignored for any other command code
> >> (SA22-7832-11 page 15-64, and figure 15-30 on page 15-75).
> >>
> >> (A sense ID is xE4, while a sense is x04 with possible modifiers in the
> >> upper four bits.  So we will cover the whole "family" of sense CCWs.)
> >>
> >> For those scenarios, since there is no requirement for the target
> >> address to be valid, we should skip the call to vfio_pin_pages() and
> >> rely on the IDAL address we have allocated/built for the channel
> >> program.  The fact that the individual IDAWs within the IDAL are
> >> invalid is fine, since they aren't actually checked in these cases.
> >>
> >> Set pa_nr to zero when skipping the pfn_array_pin() call, since it is
> >> defined as the number of pages pinned and is used to determine
> >> whether to call vfio_unpin_pages() upon cleanup.
> >>
> >> As we do this, since the pfn_array_pin() routine returns the number of
> >> pages pinned, and we might not be doing that, the logic for converting
> >> a CCW from direct-addressed to IDAL needs to ensure there is room for
> >> one IDAW in the IDAL being built since a zero-length IDAL isn't great.  
> > 
> > I have now read this sentence several times and that this and that
> > confuses me :)  
> 
> I have read this code for several months and I'm still confused.  :)

Lol, I guess you are not alone :)

> 
> > What are we doing, and what is the thing that we might
> > not be doing?  
> 
> In the codepath that converts a direct-addressed CCW into an indirect
> one, we currently rely on the returned value from pfn_array_pin() to
> tell us how many pages were pinned, and thus how big of an IDAL to
> allocate.  But since this patch causes us to skip the call to
> pfn_array_pin() for certain CCWs, using that value would be zero
> (leftover from pfn_array_alloc()) and thus would be weird to pass to the
> kcalloc() for our IDAL.  We definitely want to allocate our own IDAL so
> that CCW.CDA contains a valid address, regardless of whether the IDAWs
> will be populated or not, so we calculate the number of pages ourselves
> here.
> 
> (Sidebar, the above is not a concern for the IDAL-to-IDAL codepath,
> since it has already calculated the size of the IDAL from the guest CCW
> and is going page-by-page through it.)
> 
> pfn_array_pin() doesn't return "partial pin" counts.  If we ask for 10
> pages to be pinned and it only does 5, we're going to get an error that
> we have to clean up from, rather than carrying on as if "up to 10" pages
> pinned was acceptable.  To say that another way, there's no SLI bit for
> the vfio_pin_pages() call, so it's not necessary to rely on the count
> being returned if we ourselves calculate it.
> 
> So, with that...  Maybe the paragraph in question should be something
> like this?
> 
> ---8<---
> The pfn_array_pin() routine returns the number of pages that were
> pinned, but now might be skipped for some CCWs.  Thus we need to
> calculate the expected number of pages ourselves such that we are
> guaranteed to allocate a reasonable number of IDAWs, which will
> provide a valid address in CCW.CDA regardless of whether the IDAWs
> are filled in with pinned/translated addresses or not.

Much better, thanks!

I can change the description when picking up, if no reason for a respin
comes up (series seems sane to me so far).

> 
> >   
> >>
> >> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >> ---
> >>   drivers/s390/cio/vfio_ccw_cp.c | 55 ++++++++++++++++++++++++++++++----
> >>   1 file changed, 50 insertions(+), 5 deletions(-)  
> >   
