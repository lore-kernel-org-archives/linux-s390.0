Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F71D63E8;
	Thu, 16 Jan 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019959; cv=none; b=gMa5+gCz5oXB5zGejdeY0y7uSgpHEsiD61hyZw32kPBl6LFaD7UuugDI1vd1Nt4W5Tpl8j7FQk4b428I8mPdDvKssiKj7vI0kDAT3D6qzOceeRtBGYz34aia5lRKjpbwtRzmBpU6UZsRriD2AFk1Q3NTvZ42lzXD82Opgr1CFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019959; c=relaxed/simple;
	bh=LWt7XEVPS8N0YQy0uQOXW6JLOsPR54wsDdcCXDxVGWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpkMtdNLjmxx/6fh24SIM6FJGyqtWkzEBjcNaXMYl3jFKe3jJOFQCD6qyqQuEfvalg0QaS3V7krRzhvg2813VP1Tpm7+SuYakxPr4+QjrmoO/nbp3Ui8rPNz3vkQ7a7IKNnaBC4Y3NOgdX2Tfa+jBxAu1WC7INAxx+0gi6QSsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CXe9M9ng; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CXe9M9ng"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737019953; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uuXQ582Ha4DdvDN45Lh8QaDTbd5XVBqL+jFWzVMrE5Q=;
	b=CXe9M9ngwDpnU9UcufqvNYhvn9tJDZtqI3Vb5p1pWROqHmXIAcghwsfgtJDK6FXRptJFSzO9egnoApTrBZBjchhEQ15N/NOWsIMZGaPJXww4KYNivtF3n3asZfcgL7WBUjN+lCYlIH5XDs1h6mKOzxedxFGc1CXlP5YmK/LKr9o=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNlGIC9_1737019952 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 17:32:32 +0800
Date: Thu, 16 Jan 2025 17:32:31 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250116093231.GD89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115195527.2094320-1-wintera@linux.ibm.com>

On 2025-01-15 20:55:20, Alexandra Winter wrote:

Hi Winter,

I'm fully supportive of the refactor!

Interestingly, I developed a similar RFC code about a month ago while
working on enhancing internal communication between guest and host
systems. Here are some of my thoughts on the matter:

Naming and Structure: I suggest we refer to it as SHD (Shared Memory
Device) instead of ISM (Internal Shared Memory). To my knowledge, a
"Shared Memory Device" better encapsulates the functionality we're
aiming to implement. It might be beneficial to place it under
drivers/shd/ and register it as a new class under /sys/class/shd/. That
said, my initial draft also adopted the ISM terminology for simplicity.

Modular Approach: I've made the ism_loopback an independent kernel
module since dynamic enable/disable functionality is not yet supported
in SMC. Using insmod and rmmod for module management could provide the
flexibility needed in practical scenarios.

Abstraction of ISM Device Details: I propose we abstract the ISM device
details by providing SMC with helper functions. These functions could
encapsulate ism->ops, making the implementation cleaner and more
intuitive. This way, the struct ism_device would mainly serve its
implementers, while the upper helper functions offer a streamlined
interface for SMC.

Structuring and Naming: I recommend embedding the structure of ism_ops
directly within ism_dev rather than using a pointer. Additionally,
renaming it to ism_device_ops could enhance clarity and consistency.


>This RFC is about providing a generic shim layer between all kinds of
>ism devices and all kinds of ism users.
>
>Benefits:
>- Cleaner separation of ISM and SMC-D functionality
>- simpler and less module dependencies
>- Clear interface definition.
>- Extendable for future devices and clients.

Fully agree.

>
>Request for comments:
>---------------------
>Any comments are welcome, but I am aware that this series needs more work.
>It may not be worth your time to do an in-depth review of the details, I am
>looking for feedback on the general idea.
>I am mostly interested in your thoughts and recommendations about the general
>concept, the location of net/ism, the structure of include/linux/ism.h, the
>KConfig and makefiles.
>
>Status of this RFC:
>-------------------
>This is a very early RFC to ask you for comments on this general idea.
>The RFC does not fullfill all criteria required for a patchset.
>The whole set compiles and runs, but I did not try all combinations of
>module and built-in yet. I did not check for checkpatch or any other checkers.
>Also I have only done very rudimentary quick tests of SMC-D. More testing is
>required.
>
>Background / Status quo:
>------------------------
>Currently s390 hardware provides virtual PCI ISM devices (ism_vpci). Their
>driver is in drivers/s390/net/ism_drv.c. The main user is SMC-D (net/smc).
>ism_vpci driver offers a client interface so other users/protocols
>can also use them, but it is still heavily intermingled with the smc code.
>Namely, the ISM vPCI module cannot be used without the SMC module, which
>feels artificial.
>
>The ISM concept is being extended:
>[1] proposed an ISM loopback interface (ism_lo), that can be used on non-s390
>architectures (e.g. between containers or to test SMC-D). A minimal implementation
>went upstream with [2]: ism_lo currently is a part of the smc protocol and rather
>hidden.
>
>[3] proposed a virtio definition of ISM (ism_virtio) that can be used between
>kvm guests.
>
>We will shortly send an RFC for an ISM client that uses ISM as transport for TTY.
>
>Concept:
>--------
>Create a shim layer in net/ism that contains common definitions and code for
>all ism devices and all ism clients.
>Any device or client module only needs to depend on this ism layer module and
>any device or client code only needs to include the definitions in
>include/linux/ism.h
>
>Ideas for next steps:
>---------------------
>- sysfs representation? e.g. as /sys/class/ism ?
>- provide a full-fledged ism loopback interface
>    (runtime enable/disable, sysfs device, ..)

I think it's better if we can make this common for all ISM devices.
but yeah, that shoud be the next step.

Best regards,
Dust

>- additional clients (tty over ism)
>- additional devices (virtio-ism, ...)
>
>Link: [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>Link: [2] https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/
>Link: [3] https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=c060ecf9-ea1a-49a2-9827-c92f0e6447b2&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT
>
>Alexandra Winter (7):
>  net/ism: Create net/ism
>  net/ism: Remove dependencies between ISM_VPCI and SMC
>  net/ism: Use uuid_t for ISM GID
>  net/ism: Add kernel-doc comments for ism functions
>  net/ism: Move ism_loopback to net/ism
>  s390/ism: Define ismvp_dev
>  net/smc: Use only ism_ops
>
> MAINTAINERS                |   7 +
> drivers/s390/net/Kconfig   |  10 +-
> drivers/s390/net/Makefile  |   4 +-
> drivers/s390/net/ism.h     |  27 ++-
> drivers/s390/net/ism_drv.c | 467 ++++++++++++-------------------------
> include/linux/ism.h        | 299 +++++++++++++++++++++---
> include/net/smc.h          |  52 +----
> net/Kconfig                |   1 +
> net/Makefile               |   1 +
> net/ism/Kconfig            |  27 +++
> net/ism/Makefile           |   8 +
> net/ism/ism_loopback.c     | 366 +++++++++++++++++++++++++++++
> net/ism/ism_loopback.h     |  59 +++++
> net/ism/ism_main.c         | 171 ++++++++++++++
> net/smc/Kconfig            |  13 --
> net/smc/Makefile           |   1 -
> net/smc/af_smc.c           |  12 +-
> net/smc/smc_clc.c          |   6 +-
> net/smc/smc_core.c         |   6 +-
> net/smc/smc_diag.c         |   2 +-
> net/smc/smc_ism.c          | 112 +++++----
> net/smc/smc_ism.h          |  29 ++-
> net/smc/smc_loopback.c     | 427 ---------------------------------
> net/smc/smc_loopback.h     |  60 -----
> net/smc/smc_pnet.c         |   8 +-
> 25 files changed, 1183 insertions(+), 992 deletions(-)
> create mode 100644 net/ism/Kconfig
> create mode 100644 net/ism/Makefile
> create mode 100644 net/ism/ism_loopback.c
> create mode 100644 net/ism/ism_loopback.h
> create mode 100644 net/ism/ism_main.c
> delete mode 100644 net/smc/smc_loopback.c
> delete mode 100644 net/smc/smc_loopback.h
>
>-- 
>2.45.2
>
