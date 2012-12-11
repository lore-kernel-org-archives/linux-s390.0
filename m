From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 5/5] KVM: s390: Split out early console code.
Date: Tue, 11 Dec 2012 11:10:39 +0100
Message-ID: <DC2767EE-52E6-4BF4-9F79-0603BBE87A77@suse.de>
References: <1354883369-36537-1-git-send-email-cornelia.huck@de.ibm.com> <1354883369-36537-6-git-send-email-cornelia.huck@de.ibm.com> <C9C36A9A-40FC-47DD-B10D-0027CE590EFB@suse.de> <20121210100631.160cd7bc@BR9GNB5Z>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121210100631.160cd7bc@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 10.12.2012, at 10:06, Cornelia Huck wrote:

> On Sun, 9 Dec 2012 13:45:47 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 07.12.2012, at 13:29, Cornelia Huck wrote:
>> 
>>> This code is transport agnostic and can be used by both the legacy
>>> virtio code and virtio_ccw.
>> 
>> This code should die. It's a nightmare to implement in QEMU, because it ends up being a separate char device. I'd prefer if we don't carry it over to the virtio-ccw world :).
> 
> I don't really want to kill an interface in a patchset adding a new
> transport. We may kill this later on, though...

I fully agree :). What I was trying to say is "leave this to die in the old code and don't bother about it in the new world order". Removing support for the old kvm virtio machine is nothing for today.


Alex
