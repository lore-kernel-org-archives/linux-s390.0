Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442BA932;
	Wed,  1 Apr 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081088; cv=none; b=s5+YQuVo+6eJQgEorBJiR3z7NSjkAn8KTp2D3zZrwENH1SaauBogTWXy9gvvoty7IJsQuuLOs7nLBhRkPQjXNoeoye275y09f9RMJBE8BAphIrXHlGQNWGkElQnZt+DLbhzaxk8nmTQp59sn0MXtcCycGdH2/h+glWUQnxjNK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081088; c=relaxed/simple;
	bh=nJOvaNy7j6rvTOxcVafJpBYJp/0tPwEzuBoNXIR/zRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFBPUPTDEHafi8TncxxvscEQjexFp3tHr0dFmlPomLxFUNuklaTQbpnYm8sOUYMFfAcUkr2YOTVtsoVhxWUqGn3KarSXXH5Tyx4y2njDhg0aYA5klNphVxAcAObWikde+ChzKPtrGHojm66Gm085L3wZEtlmShec0AI1DHwENrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=nZyhmzjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXaTuolM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="nZyhmzjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXaTuolM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CE307EC0283;
	Wed,  1 Apr 2026 18:04:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 18:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775081084;
	 x=1775167484; bh=9IL6MYddNSgjsTDnmWtOw+9dnQBGMdnLa6tOppVniio=; b=
	nZyhmzjlzYpN31Sb53GozZK7YfFnFNK719ZxNlGQpgQLDoI4RRoI8M339F5zBIgP
	DGPmSvmLWrglk3g8lJVWJUSs94/QAkYpMwo77H54Nt/fezDHc1/2+oyo29mkrfEs
	l2bsZfBqayxh+z8V8ucQHXw1wY5Vvmy24jT9FNKoWitx+3abeisvjQ0mpjMxSvA+
	pl7oGOsFmkMcNMcIuIJ8H5aF/CFS3wgp4eHadqWA0LmBVC3vU8jpPQjgbrGju75Z
	ZXaEI10pr96bbPqSeIWw5d6gw2qVPFNWSCex6tGfXeF1im5lLYKdktpdxsJKVex0
	eNfvRJBbGZPM2RnxLi9TJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775081084; x=
	1775167484; bh=9IL6MYddNSgjsTDnmWtOw+9dnQBGMdnLa6tOppVniio=; b=u
	XaTuolMv4eO5R6eaSVldRiUT6ZufrCvo6UXZLk7JsR7OA+ZNLv1GgS43j344H0gB
	aez5B8w950iz7ehmhTYx1YzmvVWwKRfBEqp+YeYX4cnTrCjsL4pTZYMpVW9eafU4
	vq057RlDFfrMpgCVv/Uf7EJpMM6yK2N+gNr3RutaMt9SZq8VhLWPiApovSpExdgH
	6pM4MISBIofo4qRC82ZqWFOz5qluF6kPoRcZ2UNK4PZO9xo2PD9d7erzL0diDdrP
	68Ns7TP40GBZ22AvFzvWT15d5IpMYwwf7O/khQCqYKhOl25GqxSt4cwUjllQfEAd
	k8unY8cW200lxENP0iFZg==
X-ME-Sender: <xms:fJbNaU1cA-DrL3ZrIxpXxSBFV86qY82W51CjXscUnVabfU2rOS9HCw>
    <xme:fJbNabOp-Zu0KLqDp76KmbqlhuIYDfeLqCbsQyqp1haJnuk2eX1q4XzyyLMYWB8wY
    OHiHeX9hePeeZBOYIqojCW83PP-pNmx4icOPJC__KNliX2WiFznCw>
X-ME-Received: <xmr:fJbNaYtfEovz3-lvZUqMo_Jg2b3A2-GCwMlg4ayyDtGi4KU3xIMIIaNQ7jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudegveeu
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrnhhrsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthht
    ohepfihinhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehtsheslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopehosggvrhhprghrsehlihhnuhigrdhi
    sghmrdgtohhmpdhrtghpthhtohepghgsrgihvghrsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihishhhrghihhes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiug
    hirgdrtghomh
X-ME-Proxy: <xmx:fJbNaXIrKupSjGaE0EVXTtYjTi7paGiz_38baDpv29YwA3QIVReMmg>
    <xmx:fJbNaXOcE32pvkQHxsAd0OYSfsBOn7ueIA9ehs3C5eXPkyDRDQyj7A>
    <xmx:fJbNabDkWy0cSgWO78JnOh5OtfWgSap92ZwhLu-OeX6y14sRTOJw2Q>
    <xmx:fJbNafXbQlaNB9YEADTkl2S_Cqnja8EtNDRIxA-MW6xDg1UjaAcCUg>
    <xmx:fJbNaZzWyfJe69skIzkSNHXLMFfyvjvvEmL-sO8C0MOqSe-Yt7GrogRv>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:04:43 -0400 (EDT)
Date: Wed, 1 Apr 2026 16:04:41 -0600
From: Alex Williamson <alex@shazbot.org>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
 oberpar@linux.ibm.com, gbayer@linux.ibm.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260401160441.406fe25a@shazbot.org>
In-Reply-To: <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	<20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 14:31:24 +0100
Julian Ruess <julianr@linux.ibm.com> wrote:
> diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..00bc81f7225f806eac1b99c4520ab5a68137885e
> --- /dev/null
> +++ b/drivers/vfio/pci/ism/main.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vfio-ISM driver for s390
> + *
> + * Copyright IBM Corp.
> + */
> +
> +#include "../vfio_pci_priv.h"
> +#include "linux/slab.h"

Convention says this should be:

+#include <linux/slab.h>
 #include "../vfio_pci_priv.h"
-#include "linux/slab.h"
 
Without objection, I'll make the change and push this to next tomorrow.
Thanks,

Alex
