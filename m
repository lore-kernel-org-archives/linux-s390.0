From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 0/4] vfio: ccw: error handling fixes and improvements
Date: Thu, 24 May 2018 16:29:40 +0200
Message-ID: <20180524162940.13d3b2df.cohuck@redhat.com>
References: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
        <20180523122129.5f765d24.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523122129.5f765d24.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 23 May 2018 12:21:29 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 23 May 2018 04:56:41 +0200
> Dong Jia Shi <bjsdjshi@linux.ibm.com> wrote:
> 
> > Dear Reviewers,
> > 
> > Here is a new version for this patch series.
> > 
> > We didn't get agreement on patch #4 (#5 in v2) in the former cycle though,
> > I made it based on my understanding. We can continue discussing on it.  
> 
> I'll probably go ahead and queue 1-3 (would not mind r-bs, though) in
> any case.
> 
> I hope we can queue the tracing patch as well, as any tracing beats no
> tracing :)

OK, I've pushed this out to the vfio-ccw branch.

Would still be great to get some R-bs.

What about sending a pull req next week, so that we get this ready for
the 4.18 merge window?
