From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/1] KVM: s390/mm: fix for 4.6
Date: Mon, 4 Apr 2016 09:45:32 +0200
Message-ID: <57021B9C.4090904@redhat.com>
References: <1459755692-126047-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1459755692-126047-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/04/2016 09:41, Christian Borntraeger wrote:
> Paolo,
> 
> here is a fix of a "merge issue" breaking some 
> kvm configurations on s390.
> 
> since Martin is away this week, lets push this fix via your
> tree. (this has the additional advantage that this fix will
> probably be part of kvm/next, making 4.7 patch handling
> easier). Ok?

Sure.

Paolo

> Heiko, can you ack this fix?
