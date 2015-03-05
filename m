From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixups for changes in merge window
 for 4.0
Date: Thu, 05 Mar 2015 11:33:54 +0100
Message-ID: <54F83112.2080002@redhat.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com> <20150305010743.GA10924@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150305010743.GA10924@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>



On 05/03/2015 02:07, Marcelo Tosatti wrote:
> Can you generate pull against current master?
> 
> $ git pull --ff-only git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> tags/kvm-s390-master-20150303   

Why insist that the pull request be ff-only?  By using the tag, the
merge commit will include the tag description, so you get more
information by not doing a fast forward.

Paolo
