Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04836402E;
	Tue, 31 Mar 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978817; cv=none; b=k3BQ1/uBAFix7yqFvlSS5MgiPc/k7HyJdQZJURedLvmg39YOQcczTFN3+4jyxBic9V+tkr1oBT/yIG8gYO8UF/V2YyHCHxdT1ePFGoQM235vrlJ5BEyGo9rAtwmc+7Oe6A1ili3P8VYGGQ0EoRzkHsxZzCS4FdDyFbTaMM3CJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978817; c=relaxed/simple;
	bh=zWSkOWend9sjxDw5uiD/IiYOaY79xAnivVqepG/dnVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjtPO2xEp+K1ByBfW74XQc2DNpkNt71e5Ah+U5jQFXUBNuq0lAyYcgS5ZwZ7RRi26K8hLzztDWOqHjkcBC6ZDKHTzPiUs11tFvBbEU1QquGPJFAvtZe+G3fOfgOo6MP9uQzxFyw5Qy7ihYLlHkIH32roQt2tyuAwxuRBooKrc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=OdOSIHHL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTUfinKB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="OdOSIHHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTUfinKB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68B327A024A;
	Tue, 31 Mar 2026 13:40:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 13:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774978813;
	 x=1775065213; bh=yY6hREVEvee0G/m6jzR3TNomLLpwSqY4kM/glI679jo=; b=
	OdOSIHHLV/ysjAE7k5A4iIpXkJ1fTv3DIzpVsUek+23k8MmhU1fXZQ4uBKmoR60T
	+PRIcDKL5B2ye+1pXLR4CeZXGSbZJvNAC7EC2xJWfi8SKxF1VKXvjvNySKx2kLL3
	StWQr3wovKQURNIS0DvUlqhcITdoH17mtYO1FhlhVMEdoaGJ83wlqyC/NN/E4jSM
	uP/+j16uQVUVUvCPIoHA5/22z4h0lyaq7uM1gLu/IUwTbcmJILmw1NnC6XhcTw7a
	urQSnq93Zg5UXAxlDFS9VRC+MpvpI5cpfN0klktRIwptKc2x/ZpJCIobHFHYO0I8
	5CxvUGNy5xoFp3UOWVY1XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774978813; x=
	1775065213; bh=yY6hREVEvee0G/m6jzR3TNomLLpwSqY4kM/glI679jo=; b=o
	TUfinKBg+9bUIY/H9Rft6Ijgg/RUD8vf4OMDJaQgpNz4ee8QqKV5phnRcKaW72M/
	pZ3lECDIW6EJuwEADVVgTbo0wcxswBbgdPpUamgmlUEsAR7Tv2jaS5OoVN9HakgG
	/U+soPvoS71/BPkNA1Q/UIFrPNXsQDTQHMV0qbuASY5zyhXn69h5ETAMygzi2oPy
	Ke4V7RMQFnmcL7qaKLtZHw0Xy8jyzQ4k3ajZOR/5iIoJJmL+lQdDP1H6kZs6X7/X
	6ewGMMA5sl8bOnhHKfQf5KxhnYAqeYr8COOxoun397uNPzbJrP0GMW0/YL5EDuAA
	w7qhifcSdUjZqCzFyrmOw==
X-ME-Sender: <xms:_AbMaXLoq6er1tbNlt9ssW40tpU5X2B0-9-QK1-Gd7cHknG8JVE8EQ>
    <xme:_AbMaWWiH8zequ8LgEH4kvSCbhgpvim3EioESt-bZmGgkIQ5_wKoo0dCEiBuk9OCK
    7AhxCJn2BKPY7rZm02wKdcBZXOAxIjUtnfoDgXBt0Izb54QEpXZC1M>
X-ME-Received: <xmr:_AbMaThhs9zSue7PTmYP91IJjDWhJ0Cwbak7hBljnqQtEGTRNvm_sO2gZrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucghihhl
    lhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeevueeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvg
    igsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghkrhhofihirghksehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    jhhhvghrnhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepsghorhhnthhrrg
    gvghgvrhesuggvrdhisghmrdgtohhmpdhrtghpthhtohepmhhjrhhoshgrthhosehlihhn
    uhigrdhisghmrdgtohhmpdhrtghpthhtohepphgrshhitgeslhhinhhugidrihgsmhdrtg
    homhdprhgtphhtthhopehkfigrnhhkhhgvuggvsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:_AbMaau6BTBWCodoSsLyUNIyNbGtpurlfKgitflnG7oNMenHmkUe1A>
    <xmx:_AbMabzmS6UvxIkubWQrO91eAnm_vdQYBUJR8yOCb88V-xmxpsjCbA>
    <xmx:_AbMaXbI4wktTne1yGQj2FkRqryk9YO0W7mRQGu3W3bAZORPXt_S8Q>
    <xmx:_AbMaSUdI0YPfjGB6kA_lLAyynBJfSBQUcDkpWyjqO4tsPd4k7cvSg>
    <xmx:_QbMaVsLcdONxgTUdy5viGHmQ7fauTEp0jF4BVDhuWJEkm0RHMlLYuOd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 13:40:11 -0400 (EDT)
Date: Tue, 31 Mar 2026 11:40:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, kwankhede@nvidia.com,
 fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1 00/23] s390/vfio-ap: Implement live guest migration
 of guests using AP devices
Message-ID: <20260331114009.43e41a3a@shazbot.org>
In-Reply-To: <2949d622-fa65-4df1-af04-0665ed115ad4@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
	<20260330102748.6423ff89@shazbot.org>
	<2949d622-fa65-4df1-af04-0665ed115ad4@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 08:07:06 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 3/30/26 12:27 PM, Alex Williamson wrote:
> > On Wed, 25 Mar 2026 17:00:47 -0400
> > Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> This patch series implements live guest migration of a guest to which AP
> >> devices have been passed through. To better comprehend this design, one has
> >> to understand that VFIO AP mediated device is not used to provide userspace
> >> with direct access to a device as is the case with other devices that use
> >> the VFIO framework to pass them through to a guest. The sole purpose of the
> >> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
> >> configuration is comprised of the AP adapter IDs (APID), AP queue
> >> indexes (APQI) and domain numbers of the control domains to which a guest
> >> will be granted access. Once the VFIO AP mediated device is attached to a
> >> guest, its AP configuration is set by the vfio_ap device driver. Once set,
> >> all access to the AP devices is handled by the s390 Interpretive Execution
> >> facility; in other words, the vfio_ap device driver plays no role in
> >> providing direct access to the AP devices in the guest's AP configuration.
> >>
> >> The only role that the vfio_ap device driver plays in the migration
> >> process is to verify that the AP configuration for the source guest is
> >> compatible with the AP configuration of the destination guest.
> >> Incompatibility will result in a live guest migration failure.
> >> In order to be compatible, the following requirements must be met:
> >>
> >> 1. The destination guest will be started with the same QEMU command line
> >>     as the source guest, so the mediated device supplying the AP
> >>     configuration on both guests must have the same name (UUID).  
> > AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
> > supporting migration.  You're really concerned more with the
> > configuration/composition of the mdev device, so requiring the same
> > UUID seems a bit arbitrary.

Combining replies:

On Tue, 31 Mar 2026 07:17:08 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
> As stated above, the destination guest will be started with the same
> QEMU command line as the source guest. Within that command line
> will be a '-device' parameter like the following:
> 
> -device 
> '{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}
> 
> Note that sysfsdev is the path to the mdev named 
> 62177883-f1bb-47f0-914d-32a22e3a8804;
> therefore, the mdev with that name must exist on the destination guest or
> the migration will fail with the following error:
> 
> error: device not found: mediated device 
> '62177883-f1bb-47f0-914d-32a22e3a8804' not found

Then this is a requirement of your tooling, not a kernel requirement, not
something the kernel should care about.  QEMU matches devices by their
virtual bus path, not the sysfsdev or host attributes.  In the case of
VF migration with vfio-pci variant drivers we cannot require that the
source and target devices exist at the same bus address.  Ideally the
pre-copy data from the source device to the target will include relevant
configuration information to validate that the source and target are
compatible, regardless of the uuid.

> >> 2. The AP configuration assigned via the VFIO AP mediated device on both
> >>     guests must be compatible. As such, each AP configuration must meet
> >>     the following requirements:
> >>
> >>     * Both guests must have the same number of APQNs
> >>
> >>     * Each APQN assigned to the source guest must also be assigned to the
> >>       destination guest
> >>
> >>     * Each APQN assigned to both guests must reference an AP queue with the
> >>       same hardware capabilities  
> > Why isn't this sufficient vs also requiring the same UUID?  
> 
> I explained why in my previous response.

See above, userspace tooling requirements don't imply kernel
requirement.

> >> Note: There is a forthcoming consumer of this series which will be a QEMU
> >>        patch series is entitled:
> >>        'hw/vfio/ap: Implement live guest migration of guests using AP
> >>        devices'
> >>
> >> This design also adds a use case for enabling and disabling
> >> migration of guests to which AP devices have been passed through. To
> >> facilitate this, a new read/write sysfs 'migratable' attribute is added to
> >> the mediated device. This attribute specifies whether the vfio device is
> >> migratable (1) or not (0). When the value of this attribute is changed, the
> >> vfio_ap device driver will signal an eventfd to userspace. It is up to
> >> userspace to respond to the change by enabling or disabling migration of
> >> the guest to which the mediated device is attached. The operation will be
> >> rejected with a 'Device or resource busy' message if a migration is in
> >> progress.  
> > This seems inherently racy.  What happens if the device becomes
> > unmigratable while it's being migrated?
> >
> > If userspace is deciding that the device is now unmigratable, why does
> > it need to signal this through the kernel driver rather than with the
> > userspace orchestration agent?  The entire path seems unnecessary.  
> 
> I am not familiar with what a userspace orchestration agent is, so
> I can't address that. Can you please describe how that would work?

Something in userspace, perhaps libvirt, is managing the VM.  It needs
to coordinate with a counterpart on another host managing and
configuring the target VM to accept the migration data stream.  There's
likely also another entity that's responsible for deciding this
migration should occur and where to place the target.  All of this is
what I'm referring to as orchestration.

The path of a userspace agent writing into a sysfs attribute to mark
the device as becoming non-migratable so that the host driver can send
an interrupt to the VM to poll an INFO ioctl to block migration is an
over-engineered path at the wrong layer versus some sort of RPC to the
managing process, or even to QEMU, to block migrations.

Additionally, if the device actually itself becomes non-migratable, it
can simply fail any migration state transition other than returning to
RUNNING and can generate errors in the data stream if it needs to abort
an in-progress migration.

> Maybe it would help to provide the reason for this. For certain types
> of crypto operations, a master key must be configured for the crypto
> card domain being used. This master key must be synchronized
> between the source and destination crypto device so that in-flight
> crypto operations can be completed during migration. If these master
> keys must be changed, migration must be blocked until the master
> key changes can be synchronized between the source and destination
> system(s).

This sounds like a userspace orchestration problem, not a kernel
problem.  It might be a valid choice to use the mechanisms I outline
above to abort an in progress migration if a new master key is
configured during migration, but it's not the kernel's problem to
provide a synchronization point for this through the kernel.

> >> Userspace must also have a means for retrieving the value of the sysfs
> >> 'migratable' attribute when the guest is started to initialize whether it
> >> can be migrated. For this, The VFIO_DEVICE_GET_INFO ioctl is used. The
> >> struct vfio_device_info object passed to the ioctl will be extended with a
> >> capability specifying the vfio device attributes. One of the attributes
> >> will contain the value of the mediated device's 'migratable' attribute.  
> > This is just broken, it's redundant to our current device feature
> > mechanism for exposing migration support.  If you want the capability
> > to create unmigratable devices statically, can't that be encompassed
> > within the definition of the mdev type?  Dynamic migration support just
> > seems like it's involving the kernel in orchestration it shouldn't be a
> > part of.  
> 
> So, it appears you are suggesting the creation of a new mdev type
> for unmigratable crypto devices. I don't see the value in that.
> As I stated above, there is a valid reason for wanting to prevent
> migration while master key synchronization is taking place.

Then prevent it in userspace.

> If this feature violates the implicit rules of vfio device migration,
> then so be it. Maybe we have to figure out another way to ensure
> migration is not initiated during master key synchronization.

If there's a software entity that has the ability to write to sysfs to
declare that a device is not currently available for migration, give it
the ability to notify whatever entity is coordinating and scheduling,
ie. orchestrating, the migration rather than creating a channel through
the device.  Combine that with using the existing mechanisms to abort a
migration if its already in progress.

> If we can't find an acceptable means to do this programmatically,
> then maybe it will come down to a matter of documenting the
> need to ensure migration is not initiated while master key
> synchronization is taking place. This would put the onus on the
> various system administrators responsible for host, guest and
> master key administration to communicate out of band to
> ensure they are all on the same page with regard to migration.
> 
> It would be preferable to be able to do this with a userspace
> interface, so any suggestions would be greatly appreciated.

A userspace interface can still exist, I just don't find this path
through the driver to the VM acceptable with this justification.
Mechanisms already exist for the device to refuse a state transition or
generate an error for a migration already in progress.  IMHO, it would
be acceptable for the device to block a key change if the migration is
already in progress.  If the key change cannot be represented in the
migration data stream, then it's up to the orchestration of the
migration to make sure they stay synchronized, but I don't see that
the vfio uAPI needs to be involved.  Thanks,

Alex
