From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] s390: Add a mechanism to get the subchannel id.
Date: Tue, 14 Aug 2012 10:52:09 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1208141040240.1632@c4eb>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com> <1344351168-2568-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351168-2568-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Tue, 7 Aug 2012, Cornelia Huck wrote:
> +/**
> + * ccw_device_get_schid - obtain a subchannel id
> + * @cdev: device to obtain the id for
> + * @schid: where to fill in the values
> + */
> +void ccw_device_get_schid(struct ccw_device *cdev, struct subchannel_id *schid)
> +{
> +	*schid = cdev->private->schid;
> +}
> +EXPORT_SYMBOL(ccw_device_get_schid);

After I gave this some thought I like your version of this function
better. But please use the id of the parent subchannel instead of the
copy in cdev->private (since this will be removed soon). I'll do a
cleanup patch to convert the internal users of the old function to use
the one above.

Regards,
Sebastian
