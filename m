From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixups for changes in merge window for
 4.0
Date: Thu, 5 Mar 2015 14:43:38 -0300
Message-ID: <20150305174338.GB5396@amt.cnet>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
 <20150305010743.GA10924@amt.cnet>
 <54F83112.2080002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F83112.2080002@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 05, 2015 at 11:33:54AM +0100, Paolo Bonzini wrote:
> 
> 
> On 05/03/2015 02:07, Marcelo Tosatti wrote:
> > Can you generate pull against current master?
> > 
> > $ git pull --ff-only git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> > tags/kvm-s390-master-20150303   
> 
> Why insist that the pull request be ff-only?  By using the tag, the
> merge commit will include the tag description, so you get more
> information by not doing a fast forward.
> 
> Paolo

No reason, in fact. 

Pulled.
