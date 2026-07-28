Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7833F4DD2;
	Tue, 28 Jul 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236654; cv=none; b=eAbLxlsNNEWQqJhb1oCltTDanZz0pWrm9+mdSu8DkhV2LUUjVIvKO7RQmQIl8qYQTs8L/NJdoD2FS15mP6EMx6sDQB6YWfp73FpAk1Xn3M/G7CZsV6r+NFN6jfaSicgTxWWo9+U9ncNB9UMyfp9qgngtEZP2SfvCa6c4qqEckio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236654; c=relaxed/simple;
	bh=0TW+2gO2Y449U6B5oL76Jdv/YZDAunh/PaMgBAxw8jg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xp0udaHO8U/JhgKZp7VD23CnlyBNP8Ac2GcouEVBYOSDMLuLA7zbieeY0sYhFrloYWIEdBc2liQ4jplnd7wnnvq2yD7AdnJHHFw4BQGmOqpOZ8DgW3NqdBy4QSr2RSTi19TEEZLARWByKacPP3pd2sDPqs20IqwuLRWD8+6SHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=qyurEcKw; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="qyurEcKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785236557;
	bh=EqoHwxE+VU0310UtxmGkojwDciTmupYIvGucpqVpWrA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qyurEcKwgvj0qpSR1t/6OlutKY/fv9cfu2ntNNZo6yguKVrP8rhjsPEBar3hi++04
	 jyqQ40F6rnEVP6JIn4EwAx1gXEP9iFObYcs3RD1foLbCtyWB71ZaZ442i7tiohtBvz
	 IFm1T22Bj6zHz97A+JeVBqjy4P4VZ2WajnMzc1x8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h8XcF5pJQzGpFd;
	Tue, 28 Jul 2026 11:02:37 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h8XcD6lmVzGpDx;
	Tue, 28 Jul 2026 11:02:36 +0000 (UTC)
Date: Tue, 28 Jul 2026 12:02:35 +0100
From: Bradley Morgan <include@grrlz.net>
To: Mete Durlu <meted@linux.ibm.com>
CC: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
 borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pmladek@suse.com, sparclinux@vger.kernel.org, svens@linux.ibm.com
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
In-Reply-To: <5b9f08f0-4412-4841-b7c1-21de21557fe4@linux.ibm.com>
References: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net> <5b9f08f0-4412-4841-b7c1-21de21557fe4@linux.ibm.com>
Message-ID: <C84A503B-3DBE-4982-A124-F3702BF9EB36@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 July 2026 11:43:17 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>On 27/07/2026 15:01, Bradley Morgan wrote:
>
>Hi Bradley,
>
>>> This now means that the panic_timeout value takes precedence over user
>>> defined on_panic behavior.
>> 
>> this is the part i want to poke at. distros routinely ship panic=N on
>> the cmdline. with this change, anyone who configured on_panic=dump on
>> such a system silently stops getting dumps, because
>> emergency_restart() runs first and never returns. a reboot instead of
>> the dump you explicitly asked for is strictly worse. if you and Sven
>> want that semantic, fine, but spell it out properly and give the s390
>> docs for on_panic a line about the new precedence.
>
>FWICT, there is no mention of shutdown actions in kernel documentation.
>s390's user documentation is a different story. I agree it should be
>documented on Linux on IBM systems documentation.
>
>I'd argue that specifying both on_panic=dump and panic=N (N>0) is
>a configuration error, but maybe a pr_warn() could be added to the
>when on_panic=dump is configured with panic=N is set. That could
>hint what is wrong if anyone investigating dmesg and trying to
>figure out why system didn't dump.
>


hey, sorry I'm out, so I can't do the most massive think ever, and I may
embarrass myself, heh.

I think a BUG would be sufficient, we would want to shut down the system
with said bug, I know about panic on warn, but sometimes that's not always
enabled, something like a BUG would be good, what do you think?

>On another note, dumping via shutdown actions serves as a backup
>and kdump is the main dump mechanism nowadays. Kdump always takes
>precedence over panic=N.
>
>> also worth saying in the changelog what this actually wins: today the
>> INT_MIN notifier never returns, so sys_info, kmsg_dump, the post
>> notifier crash_kexec path, the console flushes and the end banner
>> never execute on s390 once on_panic fires. after this patch they all
>> do. thats the headline and the changelog undersells it.
>> 
>
>Right, I will add that part to the commit message too.
>
>>> Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
>> 
>> What's broken? What's buggy? 
>
>I can put a couple of sentences on how and why panic=
>kernel command line argument was broken for s390.
>> s/now allow/now allows/ in the changelog..
>
>Will fix in next version!
>
>Thank you
>
>

Thanks!
