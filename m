From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 23 Oct 2018 12:17:13 +0000
Subject: Re: [PATCH v1 2/2] vfio: ccw: Register mediated device once all structures are initialized
Message-Id: <20181023141713.2ebcf24d.cohuck@redhat.com>
In-Reply-To: <2ca9df71-848e-1ec1-9773-100f05d01b8a@linux.ibm.com>
References: <2ca9df71-848e-1ec1-9773-100f05d01b8a@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 Oct 2018 19:52:25 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 10/20/2018 07:10 PM, Cornelia Huck wrote:
> > On Thu, 18 Oct 2018 15:58:48 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> On 10/18/2018 09:51 AM, Pierre Morel wrote:  
> >>> There is a risk that the mediated device is used before all the
> >>> data are initialized if it is register too early.    
> >>
> >> How big is the risk? Is this a bug fix (if it is do we need cc stable)
> >> or readability improvement?  
> > 
> > This looks like a bug fix to me, but not sure if it is stable material.
> > I wanted to apply as-is.
> >   
> 
> Isn't atomic_set(&private->avail, 1); sufficient to ensure no mdev
> is created on top of the parent dev unless private->io_work is already
> initialized? (->avail an ->state are zero initialized, which for the
> latter means VFIO_CCW_STATE_NOT_OPER.)
> 
> Pierre states in the cover letter that this one is a bugfix. But I don't
> quite get it.
> 
> If it is an exploitable bug, I think it should be stable material, or?
> 
> Regardless, I would prefer a better commit message and title. For
> instance 'if it is register too early' does not seem grammatical to me,
> and the 'register' is also misleading: I guess, it is not about
> vfio_ccw_mdev_reg() but the register triggered by mdev create.
> 
> But no strong feelings here: the patch, if nothing else, contributes to
> readability, thus it is useful.
> 
> BTW I do remember not being confident about the synchronization in vfio-ccw,
> but was hoping all this gets cleared up when the new functions (clear, halt,
> etc) get implement.

OK, I'm not in the position at the moment to do an in-depth discussion
of this (conference)... Pierre, can you post an updated description,
and Halil, can you let me know if that satisfies your requirements? If
I'm going to apply this, I'd like to know whether people are happy with
that soon...

> 
> Regards,
> Halil
> 
> >>
> >> I would prefer a commit message that clearly answers these questions.
> >>
> >> Otherwise I don't have a strong opinion.
> >>
> >> Regards,
> >> Halil
> >>  
> >>>
> >>> Let's register the mediated device when all the data structures
> >>> which could be used are initialized.
> >>>
> >>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>    
> >>  
> >   
> 
