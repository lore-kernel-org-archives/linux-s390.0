From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/5] KVM: s390: Base infrastructure for enabling capabilities.
Date: Tue, 11 Dec 2012 11:24:26 +0100
Message-ID: <4DE13BE9-6E59-42CE-B2E9-CE69041AD0CA@suse.de>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com> <1354883425-38531-5-git-send-email-cornelia.huck@de.ibm.com> <5C533A6B-0742-48CE-A62C-0385D7AB999A@suse.de> <20121210111613.4cab94c1@BR9GNB5Z>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121210111613.4cab94c1@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 10.12.2012, at 11:16, Cornelia Huck wrote:

> On Mon, 10 Dec 2012 08:54:45 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>> Missing patch description. Otherwise:
> 
> "Add base infrastructure for enabling capabilities" would be redundant,
> no?

Well, whoever pulls this gets to say what style he likes. I simply heads-on reject every patch that doesn't contain a patch description, but only a subject line :). Others are a lot more relaxed about this.

And yes, it'd be redundant, but easier readable imho.


Alex
