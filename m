From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: new KVM branch for linux-next
Date: Thu, 7 Dec 2017 09:47:17 +1100
Message-ID: <20171207094717.606e313e@canb.auug.org.au>
References: <60545562-09bf-77bd-53f2-786508bdc53e@redhat.com>
        <20171128082441.3d242d3a@canb.auug.org.au>
        <150f7734-5b9e-2564-f254-d09fbc6902ac@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <150f7734-5b9e-2564-f254-d09fbc6902ac@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christian,

On Wed, 6 Dec 2017 09:31:16 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
> when we are at it: can you also add branch master of
> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
> 
> (probably after the kvm/master thing)
> 
> A good name might be kvms390-fixes
> 
> This will contain fixes for kvm on s390 targeted for the current release.
> Usually this branch will be merged in Paolos kvm/master which will 
> then go to Linus
> 
> As contact please use
> "Christian Borntraeger <borntraeger@de.ibm.com>"
> "Cornelia Huck <cohuck@redhat.com>"
> kvm@vger.kernel.org
> linux-s390@vger.kernel.org

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr@canb.auug.org.au
