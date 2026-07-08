Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DB3B893F
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529098; cv=none; b=YCFbbtI0VYnEhdZPq5VEwMOadN0m8oCDNLZhcjnzoZN8x/mbkRnFsvCdS9oqmhdkGX/BhTi13eDVPNUIFgPM/eYzh6qYRsgo0gOmS6MWUQJ5WhLbJTBJyByMgNQBIMgk8xdJTaGInAO94odwJ2VeGlSpHQLBVfvFPZsxsm2eglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529098; c=relaxed/simple;
	bh=Eb1KKspIxhPRLxZ7jZvZL663ogWrWGBIvsMn8NeS38k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZfCFfD778+5AtCn39dntgoCTVpJFFfhqH8T8dy4UPqAH3xEtEt/TTZMAi2C4OIOWbvFxf1YC85DwJVGcHILK2whroUOXq6mLGXDJgLxRWqKrI2zc10Qb48mQrT77k0cVs8S/pj7idqd9o7UhjLerx6gb+BlEKvTY3hSLxdXIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4WC0tDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4WC0tDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529095;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=XkHhE4HS0EC9R/UNwCYKkpRr9HZXSRPHfO4vuMPwrWM=;
	b=C4WC0tDeoszlx6IwOtOn/Au7SVZQVPNlOw/O2RT2lyCxLLfDLv53J+mME1zvEM7k20pqkl
	61CeGYb7Mjp4FpZGjJUMTtGXgT8qc3NvntImeWOt9YIzeySrIJFUbn9eM5NUFAojDCl/va
	N2zspgcBxs8xx8bKhlUKwlap1xXZFn0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-6rZPWQn5NTeILkmpW0M2_Q-1; Wed,
 08 Jul 2026 12:44:50 -0400
X-MC-Unique: 6rZPWQn5NTeILkmpW0M2_Q-1
X-Mimecast-MFC-AGG-ID: 6rZPWQn5NTeILkmpW0M2_Q_1783529088
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AF4B1955F2A;
	Wed,  8 Jul 2026 16:44:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A52C231D2;
	Wed,  8 Jul 2026 16:44:44 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:44:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
	iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	linux-s390@vger.kernel.org, dengler@linux.ibm.com,
	borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
Message-ID: <ak5-efTUs5qqteKp@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <87jyr7jg13.fsf@redhat.com>
 <f5da328519f83191277bd5b3d8060712@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5da328519f83191277bd5b3d8060712@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Tue, Jul 07, 2026 at 04:02:28PM +0200, Harald Freudenberger wrote:
> On 2026-07-07 11:38, Cornelia Huck wrote:
> > On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> > 
> > > This patch series extends the s390 qemu CPACF support to be able to
> > > run a subset of the CPACF instruction cross platform. There have been
> > > requests on the kernel crypto mailing list about a way to test
> > > s390 specific crypto implementations. For example a way to test
> > > s390 CPACF exploitation code like the s390_aes.ko kernel module.
> > > 
> > > So here now is a set of patches verified on x86 and s390 which
> > > over (slow but working) support for a subset of the subfunctions of
> > > some of the CPACF instructions.
> > 
> > Hi,
> > 
> > I wanted to pick this, but unfortunately, there are some problems with
> > it, as spotted by checkpatch (sadly, I did not see this earlier, and
> > softfreeze is upon us...)
> > 
> > - Licensing information: new files (e.g. cpacf.h) must use an SPDX
> >   identifier instead of licence boilerplate text - this needs to be
> > fixed
> > - some files are using tabs instead of spaces in some places
> > - there are also some other moans (less important), but you may want to
> >   look at them anyway (the long lines are not really a problem)
> > 
> > Cornelia
> 
> Yes, I saw these checkpatch complains but as nobody else seems to obey
> to the checkpatch findings I ignored most of them.

That is very much the wrong conclusion to draw. Our existing in-tree
code may not be clean on checkpatch, because we change checkpatch
rules over time but we don't retrospectively change existing code.

New code is expected to be clean with checkpatch unless there are
some genuine false positives which can't be reasonably avoided.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

