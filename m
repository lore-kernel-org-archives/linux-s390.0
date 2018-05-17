From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Thu, 17 May 2018 11:24:43 +0200
Message-ID: <20180517112443.0b39d7d9.cohuck@redhat.com>
References: <20180516173342.15174-1-pasic@linux.ibm.com>
        <20180517010925.GA30480@bjsdjshi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517010925.GA30480@bjsdjshi@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 17 May 2018 09:09:25 +0800
Dong Jia Shi <bjsdjshi@linux.ibm.com> wrote:

> * Halil Pasic <pasic@linux.ibm.com> [2018-05-16 19:33:42 +0200]:
> 
> Nitpick for Subject prefix (?):
> s/s390: vfio-ccw:/vfio: ccw:/

Trivial to fix up while applying.

> 
> > There is at least one relevant guest OS that doesn't set the IDA flags in
> > the ORB as we would like them, but never uses any IDA. So instead of
> > saying -EOPNOTSUPP when observing an ORB, such that a channel program
> > specified by it could be a not supported one, let us say -EOPNOTSUPP only
> > if the channel program is a not supported one.
> > 
> > Of course, the real solution would be doing proper translation for all
> > IDA. This is possible, but given the current code not straight forward.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> > ---
> > ---  
> Leftover?

git am will drop this anyway :)

> 
> >  drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >   
> 
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>

Thanks!
