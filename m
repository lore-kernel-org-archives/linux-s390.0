Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Sep 2020 14:14:04 -0700
From: Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
Message-ID: <20200922211404.GA4141897@google.com>
References: <20200922004024.3699923-1-vipinsh@google.com>
 <20200922014836.GA26507@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922014836.GA26507@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: thomas.lendacky@amd.com, pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, brijesh.singh@amd.com, jon.grimm@amd.com, eric.vantassell@amd.com, gingell@google.com, rientjes@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:48:38PM -0700, Sean Christopherson wrote:
> On Mon, Sep 21, 2020 at 05:40:22PM -0700, Vipin Sharma wrote:
> > Hello,
> > 
> > This patch series adds a new SEV controller for tracking and limiting
> > the usage of SEV ASIDs on the AMD SVM platform.
> > 
> > SEV ASIDs are used in creating encrypted VM and lightweight sandboxes
> > but this resource is in very limited quantity on a host.
> > 
> > This limited quantity creates issues like SEV ASID starvation and
> > unoptimized scheduling in the cloud infrastructure.
> > 
> > SEV controller provides SEV ASID tracking and resource control
> > mechanisms.
> 
> This should be genericized to not be SEV specific.  TDX has a similar
> scarcity issue in the form of key IDs, which IIUC are analogous to SEV ASIDs
> (gave myself a quick crash course on SEV ASIDs).  Functionally, I doubt it
> would change anything, I think it'd just be a bunch of renaming.  The hardest
> part would probably be figuring out a name :-).
> 
> Another idea would be to go even more generic and implement a KVM cgroup
> that accounts the number of VMs of a particular type, e.g. legacy, SEV,
> SEV-ES?, and TDX.  That has potential future problems though as it falls
> apart if hardware every supports 1:MANY VMs:KEYS, or if there is a need to
> account keys outside of KVM, e.g. if MKTME for non-KVM cases ever sees the
> light of day.

I read about the TDX and its use of the KeyID for encrypting VMs. TDX
has two kinds of KeyIDs private and shared.

On AMD platform there are two types of ASIDs for encryption.
1. SEV ASID - Normal runtime guest memory encryption.
2. SEV-ES ASID - Extends SEV ASID by adding register state encryption with
		 integrity.

Both types of ASIDs have their own maximum value which is provisioned in
the firmware

So, we are talking about 4 different types of resources:
1. AMD SEV ASID (implemented in this patch as sev.* files in SEV cgroup)
2. AMD SEV-ES ASID (in future, adding files like sev_es.*)
3. Intel TDX private KeyID
4. Intel TDX shared KeyID

TDX private KeyID is similar to SEV and SEV-ES ASID. I think coming up
with the same name which can be used by both platforms will not be easy,
and extensible with the future enhancements. This will get even more
difficult if Arm also comes up with something similar but with different
nuances.

I like the idea of the KVM cgroup and when it is mounted it will have
different files based on the hardware platform.

1. KVM cgroup on AMD will have:
sev.max & sev.current.
sev_es.max & sev_es.current.

2. KVM cgroup mounted on Intel:
tdx_private_keys.max
tdx_shared_keys.max

The KVM cgroup can be used to have control files which are generic (no
use case in my mind right now) and hardware platform specific files
also.
