From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 00/18] KVM: s390: Fixes and features for kvm/next (4.6)
Date: Fri, 12 Feb 2016 16:54:31 +0100
Message-ID: <56BE0037.6090505@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
 <56BDFF66.6080003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <56BDFF66.6080003@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 02/12/2016 04:51 PM, Paolo Bonzini wrote:
> 
> 
> On 12/02/2016 14:22, Christian Borntraeger wrote:
>> This time with less testing than usual on the branch itself, as 4.5-rc3
>> is broken in several ways (with fixes or workarounds or people working on
>> the issues). So this time these patches have been partially tested against
>> a 4.4 base and partially tested agains kvm/next :-/
> 
> Do you want to send them against 4.4 instead?  That would simplify
> bisection in the future.

I need one patch for 4.4 as well (vs. 3 patches against 4.5-rc3). So bisect is broken
on 4.4 as well, I just had it fixed earlier.

As you like, I can certainly rebase against 4.4, I am (un)happy with both.
