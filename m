From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/4] s390/kvm: Handle hosts not supporting s390-virtio.
Date: Fri, 10 Aug 2012 09:45:00 +0200
Message-ID: <20120810094500.0211c349@BR9GNB5Z>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351168-2568-2-git-send-email-cornelia.huck@de.ibm.com>
	<1DF99033-5FD5-40ED-9221-61E7EA5A9219@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1DF99033-5FD5-40ED-9221-61E7EA5A9219@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 10 Aug 2012 01:09:15 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 07.08.2012, at 16:52, Cornelia Huck wrote:
> 
> > Running under a kvm host does not necessarily imply the presence of
> > a page mapped above the main memory with the virtio information;
> > however, the code includes a hard coded access to that page.
> > 
> > Instead, check for the presence of the page and exit gracefully
> > before we hit an addressing exception if it does not exist.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > drivers/s390/kvm/kvm_virtio.c | 21 +++++++++++++++++++++
> > 1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
> > index 47cccd5..408447c 100644
> > --- a/drivers/s390/kvm/kvm_virtio.c
> > +++ b/drivers/s390/kvm/kvm_virtio.c
> > @@ -418,6 +418,21 @@ static void kvm_extint_handler(struct ext_code ext_code,
> > 	}
> > }
> > 
> > +static int __init test_devices_support(void)
> 
> Today we know what this function does, but the next person running into it has no clue. Maybe add a nice description here that you're trying to access memory above ram? (is this even what you're doing here? my s390 asm is slightly rusty) :)

Good point, will add a comment.
