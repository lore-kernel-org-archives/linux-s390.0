From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: wire up bpb feature
Date: Thu, 18 Jan 2018 07:27:32 +0100
Message-ID: <20180118072732.095bfddb@mschwideX1>
References: <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
        <20180117134434.48676-1-borntraeger@de.ibm.com>
        <887651e4-10fa-9bd1-0ce6-091235a9b085@redhat.com>
        <90ae6d5a-9f86-964b-74ca-e0971a11f497@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90ae6d5a-9f86-964b-74ca-e0971a11f497@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 22:43:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Conny can you review and ack as well?
> 
> Paolo, Radim,
> 
> As the other patches need to sync on the ifetch/nospec/gmb naming I have changed my mind. :-)
> This patch is independent from the other patches (as it just provides the guest facilities not caring
> about what the host does).
> 
> It seems that you do a kvm pull request for 4.15 anyway (for power), so it might make sense to
> apply this patch as well for 4.15. this will make it easier to also upstream the QEMU part in time
> as we need the uabi interfaces.

Indeed, there is no real dependency. I am thinking about doing a split of my patches as well,
everything but the gmb/nospec_xxx/ifetch/isync/whatever part. The prctl part needs some more
discussion, as will prepare a patch. Or two.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
