Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Nov 2020 13:08:17 -0800
From: Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
Message-ID: <20201124210817.GA65542@google.com>
References: <alpine.DEB.2.23.453.2011131615510.333518@chino.kir.corp.google.com>
 <20201124191629.GB235281@google.com>
 <20201124194904.GA45519@google.com>
 <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas <thomas.lendacky@amd.com>, pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>, Eric <eric.vantassell@amd.com>, gingell@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:18:45PM -0800, David Rientjes wrote:
> On Tue, 24 Nov 2020, Vipin Sharma wrote:
> 
> > > > Looping Janosch and Christian back into the thread.                           
> > > >                                                                               
> > > > I interpret this suggestion as                                                
> > > > encryption.{sev,sev_es,keyids}.{max,current,events} for AMD and Intel         
> > > 
> > > I think it makes sense to use encryption_ids instead of simply encryption, that
> > > way it's clear the cgroup is accounting ids as opposed to restricting what
> > > techs can be used on yes/no basis.
> > > 
> 
> Agreed.
> 
> > > > offerings, which was my thought on this as well.                              
> > > >                                                                               
> > > > Certainly the kernel could provide a single interface for all of these and    
> > > > key value pairs depending on the underlying encryption technology but it      
> > > > seems to only introduce additional complexity in the kernel in string         
> > > > parsing that can otherwise be avoided.  I think we all agree that a single    
> > > > interface for all encryption keys or one-value-per-file could be done in      
> > > > the kernel and handled by any userspace agent that is configuring these       
> > > > values.                                                                       
> > > >                                                                               
> > > > I think Vipin is adding a root level file that describes how many keys we     
> > > > have available on the platform for each technology.  So I think this comes    
> > > > down to, for example, a single encryption.max file vs                         
> > > > encryption.{sev,sev_es,keyid}.max.  SEV and SEV-ES ASIDs are provisioned      
> > > 
> > > Are you suggesting that the cgroup omit "current" and "events"?  I agree there's
> > > no need to enumerate platform total, but not knowing how many of the allowed IDs
> > > have been allocated seems problematic.
> > > 
> > 
> > We will be showing encryption_ids.{sev,sev_es}.{max,current}
> > I am inclined to not provide "events" as I am not using it, let me know
> > if this file is required, I can provide it then.
> > 
> > I will provide an encryption_ids.{sev,sev_es}.stat file, which shows
> > total available ids on the platform. This one will be useful for
> > scheduling jobs in the cloud infrastructure based on total supported
> > capacity.
> > 
> 
> Makes sense.  I assume the stat file is only at the cgroup root level 
> since it would otherwise be duplicating its contents in every cgroup under 
> it.  Probably not very helpful for child cgroup to see stat = 509 ASIDs 
> but max = 100 :)

Yes, only at root.
