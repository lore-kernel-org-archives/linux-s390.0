Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 Nov 2020 18:06:24 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
Message-ID: <20201103020623.GJ21563@linux.intel.com>
References: <20200922004024.3699923-1-vipinsh@google.com>
 <20200922014836.GA26507@linux.intel.com>
 <20200922211404.GA4141897@google.com>
 <20200924192116.GC9649@linux.intel.com>
 <cb592c59-a50e-5901-71fe-19e43bc9e37e@amd.com>
 <20200925222220.GA977797@google.com>
 <20201002204810.GA3179405@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002204810.GA3179405@google.com>
List-ID: <linux-s390.vger.kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: thomas.lendacky@amd.com, pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, brijesh.singh@amd.com, jon.grimm@amd.com, eric.vantassell@amd.com, gingell@google.com, rientjes@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:48:10PM -0700, Vipin Sharma wrote:
> On Fri, Sep 25, 2020 at 03:22:20PM -0700, Vipin Sharma wrote:
> > I agree with you that the abstract name is better than the concrete
> > name, I also feel that we must provide HW extensions. Here is one
> > approach:
> > 
> > Cgroup name: cpu_encryption, encryption_slots, or memcrypt (open to
> > suggestions)
> > 
> > Control files: slots.{max, current, events}

I don't particularly like the "slots" name, mostly because it could be confused
with KVM's memslots.  Maybe encryption_ids.ids.{max, current, events}?  I don't
love those names either, but "encryption" and "IDs" are the two obvious
commonalities betwee TDX's encryption key IDs and SEV's encryption address
space IDs.
