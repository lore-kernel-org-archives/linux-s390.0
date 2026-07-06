Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61A42CAED
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341674; cv=none; b=k4vVu3XrbSR/Xwm3wo+Uzoy0tG5C+NGDV8HKsG14EsbkElPbab6hrKPKjWYQEjuGhheF5Q8ELyQO4W52e/pr6yKhpq9rRIFrUwS1f/kHxp0cW47djA3oaNz58pDgjfqfLfBfCzjojTtnT0arZct35YdBNiM6rdyq59R1JwT2Muk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341674; c=relaxed/simple;
	bh=xpw9+bFWKLaYWtye/sSV7RLWHcuKmTX0D9n0AStVX6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIaL9lKPaUy8kMt2LrrW4V/xf3CNKubkZbhl2IKAnCGDwp96cRPAKwb4XVcwUqHDMtbg9siZJIQjY9f4QhwA05uiKotUR1dmSaQymiPQ15u0EZkGnOrpxxDSqSChMGMMQ8CquQ8gBEbQMAGJfl2k5cupMwYkI5ipT0a9GUFsKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J77QvCta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J77QvCta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783341670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLC6x+9zBUwRED6dFvVyoWGWDc8ORTDu0ZeXm6hXJro=;
	b=J77QvCtaszbSRXkqImx4LYzSJ6ncKonxziUlY5CHSA98jZOyqOctC3jShxrO6MTPg0fgjP
	RkvtuchoK3xGshoIaQaYKKxtXQ5VK6+/cqoQIwBpM2kjF7Ppklv6BQc5Qa1ibburewwjve
	fZIqM9/G4S8RSNFm8j9ADiRSwyqPIx8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-i5Gneoz2MBWrVo1KneRUPw-1; Mon,
 06 Jul 2026 08:41:09 -0400
X-MC-Unique: i5Gneoz2MBWrVo1KneRUPw-1
X-Mimecast-MFC-AGG-ID: i5Gneoz2MBWrVo1KneRUPw_1783341668
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B098F1955DCD;
	Mon,  6 Jul 2026 12:41:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA92736535;
	Mon,  6 Jul 2026 12:41:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf
 protected keys
In-Reply-To: <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com> <87v7asjpzc.fsf@redhat.com>
 <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 14:41:04 +0200
Message-ID: <87se5wjnof.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-07-06 13:51, Cornelia Huck wrote:
>> On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
>> 
>>> Add base support for cpacf protected key handling.
>>> 
>>> The qemu version provided here is only a fake intended to make
>>> protected key available for developing and testing purpose:
>>> * The protected key is 'derived' from the clear key by xoring
>>>   the fixed pattern 0xAAAA... onto the key value.
>>> * The AES Wrapping Key Verification Pattern is a fixed
>>>   value of 32 bytes 0xFACEFACE...
>>> 
>>> Add preprocessor defines for the xor pattern and wkvp used to
>>> construct ('encrypt') a protected key from a clear key value with
>>> this implementation. Also add some static functions to 'encrypt'
>>> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>>> 
>>> The preprocessor defines shall be used later in testcases to
>>> construct and decode protected keys.
>> 
>> Hmm... so does that mean that we only provide the protected key 
>> handling
>> in the !KVM case for people who want to run via tcg for some 
>> development
>> purposes? Does the user actually get some kind of notice in that case,
>> if for example they run with !KVM due to some configuration hiccup? 
>> IOW,
>> do users get some clue that they are running with a fake placeholder
>> implementation, other than the setup being slow?
>> 
>
> Well, there are 2 paths leading to protected use:
> 1) you have a secure key and want to 'derive' a protected key from that
>     to operate faster. This is for example the case now when you have an
>     PAES encrypted filesystem.
>     In such a case you need a crypto card with the Master Key setting
>     fitting to when your secure key was generated.
>     -> this is not a practical way for qemu on !KVM as you need a crypto
>     card AND the s390 firmware stack.

Nod.

> 2) you 'derive' a protected key from a clear key value. On a s390 system
>     this is done via the privileged instruction PCKMO. On this qemu with
>     !KVM this is the fake I implemented.
>     In general it is absolutely not recommended to go this path as the 
> source
>     of the key is/was/needs to stay in OS memory. So you don't win any
>     security by using protected keys this way - in fact you would have
>     done better to just use the clear key as it is. Please note also, 
> that
>     by default this path on a s390 system is disabled - however, for 
> testing
>     purpose there are ways to use it this way.
>     However, this is exactly what this implementation here is for. For 
> testing
>     purpose you may 'derive' a protected key from clear key or any other 
> way
>     as the algorithm to derive is clear documented here. And then you can 
> play
>     around and run tests with protected key implementations.

Yes, and it is useful for that.

>
> I see your point: How can a innocent user see that his/her vm is running 
> with
> this fake installation instead of the real one. The answer is:
> If the source of the protected key is a secure key - then there is no 
> path
> on the faked implementation to get a hand on a protected key.
> If the source of the protected key is a clear key - honestly does it 
> even
> matter which implementation is then running?
>
> Hopefully I could explain the difference.

Yes, thanks.

It seems we have similar cases for other archs, so let's just keep it as
it is now.

