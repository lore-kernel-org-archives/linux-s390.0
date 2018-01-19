From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Fri, 19 Jan 2018 11:29:24 +0100
Message-ID: <20180119112924.2612f3ae.cohuck@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
        <20180116200217.211897-3-borntraeger@de.ibm.com>
        <a81038d6-4b2c-05ab-7159-bf91b1aca164@redhat.com>
        <20180119101241.GB4519@osiris>
        <9f7484d1-6880-4000-ebad-b22611276810@redhat.com>
        <20180119102038.GC4519@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180119102038.GC4519@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 19 Jan 2018 11:20:39 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Fri, Jan 19, 2018 at 11:17:10AM +0100, David Hildenbrand wrote:
> > On 19.01.2018 11:12, Heiko Carstens wrote:  
> > > On Thu, Jan 18, 2018 at 09:47:01PM +0100, David Hildenbrand wrote:  
> > >> Two minor things
> > >>  
> > >>>  
> > >>> +struct kvm_s390_gisa {
> > >>> +	u32 next_alert;
> > >>> +	u8 ipm;
> > >>> +	u8 reserved01;
> > >>> +	u8:6;  
> > >>
> > >> Mind giving this also a reserved name  
> > > 
> > > And then all reserved fields have to be renamed as soon as one bit gets
> > > used? Please don't...  
> > 
> > Only if one keeps the order of the reserved field numbers ...  
> 
> And that's what people usually do. Therefore having unnamed bitfields is
> nice, since you don't have to care.
> 

+1

They make these kinds of definitions so much nicer...
