Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35F47FAF8;
	Wed, 19 Aug 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156729; cv=none; b=Ead1SUPoqY3TxT01K7wmOwS7mS8LFuKqEg7hfoIA956UDcyKZwuKoXp710m23VQLquDu6APgyKS3MA9V9PIrqnShHzBIKJPsltNwgRZmlxLiJRUAByyGarvkKf9JqF1DYRiqg/L23e4w7yQoC5HFlKYpwr2vMEOZgUuUWbsrxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156729; c=relaxed/simple;
	bh=CXxFSSIaiFgxYxkqSmq+3r9ctVdW7dvjaLm00VRApXg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IjzqZOluFoDiunRjI5ywU1v7hMzzX3TMCOfF0+G2RS4ruEKOe0Ml26ac/BIguI0TYVT5udlHmP6mBjoesiOEK5PLVc3RZff3DWpin3Iw8v/VkvCWMj9NnL2miBrySBy4KWfHKwrcMMIx/iB+VSAGM6zSGTYAQ9cUP+nrHQZkrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NaOHvWnh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NaOHvWnh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=6nHVcsahYdRFKfreUIyRHCzY9W+x/Y0KpflpSSYhZxs=; b=NaOHvWnhHqHInugzy7gTk9JZJz
	00Nef5L2eN+Bu96MK9aWv3+f2hMx5uwjjEKhsVf9Ok46Q2WeaZzCZ+OU7sTNS8CSFwwj/DMPWeYx5
	VifwF0NNf5Um+pW4bv46Y13F3vXTniZbhTmC0RUMM8/a0LE5UJX0OPdohEO/3pDsYevy63GShXIwo
	AQmfFXNS4MTaOSK6qq65cS+u/p2rvK72JAAjjwyNI9TevNQ9Q8o0YVXYnME25nWa7jCpqgmsDv/rr
	gXjMLN6VK3TuXnIS0qrYmP1IrJfMmqAIFha69pWfmfaBYHjfFLCsq7qeEIPJRu2bteD/keNgduddR
	estsFPyA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwj6T-006Bnn-Kx; Wed, 19 Aug 2026 18:25:25 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wwj6S-00EYZ5-My; Wed, 19 Aug 2026 18:25:25 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wwj6S-000000027Fi-2mM4;
	Wed, 19 Aug 2026 18:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 13:25:24 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, Vasily
 Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH RFC v2 05/13] sysctl, parport: update register_sysctl()
 callers with template arguments
In-Reply-To: <20260819024411.C41E61F000E9@smtp.kernel.org>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-5-d5a69dae5798@igalia.com>
 <20260819024411.C41E61F000E9@smtp.kernel.org>
Message-ID: <dcc4fc5f41793bdf4133891d566b4b98@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On 2026-08-18 23:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless traversal of the `port->devices` list can lead to a use-after-free if a device is concurrently unregistered.
> --

Pre-existing and apparently acknowledged, per details below.

> 
> --- Patch [5]: [PATCH RFC v2 05/13] sysctl, parport: update register_sysctl() callers with template arguments ---
> commit 511c6de215c54187a5a0e65c0208aa20775855cf
> Author: Mauricio Faria de Oliveira <mfo@igalia.com>
> 
> sysctl, parport: update register_sysctl() callers with template arguments
> 
> Update callers with dynamic table/path to use template arguments.
> 
>> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
>> index cda3221e386ed..7c048e9a973aa 100644
>> --- a/drivers/parport/procfs.c
>> +++ b/drivers/parport/procfs.c
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could reading the active
> device sysctl lead to a use-after-free if a device is concurrently
> unregistered?
> 
> In drivers/parport/procfs.c:do_active_device(), the port->devices list is
> traversed locklessly:
> 
>     for (dev = port->devices; dev ; dev = dev->next) {
> 
> Concurrently, parport_unregister_device() in drivers/parport/share.c can
> remove a device from this list and free it:
> 
>     device_unregister(&dev->dev);
> 
> Since there is no synchronization (like taking port->pardevice_lock)
> between the sysctl read and device removal, couldn't the lockless traversal
> dereference a freed pardevice pointer?
> 
> This missing locking is also explicitly annotated in another lockless
> traversal in drivers/parport/share.c:parport_release():
> 
>     /* !!! LOCKING IS NEEDED HERE */
>     for (pd = port->devices; !port->cad && pd; pd = pd->next) {
> 
> Could an unprivileged user trigger this by repeatedly reading the sysctl
> while a device is unregistered?

-- 
Mauricio
