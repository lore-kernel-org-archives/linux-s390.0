Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3656429806;
	Wed,  1 Apr 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062670; cv=none; b=abBuAdEq+A1aRWTnjTYd+bkg2eOuhkhlEwD1ARh1aj8iNIGr+LNcfZk0lcNA3R5ex3qRrc2XlNdHcPVvG7s+oOBfKVBZy6yrjLfUpav89xNyz3NqqTMEo8x8qAMNyk/17q+EbSPw53RXAtSj46rBGCDzDYTh8dJNt6OsMIcco88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062670; c=relaxed/simple;
	bh=bqcjZxFpXk9wQTPA42bx7ptfsXvOF/E9CA7AExNd9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRqqfTnek+yY9vdtD6CDamtTCdMA8vbKKNpY4pWR1D1aZkwaRXLQ6e6dlTyH0xiu+arMGWePBv93K+b/HyPX2/g9E7d4dymmzmYOc2NwLhFcoCWJkdSFiAelX8ZdZiMBnVUhidR8S39rjt4Oa8JIRlE+qeTVbrBZKRHC5VJX7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Zya+XYxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNbMXHao; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Zya+XYxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNbMXHao"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F227F1400276;
	Wed,  1 Apr 2026 12:57:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 01 Apr 2026 12:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775062666;
	 x=1775149066; bh=XxvpCMyRZU3ZKxLxX631RMdtg2ENH68G+eyTgr/tj+Q=; b=
	Zya+XYxfotcjNIGpsYqFnOtHid+F/hWMumOo7h2pPyeJR1Hc6wIwxi7ZbSPSw9g0
	EViLkB4lKii6g7rzYFeHebq4jOYLNikGE8xYPrqpXllP93EA7r5B9AGriZ7QQRRd
	MFLEkyFWNnkLlnnHxZtOUA+PZAbMXyZXGnLtVJTO3NOg6HTUpU37E1TcoZhEFeWC
	Q2iiPgk9VThIrqq5tnCqHoRGWesIvQQfZqurHRxQoAqQBUAdx46WYdvT1LR3DPQN
	5qdnD4XEc4y/MwD8HuWBMdOtArsdL2M0Da8wd0d6Aq21/Oa1maz7mjL6BhDb1B9U
	8IXXOy62IdAqsARfHQFyug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775062666; x=
	1775149066; bh=XxvpCMyRZU3ZKxLxX631RMdtg2ENH68G+eyTgr/tj+Q=; b=G
	NbMXHaopmG20doDX5bOixDvwvqj8tnIeBfJkErzeRy91HlnIf7zm0P22CSGnbS2K
	ao3eSOJsa+I8YWwnfO3QqsCvUWwo3W6cC0ZwfW05IWL2Ql/JJqi1UXXukt7Nq5om
	zXLlGB6YOTBEzV71RrX33PSjqvwRwAYhGaZitdIcjLYLVDCXdHlTiuxtLh4Tl7qP
	kWIyzVG/DREfnLg9Lt6nWCQUS5PJiSwzolF11qmYEouHSgdHGQP/jMr6vBr4N2UT
	/7ENKdhmGFF+ws+U5/5vfmWNkSdaYTcdvARgZ7qe8mLmWjbrD0YFREzaY1pvDKXc
	QIRIFPeNIXFNaly31U0pw==
X-ME-Sender: <xms:ik7Nab-oXTV8IauUuVByCN3dMk0BANUAC3ZOLrTCUv2atU5pHD44YA>
    <xme:ik7NaRG_9uFkQ51FN53BQpsqYT729YgUq_7wCWH3xk4Z8_plOLZunxqMMawSMm0_i
    DzPzMWjpuitg8_K39HTH2f-QQb3b8vnqw8vc5B5tlod3ISKppPAwyM>
X-ME-Received: <xmr:ik7NaRjeY5cqRdsM7IEXwXDjxDb4X8VRT06-xvRSnnT59WweNso57YjHBC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrghdprhgtphhtth
    hopegrkhhrohifihgrkheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvhhm
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhjhhgvrhhnvgeslhhinh
    hugidrihgsmhdrtghomhdprhgtphhtthhopegsohhrnhhtrhgrvghgvghrseguvgdrihgs
    mhdrtghomhdprhgtphhtthhopehmjhhrohhsrghtoheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehprghsihgtsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:ik7NaW-eZ_ms-AsnmOrjr5yyFd2F-qvAs8dfAvmSWh-CpExCRd3XMw>
    <xmx:ik7NaRY1d3gcO3X8Bnr5BMvqHOc5lbBRhJUYsJkiVDt5V7zdrK4xPg>
    <xmx:ik7NaUsoPRYWehsvzTowC3G1_IzrRRnrSSjCAeKg6BakuvcAi6Gipg>
    <xmx:ik7NaVksV1PCsaaI1IevFCi572p0Z-U9aw4Xz9ljlp_9fLmCGP_C_g>
    <xmx:ik7Naer7-U0B7nbycG7K9eyIiRJ98rA3GqbVkHJEaWzVWX4-DUHPtOgG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 12:57:45 -0400 (EDT)
Date: Wed, 1 Apr 2026 10:57:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: alex@shazbot.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jjherne@linux.ibm.com,
 borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 kwankhede@nvidia.com, fiuczy@linux.ibm.com, pbonzini@redhat.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH v1 00/23] s390/vfio-ap: Implement live guest migration
 of guests using AP devices
Message-ID: <20260401105743.6c88f13a@shazbot.org>
In-Reply-To: <3f320ef3-c539-4671-8fbf-283ea9f48633@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
	<20260330102748.6423ff89@shazbot.org>
	<2949d622-fa65-4df1-af04-0665ed115ad4@linux.ibm.com>
	<20260331114009.43e41a3a@shazbot.org>
	<3f320ef3-c539-4671-8fbf-283ea9f48633@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 09:38:59 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 3/31/26 1:40 PM, Alex Williamson wrote:
> > On Tue, 31 Mar 2026 08:07:06 -0400
> > Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> On 3/30/26 12:27 PM, Alex Williamson wrote:  
> >>> On Wed, 25 Mar 2026 17:00:47 -0400
> >>> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>     
> >>>> This patch series implements live guest migration of a guest to which AP
> >>>> devices have been passed through. To better comprehend this design, one has
> >>>> to understand that VFIO AP mediated device is not used to provide userspace
> >>>> with direct access to a device as is the case with other devices that use
> >>>> the VFIO framework to pass them through to a guest. The sole purpose of the
> >>>> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
> >>>> configuration is comprised of the AP adapter IDs (APID), AP queue
> >>>> indexes (APQI) and domain numbers of the control domains to which a guest
> >>>> will be granted access. Once the VFIO AP mediated device is attached to a
> >>>> guest, its AP configuration is set by the vfio_ap device driver. Once set,
> >>>> all access to the AP devices is handled by the s390 Interpretive Execution
> >>>> facility; in other words, the vfio_ap device driver plays no role in
> >>>> providing direct access to the AP devices in the guest's AP configuration.
> >>>>
> >>>> The only role that the vfio_ap device driver plays in the migration
> >>>> process is to verify that the AP configuration for the source guest is
> >>>> compatible with the AP configuration of the destination guest.
> >>>> Incompatibility will result in a live guest migration failure.
> >>>> In order to be compatible, the following requirements must be met:
> >>>>
> >>>> 1. The destination guest will be started with the same QEMU command line
> >>>>      as the source guest, so the mediated device supplying the AP
> >>>>      configuration on both guests must have the same name (UUID).  
> >>> AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
> >>> supporting migration.  You're really concerned more with the
> >>> configuration/composition of the mdev device, so requiring the same
> >>> UUID seems a bit arbitrary.  
> > Combining replies:
> >
> > On Tue, 31 Mar 2026 07:17:08 -0400
> > Anthony Krowiak <akrowiak@linux.ibm.com> wrote:  
> >> As stated above, the destination guest will be started with the same
> >> QEMU command line as the source guest. Within that command line
> >> will be a '-device' parameter like the following:
> >>
> >> -device
> >> '{"driver":"vfio-ap","id":"hostdev0","sysfsdev":"/sys/bus/mdev/devices/62177883-f1bb-47f0-914d-32a22e3a8804"}
> >>
> >> Note that sysfsdev is the path to the mdev named
> >> 62177883-f1bb-47f0-914d-32a22e3a8804;
> >> therefore, the mdev with that name must exist on the destination guest or
> >> the migration will fail with the following error:
> >>
> >> error: device not found: mediated device
> >> '62177883-f1bb-47f0-914d-32a22e3a8804' not found  
> > Then this is a requirement of your tooling, not a kernel requirement, not
> > something the kernel should care about.  QEMU matches devices by their
> > virtual bus path, not the sysfsdev or host attributes.  In the case of
> > VF migration with vfio-pci variant drivers we cannot require that the
> > source and target devices exist at the same bus address.  Ideally the
> > pre-copy data from the source device to the target will include relevant
> > configuration information to validate that the source and target are
> > compatible, regardless of the uuid.  
> 
> Maybe the problem here is stating that having the same UUID is a
> requirement in the patch series description. I agree this is
> not a kernel requirement; however, a live guest migration will not
> succeed unless the destination host has a mediated device with
> a UUID that matches that of the UUID of the mediated device used
> to pass through s390 crypto devices to the source guest for the
> reason I stated above. Would it help if I removed item #1 as a
> requirement?

Yes, AIUI this is an artifact of your tooling.  The destination QEMU
can be started with any arbitrary UUID and should accept an incoming
migration, routing the migration to the correct device by the virtual
path, independent of the UUID.

> >>>> 2. The AP configuration assigned via the VFIO AP mediated device on both
> >>>>      guests must be compatible. As such, each AP configuration must meet
> >>>>      the following requirements:
> >>>>
> >>>>      * Both guests must have the same number of APQNs
> >>>>
> >>>>      * Each APQN assigned to the source guest must also be assigned to the
> >>>>        destination guest
> >>>>
> >>>>      * Each APQN assigned to both guests must reference an AP queue with the
> >>>>        same hardware capabilities  
> >>> Why isn't this sufficient vs also requiring the same UUID?  
> >> I explained why in my previous response.  
> > See above, userspace tooling requirements don't imply kernel
> > requirement.  
> 
> Got it.
> 
> > A userspace interface can still exist, I just don't find this path
> > through the driver to the VM acceptable with this justification.
> > Mechanisms already exist for the device to refuse a state transition or
> > generate an error for a migration already in progress.  IMHO, it would
> > be acceptable for the device to block a key change if the migration is
> > already in progress.  If the key change cannot be represented in the
> > migration data stream, then it's up to the orchestration of the
> > migration to make sure they stay synchronized, but I don't see that
> > the vfio uAPI needs to be involved.  Thanks,  
> 
> As I stated in the cover letter description, all access to the AP 
> devices is handled by the s390 Interpretive Execution facility, so 
> without a complete redesign of the vfio_ap device driver, there is no 
> way to know that a master key change is being requested. I do get your 
> point, however, so I will figure out how best to handle this in 
> userspace. Thanks for you review.

The cover letter has one sentence describing the Interpretive Execution
facility handling access to the device.  There are a lot of subtleties
there that are not obvious to laypersons.

It seems like the architecture really doesn't have the ability
to monitor state changes of the device, and therefore represent those
changes in the migration data stream, so you want to fallback to a
cooperative scheme with a side-band channel to interrupt or block
migration when an asynchronous configuration change happens.

I just don't see that such cooperation needs a new uAPI through the
device; either the device itself could perform the same within the
existing uAPI or the agent changing the configuration could coordinate
with the migration orchestration.  Thanks,

Alex
