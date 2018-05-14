From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Mon, 14 May 2018 17:01:35 +0200
Message-ID: <20180514170135.2cab4f7d.cohuck@redhat.com>
References: <20180509173647.61367-1-pasic@linux.ibm.com>
        <20180514135554.29569999.cohuck@redhat.com>
        <d0eb5f47-bb71-f615-3780-e753a22daf5b@linux.ibm.com>
        <20180514160016.3b689728.cohuck@redhat.com>
        <7bd8fc8b-0500-9905-a3a0-2ec56d3fc9f2@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7bd8fc8b-0500-9905-a3a0-2ec56d3fc9f2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 14 May 2018 16:44:29 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/14/2018 04:00 PM, Cornelia Huck wrote:
> > On Mon, 14 May 2018 15:37:17 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> On 05/14/2018 01:55 PM, Cornelia Huck wrote:  
> >>> On Wed,  9 May 2018 19:36:47 +0200
> >>> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>      
> >>>> +		/*
> >>>> +		 * 2k byte block IDAWs (fmt1 or fmt2) are not yet supported.
> >>>> +		 * There are however CPs that don't use IDA at all, and can
> >>>> +		 * benefit from not failing until failure is eminent.  
> >>>
> >>> What about:
> >>>
> >>> "As we don't want to fail direct addressing even if the orb specified
> >>> one of the unsupported formats, we defer checking for IDAWs in
> >>> unsupported formats to here."  
> >>
> >> Was the second sentence only confusing because of CP? I'm not perfectly
> >> satisfied with your version either:
> >> * 'fail direct addressing even if the orb specified one of the unsupported formats'
> >>      I wanted to say: 'hey it does not matter what format for IDA the orb implies
> >>      if the channel program does not use any IDA at all'. That could be paraphrased
> >>      as channel programs using direct addressing exclusively. But failing the direct
> >>      addressing does not fit for me.  
> > 
> > But that's effectively what happens now, no? We reject the orb out of
> > hand due to unsupported flags that do not have any relevance for the
> > channel program in that case.  
> 
> Yes, that's what happens now, except that we make the whole channel program fail,
> and not the direct addressing. But the comment should describe what happens
> with the patch applied.

Even more, it should describe _why_ it is done that way (the reason
being "we don't want to fail..."). That's where I've been coming from.

> >>> The patch looks sane, I have only issues with the description/comments.
> >>>      
> >>
> >> Thanks for having a look. Please give me short feedback about the one
> >> open point and I will respin with the requested changes.  
> > 
> > Does anybody else have feedback?
> >   
> 
> Will wait a day or so. Dong Jia and Jason have already seen the patch, and
> they only complained about the text. Since that spin was mainly for the
> tested-by tags, and I stated that any substantial discussion should happen
> upstream, I ignored those complaints.
> 
> So yes I will wait a bit so everybody can chime in.

Sounds good.
