From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 5/5] KVM: s390: Split out early console code.
Date: Tue, 30 Oct 2012 13:59:26 +0100
Message-ID: <20121030135926.2db07255@BR9GNB5Z>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com>
	<1351516046-30037-6-git-send-email-cornelia.huck@de.ibm.com>
	<1440F0DC-0DC5-40FB-88E2-EE203A7C5F66@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1440F0DC-0DC5-40FB-88E2-EE203A7C5F66@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 29 Oct 2012 19:14:19 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 29.10.2012, at 14:07, Cornelia Huck wrote:
> 
> > This code is transport agnostic and can be used by both the legacy
> > virtio code and virtio_ccw.
> 
> Would it be possible to actually send real virtio or sclp console commands for early printk? That'd make things a lot easier on the user space end. Combining two completely separate character channels (early printk + sclp or early printk + virtio-console) is really tricky.
> 

This code is only used if we use a virtio console device. The sclp
code path is completely different.

What do you mean with "real virtio console commands"? The message is
just put on the output queue anyway.
