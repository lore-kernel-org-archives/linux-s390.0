Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF83EDAD1;
	Tue, 14 Apr 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188499; cv=none; b=jbLzStKrmLCJ626HsDrXtry72Jh9AmXiPWKOOtGXLvZVpi649XmIu231pzWPrcEs5O0GGlawdCqMDLYTr/HwSiRqo+fhwGCTuW3BL6WKXTsBv0mZ9U6sbnORUrvhuF2l2Bv0W/WbRagcNqb+HZCqV+WV+0sr0Ihy01pg5nFAx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188499; c=relaxed/simple;
	bh=w3Xttz0mTZ9+NRZZK9H73XaJh7kFuAwsAauzXXPCLQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1UUxoF9otuXvkj2Wu3pYi86x+dRlV4+scd1n7Q/6SrqBCyz6GupS21UVQ/UtzoqEyFteljwWTTyrPvG5urerNx9pWRK01vBui0HteEj3rJuSjur6CyDDAKgQU58oTrGTLnU6Kd0P3LH4OaBarfb4LYNWg9QIhOH+MrfJaZ1uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gx+g2Dbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HAzsvaoW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="gx+g2Dbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HAzsvaoW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 905671D00085;
	Tue, 14 Apr 2026 13:41:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776188495;
	 x=1776274895; bh=cIMYB3Vw1R1mczbcWN3ySXUNmPECAiAiyrHdvAbF5OY=; b=
	gx+g2DboglzkwLnfVfmWAdBR9zPG3JGhBiku8eSh1ltH/l+A70SLd9ndmA3EKEl2
	pPg4T8agrPZAJDET0bCtzPyEcylMgXvvqcp1f/Dwrw7M0gNsPSCIzXuC4zLk/rHn
	asgC8IQBMNml1x9Zl61Lp+PE9gQhy3mkHjIARw/MZCqpc0X6wjC6ZxlGbLbmM7mb
	jUV37MMjL3rCfNA+iDqt1zOYTkhYGdhXhI8oCgst7Dr9SYe0+vmUt28O+Dvf7i5q
	f6Wj6bahZk6HXa6EJyrSrvpeQX8Qv3WgB7/MptIBXar5cqP15zTZijzdU1bb+WfA
	bh0/ajdlXaW2daRS6ct3og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776188495; x=
	1776274895; bh=cIMYB3Vw1R1mczbcWN3ySXUNmPECAiAiyrHdvAbF5OY=; b=H
	AzsvaoWGjjs/C1p+pVsELlgTkIQW+ecKYgF5qJZHpXnadrgJHEPdFvcCgr3fC8SB
	+V1etI1oeFn4qZ3ODyYD4UiAaLpoz17ll2Ik0fXc86UDjry9zuVat9yVXdxWmTIn
	rZ45N48fTLkhwi3ZQsia7KXFm2DYN4Wslfon1XHtaXvE8qLAJ7MdqOLuEIcd1xNy
	EHuHZqtBHx/rllGY2XjmYkxTIYF3XHEl4gGVSUOWTiBfE8uBT9cCrp5T20uMdoXe
	9z2H5F+wjwwRg34LaJ2LIZ+G1X5K8LePpelgyCIiOEwQCqRVutecc8ULDsxV6QAk
	E6GuFFQ7r3Rxm3HNey3hQ==
X-ME-Sender: <xms:TnzeaSqpvupzjmXOlTftUuVr4Of_oeZvRQsDmI0zMQHqUlJOp8dI8A>
    <xme:TnzeaYyU4Mha1-CtOlbhQDus2bENMl-7PtscvFmbpnCIP_koKWoKfi_kpHUNOuMZ4
    PS2d1YmvjzyQwu6W5AHruYP8jsy-q3BL_4A6rjX6tqo52Tf2kvq>
X-ME-Received: <xmr:TnzeaWsVvm8iF73Qp6Eq0fdz4ggnl55LqVPnmoW2eRsZcb7I9Vth1Q5_xms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgsehtjeertd
    ertddvnecuhfhrohhmpeetlhgvgicuhghilhhlihgrmhhsohhnuceorghlvgigsehshhgr
    iigsohhtrdhorhhgqeenucggtffrrghtthgvrhhnpedvkeefjeekvdduhfduhfetkedugf
    duieettedvueekvdehtedvkefgudegveeuueenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspg
    hrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhifhhm
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidqshefledtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheptg
    hlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:TnzeaR2_OzZqsCMy8fQzjoCGcCwMWp_2dInZrFKDqjh7s68EydKj6A>
    <xmx:TnzeaeCO0JaN8e2xKvq9FPCMI6fmrQ9goo_OuZhWg9X-0dVQ_SjM0w>
    <xmx:TnzeafC0F_OrWO9m4tOAeLgR5SzDEftkvuZg74eHNL62r5p0GmrNTQ>
    <xmx:Tnzeafm00VNsb8d-2dokuy_iU7Q8rfMXUoHby3XrQ9anf0oxQA86bA>
    <xmx:T3zeaYYasD7QeZnhWGQ5DdyrL0sMgwgtOz0ZoK8s-XiQ1nSUUh28MSI4>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:41:34 -0400 (EDT)
Date: Tue, 14 Apr 2026 11:41:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260414114132.31481b48@shazbot.org>
In-Reply-To: <5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
	<20260413210608.2912-6-alifm@linux.ibm.com>
	<20260413165758.0f87312b@shazbot.org>
	<cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
	<20260414081238.23e2cecc@shazbot.org>
	<5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 10:13:22 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> On 4/14/2026 7:12 AM, Alex Williamson wrote:
> > On Mon, 13 Apr 2026 16:40:49 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >> On 4/13/2026 3:57 PM, Alex Williamson wrote:  
> >>> On Mon, 13 Apr 2026 14:06:06 -0700
> >>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>>> index 5de618a3a5ee..2980ca39dd38 100644
> >>>> --- a/include/uapi/linux/vfio.h
> >>>> +++ b/include/uapi/linux/vfio.h
> >>>> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
> >>>>     */
> >>>>    #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >>>>    
> >>>> +/**
> >>>> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> >>>> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
> >>>> + * involves platform firmware and notification to operating system is done
> >>>> + * by architecture specific mechanism. Exposing this information to
> >>>> + * userspace allows it to take appropriate actions to handle an
> >>>> + * error on the device. The pending_errors provide any additional errors
> >>>> + * pending for the device, and userspace should read until zero. A value of
> >>>> + * 0 for pending_errors and pec would indicate no pending errors that need
> >>>> + * to be handled.
> >>>> + */
> >>>> +
> >>>> +struct vfio_device_feature_zpci_err {
> >>>> +	__u8 version;
> >>>> +	__u8 pending_errors;
> >>>> +	__u16 pec;
> >>>> +};  
> >>> I assume .version is for compatibility, but we don't define a strategy
> >>> for using it or specify what the version should be for this table.  It
> >>> doesn't seem like there's actually an value-add to having it.  
> >> Its possible we may need to extend this structure in the future if we
> >> want to report more information to userspace. I at least want the
> >> flexibility to do so. We had some discussion around this [1] in an
> >> earlier version. I was trying to follow similar versioning pattern we
> >> had around vfio-pci/zdev structures.  
> > IMHO, the version field is a dead end towards achieving this,
> > especially if we don't specify from the onset the expected version
> > value or the compatibility semantics.  All that's going to happen is
> > that some userspace will hard code that it understands version 1
> > because that's what's currently reported and matches the struct defined
> > here, and you can never ever report anything other than version 1
> > without breaking that user.  At that point you need to come up with
> > some other means for the user to opt-in to a new version, whether it's
> > triggered by another feature (as we did with the PRECOPY_INFOv2 above
> > this), or we reimplement the whole v2 feature.  
> 
> My understanding was based on how we version some of the capability 
> structures for zdev (in include/uapi/linux/vfio_zdev.h). If we wanted to 
> provide more information to userspace in the future, what would be 
> preferred approach? Do we need to explicitly define a v2 feature? I am 
> open to suggestions on this.
> 
> If we need to define v2 explicitly in the future, then yes I agree we 
> can simplify it to return only the PEC code (or an error code otherwise).

Maybe I'm reading too much into it, but it sounds like you already have
plans to expand this.

The existing zdev structures seem to rely on the version field in the
capability header and maybe you've gotten away with bumping the version
without breaking userspace, but it's fragile.  AFAICT, the ioctls do not
define a versioning strategy where vN+1 only adds fields to vN, so all
it takes is one outspoken userspace tool that hard codes its
compatibility to a specific version to become a problem for further
updates.

Likewise this feature doesn't define a versioning policy for userspace
to follow.  I'm sure there are other examples within vfio that are
problematic, but let's try not to create more.

If you want to use a version, then also define what the version is and
what the compatibility policy is for future versions.  A flags field is
another option that we've used extensively in vfio.  The version field
might be better for incremental expansion of the structure, while flags
can address specific fields more directly, ex. a reserved field being
redefined.  Thanks,

Alex
