Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C6376479;
	Mon, 30 Mar 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888075; cv=none; b=AYSYjtljiDt5C+TGz8dR/H2HyfhepWS2RxQLYLkQt9iBaEr4K0oyvzn5qErlQkmBdgeMJ4ivv2F/rzzQq5upjKYIoGmYfIjXGqLVelVLJliXkcw3heqydyfK6OOIo9FX13bYq4sDnlnL259eTpqP2pPEYBe3GAnpp6ByeIHkIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888075; c=relaxed/simple;
	bh=IqH+wfqqWSFSusJPdW6fnYqQ15IAOiTTUF13DDNiXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az8fatKDMS1eZMwZGmAQIZvziJhQPGKU5nv6XAWR5Mcz48iE3S1NPE59T+aSG/A+yNNut/lLdkYY2yqox7MykEdXV/1Znry6786ZayEsuBe+UQsEyESCZ/VPN2JA6ZJlnz6ILIMZXvOP3qy9KbUtTMPkKa6HZcD5NfOHQRJIa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Lb/sGv8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gz6i5nqI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Lb/sGv8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gz6i5nqI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 187ACEC00C5;
	Mon, 30 Mar 2026 12:27:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774888072;
	 x=1774974472; bh=a6ytzIKHDKBXuKugHJbZY/k29tn3vx4e0Y1XvVYJIHU=; b=
	Lb/sGv8o5FQoWFGPawpt260KG1tnTiYLq4f/kRgk5Iq03kKVUP/ambQE9dsRoBX/
	Y0r9HyUOUIDPOhkS2VaHZ8CL14TSQFDEzCfL+fcvKdiUWb22Zp8S37tURkTs1H8M
	BtdH5vT4E8MBFjzKacr2h+Goi+4NLRHwbgGWf5osfdIAJ2Cg9wzEY58lFGcJhwaa
	xbWKW4usaGQVPTNgYR6zGEzauVCxK1PuYtYypwXyjld91mKwa3CzTd8agS2L6zWm
	e5cGJq3OccQKK4cIt2xVbKw6FQ4TnWGH+JNXEDfcVYCkG7IBYHbE16WqxbJlCj1X
	+vWFwlljfWV+L86mHbVQrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774888072; x=
	1774974472; bh=a6ytzIKHDKBXuKugHJbZY/k29tn3vx4e0Y1XvVYJIHU=; b=g
	z6i5nqI/d4Sckt9rI8IrC/z4BqfEjLWpDUdsb6KUJRMxldsRcsqMqQ/YJxRu7OUc
	TSZiOBN5J38au/3EkC4Ot8XXJK0L5FvoWXpApdPR90yBlLByjOzxfR8b58lKL/vL
	e2Rk3lGqVQXxbsuKok8RApukV8wMs83L9THSpg7sSO1prmdcWUDlFn96jMFYJiDX
	dEhHNTqSlCee7SWouH0kdvmJ7BM0fD4+md4cUSORDUGnkDOHRjkaFBv3Fm9ltH19
	9X3sD/BBB7dVO0rnVdpWSzRmGCQSmF0n+hPndgE0Aficvl2GtqnPZ+MVHA5vUsA/
	o0nAigSuJG5cqpmXARHHQ==
X-ME-Sender: <xms:h6TKaYrMFYxV1W3zHB8qHdU4AtTm2-Q2a-sH4D0VqEEMLEdwE4zDkA>
    <xme:h6TKaYBeqkfSSPDubYeaJj37cXvM63UPtkVe8y9qAxNcZV0wTEaJFfr032b9iJdrz
    -uIFrc0vI9NUX32ki3DtIKX9PqAUap0znQX6rQZZn6ZEugzfAEQQdM>
X-ME-Received: <xmr:h6TKaVt6cILDjYfvvipIzg2nh2-nX6cRAzW-MkrPm_8YUkygiv2fEwnlmBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrkhhrohifihgrkheslhhinhhugidrihgsmhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhjhhgvrhhnvgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopegsohhrnh
    htrhgrvghgvghrseguvgdrihgsmhdrtghomhdprhgtphhtthhopehmjhhrohhsrghtohes
    lhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehprghsihgtsehlihhnuhigrdhisg
    hmrdgtohhmpdhrtghpthhtohepkhifrghnkhhhvgguvgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:h6TKafZY7ongvmvxrTAbqx2SCSJZx6qViANw-o5HZpDOYPbA8paI5g>
    <xmx:h6TKaZHq3ROqNTg6mDXy1RE3H3jZGZzdCyagYvPp1Qr_qRQve-Mwbg>
    <xmx:h6TKaarvaH9SgArFz5b_5wa7P7hPO1x8YmX1-7C9xJHwUK-MVp5WnA>
    <xmx:h6TKacxprp2IjPHZb-ua0VtcCgExwbVDXWswx5h_8M_z40FokJhUtA>
    <xmx:iKTKacGOnhxhuVhRoNmRsdd0EyP9DDfVauLqTwX0NaDeUcn8caTlY1ul>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 12:27:50 -0400 (EDT)
Date: Mon, 30 Mar 2026 10:27:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, kwankhede@nvidia.com,
 fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1 00/23] s390/vfio-ap: Implement live guest migration
 of guests using AP devices
Message-ID: <20260330102748.6423ff89@shazbot.org>
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 17:00:47 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch series implements live guest migration of a guest to which AP
> devices have been passed through. To better comprehend this design, one has
> to understand that VFIO AP mediated device is not used to provide userspace
> with direct access to a device as is the case with other devices that use
> the VFIO framework to pass them through to a guest. The sole purpose of the
> VFIO AP mediated device is to manage an AP configuration for a guest. An AP
> configuration is comprised of the AP adapter IDs (APID), AP queue 
> indexes (APQI) and domain numbers of the control domains to which a guest
> will be granted access. Once the VFIO AP mediated device is attached to a
> guest, its AP configuration is set by the vfio_ap device driver. Once set,
> all access to the AP devices is handled by the s390 Interpretive Execution
> facility; in other words, the vfio_ap device driver plays no role in
> providing direct access to the AP devices in the guest's AP configuration.
> 
> The only role that the vfio_ap device driver plays in the migration
> process is to verify that the AP configuration for the source guest is
> compatible with the AP configuration of the destination guest.
> Incompatibility will result in a live guest migration failure.
> In order to be compatible, the following requirements must be met:
> 
> 1. The destination guest will be started with the same QEMU command line
>    as the source guest, so the mediated device supplying the AP
>    configuration on both guests must have the same name (UUID).

AFAIK, same UUID is not a requirement for out-of-tree mdev drivers
supporting migration.  You're really concerned more with the
configuration/composition of the mdev device, so requiring the same
UUID seems a bit arbitrary.

> 
> 2. The AP configuration assigned via the VFIO AP mediated device on both
>    guests must be compatible. As such, each AP configuration must meet
>    the following requirements:
> 
>    * Both guests must have the same number of APQNs
> 
>    * Each APQN assigned to the source guest must also be assigned to the 
>      destination guest
> 
>    * Each APQN assigned to both guests must reference an AP queue with the
>      same hardware capabilities

Why isn't this sufficient vs also requiring the same UUID?
      
> Note: There is a forthcoming consumer of this series which will be a QEMU 
>       patch series is entitled: 
>       'hw/vfio/ap: Implement live guest migration of guests using AP 
>       devices'
> 
> This design also adds a use case for enabling and disabling 
> migration of guests to which AP devices have been passed through. To
> facilitate this, a new read/write sysfs 'migratable' attribute is added to
> the mediated device. This attribute specifies whether the vfio device is
> migratable (1) or not (0). When the value of this attribute is changed, the
> vfio_ap device driver will signal an eventfd to userspace. It is up to
> userspace to respond to the change by enabling or disabling migration of
> the guest to which the mediated device is attached. The operation will be
> rejected with a 'Device or resource busy' message if a migration is in
> progress.

This seems inherently racy.  What happens if the device becomes
unmigratable while it's being migrated?

If userspace is deciding that the device is now unmigratable, why does
it need to signal this through the kernel driver rather than with the
userspace orchestration agent?  The entire path seems unnecessary.

> Userspace must also have a means for retrieving the value of the sysfs
> 'migratable' attribute when the guest is started to initialize whether it
> can be migrated. For this, The VFIO_DEVICE_GET_INFO ioctl is used. The 
> struct vfio_device_info object passed to the ioctl will be extended with a
> capability specifying the vfio device attributes. One of the attributes 
> will contain the value of the mediated device's 'migratable' attribute.

This is just broken, it's redundant to our current device feature
mechanism for exposing migration support.  If you want the capability
to create unmigratable devices statically, can't that be encompassed
within the definition of the mdev type?  Dynamic migration support just
seems like it's involving the kernel in orchestration it shouldn't be a
part of.  Thanks,

Alex
 
> Anthony Krowiak (23):
>   s390/vfio-ap: Store queue hardware info when probed
>   s390/vfio-ap: Provide access to queue objects and related info
>   s390/vfio-ap: Add header file for xfer of vfio device caps to
>     userspace
>   MAINTAINERS: Add new header file for the S390 VFIO AP DRIVER
>     maintainers
>   s390/vfio-ap: A sysfs 'migratable' attribute to enable/disable
>     migration of guest
>   s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute
>   s390/vfio-ap: Signal event to enable/disable live guest migration
>   s390/vfio-ap: Return value of sysfs migratable attribute from
>     VFIO_DEVICE_GET_INFO ioctl
>   s390/vfio-ap: Data structures for facilitating vfio device migration
>   s390/vfio-ap: Initialize/release vfio device migration data
>   s390-vfio-ap: Callback to set vfio device mig state during guest
>     migration
>   s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
>   s390/vfio-ap: File ops called to save the vfio device migration state
>   s390/vfio-ap: Transition device migration state from STOP to RESUMING
>   s390/vfio-ap: File ops called to resume the vfio device migration
>   s390/vfio-ap: Transition device migration state from RESUMING to STOP
>   s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
>   s390/vfio-ap: Transition device migration state from STOP to RUNNING
>     and vice versa
>   s390-vfio-ap: Callback to get the current vfio device migration state
>   s390/vfio-ap: Callback to get the size of data to be migrated during
>     guest migration
>   s390/vfio-ap: Provide API to query whether migration is in progress
>   s390/vfio-ap: Disallow blocking migration in progress
>   s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst
> 
>  Documentation/arch/s390/vfio-ap.rst     |  339 +++++--
>  MAINTAINERS                             |    1 +
>  drivers/s390/crypto/Makefile            |    2 +-
>  drivers/s390/crypto/vfio_ap_drv.c       |    4 +-
>  drivers/s390/crypto/vfio_ap_migration.c | 1131 +++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_ops.c       |  263 +++++-
>  drivers/s390/crypto/vfio_ap_private.h   |   20 +
>  include/uapi/linux/vfio.h               |    2 +
>  include/uapi/linux/vfio_ap.h            |   34 +
>  9 files changed, 1685 insertions(+), 111 deletions(-)
>  create mode 100644 drivers/s390/crypto/vfio_ap_migration.c
>  create mode 100644 include/uapi/linux/vfio_ap.h
> 

