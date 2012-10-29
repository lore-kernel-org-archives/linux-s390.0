From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/5] s390: Guest support for virtio-ccw.
Date: Mon, 29 Oct 2012 19:15:04 +0100
Message-ID: <20121029191504.0d36a68a@BR9GNB5Z>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com>
	<CE383E4A-4C23-4E8C-B237-EFD2F849D884@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CE383E4A-4C23-4E8C-B237-EFD2F849D884@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 29 Oct 2012 18:55:21 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 29.10.2012, at 14:07, Cornelia Huck wrote:
> 
> > Avi, Marcelo,
> > 
> > I'd like to propose inclusion of the guest support patches for
> > virtio-ccw into 3.8.
> > 
> > I'm confident that the host <-> guest interface for virtio-ccw
> > is fine now, and the patches have been extensively tested by our
> > internal test team.
> > 
> > Patch 1 might conceivably be 3.7 material, though I fear it's a
> > bit late for that.
> 
> Well, patch 1 without virtio-ccw support is quite useless, right? You wouldn't get any I/O at all.

Yes, but it stops in an obvious way (no devices can be found) and
not with a strange backchain.
