From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/3] s390/kvm fixes
Date: Wed, 30 Jan 2013 09:51:24 +0100
Message-ID: <5108DF0C.3090907@de.ibm.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com> <20130129131202.GC15004@redhat.com> <510833F1.2000200@de.ibm.com> <20130129204600.GE627@redhat.com> <20130129210329.GF627@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130129210329.GF627@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Marcelo Tossati <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 29/01/13 22:03, Gleb Natapov wrote:

>> The question about 1/1. It is CCed to stable, does this mean you want it
>> to go to 3.8? kvm-next is for 3.9.
>>
> On the second thought, if it is not a regression 3.9 is the right place.

The store status part is broken, but it only has a severe impact in case of 
a machine check. (The machine check handler revalidates all registers with
the content of the save area).
Since machine checks are part of the virtio-ccw code, this can go into 3.9.
Feel free to remove the CC:stable. 

Christian
