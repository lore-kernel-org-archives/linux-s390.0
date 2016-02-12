From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/18] KVM: s390: Fixes and features for kvm/next (4.6)
Date: Fri, 12 Feb 2016 17:18:42 +0100
Message-ID: <56BE05E2.8060101@redhat.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
 <56BDFF66.6080003@redhat.com> <56BE0037.6090505@de.ibm.com>
 <56BE01A3.4020801@redhat.com> <56BE0397.5030901@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <56BE0397.5030901@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>



On 12/02/2016 17:08, Christian Borntraeger wrote:
>>> I need one patch for 4.4 as well (vs. 3 patches against 4.5-rc3). So bisect is broken
>>> on 4.4 as well, I just had it fixed earlier.
>>
>> If these three patches are in Linus's tree, just send the pull request
>> against that.  It's okay if a submaintainer pull request brings back a
>> few more commits from Linus's tree.
> 
> Not yet in Linus tree (cgroup-fixes mostly)

As long as the bugs only surface with libvirt, I guess that's acceptable.

Paolo
