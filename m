From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 3/4] s390/kvm: Add a channel I/O based virtio
 transport driver.
Date: Tue, 9 Oct 2012 16:30:46 +0200
Message-ID: <20121009163046.16fcefab@BR9GNB5Z>
References: <1346771622-52763-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771622-52763-4-git-send-email-cornelia.huck@de.ibm.com>
	<04780C07-9F02-4148-B375-83C6025D6E45@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <04780C07-9F02-4148-B375-83C6025D6E45@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Sep 2012 18:38:38 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 04.09.2012, at 17:13, Cornelia Huck wrote:

> > +static u32 virtio_ccw_get_features(struct virtio_device *vdev)
> > +{
> > +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > +	struct virtio_feature_desc features;
> > +	int ret;
> > +
> > +	/* Read the feature bits from the host. */
> > +	/* TODO: Features > 32 bits */
> > +	features.index = 0;
> > +	vcdev->ccw.cmd_code = CCW_CMD_READ_FEAT;
> > +	vcdev->ccw.flags = 0;
> > +	vcdev->ccw.count = sizeof(features);
> > +	vcdev->ccw.cda = vcdev->area;
> > +	ret = ccw_io_helper(vcdev, VIRTIO_CCW_DOING_READ_FEAT);
> > +	if (ret)
> > +		return 0;
> > +
> > +	memcpy(&features, (void *)(unsigned long)vcdev->area,
> > +	       sizeof(features));
> > +	return le32_to_cpu(features.features);
> 
> The fact that the features are LE is missing from the spec, right?

You're right, I thought it was there.

> 
> 
> Alex
> 
