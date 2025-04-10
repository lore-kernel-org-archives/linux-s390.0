Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CDB29344E;
	Thu, 10 Apr 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317092; cv=pass; b=grgeZ8DErtXx/tiyq6zgklvHPZBl+2+zxABCDsNfMDo08KwwVjPI9X2dwTzCABI/hG2ec9c/pg4i5NTcEirmGSDWkoYQLAY1wA4iQmpynJC4qHenSxcFhXm0dmyB04Iq+QtoWtXfeFoPtudR5hVBFhzp0/suHJrhP9dkNSABNIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317092; c=relaxed/simple;
	bh=OFgULUiNM4am4kZlLl4ZXHqMhIl5sompzO9H1RxbXmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0eenPhWzCs5YrdCJxgLp/HrztpoxhME3hx1U4CEmM4TVegVRBLHqsAbg0SoNB3uesVaJiwpLW13Qb80JlBYyIOn5/H32y0cJqKfnY2Ov9Ylbl7AWmcAbyHQv2lXiQDGXcvw7DGcRtAAXSvHkoVzAq/1PisWk5wLl2nD9VmrlJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=II+ZVnSc; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="II+ZVnSc"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 979D58A469F;
	Thu, 10 Apr 2025 20:31:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.103.0.193])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F05198A4698;
	Thu, 10 Apr 2025 20:31:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744317084; a=rsa-sha256;
	cv=none;
	b=NK9FyxfrkX46m+OwSQWB04JhwZFgK5We+dhrJWmHu5XJfjUmlCELTMpXpx/LX2MlnCB3Uf
	b4f3AmTC0u1Obo16B8iZv5A7lSLxS4rYhr4MEteRyBvR/zMYYXrDz5fL6wo2eoUthQg6z2
	MM/06vmrt/OeImADWO4CbKoBBzi3FKDNccELYVH4NSD8ce3hcGhoQx2GGmngr4elBovZpV
	UH2jlBLaU9YdwjPB3t0VLXmHxMIwNwrxm3AvTmqyv3FeSjJ+2Uf4w2tTarOK1uTct96Py1
	3HgeZG1Wy97kRQivMvBTbYjLpU8T46qMH0n5u8tBySRvl70bzvIS5ydhwWmICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744317084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tQZ8B5y7ZJWu0aZUk8aDu9a2SdfysDdPA1yijiczGzA=;
	b=zSmZZaWGvXMvS4XwQr0DNaJqZamdOez2xAhCdRytIcvHdu2HgLhoATD4LHjObF76yGut2a
	SiBcfnz/uMO28sMp23FoYsyTHRH25pgsfQjk7882CoXBxCLhiJnAXzYPesNj+qVWAVDxmL
	0XeAhq/VzSDrV6mdqhGECbd1MVy+zWkC1HJwnZFWFLyr25DkykBPt1AcV5k8N61Lve7TE6
	poP2LmzE1H4kCvqlYF4dZRL/d9gTw7ZLXchQJI6nS+g3HO7RB5Yf2PbQM5sUPFsh4NUG8f
	1nWeGuNdy64+jX1wJB7dAQpnpv0L6mK4XYyIaHfhe87lCpFPIYf1L6UsUp53Bg==
ARC-Authentication-Results: i=1;
	rspamd-7d787bdb4f-84nt4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Ski: 2acc207811187dc1_1744317084423_3382911955
X-MC-Loop-Signature: 1744317084423:1269916336
X-MC-Ingress-Time: 1744317084423
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.0.193 (trex/7.0.3);
	Thu, 10 Apr 2025 20:31:24 +0000
Received: from offworld (unknown [104.36.30.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4ZYWgG1nPZz72;
	Thu, 10 Apr 2025 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744317083;
	bh=tQZ8B5y7ZJWu0aZUk8aDu9a2SdfysDdPA1yijiczGzA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=II+ZVnScC4NBCWODwGng6NjrSEDK6pIrJruNXkXm5TLzVcX693mnzTxr6DNgySNua
	 JRVNn2sH/PsIt9lV6NcaLamhIAwVMNp91YaD0YgefmycxcI6Ijqqp4ZQasNhuAtUgQ
	 labTyNqRMpc64/X4sy3rnxndaxlXI4a3r2IEcBK8xo1vTxw/T9G02MLvnjcdkHP6hL
	 CzlBJuhsbb+fZFnA2ANmMl6csrlsfdbaBBEBr9H4WhZxd9nr0zDfiUwzXr6BN9sa3o
	 uAuNzioJvp4/K2ZuheBZdmFZ3+tNaXmOVNLAWNLSHbp9dyOmopM2oOsruTW7Onx2t7
	 QXLicnLP34M9g==
Date: Thu, 10 Apr 2025 13:31:17 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: nifan.cxl@gmail.com
Cc: willy@infradead.org, mcgrof@kernel.org, a.manzanares@samsung.com,
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <20250410203117.2ctv3cobdgawp7ma@offworld>
Mail-Followup-To: nifan.cxl@gmail.com, willy@infradead.org,
	mcgrof@kernel.org, a.manzanares@samsung.com,
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250410180254.164118-1-nifan.cxl@gmail.com>
User-Agent: NeoMutt/20220429

On Thu, 10 Apr 2025, nifan.cxl@gmail.com wrote:

>From: Fan Ni <fan.ni@samsung.com>
>
>The function free_page_and_swap_cache() takes a struct page pointer as
>input parameter, but it will immediately convert it to folio and all
>operations following within use folio instead of page.  It makes more
>sense to pass in folio directly.
>
>Introduce free_folio_and_swap_cache(), which takes folio as input to
>replace free_page_and_swap_cache().  And apply it to all occurrences
>where free_page_and_swap_cache() was used.
>
>Signed-off-by: Fan Ni <fan.ni@samsung.com>

With the already pointed out issues, this looks good.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
