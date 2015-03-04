From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixups for changes in merge window
 for 4.0
Date: Wed, 04 Mar 2015 12:42:59 +0100
Message-ID: <54F6EFC3.4050909@de.ibm.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 04.03.2015 um 12:41 schrieb Christian Borntraeger:
> Paolo, Marcelo,
> 
> here is a pull request for kvm/master targetting 4.0. It is based on
> 4.0-rc1 as I want all patches in an upcoming pull request against 
> kvm/next as well to avoid nasty merge conflicts with other changes
> that we have pending. So my next pull request for kvm/next will
> be based on fb5bf93f84c277546473, which is the HEAD of this pull
> request.

Or just against 4.0-rc1 thus having 5 identical commits.
