Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055E286D5E
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485479; cv=none; b=t7S2ytIdqhTmvrhLGhMa58Vx9dWkRZyIIGmZYPNsxKDCLTP/nabh49rixeCdjkxANLg8kyyKh2JOY1Flrg9XLWrXi8B0MVYQHv/4uS30rKK0FfB2KSShK9a+Dvx6whYKvfRoYze/z1bqqRmBEafyfMDbEJGC9J6CFZRubTsQCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485479; c=relaxed/simple;
	bh=C1JkI15vgeu08xV//dtK9AYlWM5a5o5EUbaFA14ty+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRsShjMz6q7wtT6jBHUYHmzY6oTp9VcvCu4BoNxUF9JIdOeMW9gigtF4zoV5XV6dj8fbRINZlCAVzEsWEYgiE/LSnNnpT+FqHADcoRB6V2TM2kVjJHPFK4zycca61t/P0QYE6PNupNOoCyArP+yIzev0KfnbHiJlrIp8C5kwHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZkBhq1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZkBhq1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BBD1F01561
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779485478;
	bh=C1JkI15vgeu08xV//dtK9AYlWM5a5o5EUbaFA14ty+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BZkBhq1dEMkxCJHLGd9hHIZUnfovj2cBcOHoma7ZqB1sV0+I2O6Ds5hTpwlWo4Mft
	 6cZWdkrBC8UapaBAwm7wTsgf6f8+bsxbXBKEVD6N264a0/eS6r2rdb08YfLVaVXRFl
	 DCfthOwfboPEVZicSPecr1WRFLBuk1+P+LgQEe3wX84so6iEX2i0ZTBrRDglX2hSFx
	 U8IUrYW8hVgwjP8B7VfqK2I0t+/0+rbDVSJLqQ9PbEvde4WIlEtliG3txUqHXy/bwe
	 ykb+eAMoCx2v1OrYATTHe26u6dEHYIyLuKR8dX7rGXbs6//A4IoVMdKRjJahE4F5l7
	 5hZy1XYN8h40Q==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914bbfc2464so80626985a.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 14:31:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/DbIJ3QA4IZ59xjCWwuw2yaQcJbvrtjoQ+pXSbkp//AsTGrpoJhsplu3/sBacwB6npzD1JRtF9SNP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fRMpeJru5chwFnKfh0YRBYcCwi9dhbDRzUCyZe3Y9FJPM1wQ
	Rqw5oLn5MMiXk5uBGfaVPKVot4UUI1TbnmeczX6kIziCbJQV46qufvHNELBd3XG0aa/qKn1euk9
	5ouE/rB6S5cTm98Hr47sA2ki1+yW0p3g=
X-Received: by 2002:a05:620a:372a:b0:914:c100:6a0f with SMTP id
 af79cd13be357-914c10072a4mr332092285a.23.1779485477280; Fri, 22 May 2026
 14:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com> <ahB6QyHgYq8ksj65@lucifer>
In-Reply-To: <ahB6QyHgYq8ksj65@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Sat, 23 May 2026 05:31:05 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
X-Gm-Features: AVHnY4IqrepDwpGO5qDQsSaxTVFULk1Thk0Uu8QgQ0mfUUrDDRbDPxaWPMcP1VU
Message-ID: <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"

>
> Again this is making me want to sit outside and sip on some lemonade and
> ice :)
>
> Yes - android processes are aggressively multi-threaded, sure of course.
>
> The missing bit here is the forking - what, where, why, when?
>

I really want to know the what, where, why, and when
as well. But since most applications are not
open-source, it is basically a black hole for anyone
other than the owners of those apps.

Let me try to do more investigation to understand what
is going on, although it is really hard.
To be honest, I would rather the Android framework
completely prohibit apps from calling fork(), if
possible.

> And then you say zygote is sometimes multi-threaded but sometimes
> single-threaded, which is adding a whole bunch of confusion on top of all
> that.
>
> I don't find these stack trace dumps all that useful (though thanks of
> course for taking the time to gather them), I think we'd be better off with
> specific data on forking, in some _concise_ _summarised_ form, ideally with
> numbers.
>
> There's such a thing as too much information :))

This trace shows PF I/O in one thread overlapping
with a fork() call in another thread.
But as I explained, I really do not know what kind of
user behavior is behind it.

>
> Anyway, again, please let's see a new _RFC_ with the approach proposed by
> Suren, with some _succinct_ data demonstrating _exactly_ what the problem
> is, so we can make some headway here.

Okay, sure. Thanks for your patience.

>
> And now I'm off for a cornetto! :)

Sounds good :) Enjoy your cornetto!

Best Regards
Barry
