Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518525A33F;
	Tue,  7 Apr 2026 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586470; cv=none; b=LR5EwIsHw8UlyCsyIbXICqRseqBUu40L3XUA75YFXLATFz8tm9IZdvEv1/DrRUFTp7JPdKEzUvBNXfSwDgRyuJN6DpmRFJFQEwOxeRkVMwMA/q5pRPBLdFf6oRBnsIUPivE0aqj1v9sv0cNhswL1syOnQR0CnglKCWVn/pElOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586470; c=relaxed/simple;
	bh=HdKC7Kj92VB8EZYmV1orQmOpNoBclqMG1FBFjHZvaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6g6x3xid32D2hFZqdmJz8EYyg1YoDeppTyWDUH3jzSwg31R7XN2uofrdfmp+5a38LxV5BDLtXtugPluURvMla1D7MR6nUix0ybuz3ZoNEwdknbM/qXqlKrT2KSNrXZNmCbK8j/pNtYz+2eOsOZH7SK/9BG/Fw4LNJwGCfivH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=qu0HuXFu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W90qQtoI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="qu0HuXFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W90qQtoI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E13714001B8;
	Tue,  7 Apr 2026 14:27:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 07 Apr 2026 14:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775586468;
	 x=1775672868; bh=W2hfwhsPlkDcwbImPW5CS3I8DY4zHjf5Xh/DV4y8InE=; b=
	qu0HuXFuXmitnsZyev/rPd+HC7PaFB7oVKiOea/vXfc5vvpVr/MutWM//LoENu7S
	JJGsU0ToGD8ixGLyDdnlM6d615ufePRAEY+NwLUNE59KzRcl+13BZM2o5DTBl9Ip
	iW+6q+uLiqnc4GgVNykMhASXzNiIJZMv7xhxPyRl/LTA8KyZQStmCa8ajEKNCqwh
	UWnZioeUOTUQQvrfJhHIfshrorSF8od0TdKsudz8UGNLSZSnQjNxFZ4nEUHLH8yY
	7WccaYVO+ZOH9BrW63p2Pjkay93qREwOFp4xm4W7BMQ8Nl/CyF+HS6rXu+EzUC0l
	4LXozpTVn2CHA4ZOMn+fOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775586468; x=
	1775672868; bh=W2hfwhsPlkDcwbImPW5CS3I8DY4zHjf5Xh/DV4y8InE=; b=W
	90qQtoIl4OA4JPpzDzAxpJmfLpYU4cmFz1GSGOiiTQ4Q7jqUb36kb7gA5EuwFCM/
	B8qhPzXrQgUlLusrHIRukJaXoLr/RfdEe4hqPEiylSsDeZPKydalqBbZn9ZsgKoJ
	X7ZKgm6NqWiBnAZ/LOy5c5tov1pFuEyqsdmOFcrYqxie19Kbo+aEwqJ1w1UXZcZY
	tsuekIcLodJnbRiskbs+q9n+KPyFMn/WKg9lYhtKmOHH8leKcRIGZ84xq+5voBND
	k6dNuV89O5ePHzi16YQOPhyChqQPSxssvTFcM11/jujNYKGf1ZkV7eop9jSC20a1
	KrgiZ0LtrQQnGdTsMQTCA==
X-ME-Sender: <xms:pEzVaQOttFPeAT_ZTCyrFFvChkuK48d9wsxC-DQzoiYc1CW2z7ycFg>
    <xme:pEzVaRZqu9myxS7id5Of9u5n_HcHgogjhSvMHvvfWcA-anGlyzI-vPGY781kvSP6R
    hHxUS7CZ6v93_oPVt3tDejP8qCWGQmBBixhNeZh3R1XK_sTdDoO>
X-ME-Received: <xmr:pEzVaextzkhQ7Te6iLF5WY8yCJlofkEmERc_1Rul3xKRttVcyO7xP5SSfoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudefjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pEzVaQP3JvHu2cPt3lQYKyIZz4SBLeknwr12pUiyQvFkQCUXlsoR1g>
    <xmx:pEzVadd9tWXjeMExxErWnD6G_oZ1JcifyX7HTj_nhN2p8DeJJyn8lQ>
    <xmx:pEzVaVTJc2r2lpI26tB-XlU3jd1CgGVsrIayJyA0jP6_ofE8LxY2lw>
    <xmx:pEzVabd8SNlTFfzoqo2mUSS6poMMjV17F1-tArKluq0IBrtsdW89dA>
    <xmx:pEzVaYiRx2ZlYIgiz8AwLqxxNFEAdRomboXOYyefv5sFLFcS7KlNMbJW>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 14:27:47 -0400 (EDT)
Date: Tue, 7 Apr 2026 12:27:46 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v12 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260407122746.4000a886@shazbot.org>
In-Reply-To: <4866f6cb-8770-4a21-9b5c-4a9e46009c05@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
	<20260330174011.1161-6-alifm@linux.ibm.com>
	<20260407095321.6086a080@shazbot.org>
	<4866f6cb-8770-4a21-9b5c-4a9e46009c05@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 11:13:53 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 4/7/2026 8:53 AM, Alex Williamson wrote:
> > On Mon, 30 Mar 2026 10:40:09 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index 0658095ac5b1..0a8663879eee 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -141,6 +141,42 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   	return ret;
> >>   }
> >>   
> >> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> >> +			      void __user *arg, size_t argsz)
> >> +{
> >> +	struct vfio_device_feature_zpci_err err = {};
> >> +	struct vfio_pci_core_device *vdev;
> >> +	struct zpci_dev *zdev;
> >> +	int head = 0;
> >> +	int ret;
> >> +
> >> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> >> +	zdev = to_zpci(vdev->pdev);
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> >> +				 sizeof(err));
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	mutex_lock(&zdev->pending_errs_lock);
> >> +	if (zdev->pending_errs.count) {
> >> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> >> +		err.pec = zdev->pending_errs.err[head].pec;
> >> +		zdev->pending_errs.head++;
> >> +		zdev->pending_errs.count--;
> >> +		err.pending_errors = zdev->pending_errs.count;
> >> +	}
> >> +	mutex_unlock(&zdev->pending_errs_lock);  
> > Inconsistent that this isn't a helper exported from the previous patch.  
> 
> Do you prefer it to be in a helper function? I can move it to a helper 
> function.

Yes, a helper that dequeues and returns the error pec with an arg of the
remaining count would make sense here.  Call it unconditionally and
specify 0/0 = no error and none pending.  All the locking and buffer
manipulation code is localized in s390 code.

> >
> > What's the meaning of err.pec = 0?  Could this be interpreted as an
> > error itself?  
> 
> An err.pec = 0 would indicate there are no pending errors. I don't think 
> anything would prevent userspace from doing a VFIO_DEVICE_FEATURE_GET 
> even if not nudged by an eventfd?

Maybe worth specifying in the feature description.  Thanks,

Alex
