From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/6] KVM: s390: fix sigp set prefix status stored cases
Date: Tue, 26 Jun 2012 17:42:34 +0200
Message-ID: <95617453-A143-41C4-B913-D6DB587B4FD8@suse.de>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com> <1340719601-11867-5-git-send-email-cornelia.huck@de.ibm.com> <FBB4695B-5B84-4644-9C26-C037258DC20A@suse.de> <20120626173939.52617394@BR9GNB5Z>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120626173939.52617394@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



Am 26.06.2012 um 17:39 schrieb Cornelia Huck <cornelia.huck@de.ibm.com>:

> On Tue, 26 Jun 2012 16:56:08 +0200
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 26.06.2012, at 16:06, Cornelia Huck wrote:
>> 
>>> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> 
>>> If an invalid parameter is passed or the addressed cpu is in an
>>> incorrect state sigp set prefix will store a status.
>>> This status must only have bits set as defined by the architecture.
>>> The current kvm implementation missed to clear bits and also did
>>> not set the intended status bit ("and" instead of "or" operation).
>>> 
>>> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> 
>> What was the net effect of this for a guest? Any problems rising from it?
> 
> The guest might see some unexpected status bits if it did call sigp set
> prefix in an incorrect way. I'm not aware that anybody has actually
> seen that.

Yeah, we only need the set prefix on vm init and here it should always succeed, so this one is not all that urgent :).

Alex

> 
> Cornelia
> 
