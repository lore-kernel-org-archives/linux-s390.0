Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66C3624CE;
	Mon, 30 Mar 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885013; cv=none; b=NFA9zGgtxDpwONwM1k+NrGhNEpkj4AVF2WcaS4jlwZs34KKWazTlVFLM9L5qaeCW/qLSyGavVhKZ/yxK2gqaAaqVM1f6X7tGWrCkm7uKVWRhQJ9zNH918MAhd10FKlF0aeFIEJGfqv+xGrdjGl7v0mEYrUF8ymLyZtr94P4zw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885013; c=relaxed/simple;
	bh=8XpL0hz6gQ4RRLu/LAP84ILPYxRrFhAWzSNsaZ08To4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzPBweA65V3IVNXZBA84OiD0f6jTa+LXmNveOZ/mcby0B91WpjCe8tDT8HwISQUNW8IiwiCIKsphUI1KGEydRBktHuYhVsQD+PhrVgA0kHamQpeURJ2lm1yH6khYdVaaoH+/SnRdvTMExQrLQDODWGobuH1MHWyolPsXJyH1G6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=XUi53fPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tvvDmLqx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="XUi53fPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tvvDmLqx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AE68EEC01F3;
	Mon, 30 Mar 2026 11:36:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 11:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774885009;
	 x=1774971409; bh=cbEOkWUc2U4Fm/hMCSAf19Rx3s2OVVkD2oFlIw7xFjs=; b=
	XUi53fPo+vcTcJzlnn43osylDk2eMSCXVjsq08kai8dYCJP2sFlg0N6SDlSA3Zh8
	9zHsKgqqh1+T4IeimdBp2GIFOR+/mfgU4zQBZ89qM8Ex+tKfJ/U/4abnTLqzPVCd
	NxQTHX+sr/l79gxoWvGKGdHYIKp1mmw6sKIwzt+4S00HoAElomDpWFQ8+EbkL6Cf
	SrofoMC9sn6K5Lqf6tD/sSx4qHuk0bCXpk5mLxOeO/PV9vKEGFRfy+nOrI3XfQrl
	1/uNt9UmmsuxwNUeX7Nw4KQkpZgqSvdeQ0zRdfYafJtC1AjZM7YmZY0nbjIaMZ6z
	9ZMgE/1zFwlj7Jq0TIp/dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774885009; x=
	1774971409; bh=cbEOkWUc2U4Fm/hMCSAf19Rx3s2OVVkD2oFlIw7xFjs=; b=t
	vvDmLqx9mqW3T+j5R/vYnHRQ5sB9mdXoqUYZb0B1XaTouMnNSlIp/g6cV5pY725G
	Y6OZSQgAnz5LQZm2eumILePTf07B5yMZStuO6Facj3SkdQaNYy4Lo+dc9DHSIc5d
	PPXpseZirM4FqSdUS/Y/7gZm/BWrAsqQqhbiwnT/qw6dbOtOvcp0SJJWSbAZUYOl
	1d8WeQwxAGx+iSs+479ZK5lsBbXKtqAiZy4XXE9hTJdlveVdjh70eqmRqI5hFv91
	05neSkXFbTp77Zsv3atz8cuneNNHJQ4v7ydGFWw0rOlMPZZiPXKzpo2k1uARMeXk
	TdcJD9Z2a3KDuh3nCeJZA==
X-ME-Sender: <xms:kZjKaWQw1gbrNpXCGOTuGAWbFD0CvGoACgxjrBtaCQ9mnc0sigNeyw>
    <xme:kZjKaX6hfgUdRlLAZDwfwXacW518GjcUgpv28_AK0mY-aCU-E_GNLyI0ve9bATlfC
    E7erfbwRIiwic0NSwxmiRkRIDLKhIkbRfF_QUQqMs-O43jYYGu8kg>
X-ME-Received: <xmr:kZjKafpCdGh6anGsh9mGieYwyVQYYo3eowjnZbdbW-5QjDuHLKWmBjy_T7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtg
    homhdprhgtphhtthhopegrlhhifhhmsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthht
    ohepjhhulhhirghnrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopeifihhnth
    gvrhgrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepthhssehlihhnuhigrdhi
    sghmrdgtohhmpdhrtghpthhtohepohgsvghrphgrrheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehgsggrhigvrheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthho
    pehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirg
    drtghomh
X-ME-Proxy: <xmx:kZjKabW7gQtxPI9sxUlKYTl6bNLDUu5yZHuXED9R0whv9Oe2mKunAA>
    <xmx:kZjKafo6vHIZjfwHjsUH1gleZmxuJ57TrGHOIKSbRgtB7Plq0dZjyQ>
    <xmx:kZjKaSuuCHvAINqJdASxD5pYsNdXthkzRl3beHtdR1B3ehM578MxDw>
    <xmx:kZjKaVQnPQ0ZAEOfiH92t3NX1_5MWmNE-Te1lNQY1cSLR_hZFEhcvw>
    <xmx:kZjKabHqCS0B2RuWF8CkKNIbY-TMdDWblSW3TblJ-R5ELqCjQ175hPaR>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:36:47 -0400 (EDT)
Date: Mon, 30 Mar 2026 09:36:46 -0600
From: Alex Williamson <alex@shazbot.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
 gbayer@linux.ibm.com, Jason Gunthorpe	 <jgg@ziepe.ca>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum	 <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com, raspl@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260330093646.03b0455f@shazbot.org>
In-Reply-To: <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	<20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	<4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	<3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
	<64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 15:53:30 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On Thu, 2026-03-26 at 12:05 -0700, Farhan Ali wrote:
> > On 3/26/2026 6:03 AM, Niklas Schnelle wrote:  
> > > On Wed, 2026-03-25 at 14:31 +0100, Julian Ruess wrote:  
> > > > Add a vfio_pci variant driver for the s390-specific Internal Shared
> > > > Memory (ISM) devices used for inter-VM communication.
> > > > 
> > > > This enables the development of vfio-pci-based user space drivers for
> > > > ISM devices.
> > > > 
> > > > On s390, kernel primitives such as ioread() and iowrite() are switched
> > > > over from function-handle-based PCI load/stores instructions to PCI
> > > > memory-I/O (MIO) loads/stores when these are available and not
> > > > explicitly disabled. Since these instructions cannot be used with ISM
> > > > devices, ensure that classic function-handle-based PCI instructions are
> > > > used instead.
> > > > 
> > > > The driver is still required even when MIO instructions are disabled, as
> > > > the ISM device relies on the PCI store block (PCISTB) instruction to
> > > > perform write operations.
> > > > 
> > > > Stores are not fragmented, therefore one ioctl corresponds to exactly
> > > > one PCISTB instruction. User space must ensure to not write more than
> > > > 4096 bytes at once to an ISM BAR which is the maximum payload of the
> > > > PCISTB instruction.
> > > > 
> > > > Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> > > > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> > > > ---
> > > >   drivers/vfio/pci/Kconfig      |   2 +
> > > >   drivers/vfio/pci/Makefile     |   2 +
> > > >   drivers/vfio/pci/ism/Kconfig  |  10 ++
> > > >   drivers/vfio/pci/ism/Makefile |   3 +
> > > >   drivers/vfio/pci/ism/main.c   | 408 ++++++++++++++++++++++++++++++++++++++++++
> > > >   5 files changed, 425 insertions(+)
> > > >   
> > > --- snip ---  
> > > > +
> > > > +static int ism_vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
> > > > +					      struct vfio_region_info *info,
> > > > +					      struct vfio_info_cap *caps)
> > > > +{
> > > > +	struct vfio_pci_core_device *vdev =
> > > > +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> > > > +	struct pci_dev *pdev = vdev->pdev;
> > > > +
> > > > +	switch (info->index) {
> > > > +	case VFIO_PCI_CONFIG_REGION_INDEX:
> > > > +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> > > > +		info->size = pdev->cfg_size;
> > > > +		info->flags = VFIO_REGION_INFO_FLAG_READ |
> > > > +			      VFIO_REGION_INFO_FLAG_WRITE;
> > > > +		break;
> > > > +	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
> > > > +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> > > > +		info->size = pci_resource_len(pdev, info->index);
> > > > +		if (!info->size) {
> > > > +			info->flags = 0;
> > > > +			break;
> > > > +		}
> > > > +		info->flags = VFIO_REGION_INFO_FLAG_READ |
> > > > +			      VFIO_REGION_INFO_FLAG_WRITE;
> > > > +		break;
> > > > +	default:
> > > > +		info->offset = 0;
> > > > +		info->size = 0;
> > > > +		info->flags = 0;
> > > > +		return -EINVAL;  
> > > Thinking more about this, the above default handling actually breaks
> > > additional regions such as the one added by Farhan for the error
> > > events. I think this needs to instead call the generic
> > > vfio_pci_ioctl_get_region_info() for other regions.  
> > 
> > Note for error events we are using a VFIO device feature and not a 
> > region. At this point we actually don't have additional regions. I do 
> > agree that if we were to add a zpci specific region we would need to 
> > update here and ism_vfio_pci_rw() to allow region read/write ops. This 
> > ISM driver would also need to support all the possible callbacks in 
> > struct vfio_pci_regops.
> > 
> > Given that we don't have any additional regions yet, I am conflicted if 
> > it makes sense to add all the code to support additional regions without 
> > a good way to test it. Maybe its something we can defer when if we add 
> > additional regions? Thanks
> > 
> > Farhan  
> 
> @Alex, we experimented a bit and it turns out with the custom
> ISM_VFIO_PCI_OFFSET_SHIFT it becomes quite tricky to reliably call into
> common vfio-pci code for handling other regions as that again relies on
> the normal VFIO_PCI_OFFSET_SHIFT.
> 
> So we came up with two options:
> 
> 1) vfio-pci-ism will only support this basic set of regions. It seems
> to us that new extensions like Farhan's error events should use device
> features anyway, so this to us seems like an acceptable limitation and
> would essentially mean we take this patch as is.
> 
> 2) We revisit the original idea of adjusting VFIO_PCI_OFFSET_SHIFT
> globally but do so only for CONFIG_64BIT so as not to break 32 bit
> platforms. This would simplify vfio-pci-ism and cause less code
> duplication but also affects everyone else.
> 
> Either option works for us, so I'm hoping for your input.

There's risk involved with changing the default shift.  The fear is
there's userspace drivers that hard code the shift.  DPDK was even such
a user at one point, iirc.  Maybe it's ok to break such users, maybe
there are actually no such users left and it's all FUD at this point.
Either way, I have a hard time justifying that risk for a single,
obscure S390 device.

Rather than using CONFIG_64BIT as a basis for using a different
default, should we start out with a more narrow scope of CONFIG_S390?

It's likely inevitable that we'll hit this wall in general, but maybe
S390 can be the "crash test dummy" to prove to userspace that they
really need to use the uAPI rather than hard coded values.

Farhan's series is a bit of a straw-man since it doesn't actually
convey the error codes via regions, but I can certainly agree that
using a unique region shift becomes an ongoing burden relative to
vfio-pci-core helpers.  I can accept an S390 specific (for now) change
to the region spacing if that's the most sensible path.  Thanks,

Alex
