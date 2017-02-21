From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v3 04/15] vfio: ccw: basic
 implementation for vfio_ccw driver
Date: Tue, 21 Feb 2017 15:43:02 +0800
Message-ID: <33710.9298714951$1505297852@news.gmane.org>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-5-bjsdjshi@linux.vnet.ibm.com>
	<20170220193113.3ba5af2c.cornelia.huck@de.ibm.com>
	<20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-21 15:36:23 +0800]:

[...]
> > > +static int vfio_ccw_sch_probe(struct subchannel *sch)
> > > +{
> > > +	struct pmcw *pmcw = &sch->schib.pmcw;
> > > +	struct vfio_ccw_private *private;
> > > +	int ret;
> > > +
> > > +	if (pmcw->qf) {
> > > +		dev_warn(&sch->dev, "vfio: ccw: do not support QDIO: %s\n",
> > 
> > s/do/does/
> > 
> Ok.
> 
> > > +			 dev_name(&sch->dev));
> > > +		return -ENOTTY;
> > 
> > Is -ENOTTY the right return code here? -EINVAL?
> > 
> Ok. Think it again. -EINVAL makes more sense. It's like:
> "hey, I know it's an I/O subchannel, but not the kind we support".
> 
Or -ENOTSUPP ?
> > > +	}
> > > +
[...]

-- 
Dong Jia
