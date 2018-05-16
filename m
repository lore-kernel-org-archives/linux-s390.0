From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio: ccw: fix error return in vfio_ccw_sch_event
Date: Wed, 16 May 2018 18:17:10 +0200
Message-ID: <20180516181710.1765484f.cohuck@redhat.com>
References: <20180502072559.50691-1-bjsdjshi@linux.vnet.ibm.com>
        <20180502164251.577e2af8.cohuck@redhat.com>
        <20180503020640.GW5428@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503020640.GW5428@bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 3 May 2018 10:06:40 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-05-02 16:42:51 +0200]:
> 
> > On Wed,  2 May 2018 09:25:59 +0200
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> > > If device has not been registered, or there is a pending work,  
> > 
> > s/a pending work/work pending/

Also, s/device/the device/

> >   
> > > we should reschedule a sch_event call again.
> > > 
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>  

(...)

> > 
> > I guess I should pick this for 4.17?
> >   
> I think there is no pressure for this one. So please feel free to decide
> as your convenience.
> 

OK, I've queued this for the next release. Will wait for more patches
(e.g. the ida check pushdown) before I send a pull request.
