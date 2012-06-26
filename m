From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/6] KVM: s390: fix sigp set prefix status stored cases
Date: Tue, 26 Jun 2012 17:39:39 +0200
Message-ID: <20120626173939.52617394@BR9GNB5Z>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
	<1340719601-11867-5-git-send-email-cornelia.huck@de.ibm.com>
	<FBB4695B-5B84-4644-9C26-C037258DC20A@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <FBB4695B-5B84-4644-9C26-C037258DC20A@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Jun 2012 16:56:08 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 26.06.2012, at 16:06, Cornelia Huck wrote:
> 
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > If an invalid parameter is passed or the addressed cpu is in an
> > incorrect state sigp set prefix will store a status.
> > This status must only have bits set as defined by the architecture.
> > The current kvm implementation missed to clear bits and also did
> > not set the intended status bit ("and" instead of "or" operation).
> > 
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> What was the net effect of this for a guest? Any problems rising from it?

The guest might see some unexpected status bits if it did call sigp set
prefix in an incorrect way. I'm not aware that anybody has actually
seen that.

Cornelia
