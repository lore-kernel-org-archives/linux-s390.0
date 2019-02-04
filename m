Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 4 Feb 2019 13:07:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190204130718.0fb8cdb3.cohuck@redhat.com>
In-Reply-To: <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <20190131105555.4af6d8ea.cohuck@redhat.com>
        <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
        <20190201153522.4f72cf00.cohuck@redhat.com>
        <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 4 Feb 2019 11:15:25 +0100
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 01.02.19 15:35, Cornelia Huck wrote:
> > On Thu, 31 Jan 2019 18:50:57 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> On 1/31/19 4:55 AM, Cornelia Huck wrote:  
> >>> On Wed, 30 Jan 2019 12:48:46 -0500
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>> Two questions:
> >>> - Does the event cover _any_ change to the AP configuration, or can the
> >>>    periodic scan detect changes that are not signaled?    
> >> It can detect any change, such as a change to the CRYCB masks.  
> > Nice. I suppose we can not rely on those messages being generated,
> > though, and therefore need to keep the periodic scan...  
> As you wrote, I am not sure if the ap bus code can rely on this to
> cover all changes. For kvm guests I think it is currently not working
> as there is no such notification generated at all. So I'd like to
> have the periodic scan in place.

Yes, and there are bound to be QEMU versions without that support in
active use even if this is implemented in the future. But a quicker
reaction to changes on real hardware still sounds like a win to me :)
