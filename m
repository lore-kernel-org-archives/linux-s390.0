From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/3] s390/kvm fixes
Date: Tue, 29 Jan 2013 21:41:21 +0100
Message-ID: <510833F1.2000200@de.ibm.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com> <20130129131202.GC15004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130129131202.GC15004@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Marcelo Tossati <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 29/01/13 14:12, Gleb Natapov wrote:
> On Fri, Jan 25, 2013 at 03:34:14PM +0100, Christian Borntraeger wrote:
>> Gleb, Marcelo,
>>
> Alex, can you review?

Last time I checked, Cornelia and myself were s390/kvm/kernel maintainers ;-)
Alex is maintainer for s390/kvm/qemu. 
If the patch introduces or touched an kernel<->qemu interface, I usually try
to come to a conclusion with Alex before submission, but these patches are
only bugfixes and Alex is probably pretty busy working the last day before
qemus hard freeze for 1.4.

Christian
