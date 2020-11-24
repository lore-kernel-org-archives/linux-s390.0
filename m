Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Nov 2020 23:18:14 +0000
From: Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
Message-ID: <20201124231814.GA258638@google.com>
References: <alpine.DEB.2.23.453.2011131615510.333518@chino.kir.corp.google.com>
 <20201124191629.GB235281@google.com>
 <20201124194904.GA45519@google.com>
 <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
 <20201124210817.GA65542@google.com>
 <20201124212725.GB246319@google.com>
 <20201124222149.GB65542@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124222149.GB65542@google.com>
List-ID: <linux-s390.vger.kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Rientjes <rientjes@google.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas <thomas.lendacky@amd.com>, pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>, Eric <eric.vantassell@amd.com>, gingell@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020, Vipin Sharma wrote:
> On Tue, Nov 24, 2020 at 09:27:25PM +0000, Sean Christopherson wrote:
> > Is a root level stat file needed?  Can't the infrastructure do .max - .current
> > on the root cgroup to calculate the number of available ids in the system?
> 
> For an efficient scheduling of workloads in the cloud infrastructure, a
> scheduler needs to know the total capacity supported and the current
> usage of the host to get the overall picture. There are some issues with
> .max -.current approach:
> 
> 1. Cgroup v2 convention is to not put resource control files in the
>    root. This will mean we need to sum (.max -.current) in all of the
>    immediate children of the root.

Ah, that's annoying.  Now that you mention it, I do vaguely recall this behavior.
 
> 2. .max can have any limit unless we add a check to not allow a user to
>    set any value more than the supported one. 

Duh, didn't think that one through.

Thanks!
