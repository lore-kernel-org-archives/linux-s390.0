From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Fri, 19 Jan 2018 11:12:41 +0100
Message-ID: <20180119101241.GB4519@osiris>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-3-borntraeger@de.ibm.com>
 <a81038d6-4b2c-05ab-7159-bf91b1aca164@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a81038d6-4b2c-05ab-7159-bf91b1aca164@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 18, 2018 at 09:47:01PM +0100, David Hildenbrand wrote:
> Two minor things
> 
> >  
> > +struct kvm_s390_gisa {
> > +	u32 next_alert;
> > +	u8 ipm;
> > +	u8 reserved01;
> > +	u8:6;
> 
> Mind giving this also a reserved name

And then all reserved fields have to be renamed as soon as one bit gets
used? Please don't...
