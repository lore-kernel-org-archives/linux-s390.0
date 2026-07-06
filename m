Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BF38AC8C
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338694; cv=none; b=QiR6gLBuOdALJ9T+LHZ78r1vNiS293Pvc+LalmhodRSZbpo9FcBrKvYsSvGTr7NUPxc4LtqEJdSWJUfFNOz4K48bQ7c7N6dytw3YBDLYMHBWtBjmObGW3V37SKgvkUAvORF5Cjbo1SCx65ZP4g7zKkCbmTrXBRuKiG2HTok3WVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338694; c=relaxed/simple;
	bh=s2duc5ofsTys/LWenZ4jVWn0FmyfuabA1Hl/zkxjeC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dE0wP0Kjf0KNdXGEoq3D96lCv0l1G8xXChIcBoUv1NW86NqnIaNkpxPprK25WSH1Reejb+3YacHq0tgtbgpkKqnpyVuydWNI5JgIXysEGfoqZzbvTbOqNHjMZYtVw9LHNDeMGIHtZCXRSpox4u92iYz0iBxUoipnf9UjiQCaDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRVdC/rQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRVdC/rQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783338689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MZeVVmFL+eaMn/AIwJDbn1+Nrnqjph+bxM7usbiNTo=;
	b=fRVdC/rQArVGEDHPSCscAbN1tzwXtTj0dnTtTJBd4qH7cnHrtFUht8sOhpn6sRnmGFkF39
	GSHyp5yf7z14rO9nffF1gXJ2HfEkXlpN3+ZSAfjN0tq1OmbNor5D8/YNb8eKs15Q01X7ks
	giK6TpWJwU3Kk3TPs4rtENQyiQPwlwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-FBV5qYOOOjKZ1L1QYtkYug-1; Mon,
 06 Jul 2026 07:51:23 -0400
X-MC-Unique: FBV5qYOOOjKZ1L1QYtkYug-1
X-Mimecast-MFC-AGG-ID: FBV5qYOOOjKZ1L1QYtkYug_1783338682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D08071955F73;
	Mon,  6 Jul 2026 11:51:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32FA41956049;
	Mon,  6 Jul 2026 11:51:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf
 protected keys
In-Reply-To: <20260706094317.17032-11-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 13:51:19 +0200
Message-ID: <87v7asjpzc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> Add base support for cpacf protected key handling.
>
> The qemu version provided here is only a fake intended to make
> protected key available for developing and testing purpose:
> * The protected key is 'derived' from the clear key by xoring
>   the fixed pattern 0xAAAA... onto the key value.
> * The AES Wrapping Key Verification Pattern is a fixed
>   value of 32 bytes 0xFACEFACE...
>
> Add preprocessor defines for the xor pattern and wkvp used to
> construct ('encrypt') a protected key from a clear key value with
> this implementation. Also add some static functions to 'encrypt'
> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>
> The preprocessor defines shall be used later in testcases to
> construct and decode protected keys.

Hmm... so does that mean that we only provide the protected key handling
in the !KVM case for people who want to run via tcg for some development
purposes? Does the user actually get some kind of notice in that case,
if for example they run with !KVM due to some configuration hiccup? IOW,
do users get some clue that they are running with a fake placeholder
implementation, other than the setup being slow?

>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
>  target/s390x/tcg/cpacf_aes.c | 39 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

