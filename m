Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DD37C107
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530647; cv=none; b=K/ndLBZyC9Fu84NuwxpLg6u+xHWZHGLxgAlfuuYfZLth1kUzzEZmI3daTO3IQwbUAy7+AAaCQV7OKblbftQgZCasBIMhUnaGXmikz6CSkLVd9qhIxRzmOh7r8owdvf1Y8uoerlwQV5/F+T5aMlYsTcJyQFbrX7uW9l+2wNzYRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530647; c=relaxed/simple;
	bh=f0uovZpRDHTeQwCXg/Figz0TbgFuEtVfuxELYFBAw3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MArIAFMLK0tubAcBn/W/VjVEmG+IH2rwCPce8hzMNEtG+qj64X/RHBR0eYOVB6lk2d1J9ZowA86LK+Zle4YJ/NLKf7ymTYe64vM/TZjJlcKNgx7ouuEFsdBDZ4NHPbt5/aoNHZAW2wqNZnOkCQoWqwMG9X3r9N5bTn5/65fle9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfFJFB3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfFJFB3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530644;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=DC/Xmp1EFs92MEa7tYVfSmHopH1ID1fSNwx287pqV2k=;
	b=GfFJFB3/8yoywC1qz8xXc7xM/7nBEXrkAO8YoFNeLiEerHLOLstKPEcs6lkrc+xx0qxsnC
	MToUDRlxStgHfvbZ9wZufWa09n8xTVZdvtvGR0DgfFzloGZZ4DnzwuqLsIAXmx/W8sOxd5
	OyNWFqW8sL7s3055MUTfqS996ij/qRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-in7c3cSmNjGaxM8wqtl39g-1; Wed,
 08 Jul 2026 13:10:40 -0400
X-MC-Unique: in7c3cSmNjGaxM8wqtl39g-1
X-Mimecast-MFC-AGG-ID: in7c3cSmNjGaxM8wqtl39g_1783530639
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E6751955F13;
	Wed,  8 Jul 2026 17:10:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 434D41774;
	Wed,  8 Jul 2026 17:10:34 +0000 (UTC)
Date: Wed, 8 Jul 2026 18:10:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
	iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	linux-s390@vger.kernel.org, dengler@linux.ibm.com,
	borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf protected
 keys
Message-ID: <ak6Eh8Df9K5Ew-2E@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com>
 <87v7asjpzc.fsf@redhat.com>
 <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Jul 06, 2026 at 02:18:25PM +0200, Harald Freudenberger wrote:
> On 2026-07-06 13:51, Cornelia Huck wrote:
> > On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> > 
> > > Add base support for cpacf protected key handling.
> > > 
> > > The qemu version provided here is only a fake intended to make
> > > protected key available for developing and testing purpose:
> > > * The protected key is 'derived' from the clear key by xoring
> > >   the fixed pattern 0xAAAA... onto the key value.
> > > * The AES Wrapping Key Verification Pattern is a fixed
> > >   value of 32 bytes 0xFACEFACE...
> > > 
> > > Add preprocessor defines for the xor pattern and wkvp used to
> > > construct ('encrypt') a protected key from a clear key value with
> > > this implementation. Also add some static functions to 'encrypt'
> > > from clear key to protected key and 'decrypt' back to cpacf_aes.c.
> > > 
> > > The preprocessor defines shall be used later in testcases to
> > > construct and decode protected keys.
> > 
> > Hmm... so does that mean that we only provide the protected key handling
> > in the !KVM case for people who want to run via tcg for some development
> > purposes? Does the user actually get some kind of notice in that case,
> > if for example they run with !KVM due to some configuration hiccup? IOW,
> > do users get some clue that they are running with a fake placeholder
> > implementation, other than the setup being slow?
> > 
> 
> Well, there are 2 paths leading to protected use:
> 1) you have a secure key and want to 'derive' a protected key from that
>    to operate faster. This is for example the case now when you have an
>    PAES encrypted filesystem.
>    In such a case you need a crypto card with the Master Key setting
>    fitting to when your secure key was generated.
>    -> this is not a practical way for qemu on !KVM as you need a crypto
>    card AND the s390 firmware stack.
> 2) you 'derive' a protected key from a clear key value. On a s390 system
>    this is done via the privileged instruction PCKMO. On this qemu with
>    !KVM this is the fake I implemented.
>    In general it is absolutely not recommended to go this path as the source
>    of the key is/was/needs to stay in OS memory. So you don't win any
>    security by using protected keys this way - in fact you would have
>    done better to just use the clear key as it is. Please note also, that
>    by default this path on a s390 system is disabled - however, for testing
>    purpose there are ways to use it this way.
>    However, this is exactly what this implementation here is for. For
> testing
>    purpose you may 'derive' a protected key from clear key or any other way
>    as the algorithm to derive is clear documented here. And then you can
> play
>    around and run tests with protected key implementations.
> 
> I see your point: How can a innocent user see that his/her vm is running
> with
> this fake installation instead of the real one. The answer is:
> If the source of the protected key is a secure key - then there is no path
> on the faked implementation to get a hand on a protected key.
> If the source of the protected key is a clear key - honestly does it even
> matter which implementation is then running?

IMHO any use of TCG inherantly throws away any security guarantees
that rely on a guaranteed hardware impl, and in addition we don't
claim that TCG provides a secure host/guest boundary & thus excluded
it from CVE triage.

IOW, if someone is concerned about integrity of their VM, the
answer is to detect the presence of TCG in general, rather than
detect anything related to this narrow protected key feature.

TL;DR: this is at most a docs problem to highlight the limitations
of using TCG in general, and not a problem for this patch series.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

