Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EE3A9DB6
	for <linux-s390@vger.kernel.org>; Fri,  6 Mar 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816009; cv=pass; b=HSVwDq2t55ih/jEA48rGPX5y1mj8YcEmhGSJzfWAhRjcrjMeBzVictRLkoovdFJp1YlaXblYNfCAQZgKQj3m2LeJZc6Ta7I1T19tZbXmQBTk1iHb+LzOSBGvx+TNINX8f7a6PsqLhs/p9RSX+WboqWzm+PIK9gsn5qwgHvBIbSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816009; c=relaxed/simple;
	bh=uvJAJqJ+OUG+8Qc6KivjDGtBu8adoepmT7qHr235oD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1TyySIQPrv6RA2EtbLiYQPgSZBpcHal7ox5uqUEzD6EVvsy1C078Ifje37HCYJSmIXN2yo2tKMHtNxyzzeqjF5W7FlsLcU7WXxSRPlANS+BqAOmLV6KY6ECH8zoDjHZ8QVWKKMMlBPJS4XP13+8nabH+rgkGi823/y7Y+qI2Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+8xlYrT; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+8xlYrT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae523d54d2so88975ad.1
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2026 08:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772816008; cv=none;
        d=google.com; s=arc-20240605;
        b=ad1tZuZ0AKLmyq22PwxyDGj61iTKfgM1f+PGRZK1XkKDudtbcK4OXAQnHjDWzbP8Mb
         KHktKP1ZfZluPb7n+M6roDwN1PkUbYLbim33G1auKcPPS7ikvs1STdZCLZKSRNCiO13Z
         EnqPFXEmIzZrS20V8rf1dTr4pHHRLivlt831+GEYqB9kt/PEHW+LpWQPFOnzhcPIYy9q
         V2evwVDcJWavvzH4mJllkMVN2sZa2hZrFT1/rTZVxXWRnaiHfZ9sb8qlm1NEGEIig2mL
         pQ6bPWBgbDSPq/atHxFOZVE/2gKOPBdkMBb2i/FvsLqJu4wmjOCR9x5pyU3aBv/jJF1j
         6Q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        fh=xY96yqLxBeQY1hjBnVpUa2D1bbO2b6K6uDERzw0j/ZA=;
        b=VaoDqBAH4f0zbJ9fFYW1G5io4uAtZrK+aJJLZNtV7/u9dSJ4548QIAwKhDAxDJWJTn
         fRehfvRx04CjNPgdaCjfhZzPs2n7HfwzDnylZ20OBFXVlwkW2vR/DeUMIZpbsaxmeajZ
         B+Pp+aZNO6SmzopwxNySc8NgM+P74xd/zd42X52bGxPiQSYVZyGVBZYbuR5vpVm5LELM
         Withbxe4+ZgSPV+7n7ORcPZFqb3coibOVOBgtU4b+QUbdzInqyH1/Dpt8ZBs+SqliEmp
         0ELyCSSr9JIgSjR/4kTM+f/zdO15W+yUNZ4gaYbYo8RxTz70IDIpt8EPqh5ScboSCOEC
         4/+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772816008; x=1773420808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        b=b+8xlYrTITiYbj80vcLrufR5Z/yneu9x9IgtJPoEjTUVRs+B3dhuMoEIE6XJ3HH9QM
         CIPpgLGAObu5xZ1/CcciTrhiFi/VbjC+xMPFktDbgntRlVI3B8qvk80D4vpzV+GXdklh
         TeYjczm0nvRz1pG6rhYo3F3+5nNJDsK17hM+OJnNc0GYUaAzxTJ6wNQ7aE/D+c18vxCe
         XiTcJsMYJF9Kd0ZrLH89Y6+bkOo2cDSIYvA6vjTY0LXDmi5KrZ4j5NRtPFDCyvNOe8+y
         WqIj/gkPnGoHbi97KQ0s9fo1B2b6SwIECLEiGKNBTNM/u07v8xdLHsPbHL/RE6kp9YSZ
         p8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816008; x=1773420808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        b=mNTh9FJX9dOYwpBbqq55t6RdiMt9aIx8dZJBhqas3grOXfs7CyGXNk2B76VNJDevts
         CBFY5EL83TuouIWJldyO5VFViED0uuvu03NP5+ye+kbLae+MJ6CTPUNuyik94yMv8pw2
         lwJdQd+ykuFcn/LMXa74twO6Dwl+lXMybueI2rbBPzNGhORqaulP5xDIlXSrFMIu2AMi
         jKFEn6m5aREPMWaUyrZxgc5WJLPaPTr5B2g2KSmMEOy0zxF19n6l+Nff2QPjPy+4nXy1
         K3QV9ECPCBKqaQKZnmEeJvOTLNan5BefJF0J//sIEcAoXV2PXtr+UothJXdmffjUPNLV
         6Wsg==
X-Forwarded-Encrypted: i=1; AJvYcCWicOisdkh3DVc+AEfbkMwu23KuJovizXq5llvrklHR9CtybbNcztVqdQJTxk2X0L2g55d4wwCV6h6r@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsJzqhS2FovwYaFq2gcESoKNFsEBEW7onPR+E3ACItCuMFDT4
	bAOSeMrZZfD0i4wb3/MfO1lJErRoLBu+6eOSA2LOn/BJClv70rl6OFznKzEe+CwoRib4QqE9lcN
	gq2uqdzQwafw2iuy3ZXPSRRcC9WM6ppgLFgrrnAXX
X-Gm-Gg: ATEYQzwS8tppfMQ+rEeZQwm4rwxCvF1n1uBguNZKhM6s6zo56im2jK1qIBVm5BqDEAg
	Y+M/QAeGSKfaFMgqenVHPVW2dTWP7XUzLlBBusST7s/OVMXDcb9xxpbE0yMFdpxKadNYWK53phN
	ZErxTgik6z/CtHkOJ0LjNqldquoO4jekiyR8RENJ2Ja7sFZo/CsOMVuwF7GFaB133oFcxkrccaI
	mX+L29LdHhVP5+LURSmd2W+I6UIimMb8zkfWuSeJnVnJDyxklhMxOnENwwwxVuWagXSi0/zm4Gs
	pCs5GGAM
X-Received: by 2002:a17:902:e54d:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2ae81e624cemr2487815ad.13.1772816007246; Fri, 06 Mar 2026
 08:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306071002.2526085-1-tmricht@linux.ibm.com> <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Mar 2026 08:53:15 -0800
X-Gm-Features: AaiRm52ymk7n_TnJgTnMzHWevukVygoazKQGzkWbtsoNC-MRSTc2_F6Kq8bl054
Message-ID: <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Jan Polensky <japo@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:52=E2=80=AFAM Jan Polensky <japo@linux.ibm.com> wr=
ote:
>
> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> > Perf tests
> > 120: 'perf data convert --to-ctf' command test
> > 121: 'perf data convert --to-json' command test
> > fail on s390. It is caused by selecting the default event cycles
> > which does not exist on s390 z/VM. Use software event cpu-clock
> > and specify it explicitly on the command line.
> >
> > Output before:
> > =E2=9D=AF perf test 120 121
> > 120: 'perf data convert --to-ctf' command test       : FAILED!
> > 121: 'perf data convert --to-json' command test      : FAILED!
> >
> > Output after:
> > =E2=9D=AF perf test 120 121
> > 120: 'perf data convert --to-ctf' command test       : Ok
> > 121: 'perf data convert --to-json' command test      : Ok
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> [snip]
> Thanks for providing this, Thomas!
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>

Should we not fallback for the cycles as a default event?
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c#n1374
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c#n3792

Thanks,
Ian
