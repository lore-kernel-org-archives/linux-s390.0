From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/8] s390/kvm fixes
Date: Tue, 21 May 2013 08:57:34 +0200
Message-ID: <20130521085734.2825746b@mschwide>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
	<20130519084943.GB4725@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130519084943.GB4725@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Marcelo Tossati <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 19 May 2013 11:49:43 +0300
Gleb Natapov <gleb@redhat.com> wrote:

> Hi Christian,
> 
> On Fri, May 17, 2013 at 02:41:30PM +0200, Christian Borntraeger wrote:
> > Gleb, Paolo, Marcelo,
> > 
> > here are some low level changes to kvm on s390 that we have been
> > cooking for a while now.
> > 
> > Patch "s390/pgtable: fix ipte notify bit" will go via Martins
> > tree into 3.10, but is included to reduce the amount of merge
> > conflicts. 
> > 
> > Patch "s390: fix gmap_ipte_notifier vs. software dirty pages"
> > will also go via Martins tree into 3.10 and it fixes a hang with
> > heavy host paging and KVM. This is optional for merging, but
> > makes testing on kvm/next easier.
> > 
> Can I add Martin's ACKs to those two then?

Yes.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
