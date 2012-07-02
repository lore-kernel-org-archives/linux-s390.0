From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/6] kvm/s390: sigp related changes for 3.6
Date: Mon, 2 Jul 2012 12:00:20 +0200
Message-ID: <20120702120020.1525923d@de.ibm.com>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
	<20120629231946.GB14304@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120629231946.GB14304@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Avi Kivity <avi@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jun 2012 20:19:46 -0300
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> On Tue, Jun 26, 2012 at 04:06:35PM +0200, Cornelia Huck wrote:
> > Avi, Marcelo,
> > 
> > here are some more s390 patches for the next release.
> > 
> > Patches 1 and 2 are included for dependency reasons; they will also
> > be sent through Martin's s390 tree.
> 
> I don't see why patch 1 is a dependency for merging in the kvm 
> tree, and why patch 2 should go through both trees?
> 
> That is, patch 1 can go through S390 tree, patches 2-6 through 
> KVM tree. No?

Patch 3 has a dependency on patch 2 and patch 2 has a dependency
on patch 1. The hunk in pcpu_running would cause a reject:

@@ -155,8 +131,8 @@ static inline int pcpu_stopped(struct pcpu *pcpu)
 
 static inline int pcpu_running(struct pcpu *pcpu)
 {
-       if (__pcpu_sigp(pcpu->address, sigp_sense_running,
-                       0, &pcpu->status) != sigp_status_stored)
+       if (__pcpu_sigp(pcpu->address, SIGP_SENSE_RUNNING,
+                       0, &pcpu->status) != SIGP_CC_STATUS_STORED)
                return 1;
        /* Status stored condition code is equivalent to cpu not running. */
        return 0;


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
