From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/4] KVM: irqfds for s390
Date: Mon, 24 Mar 2014 11:40:16 +0100
Message-ID: <53300B90.7090301@redhat.com>
References: <1395406341-14698-1-git-send-email-cornelia.huck@de.ibm.com> <532FF0E1.5000502@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <532FF0E1.5000502@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 24/03/2014 09:46, Christian Borntraeger ha scritto:
>> > here's the next iteration of my patchset introducing irqfds for s390.
>> >
>> > Changes from v2:
>> > - rebased against current kvm/queue
>> > - kvm common code lock fix is already in queue
>> > - move some changes that belonged in patch 2 from patch 3
>> > - add a limit for mapped pages to patch 2
>> > - collected some acks
>> >
>> > Changes from v1:
>> > - rebased against current kvm/queue, bumping capability numbers
>> > - guest adapter interrupt support is already in the kvm tree
>> >
>> > Again, find it on
>> >
>> > git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git kvms390-irqfd
> Looks all good.
>
> Paolo,
>
> I guess this will miss the next merge window,  but can you pull for kvm/queue
> if you have no further comments?

I think this can get into the next merge window, no problem.

I plan to move kvm/queue -> kvm/next tomorrow or wednesday, and include 
this series.

Paolo
