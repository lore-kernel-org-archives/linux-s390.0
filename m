Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99B3A7F48;
	Tue, 28 Jul 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239009; cv=none; b=B+kirfg6MpY6nWngnUJKL0rX30/5o6ilgthGrJS3eDBCE4gdfxE29nF6ZnKl7NFj3dnW3in0hVNs35amO4Op1xaJ/RGY6Xa8uyjr3Q4LrJNk7RoJjaTBXO/wPYPJ3Om/msDAgCIClEFYkDfgntiuVbMG4mpCzbzcERH68gV3GSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239009; c=relaxed/simple;
	bh=ftb5qmr+cCfP9d5rWmy2meS2JLm0HZXsH8Gl3K1JL5w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JN1KnI/uFQbzC+4YHQNZNg0KpmFgQQVegNM069+qxiAeYWh3WSKX8fwEstNOQz8DGTMEKLHEqxuJmaOYT2jHa/Zm7sioS49p6407W9JvSx1ym38vjlQfllzv4aulnPLZPgNE+284riT0jX9I8yTjGvx8jm23ADfPeIHrgnxz3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=XtZN3JvD; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="XtZN3JvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785239004;
	bh=m5lHHZDvfz2qDyLAe0AEkJm1lG7bEOWDoWDOcHWQIOk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XtZN3JvDrqU9uBZIUJZV+rlcML06locZ5+P7CwQK39Sinh18HQz+cGxbyFBXKUyRo
	 GdhcmPTPyeAH4YjwTGgEFFu9TRez/6iuE8Y5lwR6yFBdVIx3zE5UBJMAuyiwPb+bZW
	 yBrqOboJRPvNdpRuTyKvh/pZTZxl46aOnNktSGNI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h8YWJ2T3Cz115s;
	Tue, 28 Jul 2026 11:43:24 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h8YWH4wRPz115r;
	Tue, 28 Jul 2026 11:43:23 +0000 (UTC)
Date: Tue, 28 Jul 2026 12:43:23 +0100
From: Bradley Morgan <include@grrlz.net>
To: Sven Schnelle <svens@linux.ibm.com>
CC: Mete Durlu <meted@linux.ibm.com>, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, andreas@gaisler.com, borntraeger@linux.ibm.com,
 davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, pmladek@suse.com,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
In-Reply-To: <yt9dqzknxrz1.fsf@linux.ibm.com>
References: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net> <5b9f08f0-4412-4841-b7c1-21de21557fe4@linux.ibm.com> <C84A503B-3DBE-4982-A124-F3702BF9EB36@grrlz.net> <yt9dqzknxrz1.fsf@linux.ibm.com>
Message-ID: <FFDE05CF-6653-4B46-856D-164F9281B8BA@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 July 2026 12:40:18 BST, Sven Schnelle <svens@linux.ibm.com> wrote:
>Bradley Morgan <include@grrlz.net> writes:
>
>> On 28 July 2026 11:43:17 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>>>On 27/07/2026 15:01, Bradley Morgan wrote:
>>>
>>>Hi Bradley,
>>>
>>>>> This now means that the panic_timeout value takes precedence over
>user
>>>>> defined on_panic behavior.
>>>> 
>>>> this is the part i want to poke at. distros routinely ship panic=N on
>>>> the cmdline. with this change, anyone who configured on_panic=dump on
>>>> such a system silently stops getting dumps, because
>>>> emergency_restart() runs first and never returns. a reboot instead of
>>>> the dump you explicitly asked for is strictly worse. if you and Sven
>>>> want that semantic, fine, but spell it out properly and give the s390
>>>> docs for on_panic a line about the new precedence.
>>>
>>>FWICT, there is no mention of shutdown actions in kernel documentation.
>>>s390's user documentation is a different story. I agree it should be
>>>documented on Linux on IBM systems documentation.
>>>
>>>I'd argue that specifying both on_panic=dump and panic=N (N>0) is
>>>a configuration error, but maybe a pr_warn() could be added to the
>>>when on_panic=dump is configured with panic=N is set. That could
>>>hint what is wrong if anyone investigating dmesg and trying to
>>>figure out why system didn't dump.
>>>
>>
>>
>> hey, sorry I'm out, so I can't do the most massive think ever, and I may
>> embarrass myself, heh.
>>
>> I think a BUG would be sufficient, we would want to shut down the system
>> with said bug, I know about panic on warn, but sometimes that's not
>always
>> enabled, something like a BUG would be good, what do you think?
>
>Err... No. You don't want to make a mistake while updating the kernel
>panic parameters just to figure out that on the next boot the kernel just
>BUGs()
>because of that. There are of course lots of reasons why changing the
>kernel
>command line could end up in a non-bootable system but this one would
>be ridiculous.
>

hey, yes, fair enough , thanks, I never said the warn was objectively
wrong, (fair enough), it was more a question.

Thanks!
